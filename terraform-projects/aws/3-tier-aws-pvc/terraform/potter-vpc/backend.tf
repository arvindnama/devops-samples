# store the terraform state file in s3
terraform {
  backend "s3" {
    bucket  = "anama-terrafrom-remote-state"
    key     = "potter-vpc.tfstate"
    region  = "us-west-2"
    profile = "default"
  }
}
