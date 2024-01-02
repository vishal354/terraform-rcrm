variable "rds_identifier" {
  type        = string
  default     = "data"
  description = "Name of the RDS instance"
}

variable "rds_engine" {
  type        = string
  default     = "mysql"
  description = "RDS engine"
}

variable "rds_engine_version" {
  type        = string
  default     = "8.0"
  description = "RDS engine version"
}

variable "rds_storage" {
  type        = number
  default     = 5
  description = "RDS instance storage"
}

variable "rds_instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "RDS instance type"
}

variable "rds_dbname" {
  type        = string
  default     = "test"
  description = "Name of database in RDS instance"
}

variable "rds_username" {
  type        = string
  default     = "admin"
  description = "Username in RDS instance"
}

variable "rds_port" {
  type        = string
  default     = "3306"
  description = "Username in RDS instance"
}

variable "rds_password" {
  type        = string
  default     = "admin123"
  description = "Password for user in RDS instance"
}

variable "rds_family" {
  type        = string
  default     = "mysql8.0"
  description = "DB parameter group"
}

variable "rds_major_engine_version" {
  type        = string
  default     = "8.0"
  description = "Major version of database engine"
}

