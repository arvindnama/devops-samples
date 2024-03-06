terraform {
  source = "${get_parent_terragrunt_dir()}/../avenger"
}

include "root" {
  path = find_in_parent_folders()
  expose = true
}