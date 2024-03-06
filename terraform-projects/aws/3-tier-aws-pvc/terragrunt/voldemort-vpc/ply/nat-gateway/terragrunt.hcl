
terraform {
  source = "${get_parent_terragrunt_dir()}/../../terraform/modules/nat-gateway"
}

include "root" {
  path = find_in_parent_folders()
  expose = true
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  public_subnet_az1_id       = dependency.vpc.outputs.public_subnet_az1_id
  public_subnet_az2_id       = dependency.vpc.outputs.public_subnet_az2_id
  internet_gateway           = dependency.vpc.outputs.internet_gateway
  vpc_id                     = dependency.vpc.outputs.vpc_id
  private_app_subnet_az1_id  = dependency.vpc.outputs.private_app_subnet_az1_id
  private_data_subnet_az1_id = dependency.vpc.outputs.private_data_subnet_az1_id
  private_app_subnet_az2_id  = dependency.vpc.outputs.private_app_subnet_az2_id
  private_data_subnet_az2_id = dependency.vpc.outputs.private_data_subnet_az2_id

}