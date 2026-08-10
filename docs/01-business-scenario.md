# 1. Business Scenario

## Overview

A mid-sized organization is running its application workloads on Amazon Web Services (AWS).

The AWS environment has grown rapidly over time as development, testing, staging, and production workloads have been added.

As the environment grew, cloud spending also increased. The organization wants to reduce AWS infrastructure costs without negatively impacting production availability, performance, security, or reliability.

The Cloud/DevOps team has been asked to perform a cost optimization assessment and implement appropriate governance and automation controls.

---

## Business Challenge

The organization is currently spending approximately **$50,000 per month** on AWS.

The initial assessment identified several potential areas of cost optimization:

* Underutilized EC2 instances
* Oversized EC2 and RDS resources
* Development and staging environments running 24/7
* Unattached EBS volumes
* Old EBS snapshots
* High NAT Gateway data-processing costs
* Missing or inconsistent resource tagging
* Lack of centralized AWS budget alerts
* Limited visibility into cost by environment and application

The objective is to reduce unnecessary cloud expenditure while maintaining production reliability.

---

## Objectives

The primary objectives of this initiative are:

1. Analyze AWS infrastructure and identify potential cost wastage.
2. Identify rightsizing opportunities for compute and database resources.
3. Reduce unnecessary non-production runtime.
4. Identify unused storage resources.
5. Review networking-related AWS costs.
6. Implement AWS cost governance and tagging standards.
7. Configure AWS budget and cost alerts.
8. Manage governance infrastructure using Terraform.
9. Integrate Terraform with GitHub Actions.
10. Establish a repeatable process for ongoing cost optimization.

---

## Target Outcome

The project targets approximately **20–25% cost reduction** from the initial monthly AWS spend.

The optimization approach will prioritize:

* Production safety
* Controlled changes
* Manual approval for potentially disruptive actions
* Infrastructure as Code
* Monitoring and reporting
* Governance
* Continuous optimization

The goal is not simply to reduce the AWS bill, but to establish a sustainable cloud cost management process.

