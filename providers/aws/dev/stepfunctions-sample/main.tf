module "vpc" {
  source = "../../../../modules/aws/stepfunctions-sample/ecr"

  env = local.env
}
