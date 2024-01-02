module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.3.0"

  identifier = var.rds_identifier

  engine              = var.rds_engine
  engine_version      = var.rds_engine_version
  instance_class      = var.rds_instance_class
  allocated_storage   = var.rds_storage
  multi_az            = true
  publicly_accessible = false

  db_name  = var.rds_dbname
  username = var.rds_username
  port     = var.rds_port
  password = var.rds_password

  manage_master_user_password = false

  #   replica_mode 

  vpc_security_group_ids = [module.tutorial_database_sg.security_group_id]

  family               = var.rds_family
  major_engine_version = var.rds_major_engine_version
  tags                 = local.common_tags

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = module.vpc.database_subnets
}

output "db_endpoint" {
  value = module.db.db_instance_endpoint
}