resource "aws_ecr_repository" "gatus_repo" {
    name = "gatus_repo"
    
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
      scan_on_push = true
    }
}

resource "aws_ecr_repository_policy" "repo_policy" {
  repository = aws_ecr_repository.gatus_repo.id
  policy = jsonencode({
    version = "200"
  })
}