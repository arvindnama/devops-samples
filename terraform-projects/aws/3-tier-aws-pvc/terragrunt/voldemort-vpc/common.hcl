inputs = {
  project_name                =  "voldemort-vpc"
  vpc_cidr                    = "10.0.0.0/16"
  public_subnet_a1_cidr       = "10.0.0.0/24"
  public_subnet_a2_cidr       = "10.0.1.0/24"
  private_app_subnet_a1_cidr  = "10.0.2.0/24"
  private_app_subnet_a2_cidr  = "10.0.3.0/24"
  private_data_subnet_a1_cidr = "10.0.4.0/24"
  private_data_subnet_a2_cidr = "10.0.5.0/24"
}