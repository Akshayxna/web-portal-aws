# 🚀 Secure Web Portal: AWS 3-Tier Modular Infrastructure

## 📂 Repository Structure
```text
web-portal-project/
├── main.tf                 # The "Conductor" - Connects all modules
├── variables.tf            # Global variables (Region, Project Name)
├── terraform.tfvars        # Secrets (Ignored by Git)
├── outputs.tf              # Final outputs (e.g., Website URL)
├── .gitignore              # Protects against state/secret leakage
└── modules/                # Reusable Infrastructure Components
    ├── vpc/                # Networking: VPC, Subnets, IGW, Route Tables
    ├── alb/                # Load Balancing: ALB, Listeners, Target Groups
    ├── ecs_app/            # Compute: ECS Cluster, Task Def, Service
    └── db/                 # Data: RDS Cluster, Instances, Security Groups

🛠️ Technical SkillSet Demonstrated
Category Tools/Features Used
IaC  Terraform (Modules, Remote State Locking, Input/Output Mapping)
Cloud AWS (VPC, ECS Fargate, RDS, ALB, IAM)
Security Least Privilege IAM, Security Group Chaining, Private Subnets
SRE Focus Root Cause Analysis (RCA) on 503 errors, State Consistency, Idempotency

🚀 Deployment Guide

1.Prerequisites
Terraform v1.0+ installed.
AWS CLI configured with IAM permissions.
A terraform.tfvars file created locally (not in Git) to store db_username and db_pass.

2. Initialization
terraform init

3. Execution
# Preview the infrastructure changes
terraform plan

# Deploy to AWS
terraform apply


💡 Engineering Insights (The "SRE" Journey)
Module Decoupling: Designed the DB module to accept allowed_security_groups as a variable, ensuring the database is never exposed to the public internet.
Fargate Networking: Resolved critical 503 Service Unavailable errors by correctly mapping the ALB Target Group to ip type to support Fargate's ENI-based networking.
State Integrity: Configured S3 for remote state storage to ensure a single source of truth for the infrastructure.

📬 Connect with Me Akshay - https://www.linkedin.com/in/akshay-krishna-0k/
