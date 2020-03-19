// for stepfunctions (sync)
data "aws_iam_policy_document" "step_functions_sync_role_trust_relationship" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "step_functions_sync_role" {
  name               = "${var.role}-stepfunctions-sync-role"
  assume_role_policy = data.aws_iam_policy_document.step_functions_sync_role_trust_relationship.json
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "aws_iam_role_policy" "step_functions_sync_policy" {
  name = "stepfunctions-sync-policy"
  role = aws_iam_role.step_functions_sync_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecs:RunTask",
                "ecs:StopTask",
                "ecs:DescribeTasks",
                "iam:PassRole"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "events:PutTargets",
                "events:PutRule",
                "events:DescribeRule"
            ],
            "Resource": [
               "arn:aws:events:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:rule/StepFunctionsGetEventsForECSTaskRule"
            ]
        }
    ]
}
EOF
}

// for stepfunctions (waitForTaskToken)
data "aws_iam_policy_document" "step_functions_wait_role_trust_relationship" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "step_functions_wait_role" {
  name = "${var.role}-stepfunctions-wait-role"
  assume_role_policy = data.aws_iam_policy_document.step_functions_wait_role_trust_relationship.json
}

resource "aws_iam_role_policy" "step_functions_wait_policy" {
  name = "stepfunctions-wait-policy"
  role = aws_iam_role.step_functions_wait_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "ecs:RunTask",
            "iam:PassRole"
          ],
          "Resource": "*"
        }
    ]
}
EOF
}
