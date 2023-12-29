variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "The AWS region in which VPC will be created"
}

variable "environment" {
  description = "Environment variable used as a prefix"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "Name of the project"
  type        = string
  default     = "tutorialapp"
}

variable "owner" {
  description = "The person who owns the project"
  type        = string
  default     = "terraform"
}
