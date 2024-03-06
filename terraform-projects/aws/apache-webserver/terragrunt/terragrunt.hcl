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
    provider "aws" {
      region  = "${local.region}"
    }
  EOF
}

generate "versions" {
  path = "versions.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
    terraform {
        required_providers {
           aws  = {
                source  = "hashicorp/aws"
                version = "~> 5.31"
            }
        }
        required_version = ">= 1.2.0"
    }
EOF
}

locals {
  backend_vars = read_terragrunt_config(find_in_parent_folders("backend.inputs.hcl"))
  webserver_vars = read_terragrunt_config(find_in_parent_folders("webserver.inputs.hcl"))
  env_vars = read_terragrunt_config("env.hcl")
  project_name = local.webserver_vars.inputs.project_name
  region = local.env_vars.inputs.region

  remote_state_bucket = "${local.backend_vars.inputs.bucket_name_prefix}-${local.env_vars.inputs.env}"
  remote_state_bucket_key = "${local.project_name}/${path_relative_to_include()}/terraform.tfstate"
}

inputs = merge(local.webserver_vars.inputs, local.env_vars.inputs)