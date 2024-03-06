
terraform {
  source = "${get_parent_terragrunt_dir()}/../../terraform/modules/alb"
}

include "root" {
  path = find_in_parent_folders()
  expose = true
}

dependency "vpc" {
  config_path = "../vpc"
}
dependency "security_groups" {
  config_path = "../security-groups"
}

inputs = {
  project_name          = include.root.locals.project_name
  vpc_id                = dependency.vpc.outputs.vpc_id
  alb_security_group_id = dependency.security_groups.outputs.alb_security_group_id
  public_subnet_az1_id  = dependency.vpc.outputs.public_subnet_az1_id
  public_subnet_az2_id  = dependency.vpc.outputs.public_subnet_az2_id
  certificate_arn       = "" # (acm not working) module.acm.certificate_arn
}