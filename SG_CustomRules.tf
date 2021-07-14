provider "aws" {
  region = "us-east-1"
}

module "vote_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "user-service"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = "vpc-cdadfab5"

#https rule
  ingress_cidr_blocks      = ["0.0.0.0/16"]
  ingress_rules            = ["https-443-tcp"]

#custom rule block   
  ingress_with_cidr_blocks = [
        #Custo rule port range
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "10.10.0.0/16"
    },

        # Custo rule postgreesSQL
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}