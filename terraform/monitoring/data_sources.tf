resource "grafana_data_source" "prometheus" {
  type = "prometheus"
  name = "${module.this.stage}-${module.this.name}-amp"
  url  = var.prometheus_endpoint

  json_data_encoded = jsonencode({
    httpMethod    = "GET"
    sigV4Auth     = true
    sigV4AuthType = "workspace-iam-role"
    sigV4Region   = module.this.region
  })
}

resource "grafana_data_source" "cloudwatch" {
  type = "cloudwatch"
  name = "${module.this.stage}-${module.this.name}-cloudwatch"

  json_data_encoded = jsonencode({
    defaultRegion = module.this.region
  })
}
