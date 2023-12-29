module "tutorial_database_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "tutorial-databse-sg"
  description = "Security group with SSH port open "
  vpc_id      = module.vpc.vpc_id

  # Ingress rules and CIDR Blocks
  ingress_rules       = ["ssh-tcp", "mysql-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]

  # Egress rules and CIDR Blocks
  egress_rules = ["all-all"]
  tags         = local.common_tags
}