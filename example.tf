provider "aws" {
  region = "ap-northeast-1"
}

//resource "aws_instance" "kwata" {
//  ami = "ami-92df37ed"
//  instance_type = "t2.micro"
//}

resource "aws_vpc" "chef_sample" {
  cidr_block = "10.100.10.0/24"
  tags {
    Name = "chef_sample"
  }
}
