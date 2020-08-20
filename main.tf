provider "aws" {
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"
}

module "tadas_instance" {
  source = "./EC2"
}
module "tadas_vpc" {
  source = "./VPC"
}
module "tadas_SG" {
  source = "./SG"
}