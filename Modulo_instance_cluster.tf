provider "aws" {
  region = "us-east-1"
}
module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "Teste"
  instance_count         = 1

  ami                    = "ami-0dc2d3e4c0f9ebd18"
  instance_type          = "t2.micro"
  monitoring             = false
  vpc_security_group_ids = ["sg-e86b7d9d"]
  subnet_id              = "subnet-0a19c31711e1eb1ab"
  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
    
  }
}