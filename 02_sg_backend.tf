module "tutorial_backend_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "tutorial-backend-sg"
  description = "Security group with SSH port open "
  vpc_id      = module.vpc.vpc_id

  # Ingress rules and CIDR Blocks
  ingress_rules       = ["ssh-tcp", "http-80-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]

  # Egress rules and CIDR Blocks
  egress_rules = ["all-all"]
  tags         = local.common_tags
}