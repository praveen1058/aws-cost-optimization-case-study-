# 6. Security and Governance

## 6.1 Objective

AWS cost optimization must not compromise security, availability, compliance, or operational stability.

This project therefore treats **security and governance as core components of FinOps and Cloud Operations**.

The objective is to establish controls that allow the organization to:

* Control AWS spending
* Maintain resource ownership
* Enforce least-privilege access
* Protect production workloads
* Prevent unauthorized infrastructure changes
* Maintain infrastructure through Terraform
* Monitor cloud resources
* Track cost by environment and application
* Provide an auditable change process

---

# 6.2 Governance Principles

The project follows the following governance principles:

1. **Least privilege**
2. **Infrastructure as Code**
3. **Controlled changes**
4. **Resource ownership**
5. **Production protection**
6. **Cost accountability**
7. **Continuous monitoring**
8. **Security before automation**

Cost optimization should never be implemented by simply giving an automation process unrestricted AWS permissions.

---

# 6.3 AWS Account Structure

The target enterprise architecture can use separate AWS accounts for different environments.

```text
                    AWS Organization
                           │
              ┌────────────┼────────────┐
              │            │            │
              ▼            ▼            ▼
         Production     Staging       Dev
           Account      Account      Account
              │            │            │
              └────────────┼────────────┘
                           │
                           ▼
                    Central Governance
```

For a personal implementation of this portfolio project, a single AWS account can be used.

The multi-account architecture is presented as the **enterprise target state**.

---

# 6.4 Environment Separation

Resources should be classified by environment.

```text
Production
    │
    ├── Customer-facing workloads
    ├── High availability
    └── Strict change control

Staging
    │
    ├── Pre-production testing
    └── Controlled scheduling

Development
    │
    ├── Engineering workloads
    └── Cost optimization candidate
```

Production workloads should have stricter controls than development workloads.

---

# 6.5 Resource Tagging Governance

Tags provide the foundation for cost allocation and resource ownership.

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

---

# 6.6 Tagging Standards

## Environment

Allowed values:

```text
Production
Staging
Development
Shared
```

## ManagedBy

Examples:

```text
Terraform
Manual
CloudFormation
```

## Owner

The team responsible for the resource.

Example:

```text
Platform-Team
Payments-Team
Data-Team
```

## CostCenter

Used for financial allocation.

Example:

```text
CC-1001
CC-1002
CC-1003
```

---

# 6.7 Tag Enforcement

Tagging should be enforced through a combination of:

* Terraform standards
* Code review
* AWS governance controls
* Periodic compliance checks
* Resource inventory reviews

The goal is to prevent resources from being created without ownership information.

---

# 6.8 IAM Security Model

The project follows the principle of **least privilege**.

IAM permissions will be separated according to responsibilities.

```text
                    IAM
                     │
        ┌────────────┼─────────────┐
        │            │             │
        ▼            ▼             ▼
   Read/Analysis  Terraform     Automation
        │            │             │
        │            │             │
      Read       Governance      Limited
    Resources    Resources      Actions
```

---

# 6.9 Cost Analysis Role

The cost analysis role should primarily have read permissions.

Its purpose is to:

* Inspect AWS resources
* Read resource metadata
* Read tags
* Analyze resource state
* Generate recommendations

It should not have permission to delete production resources.

---

# 6.10 Terraform Deployment Role

Terraform requires permissions to create and manage the resources defined by the project.

The Terraform role should be scoped to the services managed by Terraform.

For example:

```text
AWS Budgets
IAM
SNS
CloudWatch
S3
```

Permissions should be reviewed periodically and reduced when no longer required.

---

# 6.11 Automation Role

If automated cost optimization is introduced later, it should use a separate IAM role.

Example:

```text
Cost Optimization Automation Role
            │
            ├── Read EC2
            ├── Read EBS
            ├── Read RDS
            └── Read Tags
```

Initially, the role should operate in **recommendation-only mode**.

Resource modification permissions can be introduced later after testing and approval.

---

# 6.12 Production Protection

Production resources require additional controls.

The project will not automatically:

