
module "vpc" {
  source = "./modules/vpc"

  project_name  = var.project_name
  vpc_cidr      = var.vpc_cidr
  subnet_1_cidr = var.subnet_1_cidr
}

module "security_group" {
  source = "./modules/security_group"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "nic" {
  source = "./modules/nic"

  project_name = var.project_name
  private_ip   = var.private_ip

  subnet_id         = module.vpc.subnet_id
  security_group_id = module.security_group.security_group_id

}

module "eip" {
  source = "./modules/eip"

  project_name = var.project_name
  private_ip   = var.private_ip

  nic_id = module.nic.nic_id
}


module "ec2" {
  source = "./modules/ec2"

  project_name      = var.project_name
  ec2_ami           = var.ec2_ami
  ec2_instance_type = var.ec2_instance_type
  ssh_key_name      = var.ssh_key_name

  nic_id = module.nic.nic_id

  depends_on = [module.nic, module.eip]

}
