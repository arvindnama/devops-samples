
terraform {
  source = "${get_parent_terragrunt_dir()}/../../terraform/modules/vpc"
}

include "root" {
  path = find_in_parent_folders()
  expose = true
}



inputs =  {
  project_name = include.root.locals.project_name
  region = include.root.locals.region
}