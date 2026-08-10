output "terraform_role_name" {
description = "Name of the Terraform deployment IAM role."
value       = aws_iam_role.terraform_deployment.name
}

output "terraform_role_arn" {
description = "ARN of the Terraform deployment IAM role."
value       = aws_iam_role.terraform_deployment.arn
}

output "aws_account_id" {
description = "AWS account ID where the IAM role is deployed."
value       = data.aws_caller_identity.current.account_id
}
