# AWS Cloud Cost Optimization & Governance Framework

![AWS](https://img.shields.io/badge/AWS-Cloud-orange)
![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4)
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-CI%2FCD-2088FF)
![Python](https://img.shields.io/badge/Python-Automation-3776AB)
![FinOps](https://img.shields.io/badge/FinOps-Cost%20Optimization-green)

## Overview

This project demonstrates a real-world **AWS Cloud Cost Optimization and Governance Framework** designed from a Cloud/DevOps engineering perspective.

The objective is to identify AWS infrastructure cost wastage, establish cost governance, implement controlled optimization, and create a repeatable process for monitoring and reducing unnecessary cloud expenditure.

The project uses a simulated enterprise AWS environment with an estimated monthly cloud spend of **$50,000**.

> **Important:** The AWS cost figures and savings presented in this repository are simulated case-study values. They are used to demonstrate the methodology and should not be interpreted as actual customer savings.

---

## Business Problem

A growing organization has accumulated increasing AWS infrastructure costs across:

* EC2
* RDS
* NAT Gateway
* EBS
* S3
* Data Transfer
* Other AWS services

The organization wants to reduce cloud expenditure without negatively affecting:

* Production availability
* Application performance
* Security
* Compliance
* Disaster recovery

The Cloud/DevOps team therefore needs a structured approach to:

1. Understand current AWS spending.
2. Identify unnecessary cloud expenditure.
3. Establish resource ownership.
4. Implement cost governance.
5. Identify optimization opportunities.
6. Automate safe and repeatable processes.
7. Measure the resulting impact.

---

## Project Objectives

The project focuses on:

* AWS cost analysis
* EC2 rightsizing
* RDS rightsizing
* Non-production scheduling
* EBS and snapshot optimization
* S3 lifecycle optimization
* NAT Gateway cost analysis
* Resource tagging
* AWS Budgets
* IAM least privilege
* Infrastructure as Code
* GitHub Actions CI/CD
* Cost monitoring
* Controlled automation
* Security and governance

---

## Target Outcome

The simulated baseline is:

```text
Monthly AWS Cost:       $50,000
```

The optimization assessment identified a potential:

```text
Monthly Saving:         $11,500
```

Target:

```text
Monthly AWS Cost:       $38,500
Potential Reduction:        23%
Annualized Saving:      $138,000
```

These values are **estimated case-study targets**, not claimed production results.

---

# Architecture

The high-level solution follows:

```text
                         AWS Environment
                               │
             ┌─────────────────┼─────────────────┐
             │                 │                 │
            EC2               RDS               S3
             │                 │                 │
             └─────────────────┼─────────────────┘
                               │
                               ▼
                      AWS Cost Management
                               │
                ┌──────────────┼──────────────┐
                │              │              │
             Budgets      Cost Analysis    Billing
                │              │
                └──────────────┘
                               │
                               ▼
                       Cost Governance
                               │
              ┌────────────────┼────────────────┐
              │                │                │
           Tagging            IAM          Monitoring
              │                │                │
              └────────────────┼────────────────┘
                               │
                               ▼
                         Optimization
                               │
                         Recommendation
                               │
                         Approval
                               │
                         Implementation
                               │
                         Validation
```

---

# Technology Stack

| Technology       | Purpose                   |
| ---------------- | ------------------------- |
| AWS              | Cloud infrastructure      |
| Terraform        | Infrastructure as Code    |
| AWS Budgets      | Cost governance           |
| IAM              | Access control            |
| CloudWatch       | Monitoring                |
| SNS              | Notifications             |
| GitHub Actions   | CI/CD                     |
| Python           | Lightweight cost analysis |
| GitHub           | Source control            |
| FinOps practices | Cost management           |

---

# Repository Structure

```text
aws-cost-optimization-case-study/
│
├── README.md
│
├── docs/
│   ├── 01-business-scenario.md
│   ├── 02-current-state.md
│   ├── 03-cost-analysis.md
│   ├── 04-optimization-plan.md
│   ├── 05-implementation.md
│   ├── 06-security-governance.md
│   └── 07-results.md
│
├── terraform/
│   ├── budgets/
│   ├── iam/
│   ├── monitoring/
│   └── tagging/
│
├── github-actions/
│   └── terraform-pipeline.yml
│
├── scripts/
│   └── small-cost-checks.py
│
├── dashboards/
│   └── aws-cost-dashboard.png
│
└── architecture/
    └── architecture.png
```

---

# Project Implementation

## 1. Cost Analysis

The initial simulated AWS monthly spend is:

| Service         | Monthly Cost |
| --------------- | -----------: |
| EC2             |      $18,000 |
| RDS             |      $10,000 |
| NAT Gateway     |       $6,000 |
| Data Transfer   |       $5,000 |
| EBS & Snapshots |       $4,000 |
| S3              |       $3,000 |
| Other           |       $4,000 |
| **Total**       |  **$50,000** |

The analysis identifies potential optimization opportunities across compute, database, storage, networking, and non-production workloads.

See:

[`docs/03-cost-analysis.md`](docs/03-cost-analysis.md)

---

## 2. Optimization Strategy

The project follows:

```text
Identify
   ↓
Analyze
   ↓
Recommend
   ↓
Assess Risk
   ↓
Approve
   ↓
Implement
   ↓
Monitor
   ↓
Validate Savings
```

This prevents unsafe automatic changes to production infrastructure.

See:

[`docs/04-optimization-plan.md`](docs/04-optimization-plan.md)

---

## 3. Terraform

Terraform is used to manage cloud governance infrastructure.

Current implementation:

```text
terraform/
└── budgets/
    ├── main.tf
    ├── variables.tf
    └── outputs.tf
```

The AWS Budget implementation provides:

* Monthly spending threshold
* Forecasted spending alerts
* Actual spending alerts
* Configurable notification email
* Terraform-managed configuration

Additional Terraform components will be added for:

* IAM
* Monitoring
* Tagging

---

## 4. Security and Governance

The project follows:

* Least-privilege IAM
* Production protection
* Infrastructure as Code
* Resource tagging
* Controlled changes
* Pull-request-based deployment
* GitHub OIDC authentication
* Terraform state protection
* Monitoring and auditing

See:

[`docs/06-security-governance.md`](docs/06-security-governance.md)

---

# Cost Optimization Opportunities

| Optimization              | Potential Monthly Saving | Risk        |
| ------------------------- | -----------------------: | ----------- |
| EC2 Rightsizing           |                   $4,500 | Medium      |
| Non-Production Scheduling |                   $2,500 | Low/Medium  |
| RDS Rightsizing           |                   $2,000 | Medium      |
| EBS & Snapshots           |                   $1,000 | Low         |
| NAT Gateway               |                   $1,000 | Medium/High |
| S3 Optimization           |                     $500 | Low         |
| **Total**                 |              **$11,500** |             |

---

# Safety Approach

This project does **not** blindly delete or modify AWS resources.

For potentially destructive operations, the workflow is:

```text
Detection
    ↓
Recommendation
    ↓
Owner Review
    ↓
Risk Assessment
    ↓
Approval
    ↓
Implementation
    ↓
Monitoring
    ↓
Savings Validation
```

Production resources require additional approval and change management.

---

# CI/CD Strategy

Terraform changes will eventually follow:

```text
Developer
    │
    ▼
Feature Branch
    │
    ▼
Pull Request
    │
    ▼
GitHub Actions
    │
    ├── Terraform Format
    ├── Terraform Validate
    ├── Terraform Plan
    └── Security Scan
             │
             ▼
        Code Review
             │
             ▼
          Approval
             │
             ▼
       Terraform Apply
```

---

# Current Implementation Status

| Component                | Status     |
| ------------------------ | ---------- |
| Business Scenario        | ✅ Complete |
| Current State Assessment | ✅ Complete |
| Cost Analysis            | ✅ Complete |
| Optimization Plan        | ✅ Complete |
| Implementation Design    | ✅ Complete |
| Security & Governance    | ✅ Complete |
| Results & Outcomes       | ✅ Complete |
| AWS Budget Terraform     | ✅ Complete |
| IAM Terraform            | ⏳ Planned  |
| Monitoring Terraform     | ⏳ Planned  |
| Tagging Terraform        | ⏳ Planned  |
| Cost Analysis Script     | ⏳ Planned  |
| GitHub Actions           | ⏳ Planned  |
| Dashboard                | ⏳ Planned  |
| Architecture Diagram     | ⏳ Planned  |

---

# Key Cloud/DevOps Concepts Demonstrated

This project demonstrates practical experience with:

### AWS

* Cost management
* EC2
* RDS
* EBS
* S3
* VPC/NAT Gateway
* IAM
* CloudWatch
* AWS Budgets
* SNS

### DevOps

* Terraform
* Infrastructure as Code
* Git
* GitHub
* GitHub Actions
* CI/CD
* Security scanning
* Change management

### Cloud Governance

* Tagging strategy
* Resource ownership
* Least privilege
* Budget controls
* Cost allocation
* Production protection
* Optimization governance

### FinOps

* Cost visibility
* Cost allocation
* Rightsizing
* Waste identification
* Savings estimation
* Continuous optimization

---

# Project Roadmap

## Phase 1 — Documentation

* [x] Business scenario
* [x] Current-state assessment
* [x] Cost analysis
* [x] Optimization plan
* [x] Implementation design
* [x] Security and governance
* [x] Results

## Phase 2 — Terraform

* [x] AWS Budget
* [ ] IAM
* [ ] Monitoring
* [ ] Tagging

## Phase 3 — Automation

* [ ] Cost analysis script
* [ ] Resource detection
* [ ] Recommendation reporting
* [ ] GitHub Actions
* [ ] Security scanning

## Phase 4 — Reporting

* [ ] AWS cost dashboard
* [ ] Architecture diagram
* [ ] Before/after visualization
* [ ] Optimization report

---

# Disclaimer

This repository is a **portfolio and learning case study**.

The AWS architecture, cost figures, utilization assumptions, optimization opportunities, and savings estimates are simulated for demonstration purposes.

No actual customer data or confidential infrastructure information is included.

The project is designed to demonstrate how a Cloud/DevOps engineer can approach AWS cost optimization using infrastructure, governance, automation, security, and operational best practices.
