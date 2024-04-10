remote_state {
  backend = "s3" 
  generate = {
    path      = "remote_state.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket  = local.remote_state_bucket
    key     = local.remote_state_bucket_key
    region  = local.region
  }
}


generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
    provider "helm" {
      kubernetes {
        config_path = "~/.kube/config"
      }
    }
  EOF
}



// resource "helm_release" "helm" {
//   name      = "harry"
//   namespace = "vmc-cicd"
//   chart     = "../../../helm-projects/wizarding-world/charts"

//   values = [
//     "${file("../../../helm-projects/wizarding-world/harry.yaml")}"
//   ]
// }

locals {
  backend_vars = read_terragrunt_config(find_in_parent_folders("backend.inputs.hcl"))
  common_vars = read_terragrunt_config(find_in_parent_folders("common.inputs.hcl"))
  helm_vars = read_terragrunt_config("helm.inputs.hcl")
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  release_name = local.helm_vars.inputs.release_name
  region = local.env_vars.inputs.region

  remote_state_bucket = "${local.backend_vars.inputs.bucket_name_prefix}-${local.env_vars.inputs.env}"
  remote_state_bucket_key = "${local.release_name}/${path_relative_to_include()}/terraform.tfstate"

  chart_location = "${get_parent_terragrunt_dir()}/../../../helm-projects/wizarding-world/charts"
}

inputs = merge(
  local.common_vars.inputs, 
  local.helm_vars.inputs, 
  local.env_vars.inputs,
  {
        chart_location = local.chart_location
  }
)

terraform {
  source = "${get_parent_terragrunt_dir()}/../terraform/wizard"
}