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
    profile = "default"
  }
}


generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
    provider "aws" {
      region  = "us-west-2"
      profile = "default"
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
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  project_name = local.common_vars.inputs.project_name
  region = local.env_vars.inputs.region

  remote_state_bucket = "anama-terrafrom-remote-state-${local.env_vars.inputs.env}"
  remote_state_bucket_key = "${local.project_name}/${path_relative_to_include()}/terraform.tfstate"
}

inputs = merge(local.common_vars.inputs, local.env_vars.inputs)