
module "helm" {
  source = "./modules/helm"

  release_name   = var.release_name
  namespace      = var.namespace
  chart_location = var.chart_location
  values_file    = var.values_file
}
