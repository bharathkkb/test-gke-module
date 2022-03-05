# doesnt seem to work due to https://github.com/hashicorp/terraform/issues/28330
# output "endpoints" {
#   value = {for r in local.regions: r => module.gke[r].endpoint}
# }

# output "ca_certificates" {
#   value = {for r in local.regions: r => module.gke[r].ca_certificate}
# }

output "endpoint" {
  value = module.gke["us-central1"].endpoint
}

output "ca_certificate" {
  value = module.gke["us-central1"].ca_certificate
}
