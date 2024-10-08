# configure aws provider

provider "aws" {
  region  = var.region
  profile = "default"
}


# create vpc

module "vpc" {
  source = "../modules/vpc"

  region                      = var.region
  project_name                = var.project_name
  vpc_cidr                    = var.vpc_cidr
  public_subnet_a1_cidr       = var.public_subnet_a1_cidr
  public_subnet_a2_cidr       = var.public_subnet_a2_cidr
  private_app_subnet_a1_cidr  = var.private_app_subnet_a1_cidr
  private_app_subnet_a2_cidr  = var.private_app_subnet_a2_cidr
  private_data_subnet_a1_cidr = var.private_data_subnet_a1_cidr
  private_data_subnet_a2_cidr = var.private_data_subnet_a2_cidr
}


# create nat gateway

module "nat_gateway" {
  source = "../modules/nat-gateway"

  public_subnet_az1_id       = module.vpc.public_subnet_az1_id
  public_subnet_az2_id       = module.vpc.public_subnet_az2_id
  internet_gateway           = module.vpc.internet_gateway
  vpc_id                     = module.vpc.vpc_id
  private_app_subnet_az1_id  = module.vpc.private_app_subnet_az1_id
  private_data_subnet_az1_id = module.vpc.private_data_subnet_az1_id
  private_app_subnet_az2_id  = module.vpc.private_app_subnet_az2_id
  private_data_subnet_az2_id = module.vpc.private_data_subnet_az2_id

}


# create security gateway 

module "security_groups" {
  source = "../modules/security-groups"

  vpc_id = module.vpc.vpc_id
}


# create ec2 task execution role

module "ecs_task_execution_role" {
  source = "../modules/ecs-task-execution-role"

  project_name = var.project_name
}


# create ssl certificate

# module "acm" {
#   source = "../modules/acm"

#   domain_name      = var.domain_name
#   alternative_name = var.alternative_name
# }


# create alb 

module "application_load_balencer" {
  source = "../modules/alb"

  project_name          = var.project_name
  vpc_id                = module.vpc.vpc_id
  alb_security_group_id = module.security_groups.alb_security_group_id
  public_subnet_az1_id  = module.vpc.public_subnet_az1_id
  public_subnet_az2_id  = module.vpc.public_subnet_az2_id
  certificate_arn       = "" # (acm not working) module.acm.certificate_arn

}
