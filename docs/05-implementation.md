
# 5. Implementation

## 5.1 Implementation Objective

This phase converts the AWS cost optimization strategy into infrastructure, governance controls, monitoring, and CI/CD automation.

The implementation is designed for a Cloud/DevOps engineer and focuses on:

* Infrastructure as Code
* AWS cost governance
* Resource tagging
* Budget monitoring
* IAM security
* CloudWatch monitoring
* GitHub Actions
* Controlled automation
* Cost optimization reporting

The implementation follows a **recommendation-first** approach.

Potentially destructive actions such as deleting EBS volumes, deleting snapshots, or modifying production resources are not automatically performed.

> **Note:** This project is a portfolio case study. Cost figures and optimization estimates are simulated. AWS resources should only be deployed in an account where the required permissions and budget are understood.

---

# 5.2 Target AWS Architecture

The implementation uses the following AWS services:

```text
                         AWS Account
                              │
                ┌─────────────┼─────────────┐
                │             │             │
              EC2            RDS            S3
                │             │             │
                └─────────────┼─────────────┘
                              │
                              ▼
                       AWS Cost Services
                              │
                ┌─────────────┼─────────────┐
                │             │             │
          Cost Explorer     Budgets       Billing
                │             │
                └─────────────┘
                              │
                              ▼
                       Cost Monitoring
                              │
                         CloudWatch
                              │
                              ▼
                             SNS
                              │
                              ▼
                       Email Notification


                  Infrastructure Management
                              │
                              ▼
                          Terraform
                              │
                              ▼
                       GitHub Actions
                              │
                    ┌─────────┴─────────┐
                    ▼                   ▼
                 Plan                Apply
                    │                   │
                    └────── Approval ───┘
```

---

# 5.3 Terraform Implementation

Terraform will be used to manage the supporting AWS infrastructure.

The repository structure is:

```text
terraform/
│
├── budgets/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── iam/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── monitoring/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
└── tagging/
    ├── main.tf
    ├── variables.tf
    └── outputs.tf
```

Terraform is responsible for creating and maintaining the governance components.

---

# 5.4 AWS Budget Implementation

The first infrastructure component is an AWS monthly budget.

The simulated baseline is:

```text
Current Monthly Spend: $50,000
```

A budget can be configured with alert thresholds:

```text
80%  → Warning
90%  → High Usage Alert
100% → Budget Exceeded
```

Example:

```text
Monthly Budget
      │
      ├── 80%
      │    ↓
      │  Warning
      │
      ├── 90%
      │    ↓
      │  Critical Warning
      │
      └── 100%
           ↓
        Budget Exceeded
```

The budget provides an early warning mechanism before AWS expenditure exceeds the approved threshold.

Terraform will manage the budget configuration so that the configuration is version controlled.

---

# 5.5 Cost Alerting

Cost alerts will use AWS Budgets notifications.

Example workflow:

```text
AWS Spending
     │
     ▼
Budget Threshold
     │
     ▼
AWS Budgets
     │
     ▼
Notification
     │
     ▼
SNS
     │
     ▼
Email
```

The objective is to notify the Cloud/DevOps team when spending approaches the defined threshold.

---

# 5.6 Resource Tagging Strategy

A standardized tagging strategy will be implemented.

Required tags:

```text
Environment
Application
Owner
CostCenter
ManagedBy
Project
```

Example:

```text
Environment = Production
Application = Payments
Owner       = Platform-Team
CostCenter  = CC-1001
ManagedBy   = Terraform
Project     = CostOptimization
```

## Why Tags Matter

Tags allow the organization to:

* Identify resource ownership
* Allocate costs
* Separate production and non-production
* Identify application costs
* Support reporting
* Improve resource governance
* Identify resources that can be safely reviewed

---

# 5.7 Environment Classification

Resources will be classified using:

```text
Environment
├── Production
├── Staging
└── Development
```

This classification is particularly important for automation.

For example:

```text
Environment = Production
        ↓
Do NOT automatically stop

Environment = Staging
        ↓
Eligible for scheduling

Environment = Development
        ↓
Eligible for scheduling
```

This prevents a generic automation process from accidentally stopping production workloads.

---

# 5.8 IAM Implementation

IAM will follow the principle of least privilege.

The cost optimization components should have only the permissions required for their function.

Permissions will be separated between:

### Read/Analysis

Used for:

* Reading EC2 information
* Reading EBS information
* Reading RDS information
* Reading resource tags
* Reading cost information

