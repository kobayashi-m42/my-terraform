module "ecr" {
  source = "../../../../modules/aws/stepfunctions-sample/ecr"

  env = local.env
}

module "ecs" {
  source = "../../../../modules/aws/stepfunctions-sample/ecs"

  env                = local.env
  role               = local.role
  vpc_id             = data.terraform_remote_state.network.outputs.vpc_id
  ecs_cluster_name   = local.ecs_cluster_name
  cloudwatch_logname = local.cloudwatch_logname
  ecs_sg_name        = local.ecs_sg_name
}
