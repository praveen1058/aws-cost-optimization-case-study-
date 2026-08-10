# 2. Current State Assessment

## AWS Environment

The organization operates multiple AWS environments:

| Environment     | Purpose                                    | Criticality |
| --------------- | ------------------------------------------ | ----------- |
| Production      | Customer-facing workloads                  | High        |
| Staging         | Pre-production validation                  | Medium      |
| Development     | Engineering workloads                      | Low         |
| Shared Services | Monitoring, networking and common services | High        |

---

## Initial Monthly AWS Spend

The environment has an estimated monthly AWS spend of approximately **$50,000**.

| AWS Service     | Monthly Cost | Percentage |
| --------------- | -----------: | ---------: |
| EC2             |      $18,000 |        36% |
| RDS             |      $10,000 |        20% |
| NAT Gateway     |       $6,000 |        12% |
| EBS & Snapshots |       $4,000 |         8% |
| S3              |       $3,000 |         6% |
| Data Transfer   |       $5,000 |        10% |
| Other Services  |       $4,000 |         8% |
| **Total**       |  **$50,000** |   **100%** |

> Note: The figures represent a simulated enterprise AWS environment created for this case study. They are used to demonstrate the cost optimization methodology and are not production customer data.

---

## Initial Findings

### EC2

The initial review identified:

* Underutilized EC2 instances
* Oversized instances
* Non-production instances running outside working hours
* Lack of consistent scheduling policies
* Inconsistent resource tagging

### RDS

Potential optimization areas include:

* Oversized database instances
* Low utilization during non-business hours
* Development databases running continuously
* Lack of standardized sizing reviews

### EBS

Potential storage waste includes:

* Unattached EBS volumes
* Older snapshots
* Volumes that could potentially migrate from gp2 to gp3

### NAT Gateway

NAT Gateway costs require investigation because of:

* High data processing
* Private workloads accessing AWS services through NAT
* Potential opportunities for VPC endpoints

### S3

Potential optimization opportunities include:

* Objects with long retention periods
* Lack of lifecycle policies
* Infrequently accessed data stored in higher-cost storage classes

---

## Governance Gaps

The assessment identified the following governance gaps:

* Inconsistent tagging
* No standardized cost-center tagging
* Limited budget alerting
* No documented cost ownership
* No regular cost review process
* Limited visibility into cost by environment

---

## Risk Considerations

Cost optimization changes must not negatively affect:

* Production availability
* Application performance
* Disaster recovery
* Security controls
* Compliance requirements
* Backup and retention requirements

Therefore, optimization actions will be categorized as **Low, Medium, or High Risk** before implementation.

