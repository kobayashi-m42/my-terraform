resource "aws_ecs_cluster" "app" {
  name = var.ecs_cluster_name
}

resource "aws_cloudwatch_log_group" "app" {
  name = var.cloudwatch_logname
}
