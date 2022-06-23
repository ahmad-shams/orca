module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "postgresql-for-scaling"
  description = "pg security group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules = ["http-80-tcp", "https-443-tcp", "ssh-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "PostgreSQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    }
  ]
   egress_rules        = ["all-all"]
}



# resource "aws_security_group" "allow_http_ssh" {
#   name        = "orca_scalling_sg"
#   description = "Allow http inbound traffic"
#   vpc_id      = module.vpc.vpc_id

#   ingress {
#     description      = "https"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     cidr_blocks      = [module.vpc.vpc_cidr_block, "172.31.0.0/16"]
#     # ipv6_cidr_blocks = [module.vpc.vpc_ipv6_cidr_block]
#   }
#   ingress {
#     description      = "http"
#     from_port        = 80
#     to_port          = 80
#     protocol         = "tcp"
#     cidr_blocks      = [module.vpc.vpc_cidr_block, "172.31.0.0/16"]
#     # ipv6_cidr_blocks = [module.vpc.vpc_ipv6_cidr_block]
#   }
#   ingress {
#     description      = "ssh"
#     from_port        = 22
#     to_port          = 22
#     protocol         = "tcp"
#     cidr_blocks      = [module.vpc.vpc_cidr_block, "84.110.125.174/32", "172.31.0.0/16"]
#   }



#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "allow_tls"
#   }
# }