### Governance

Used for:

* Creating budgets
* Configuring alerts
* Managing monitoring resources

### Automation

Any future automation that modifies resources will use a separate IAM role with explicitly approved permissions.

---

# 5.9 IAM Design

The conceptual IAM structure is:

```text
AWS Account
     │
     ├── Human Administrator
     │
     ├── Terraform Deployment Role
     │
     ├── Cost Analysis Role
     │
     └── Automation Role
```

The automation role will not automatically receive unrestricted administrative access.

For example, an automation role intended to inspect EC2 resources should not require:

```text
ec2:*
```

Instead, permissions should be limited to the operations actually required.

---

# 5.10 CloudWatch Monitoring

CloudWatch will be used to support operational validation.

Metrics that may be reviewed include:

### EC2

* CPU utilization
* Network utilization
* Disk metrics where available

### RDS

* CPU utilization
* Freeable memory
* Database connections
* Read/write IOPS
* Storage

### Lambda

If Lambda-based analysis is introduced:

* Invocations
* Errors
* Duration
* Throttles

The objective is to make cost optimization decisions based on operational data rather than assumptions.

---

# 5.11 Cost Optimization Detection

The project will include lightweight scripts for identifying potential optimization candidates.

The script will focus on **detection and reporting**, not destructive changes.

Example workflow:

```text
AWS Resource
     │
     ▼
Read Resource Metadata
     │
     ▼
Check Tags
     │
     ▼
Check Utilization / State
     │
     ▼
Optimization Rule
     │
     ▼
Recommendation
```

Example recommendation:

```text
Resource: i-0123456789
Type: EC2
Environment: Development
CPU Utilization: Low

Recommendation:
Review instance rightsizing.

Risk:
Medium

Action:
Manual review required.
```

---

# 5.12 EBS Optimization Detection

The implementation will identify unattached EBS volumes.

Conceptually:

```text
EBS Volume
     │
     ▼
State = Available?
     │
   Yes
     │
     ▼
Check Owner / Tags
     │
     ▼
Check Retention Requirement
     │
     ▼
Generate Recommendation
```

The system will **not automatically delete the volume**.

Instead:

```text
Potentially Unused Volume
          ↓
Recommendation
          ↓
Owner Review
          ↓
Approval
          ↓
Manual / Controlled Deletion
```

This is an important production-safety control.

---

# 5.13 Non-Production Scheduling

Development and staging resources are candidates for scheduled operation.

Example:

```text
Monday - Friday

08:00
  ↓
Start resources

20:00
  ↓
Stop eligible resources
```

Resources will be identified using tags:

```text
Environment = Development
Environment = Staging
```

Production resources will be excluded.

Additional safeguards:

* Explicit opt-out tag
* Resource ownership
* Notification before implementation
* Monitoring after start/stop
* Manual approval for initial rollout

---

# 5.14 S3 Lifecycle Implementation

S3 lifecycle policies will be evaluated based on data requirements.

Example conceptual policy:

```text
Object Created
      │
      ▼
Standard Storage
      │
    30 days
      │
      ▼
Infrequent Access
      │
    90 days
      │
      ▼
Archive
      │
 Retention Period
      │
      ▼
Deletion
```

The actual lifecycle periods should be determined from business and compliance requirements.

Lifecycle policies should never be implemented simply to reduce cost if the data is still required for application or regulatory purposes.

---

# 5.15 NAT Gateway Optimization

NAT Gateway cost optimization will initially be an architecture review rather than an automatic change.

The following will be investigated:

```text
Private Subnet
      │
      ▼
NAT Gateway
      │
      ▼
AWS Service
```

Potential improvement:

```text
Private Subnet
      │
      ▼
VPC Endpoint
      │
      ▼
AWS Service
```

Potential candidates include S3 and DynamoDB traffic.

The implementation will validate:

* Current traffic patterns
* Security requirements
* Application dependencies
* Cross-AZ traffic
* Endpoint costs
* Operational impact

The objective is to reduce unnecessary NAT data processing without creating a more expensive or complex architecture.

---

# 5.16 GitHub Actions Implementation

Terraform will be integrated with GitHub Actions.

Pipeline:

```text
Git Push
   │
   ▼
GitHub Actions
   │
   ├── Checkout
   │
   ├── Terraform Format
   │
   ├── Terraform Init
   │
   ├── Terraform Validate
   │
   ├── Security Scan
   │
   └── Terraform Plan
             │
             ▼
       Pull Request Review
             │
             ▼
       Manual Approval
             │
             ▼
       Terraform Apply
```

