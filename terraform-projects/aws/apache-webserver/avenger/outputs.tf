output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_ip" {
  value = module.eip.public_ip
}
