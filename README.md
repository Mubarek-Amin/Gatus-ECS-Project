gatus-ecs-project/
├── app/
│   ├── Dockerfile
│   └── config.yaml
│
├── infra/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── ecs/
│       ├── cluster.tf
│       ├── service.tf
│       ├── task_definition.tf
│       ├── load_balancer.tf
│       ├── vpc.tf
│       └── ecr.tf
│
└── .github/
    └── workflows/
        └── deploy.yml
