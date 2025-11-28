resource "aws_iam_role" "ecs_task_execution" {
  name = "ecs-task-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy" "terraform_state_access" {
  name        = "TerraformStateAccess"
  description = "Allows Terraform to read/write state and acquire locks"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
          "dynamodb:UpdateItem"
        ]
        Resource = [
          "arn:aws:s3:::${var.terraform_state_bucket}/*",
          "arn:aws:dynamodb:${var.region}:${var.account_id}:table/${var.dynamodb_table_name}"
        ]
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "terraform_attach" {
  user       = var.terraform_user_name
  policy_arn = aws_iam_policy.terraform_state_access.arn
}
