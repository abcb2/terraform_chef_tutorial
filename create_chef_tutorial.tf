variable "region" {}
variable "user" {}
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "subnet" {}
variable "instance_key_name" {}
variable "chef_nodes" {}
variable "chef_nodes_ami" {}
variable "chef_nodes_instance_type" {}
variable "chef_nodes_private_ip" {}
variable "chef_server" {}
variable "chef_server_ami" {}
variable "chef_server_instance_type" {}
variable "chef_server_private_ip" {}

# credentialはawscliで作成した~/.aws以下のものを読み込んでくれる。
provider "aws" {
  region = "${var.region}"
}

resource "aws_vpc" "chef_sample" {
  cidr_block = "${var.vpc_cidr}"
  tags {
    Name = "${var.vpc_name}"
  }
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "chef_sample_public" {
  vpc_id = "${aws_vpc.chef_sample.id}"
  tags {
    Name = "${var.vpc_name}"
  }
}

resource "aws_route_table" "chef_sample_public" {
  vpc_id = "${aws_vpc.chef_sample.id}"
  //  route_table_id =
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.chef_sample_public.id}"
  }
  tags {
    Name = "${var.vpc_name}"
  }
}

# VPCのセキュリティグループ
resource "aws_default_security_group" "chef_sample" {
  vpc_id = "${aws_vpc.chef_sample.id}"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  tags {
    Name = "${var.vpc_name}"
  }
}

resource "aws_subnet" "chef_sample_subnet" {
  vpc_id = "${aws_vpc.chef_sample.id}"
  cidr_block = "${var.subnet}"
  tags {
    Name = "chef_sample_subnet.${var.user}"
  }
  map_public_ip_on_launch = true
}

resource "aws_route_table_association" "chef_sample_association" {
  route_table_id = "${aws_route_table.chef_sample_public.id}"
  subnet_id = "${aws_subnet.chef_sample_subnet.id}"
}

data "template_file" "cloud_init" {
  template = "${file("${path.module}/config/cloud_init.${var.user}.tpl")}"
}

data "template_file" "cloud_init_shell" {
  template = "${file("${path.module}/config/cloud_init_shell.${var.user}.tpl")}"
}

data "template_cloudinit_config" "cloud_config" {
  gzip = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content = "${data.template_file.cloud_init.rendered}"
  }
  part {
    filename = "shell_hostname"
    content_type = "text/x-shellscript"
    content = "${data.template_file.cloud_init_shell.rendered}"
  }
}

resource "aws_instance" "chef-node" {
  count = "${var.chef_nodes}"
  ami = "${var.chef_nodes_ami}"
  instance_type = "${var.chef_nodes_instance_type}"
  key_name = "${var.instance_key_name}"
  subnet_id = "${aws_subnet.chef_sample_subnet.id}"
  private_ip = "${element(split(",", var.chef_nodes_private_ip), count.index)}"
  associate_public_ip_address = true
  security_groups = [
    "${aws_default_security_group.chef_sample.id}"
  ]
  user_data = "${data.template_cloudinit_config.cloud_config.rendered}"
  tags {
    Name = "chef_node_${var.user}_${count.index + 1}"
    HostName = "node${count.index + 1}.${var.user}.com"
  }
}

resource "aws_instance" "chef-server" {
  count = "${var.chef_server}"
  ami = "${var.chef_server_ami}"
  instance_type = "${var.chef_server_instance_type}"
  key_name = "${var.instance_key_name}"
  subnet_id = "${aws_subnet.chef_sample_subnet.id}"
  private_ip = "${element(split(",", var.chef_server_private_ip), count.index)}"
  associate_public_ip_address = true
  security_groups = [
    "${aws_default_security_group.chef_sample.id}"
  ]
  user_data = "${data.template_cloudinit_config.cloud_config.rendered}"
  tags {
    Name = "chef_server.${var.user}"
    HostName = "chef-server.${var.user}.com"
  }
}

output "configuration" {
  value = <<CONFIG

subnet: ${aws_subnet.chef_sample_subnet.id}

CONFIG
}