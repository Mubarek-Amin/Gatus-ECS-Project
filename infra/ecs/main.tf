resource "aws_ecs_cluster" "gatus-cluster" {
  name = "gatus-cluster"


}

resource "aws_cloudwatch_log_group" "gatus" {
  name              = "gatus_ecs_cloudwatch"
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "gatus-task" {
  family                   = "gatus_task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn
  container_definitions = jsonencode([
    {
      name  = "gatus"
      image = "${var.gatus_image}:${var.gatus_image_tag}"

      portMappings = [{
        containerPort = 8080
        protocol      = "tcp"
      }]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.gatus.name
          awslogs-stream-prefix = "ecs"
          awslogs-region        = var.region
        }
      }
    }
  ])



}
resource "aws_ecs_service" "gatus-service" {
  name             = "gatus-service"
  cluster          = aws_ecs_cluster.gatus-cluster.id
  task_definition  = aws_ecs_task_definition.gatus-task.arn
  desired_count    = 2
  launch_type      = "FARGATE"
  platform_version = "LATEST"
  propagate_tags   = "SERVICE"

  health_check_grace_period_seconds = 60

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "gatus"
    container_port   = 8080
  }

  network_configuration {
    assign_public_ip = false
    subnets          = var.private_subnet_ids
    security_groups  = [var.ecs_sg_id]
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }


}