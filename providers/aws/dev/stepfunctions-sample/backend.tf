terraform {
  backend "s3" {
    bucket  = "kobayashi-m42-tfstate"
    key     = "stepfunctions-sample/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "kobayashi-m42-dev"
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket  = "kobayashi-m42-tfstate"
    key     = "vpc/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "kobayashi-m42-dev"
  }
}