* Delete production EBS volumes
* Delete production snapshots
* Stop production EC2 instances
* Modify production RDS instances
* Delete production S3 data

Instead, these actions follow:

```text
Detection
   ↓
Recommendation
   ↓
Impact Assessment
   ↓
Owner Approval
   ↓
Change Request
   ↓
Maintenance Window
   ↓
Implementation
   ↓
Validation
```

---

# 6.13 Destructive Action Policy

Potentially destructive operations must be explicitly controlled.

Examples:

```text
Delete EBS Volume       → Approval required
Delete Snapshot         → Approval required
Delete S3 Data          → Approval required
Stop Production EC2     → Approval required
Modify Production RDS   → Approval required
```

This is one of the key safety principles of the project.

---

# 6.14 GitHub Repository Security

The GitHub repository should not contain:

* AWS access keys
* AWS secret keys
* Passwords
* API tokens
* Database credentials
* Private certificates
* Production configuration secrets

The `.gitignore` file should prevent accidental commits of sensitive files.

Example:

```text
*.tfstate
*.tfstate.*
.terraform/
.env
*.pem
*.key
secrets/
```

---

# 6.15 GitHub Actions Authentication

GitHub Actions should authenticate to AWS using **OIDC** rather than long-lived AWS access keys wherever possible.

Architecture:

```text
GitHub Actions
       │
       ▼
GitHub OIDC Token
       │
       ▼
AWS IAM Trust Policy
       │
       ▼
Terraform Deployment Role
       │
       ▼
AWS
```

Advantages:

* No permanent AWS access key stored in GitHub
* Short-lived credentials
* Better auditability
* Easier credential management
* Reduced credential leakage risk

---

# 6.16 GitHub Branch Protection

The main branch should be protected.

Recommended controls:

```text
main
 │
 ├── Pull Request required
 ├── Code review required
 ├── Terraform validation required
 ├── Security scan required
 └── Direct push restricted
```

Infrastructure changes should be introduced through pull requests.

---

# 6.17 Pull Request Workflow

The recommended workflow is:

```text
Developer
    │
    ▼
Feature Branch
    │
    ▼
Terraform Changes
    │
    ▼
Pull Request
    │
    ├── terraform fmt
    ├── terraform validate
    ├── terraform plan
    └── Security Scan
            │
            ▼
       Code Review
            │
            ▼
          Merge
            │
            ▼
       Deployment
```

This creates an auditable infrastructure change process.

---

# 6.18 Terraform State Security

Terraform state can contain sensitive infrastructure information.

Therefore:

* Terraform state should not be committed to Git.
* State should be stored remotely for team environments.
* State access should be restricted.
* State locking should be enabled where supported.
* State backups should be considered.

For an enterprise implementation, an S3-based remote backend with appropriate access controls can be used.

---

# 6.19 Encryption

AWS resources should use encryption where applicable.

Examples include:

* EBS encryption
* RDS encryption
* S3 encryption
* Terraform state encryption
* CloudWatch Logs encryption where required

Encryption requirements should be determined according to organizational security and compliance policies.

---

# 6.20 Monitoring and Auditing

Security and governance require visibility.

The implementation can use:

```text
CloudWatch
    │
    ├── Metrics
    ├── Logs
    └── Alarms

CloudTrail
    │
    └── AWS API activity
```

CloudTrail can help determine:

* Who changed a resource
* When the change occurred
* Which API action was performed
* Which AWS identity performed the action

This is useful for both security and operational investigations.

---

# 6.21 Cost Governance

Cost governance will be implemented using:

```text
AWS Budgets
     │
     ▼
Cost Thresholds
     │
     ▼
Notifications
     │
     ▼
Cloud/DevOps Team
```

Example thresholds:

```text
80%  → Warning
90%  → Critical Warning
100% → Budget Exceeded
```

The thresholds can be adjusted based on organizational requirements.

---

# 6.22 Cost Ownership

Each major AWS resource should have an identifiable owner.

Example:

```text
Application: Payments
Owner: Payments-Team
CostCenter: CC-1001
Environment: Production
```

This makes it easier to answer:

