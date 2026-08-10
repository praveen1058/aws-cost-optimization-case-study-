
# 4. AWS Cost Optimization Plan

## 4.1 Objective

The objective of this phase is to convert the cost analysis findings into a controlled and measurable implementation plan.

The optimization strategy will focus on reducing unnecessary AWS expenditure while protecting:

* Production availability
* Application performance
* Security
* Compliance
* Backup and disaster recovery
* Operational stability

The target is to reduce the simulated AWS monthly spend from approximately **$50,000 to $38,500**, representing a potential **23% reduction**.

> **Note:** The costs and savings in this case study are simulated estimates for demonstration purposes.

---

# 4.2 Optimization Strategy

The implementation will follow four stages:

```text
                Cost Analysis
                      │
                      ▼
              ┌───────────────┐
              │ Identification│
              │   of Waste    │
              └───────┬───────┘
                      │
                      ▼
              ┌───────────────┐
              │ Recommendation│
              └───────┬───────┘
                      │
                      ▼
              ┌───────────────┐
              │ Approval &    │
              │ Risk Review   │
              └───────┬───────┘
                      │
                      ▼
              ┌───────────────┐
              │ Implementation│
              └───────┬───────┘
                      │
                      ▼
              ┌───────────────┐
              │ Monitoring &  │
              │ Validation    │
              └───────────────┘
```

The project will follow a **recommendation-first** approach.

Potentially destructive actions will not be automatically executed without validation and approval.

---

# 4.3 Optimization Phases

## Phase 1 — Visibility and Governance

### Objective

Establish visibility into AWS spending and resource ownership before making infrastructure changes.

### Activities

* Configure AWS Budgets
* Configure cost alerts
* Define tagging standards
* Identify resource owners
* Categorize costs by environment
* Categorize costs by application
* Establish monthly cost review
* Document optimization candidates

### Expected Outcome

The organization should be able to answer:

* How much are we spending?
* Which AWS service costs the most?
* Which environment is consuming the most?
* Which application owns the resource?
* Who is responsible for the resource?
* Where are the biggest optimization opportunities?

### Priority

**High**

### Risk

**Low**

---

# 4.4 Phase 2 — Quick-Win Optimization

The second phase focuses on optimization activities that have relatively low operational risk.

### Activities

#### EBS

Identify:

* Unattached EBS volumes
* Old snapshots
* Unused storage

Actions:

* Validate ownership
* Confirm retention requirements
* Create cleanup recommendations
* Remove resources only after approval

---

#### S3

Review:

* Storage classes
* Object age
* Lifecycle policies
* Retention requirements

Actions:

* Introduce lifecycle policies where appropriate
* Move infrequently accessed data to appropriate storage classes
* Review unnecessary retention

---

#### Non-Production

Identify development and staging resources that do not require 24×7 availability.

Potential schedule:

```text
Start: 08:00
Stop:  20:00

Days:
Monday - Friday
```

Production resources will be excluded.

### Expected Outcome

Estimated savings:

**$4,000/month**

from quick-win optimization activities.

---

# 4.5 Phase 3 — Rightsizing and Infrastructure Optimization

This phase addresses higher-value optimization opportunities.

## EC2 Rightsizing

### Assessment

Review historical utilization for:

* CPU
* Memory
* Network
* Disk
* Application performance

### Process

```text
Identify Instance
       │
       ▼
Review Utilization
       │
       ▼
Check Application Requirements
       │
       ▼
Identify Target Instance
       │
       ▼
Estimate Savings
       │
       ▼
Application Owner Approval
       │
       ▼
Change During Maintenance Window
       │
       ▼
Monitor
```

### Estimated Opportunity

**$4,500/month**

---

# 4.6 RDS Rightsizing

RDS optimization will follow a similar controlled process.

### Metrics

The following metrics will be reviewed:

* CPU utilization
* Freeable memory
* Database connections
* Read IOPS
* Write IOPS
* Storage
* Network throughput
* Application performance

### Change Process

```text
Utilization Analysis
        ↓
Rightsizing Recommendation
        ↓
Performance Validation
        ↓
Change Approval
        ↓
Maintenance Window
        ↓
Implementation
        ↓
Post-Change Monitoring
```

### Estimated Opportunity

**$2,000/month**

---

# 4.7 Phase 4 — Network Cost Optimization

Networking costs will be reviewed separately because reducing network costs often requires architectural changes.

## NAT Gateway

Current estimated cost:

**$6,000/month**

### Assessment Areas

* NAT Gateway data processing
* Traffic volume
* Cross-AZ traffic
* AWS service access patterns
* Application traffic patterns

### Potential Improvements

Evaluate:

* S3 Gateway Endpoint
* DynamoDB Gateway Endpoint
* Interface VPC Endpoints
* NAT architecture
* Cross-AZ traffic patterns

### Important Consideration

VPC architecture changes can affect application connectivity.

Therefore, network optimization will require:

* Architecture review
* Application validation
* Security review
* Change approval
* Testing
* Monitoring

### Estimated Opportunity

**$1,000/month**

---

# 4.8 Optimization Risk Classification

Every optimization activity will be classified according to operational risk.

