
terraform {
  source = "${get_parent_terragrunt_dir()}/../../terraform/modules/security-groups"
}

include "root" {
  path = find_in_parent_folders()
  expose = true
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
}