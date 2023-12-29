variable "vpc_enable_nat_gateway" {
  type    = bool
  default = true
}

variable "vpc_single_nat_gateway" {
  type    = bool
  default = true
}

variable "vpc_azs" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
  description = "VPC availability zones"
}

variable "vpc_private_subnets" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  description = "VPC Private Subnets"
}

variable "vpc_public_subnets" {
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
  description = "VPC Public Subnets"
}

variable "vpc_database_subnets" {
  type        = list(string)
  default     = ["10.0.151.0/24", "10.0.152.0/24"]
  description = "VPC Database Subnets"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC"
}

variable "vpc_name" {
  type        = string
  default     = "tutorial-vpc"
  description = "Name of the VPC"
}