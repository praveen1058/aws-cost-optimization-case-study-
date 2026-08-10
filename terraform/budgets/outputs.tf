
output "budget_name" {
description = "Name of the AWS budget."
value       = aws_budgets_budget.monthly_cost.name
}

output "monthly_budget" {
description = "Configured monthly AWS budget."
value       = aws_budgets_budget.monthly_cost.limit_amount
}

output "budget_arn" {
description = "ARN of the AWS budget."
value       = aws_budgets_budget.monthly_cost.arn
}
