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

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

resource "aws_iam_role" "terraform_deployment" {
name = var.terraform_role_name

assume_role_policy = jsonencode({
Version = "2012-10-17"

```
Statement = [
  {
    Sid    = "AllowAccountAssumption"
    Effect = "Allow"

    Principal = {
      AWS = "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"
    }

    Action = "sts:AssumeRole"

    Condition = {
      StringEquals = {
        "aws:PrincipalAccount" = data.aws_caller_identity.current.account_id
      }
    }
  }
]
```

})

tags = {
Project     = "AWS-Cost-Optimization"
ManagedBy   = "Terraform"
Environment = "Management"
}
}

resource "aws_iam_role_policy" "terraform_deployment" {
name = "${var.terraform_role_name}-policy"
role = aws_iam_role.terraform_deployment.id

policy = jsonencode({
Version = "2012-10-17"

```
Statement = [
  {
    Sid    = "BudgetsManagement"
    Effect = "Allow"

    Action = [
      "budgets:CreateBudget",
      "budgets:ModifyBudget",
      "budgets:ViewBudget",
      "budgets:DescribeBudget",
      "budgets:DeleteBudget",
      "budgets:DescribeBudgets",
      "budgets:DescribeBudgetActionsForBudget",
      "budgets:DescribeNotificationsForBudget",
      "budgets:DescribeSubscribersForNotification"
    ]

    Resource = "*"
  },

  {
    Sid    = "SNSManagement"
    Effect = "Allow"

    Action = [
      "sns:CreateTopic",
      "sns:DeleteTopic",
      "sns:GetTopicAttributes",
      "sns:SetTopicAttributes",
      "sns:Subscribe",
      "sns:Unsubscribe",
      "sns:ListSubscriptionsByTopic",
      "sns:ListTagsForResource",
      "sns:TagResource",
      "sns:UntagResource"
    ]

    Resource = "*"
  },

  {
    Sid    = "CloudWatchManagement"
    Effect = "Allow"

    Action = [
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DeleteAlarms",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:ListTagsForResource",
      "cloudwatch:TagResource",
      "cloudwatch:UntagResource"
    ]

    Resource = "*"
  },

  {
    Sid    = "ReadOnlyInfrastructure"
    Effect = "Allow"

    Action = [
      "ec2:DescribeInstances",
      "ec2:DescribeVolumes",
      "ec2:DescribeTags",
      "rds:DescribeDBInstances",
      "rds:ListTagsForResource",
      "s3:GetBucketLocation",
      "s3:GetBucketTagging",
      "s3:ListAllMyBuckets"
    ]

    Resource = "*"
  },

  {
    Sid    = "TaggingManagement"
    Effect = "Allow"

    Action = [
      "ec2:CreateTags",
      "ec2:DeleteTags",
      "rds:AddTagsToResource",
      "rds:RemoveTagsFromResource"
    ]

    Resource = "*"
  }
]
```

})
}