| Optimization                 | Risk   | Approval                 |
| ---------------------------- | ------ | ------------------------ |
| Cost alerts                  | Low    | Standard                 |
| Resource tagging             | Low    | Standard                 |
| Budget configuration         | Low    | Standard                 |
| EBS identification           | Low    | Standard                 |
| S3 lifecycle review          | Low    | Standard                 |
| Non-prod scheduling          | Medium | Team approval            |
| EC2 rightsizing              | Medium | Application approval     |
| RDS rightsizing              | Medium | DBA/Application approval |
| NAT architecture changes     | High   | Architecture approval    |
| Production resource deletion | High   | Explicit approval        |

---

# 4.9 Automation Strategy

The project will use a **detect → recommend → approve → implement** model.

```text
AWS Resources
      │
      ▼
Cost / Utilization Data
      │
      ▼
Detection
      │
      ▼
Optimization Recommendation
      │
      ▼
Report / Dashboard
      │
      ▼
Approval
      │
      ▼
Terraform / Controlled Automation
      │
      ▼
AWS Infrastructure
      │
      ▼
Monitoring
```

Automation should initially focus on **visibility and recommendations**.

Automatic deletion or modification of production resources will not be enabled.

---

# 4.10 Terraform Strategy

Terraform will be used to manage the governance and supporting infrastructure.

Terraform-managed components include:

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

Terraform will provide:

* Repeatable infrastructure
* Version control
* Change tracking
* Review through pull requests
* Consistent environments
* Reduced configuration drift

---

# 4.11 GitHub Actions Strategy

Terraform changes will be integrated with GitHub Actions.

The pipeline will follow:

```text
Developer
    │
    ▼
Git Push / Pull Request
    │
    ▼
GitHub Actions
    │
    ├── Terraform Format
    │
    ├── Terraform Validate
    │
    ├── Security Scan
    │
    └── Terraform Plan
            │
            ▼
       Pull Request
            │
            ▼
       Code Review
            │
            ▼
      Manual Approval
            │
            ▼
       Terraform Apply
```

The pipeline will prevent unreviewed infrastructure changes from being deployed.

---

# 4.12 Cost Optimization Controls

The following controls will be implemented as part of the project.

## Budget Control

Configure AWS Budgets with thresholds such as:

```text
80%  → Warning
90%  → Alert
100% → Critical Alert
```

---

## Tagging Control

Standard tags:

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

# 4.13 Change Management

Cost optimization changes will follow a controlled change process.

```text
Optimization Candidate
        ↓
Business Impact Assessment
        ↓
Risk Classification
        ↓
Savings Estimate
        ↓
Application Owner Review
        ↓
Change Approval
        ↓
Implementation
        ↓
Monitoring
        ↓
Savings Validation
```

For production resources, rollback procedures must be defined before implementation.

---

# 4.14 Savings Validation

Cost reduction will not be considered successful simply because a resource was changed.

Savings will be validated after implementation.

### Example

Before optimization:

```text
EC2 Cost
$18,000/month
```

After optimization:

```text
EC2 Cost
$13,500/month
```

Potential reduction:

```text
$4,500/month
```

The actual result will be compared with the original baseline.

---

# 4.15 Target Savings

The optimization plan targets:

| Area                      | Target Monthly Saving |
| ------------------------- | --------------------: |
| EC2 Rightsizing           |                $4,500 |
| Non-Production Scheduling |                $2,500 |
| RDS Rightsizing           |                $2,000 |
| EBS & Snapshots           |                $1,000 |
| NAT Gateway               |                $1,000 |
| S3                        |                  $500 |
| **Total**                 |           **$11,500** |

### Target Result

```text
Current Cost:       $50,000/month

Target Saving:      $11,500/month

Target Cost:        $38,500/month

Target Reduction:       23%
```

---

# 4.16 Implementation Roadmap

The project will be implemented in the following order:

### Sprint 1 — Visibility

* Establish cost baseline
* Define tagging strategy
* Configure AWS Budgets
* Configure alerts
* Document ownership

### Sprint 2 — Quick Wins

* Identify unattached EBS
* Review snapshots
* Review S3 lifecycle
* Identify non-production scheduling opportunities

### Sprint 3 — Compute and Database

* Analyze EC2 utilization
* Create rightsizing recommendations
* Analyze RDS utilization
* Create RDS rightsizing recommendations

### Sprint 4 — Networking

* Analyze NAT Gateway costs
* Review VPC traffic
* Evaluate VPC endpoints
* Identify unnecessary data transfer

### Sprint 5 — Automation

* Terraform governance infrastructure
* GitHub Actions pipeline
* Cost reporting
* Optimization checks

### Sprint 6 — Validation

* Compare before/after costs
* Validate application performance
* Validate availability
* Document realized savings
* Establish continuous cost review

---

# 4.17 Definition of Success

The project will be considered successful when:

* AWS cost visibility is established.
* Resources have standardized ownership tags.
* Budget alerts are configured.
* Cost optimization opportunities are documented.
* Quick-win optimizations are implemented safely.
* EC2 and RDS rightsizing candidates are identified.
* Terraform manages governance infrastructure.
* GitHub Actions validates infrastructure changes.
* Production workloads remain stable.
* Cost savings are measurable and documented.
* A repeatable monthly cost optimization process is established.

---

## Next Document

The next phase is:

`docs/05-implementation.md`

This document will describe the **actual AWS implementation**, including Terraform, AWS Budgets, IAM, tagging, CloudWatch, and GitHub Actions.
