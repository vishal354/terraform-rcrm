variable "github_token" {
  type        = string
  description = "The token that gives access to github"
  default     = "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"
}

variable "ec2_instance_profile" {
  type    = string
  default = "arn:aws:iam::547204702969:instance-profile/ec2_backend_role"
}

variable "key_name" {
  type    = string
  default = "tutorial-key"
}

variable "codedeploy_role_arn" {
  type    = string
  default = "arn:aws:iam::547204702969:role/codedeploy_backend_role"
}