provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "TesteVPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VCP_Prod"
  }
}

resource "aws_subnet" "SubNetProd" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.TesteVPC.id
  tags = {
    Name = "subnet-prod"
  }
}

resource "aws_instance" "frontend" {
  subnet_id = aws_subnet.SubNetProd.id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  ami = "ami-0dc2d3e4c0f9ebd18"
  tags = {
    Name = "FrontEndProd"
  }
  
}