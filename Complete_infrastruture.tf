provider "aws" {
  region = "us-east-1"
}

# Creation of a VPC
resource "aws_vpc" "TesteVPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VCP_Prod"
  }
}

# Creation of a Subnet
resource "aws_subnet" "FrontEndProd" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.TesteVPC.id
  tags = {
    Name = "Private-frontend-prod"
  }
  depends_on = [
    aws_vpc.TesteVPC
  ]
}

resource "aws_subnet" "BackEndProd" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.TesteVPC.id
  tags = {
    Name = "Private-backend-prod"
  }
  depends_on = [
    aws_vpc.TesteVPC
  ]
}

resource "aws_subnet" "NATSubnet" {
  cidr_block = "10.0.3.0/24"
  vpc_id = aws_vpc.TesteVPC.id
  tags = {
    Name = "Public-NAT"
  }
  depends_on = [
    aws_vpc.TesteVPC
  ]
}

# GW for the NATSubnet
resource "aws_internet_gateway" "InternetGW" {
  vpc_id = aws_vpc.TesteVPC.id
  tags = {
    "Name" = "TesteVPC_GW"
  }
  depends_on = [
    aws_vpc.TesteVPC
  ]
}

# NAT for the Internet acess on private subnets
resource "aws_nat_gateway" "NAT_GW" {
  subnet_id = aws_subnet.NATSubnet.id
  allocation_id = aws_internet_gateway.InternetGW.id

  depends_on = [
    aws_internet_gateway.InternetGW
    
  ]
}


















# Creation of a security group
resource "aws_security_group" "MyBackEndSG" {
  name  = "AllowFrontEnd"
  vpc_id = aws_vpc.TesteVPC.id
   ingress {
    from_port        = 0
    to_port          = 0
    description      = "FrontToBackEnd"
    protocol         = "tcp"
    cidr_blocks      = ["10.0.1.0/24"]
    }
  tags = {
    Name = "MyBackEndSG"
  }
}

