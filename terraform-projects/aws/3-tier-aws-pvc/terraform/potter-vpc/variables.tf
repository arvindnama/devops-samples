variable "region" { type = string }
variable "project_name" { type = string }
variable "vpc_cidr" { type = string }
variable "public_subnet_a1_cidr" { type = string }
variable "public_subnet_a2_cidr" { type = string }
variable "private_app_subnet_a1_cidr" { type = string }
variable "private_app_subnet_a2_cidr" { type = string }
variable "private_data_subnet_a1_cidr" { type = string }
variable "private_data_subnet_a2_cidr" { type = string }

variable "domain_name" { type = string }
variable "alternative_name" { type = string }
