variable "aws_region" {
description = "AWS region where the supporting resources are deployed."
type        = string
default     = "ap-south-1"
}

variable "budget_name" {
description = "Name of the AWS monthly cost budget."
type        = string
default     = "aws-cost-optimization-monthly-budget"
}

variable "monthly_budget" {
description = "Maximum monthly AWS budget in USD."
type        = number
default     = 100
}

variable "notification_email" {
description = "Email address that receives AWS Budget notifications."
type        = string

validation {
condition     = can(regex("^[^@\s]+@[^@\s]+\.[^@\s]+$", var.notification_email))
error_message = "notification_email must be a valid email address."
}
}

