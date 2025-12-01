Gatus ECS Project
Table of Contents

Project Overview

Architecture

Folder Structure

Infrastructure

Application

Deployment

Environment Variables / Configuration

Contributing

Project Overview

This project deploys Gatus, a service monitoring tool, on AWS ECS Fargate using Terraform.

Key features:

Containerised deployment using Docker

ECS Fargate for serverless container execution

Public ALB routing to ECS tasks

Infrastructure as code via Terraform modules

CI/CD pipeline with GitHub Actions

Components include VPC, ALB, ECS, ACM, ECR, Security Groups, IAM, Route 53

Architecture

High-level traffic flow:

[Internet] → [ALB] → [ECS Tasks / Containers] → [Services monitored by Gatus]


ALB: Public-facing load balancer

ECS Tasks: Runs Gatus container in private subnets

NAT Gateway: Provides outbound internet access for ECS tasks

Route 53: Manages DNS records for domain/subdomain

Terraform Modules: Modular infrastructure for maintainability

Folder Structure
gatus-ecs-project/
├── app/
│   ├── Dockerfile         # Dockerfile for Gatus container
│   ├── config.yml         # Gatus service monitoring config
│   └── main.go            # Entry point for any custom app logic
│
├── infra/
│   ├── main.tf            # Root Terraform configuration
│   ├── variables.tf       # Root variables
│   ├── provider.tf        # Provider configuration (AWS)
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
        ├── ci.yaml          # CI: build Docker, scan, push to ECR
        └── cd.yaml          # CD: Terraform apply, update ECS tasks
        └── manual-destroy.yml

Infrastructure
Terraform Modules

VPC: Creates public/private subnets, route tables, NAT Gateway

ALB: Configures Application Load Balancer, listener, target groups

ECS: ECS cluster, service, task definitions

ACM: SSL/TLS certificate for secure HTTPS

ECR: Docker image repository

Security Groups: Manages access for ALB and ECS tasks

IAM: ECS task execution roles, service roles

Route 53: DNS records pointing domain/subdomain to ALB

Terraform modules allow for modular, reusable, and maintainable infrastructure.

Application

Dockerfile: Builds the Gatus container

config.yml: Configures which services to monitor

main.go: Custom application logic (if needed)

Docker images are built and pushed to ECR using GitHub Actions, with commit SHA tags for versioning.

Deployment
CI/CD Pipeline

CI Workflow (ci.yaml)

Checks out code

Builds Docker image from /app

Scans image for vulnerabilities

Pushes Docker image to ECR

CD Workflow (cd.yaml)

Runs Terraform plan and apply

Updates ECS service with the new image tag (commit SHA)

Performs zero-downtime deployments via ECS Fargate

Manual Terraform Commands
cd infra
terraform init
terraform plan
terraform apply -auto-approve

Environment Variables / Configuration

TF_VAR_gatus_image_tag: Docker image tag for ECS service

AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY: AWS credentials

ECR_REPO: Name of ECR repository

Contributing

Fork the repository

Make changes in /app or /infra

Push changes to a feature branch

Submit a pull request for review

CI/CD workflows handle Docker build, image push, and ECS deployment