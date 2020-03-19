locals {
  env                = "dev"
  role               = "stepfunctions-sample"
  ecs_cluster_name   = "${local.env}-${local.role}"
  ecs_sg_name        = "${local.env}-${local.role}"
  cloudwatch_logname = "${local.env}-${local.role}"
}
