module "vpc" {
  source = "../../../../modules/aws/vpc"

  env      = local.env
  az_names = local.az_names
  vpc_cidr = local.vpc_cidr
}