---

# 5.17 Terraform Validation

Every Terraform change should pass:

```text
terraform fmt
terraform validate
terraform plan
```

The pipeline should fail if Terraform configuration is invalid.

This provides an early quality gate before infrastructure changes reach AWS.

---

# 5.18 Security Scanning

Infrastructure code should also be scanned for common security issues.

Potential tools include:

* Checkov
* Trivy
* tfsec

The purpose is to detect issues such as:

* Overly permissive IAM
* Publicly accessible resources
* Insecure configurations
* Missing encryption
* Configuration weaknesses

Security scanning is part of the CI/CD quality gate.

---

# 5.19 Deployment Approval

Production infrastructure should not be changed automatically from an unreviewed pull request.

The workflow is:

```text
Pull Request
     ↓
Terraform Plan
     ↓
Security Scan
     ↓
Code Review
     ↓
Approval
     ↓
Terraform Apply
```

This provides separation between:

* Development
* Review
* Approval
* Deployment

---

# 5.20 AWS Credentials

Long-lived AWS access keys should not be stored in GitHub repository secrets when avoidable.

The preferred approach is:

```text
GitHub Actions
      │
      ▼
OIDC Authentication
      │
      ▼
AWS IAM Role
      │
      ▼
AWS Account
```

This avoids storing permanent AWS access keys in the repository.

The GitHub Actions role should use least-privilege permissions.

---

# 5.21 Implementation Safety Controls

The following controls will be applied:

| Control              | Purpose                      |
| -------------------- | ---------------------------- |
| Terraform            | Infrastructure consistency   |
| GitHub PR            | Change review                |
| IAM least privilege  | Reduce access risk           |
| Tags                 | Resource ownership           |
| Budget alerts        | Spending visibility          |
| Manual approval      | Production protection        |
| Monitoring           | Validate changes             |
| Rollback plan        | Recover from issues          |
| Recommendation-first | Avoid destructive automation |

---

# 5.22 Implementation Sequence

The implementation will be performed in the following order:

### Step 1

Create the Terraform directory structure.

### Step 2

Configure AWS provider and Terraform backend strategy.

### Step 3

Implement AWS Budget configuration.

### Step 4

Implement SNS notification configuration.

### Step 5

Implement IAM roles and policies.

### Step 6

Implement tagging and governance configuration.

### Step 7

Implement CloudWatch monitoring.

### Step 8

Create lightweight cost analysis scripts.

### Step 9

Create GitHub Actions Terraform pipeline.

### Step 10

Enable security scanning.

### Step 11

Test in a non-production environment.

### Step 12

Review the Terraform plan.

### Step 13

Apply approved infrastructure.

### Step 14

Validate AWS resources.

### Step 15

Document the implementation results.

---

# 5.23 Validation Checklist

After deployment, validate:

```text
[ ] Terraform configuration is valid
[ ] Terraform plan reviewed
[ ] AWS Budget created
[ ] Budget alerts configured
[ ] SNS notifications configured
[ ] IAM permissions reviewed
[ ] Tags applied consistently
[ ] CloudWatch monitoring configured
[ ] GitHub Actions pipeline working
[ ] Security scan passing
[ ] No long-lived AWS credentials in GitHub
[ ] Production resources protected
[ ] Cost recommendations generated
```

---

# 5.24 Expected Implementation Result

The completed implementation will provide a foundation for AWS cost governance.

The expected architecture is:

```text
                    GitHub
                       │
                       ▼
               GitHub Actions
                       │
              ┌────────┴────────┐
              │                 │
         Terraform Plan    Security Scan
              │                 │
              └────────┬────────┘
                       │
                  Approval
                       │
                       ▼
                    AWS IAM
                       │
                       ▼
                  AWS Resources
                       │
          ┌────────────┼────────────┐
          │            │            │
         EC2          RDS           S3
          │            │            │
          └────────────┼────────────┘
                       │
                       ▼
                Cost Monitoring
                       │
              ┌────────┴────────┐
              │                 │
            Budget           CloudWatch
              │                 │
              └────────┬────────┘
                       │
                       ▼
                  Notifications
```

The implementation establishes the technical foundation for the cost optimization program.

The next phase will document the security, governance, access-control, tagging, and operational controls in detail.
