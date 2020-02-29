terraform {
  backend "s3" {
    bucket  = "kobayashi-m42-tfstate"
    key     = "vpc/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "kobayashi-m42-dev"
  }
}
