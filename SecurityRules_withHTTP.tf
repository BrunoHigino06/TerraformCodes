provider "aws" {
  region = "us-east-1"
}

module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = "vpc-09fadbe3fe5a2f549"

  ingress_cidr_blocks = ["10.10.0.0/16"]
  
}