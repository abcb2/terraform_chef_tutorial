# aws region
region = "ap-northeast-1"

# person to use env
user = "user01"

# network
vpc_name = "chef_sample_01"
vpc_cidr = "10.10.0.0/16"
subnet = "10.10.10.0/24"

# servers
instance_key_name = "chef_sample"

chef_nodes = "1"
chef_nodes_ami = "ami-92df37ed" # amazon-linux
chef_nodes_instance_type = "t2.micro" # [ t2.micro | t2.medium ]
chef_nodes_private_ip = "10.10.10.11"

chef_server = "1"
chef_server_ami = "ami-92df37ed" # amazon-linux
chef_server_instance_type = "t2.medium" # [ t2.micro | t2.medium ]
chef_server_private_ip = "10.10.10.21"

