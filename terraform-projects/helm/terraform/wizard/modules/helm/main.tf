resource "helm_release" "helm" {
  name      = var.release_name
  namespace = var.namespace
  chart     = var.chart_location

  values = [
    "${file(var.values_file)}"
  ]
}
