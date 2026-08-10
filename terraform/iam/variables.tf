variable "aws_region" {
description = "AWS region used by the Terraform provider."
type        = string
default     = "ap-south-1"
}

variable "terraform_role_name" {
description = "Name of the IAM role used for Terraform deployments."
type        = string
default     = "aws-cost-optimization-terraform-role"
}
