terraform {
required_version = ">= 1.5.0"

required_providers {
aws = {
source  = "hashicorp/aws"
version = "~> 6.0"
}
}
}

provider "aws" {
region = var.aws_region
}

resource "aws_budgets_budget" "monthly_cost" {
name         = var.budget_name
budget_type  = "COST"
limit_amount = var.monthly_budget
limit_unit   = "USD"
time_unit    = "MONTHLY"

cost_types {
include_credit             = false
include_discount           = true
include_other_subscription = true
include_recurring          = true
include_refund             = false
include_subscription       = true
include_support            = true
include_tax                = true
use_amortized              = false
use_blended                = false
}

notification {
comparison_operator        = "GREATER_THAN"
threshold                  = 80
threshold_type             = "PERCENTAGE"
notification_type          = "FORECASTED"
subscriber_email_addresses = [var.notification_email]
}

notification {
comparison_operator        = "GREATER_THAN"
threshold                  = 90
threshold_type             = "PERCENTAGE"
notification_type          = "ACTUAL"
subscriber_email_addresses = [var.notification_email]
}

notification {
comparison_operator        = "GREATER_THAN"
threshold                  = 100
threshold_type             = "PERCENTAGE"
notification_type          = "ACTUAL"
subscriber_email_addresses = [var.notification_email]
}
}

