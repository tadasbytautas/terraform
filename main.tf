provider "aws" {
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"
}

module "tadas_instance" {
  source    = "./EC2"
  subnet_id = module.tadas_vpc.subnet_a_id
  vpc_security_group_ids = module.tadas_SG.vpc_security_group_ids
}
module "tadas_vpc" {
  source = "./VPC"
}
module "tadas_SG" {
  source = "./SG"
  vpc_id = module.tadas_vpc.vpc_id
}