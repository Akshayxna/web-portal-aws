# 🚀 Secure Web Portal: AWS 3-Tier Modular Infrastructure

[![Terraform](https://img.shields.io/badge/Terraform-1.0+-623CE4.svg?style=flat&logo=terraform)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-Cloud-232F3E.svg?style=flat&logo=amazon-aws)](https://aws.amazon.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 📌 Project Overview
This repository demonstrates a **production-grade, 3-tier networking and compute stack** deployed on AWS using Terraform. As part of my transition from App Support to **DevOps/SRE**, this project focuses on automation, modularity, and high availability.

I have moved away from monolithic EC2 deployments to a modern, **serverless containerized architecture** using AWS ECS Fargate, ensuring the infrastructure is scalable, cost-effective, and easy to maintain.

---

## 🏗️ Architecture Design
The project follows a "Conductor" pattern where the root configuration orchestrates specialized, reusable modules:

* **Networking (VPC Module):** Isolated Public and Private subnets across multiple AZs with NAT Gateways for secure egress.
* **Load Balancing (ALB Module):** Entry point for user traffic, utilizing `ip` based target groups for ECS Fargate compatibility.
* **Compute (ECS App Module):** Serverless container orchestration. No OS management, automated scaling, and IAM-restricted execution.
* **Storage (DB Module):** Amazon RDS (Aurora/MySQL) cluster placed in private subnets, allowing traffic **only** from the Application Security Group.

---

## 📂 Repository Structure

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

🛠️ Technical Skill Set DemonstratedCategoryTools/Features UsedIaCTerraform (Modules, Remote State Locking, Input/Output Mapping)CloudAWS (VPC, ECS Fargate, RDS, ALB, IAM)SecurityLeast Privilege IAM, Security Group Chaining, Private SubnetsSRE FocusRoot Cause Analysis (RCA) on 503 errors, State Consistency, Idempotency🚀 Deployment Guide1. PrerequisitesTerraform v1.0+ installed.AWS CLI configured with IAM permissions.A terraform.tfvars file created locally (not in Git) to store db_username and db_pass.2.

Initialization
terraform init

3. ExecutionBash# Preview the infrastructure changes
terraform plan

# Deploy to AWS
terraform apply

💡 Engineering Insights (The "SRE" Journey)Module Decoupling: Designed the DB module to accept allowed_security_groups as a variable, ensuring the database is never exposed to the public internet.Fargate Networking: Resolved critical 503 Service Unavailable errors by correctly mapping the ALB Target Group to ip type to support Fargate's ENI-based networking.State Integrity: Configured S3 for remote state storage to ensure a single source of truth for the infrastructure.

📬 Connect with MeAkshay - https://www.linkedin.com/in/akshay-krishna-0k/
