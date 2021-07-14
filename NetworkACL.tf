provider "aws" {
  region = "us-east-1"
}

resource "aws_network_acl" "main" {
  vpc_id = "vpc-cdadfab5"
  subnet_ids = ["subnet-b8b56ee4"]


  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "10.3.0.0/18"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.3.0.0/18"
    from_port  = 80
    to_port    = 80
  }

  tags = {
    Name = "TesteNET_ACL"
  }
}