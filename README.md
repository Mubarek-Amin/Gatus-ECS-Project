# Gatus ECS Project

## Table of Contents
1. [Project Overview](#project-overview)  
2. [Architecture](#architecture)  
3. [Folder Structure](#folder-structure)  
4. [Infrastructure](#infrastructure)  
5. [Application](#application)  
6. [Deployment](#deployment)  
7. [Environment Variables / Configuration](#environment-variables--configuration)  
8. [Contributing](#contributing)  

---

## Project Overview
This project deploys **Gatus**, a service monitoring tool, on **AWS ECS Fargate** using **Terraform**.  

Key features:  
- Containerized deployment using **Docker**  
- ECS Fargate for serverless container execution  
- Public-facing **ALB** routing to ECS tasks  
- Infrastructure as code via **Terraform modules**  
- CI/CD pipeline with **GitHub Actions**  
- Infrastructure includes **VPC, ALB, ECS, ACM, ECR, Security Groups, IAM, Route 53**  

---

## Architecture
High-level traffic flow:


- **ALB**: Public-facing load balancer for routing traffic  
- **ECS Tasks**: Runs Gatus container in private subnets  
- **NAT Gateway**: Provides outbound internet access for ECS tasks  
- **Route 53**: Manages DNS records pointing domain/subdomain to ALB  
- **Terraform Modules**: Modular, reusable infrastructure for maintainability  

---

## Folder Structure

```text
gatus-ecs-project/
├── app/
│   ├── Dockerfile
│   ├── config.yaml         
│   ├── go.mod
│   ├── go.sum        
│   └── main.go           
│
├── infra/
│   ├── main.tf            
│   ├── variables.tf       
│   ├── provider.tf        
│   └── modules/
│       ├── vpc/
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── alb/
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── ecs/
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── acm/
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── ecr/
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── security_groups/
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── iam/
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       └── route53/
│           ├── main.tf
│           ├── variables.tf
│           └── outputs.tf
│
└── .github/
    └── workflows/
        ├── ci.yml          # CI: build Docker, scan, push to ECR
        ├── cd.yml          # CD: Terraform apply, update ECS tasks
        └── manual-destroy.yml