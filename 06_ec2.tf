# module "ec2_instance1" {
#   source = "terraform-aws-modules/ec2-instance/aws"

#   name = "tutorial-instance-1"
#   ami  = data.aws_ami.ubuntu.id

#   instance_type               = "t2.micro"
#   key_name                    = "tutorial-key"
#   monitoring                  = true
#   vpc_security_group_ids      = [module.tutorial_backend_sg.security_group_id]
#   subnet_id                   = module.vpc.public_subnets[0]
#   associate_public_ip_address = true

#   tags = local.common_tags
# }


# module "ec2_instance2" {
#   source = "terraform-aws-modules/ec2-instance/aws"

#   name = "tutorial-instance-2"
#   ami  = data.aws_ami.ubuntu.id

#   instance_type               = "t2.micro"
#   key_name                    = "tutorial-key"
#   monitoring                  = true
#   vpc_security_group_ids      = [module.tutorial_backend_sg.security_group_id]
#   subnet_id                   = module.vpc.public_subnets[1]
#   associate_public_ip_address = true

#   tags = local.common_tags
# }