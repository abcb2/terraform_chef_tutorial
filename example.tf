provider "aws" {
  region = "ap-northeast-1"
}

//resource "aws_instance" "chef-workstation" {
//  ami = "ami-92df37ed"
//  instance_type = "t2.micro"
//}

//resource "aws_instance" "chef-server" {
//  ami = "ami-92df37ed"
//  instance_type = "t2.micro"
//}

resource "aws_vpc" "chef_sample" {
  cidr_block = "10.10.0.0/16"
  tags {
    Name = "chef_sample"
  }
}

resource "aws_subnet" "subnet_member01" {
  cidr_block = "10.10.10.0/24"
  vpc_id = "${aws_vpc.chef_sample.id}"
  tags {
    Name = "chef_sample-member01"
  }
}

resource "aws_subnet" "subnet_member02" {
  cidr_block = "10.10.20.0/24"
  vpc_id = "${aws_vpc.chef_sample.id}"
  tags {
    Name = "chef_sample-member02"
  }
}
