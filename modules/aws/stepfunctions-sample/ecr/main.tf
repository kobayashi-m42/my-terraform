locals {
  lifecycle_policy = <<EOF
  {
    "rules": [
      {
        "rulePriority": 10,
        "description": "Expire images count more than 5",
        "selection": {
          "tagStatus": "any",
          "countType": "imageCountMoreThan",
          "countNumber": 5
        },
        "action": {
          "type": "expire"
        }
      }
    ]
  }
EOF
}

resource "aws_ecr_repository" "step_functions_sync" {
  name = "${var.env}-stepfunctions-sync"
}

resource "aws_ecr_lifecycle_policy" "step_functions_sync" {
  repository = aws_ecr_repository.step_functions_sync.name
  policy = local.lifecycle_policy
}

resource "aws_ecr_repository" "step_functions_wait_token" {
  name = "${var.env}-stepfunctions-wait-token"
}

resource "aws_ecr_lifecycle_policy" "step_functions_wait_token" {
  repository = aws_ecr_repository.step_functions_wait_token.name
  policy = local.lifecycle_policy
}
