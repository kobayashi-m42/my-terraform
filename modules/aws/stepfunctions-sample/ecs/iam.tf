// for TaskRole
data "aws_iam_policy_document" "task_role_trust_relationship" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "task_role" {
  name               = "${var.role}-task-role"
  assume_role_policy = data.aws_iam_policy_document.task_role_trust_relationship.json
}

resource "aws_iam_role_policy" "task_role_step_functions" {
  name = "step-functions-policy"
  role = aws_iam_role.task_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "states:SendTaskSuccess",
            "states:SendTaskFailure",
            "states:SendTaskHeartbeat"
          ],
          "Resource": "*"
        }
    ]
}
EOF
}

// for ExecutionTaskRole
data "aws_iam_policy_document" "task_execution_trust_relationship" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "task_execution_role" {
  name = "${var.role}-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.task_execution_trust_relationship.json
}

resource "aws_iam_role_policy_attachment" "task_execution_role_attach" {
  role = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