> "Who owns this AWS cost?"

Without ownership, cost optimization becomes difficult because teams may be unwilling or unable to validate resources.

---

# 6.23 Exception Management

Not every resource should be optimized automatically.

Examples of valid exceptions:

* Disaster recovery infrastructure
* High-availability resources
* Compliance workloads
* Performance-critical systems
* Business-critical databases
* Resources required for testing
* Backup infrastructure

An exception can be represented using a tag:

```text
CostOptimization = Exempt
```

Example:

```text
Environment       = Production
Application       = Payments
CostOptimization  = Exempt
ExemptionReason   = Business Critical
Owner             = Payments-Team
```

Exceptions should be reviewed periodically.

---

# 6.24 Cost Optimization Risk Matrix

| Action                    | Risk     | Automation |
| ------------------------- | -------- | ---------- |
| Identify unused EBS       | Low      | Allowed    |
| Generate recommendation   | Low      | Allowed    |
| Send cost alert           | Low      | Allowed    |
| Apply tags                | Low      | Controlled |
| Stop Dev EC2              | Medium   | Controlled |
| Stop Staging EC2          | Medium   | Controlled |
| Rightsize EC2             | Medium   | Approval   |
| Rightsize RDS             | Medium   | Approval   |
| Modify NAT architecture   | High     | Manual     |
| Delete Production EBS     | High     | Manual     |
| Delete Production S3 data | Critical | Manual     |

---

# 6.25 Governance Review Process

Cost and governance should be reviewed regularly.

Recommended monthly review:

```text
Monthly AWS Cost Review
          │
          ├── Total AWS Spend
          ├── Cost by Service
          ├── Cost by Environment
          ├── Cost by Application
          ├── Top Cost Increase
          ├── Optimization Opportunities
          ├── Realized Savings
          └── Exceptions
```

The review should produce an action list for the next month.

---

# 6.26 Security and Cost Optimization Balance

Cost optimization should follow this priority:

```text
Security
   ↓
Reliability
   ↓
Performance
   ↓
Compliance
   ↓
Cost Optimization
```

Cost should not be reduced by weakening security or reliability.

For example:

**Incorrect approach:**

> Delete all old backups to reduce storage costs.

**Correct approach:**

> Review backup retention requirements, identify redundant backups, validate compliance requirements, and then optimize retention safely.

---

# 6.27 Governance Checklist

Before implementing an optimization:

```text
[ ] Resource owner identified
[ ] Environment identified
[ ] Cost impact calculated
[ ] Business impact assessed
[ ] Security impact assessed
[ ] Risk classified
[ ] Backup requirements checked
[ ] Approval obtained
[ ] Change window identified
[ ] Rollback plan prepared
[ ] Monitoring configured
[ ] Savings validated
```

---

# 6.28 Target Governance Model

The final governance model is:

```text
                    AWS Environment
                           │
                           ▼
                   Resource Inventory
                           │
             ┌─────────────┼─────────────┐
             │             │             │
             ▼             ▼             ▼
          Tagging        IAM          Monitoring
             │             │             │
             └─────────────┼─────────────┘
                           │
                           ▼
                    Cost Governance
                           │
             ┌─────────────┼─────────────┐
             │             │             │
          Budgets     Optimization     Reporting
             │             │             │
             └─────────────┼─────────────┘
                           │
                           ▼
                    Review & Improve
```

---

# 6.29 Expected Outcome

After implementing the security and governance framework, the organization should have:

* Controlled AWS access
* Least-privilege IAM
* Standardized tagging
* Cost ownership
* Budget alerts
* Production protection
* Controlled infrastructure changes
* Secure GitHub Actions authentication
* Terraform-managed governance
* Auditable changes
* Repeatable cost reviews
* Controlled cost optimization automation

The result is a cost optimization framework that balances **cost, security, reliability, and operational risk**.

---

## Next Document

The next phase is:

`docs/07-results.md`

This document will show the **before vs. after results**, including:

* AWS cost reduction
* Monthly savings
* Annualized savings
* Optimization impact
* Operational improvements
* Key metrics
* Lessons learned
* Future improvements

