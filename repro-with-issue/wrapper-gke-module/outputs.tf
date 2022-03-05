# output "kubernetes_endpoint" {
#   sensitive = true
#   value     = module.gke.endpoint
# }

# output "ca_certificate" {
#   value = module.gke.ca_certificate
# }

output "clusters" {
  value = module.gke
}

output "endpoint" {
  value = module.gke["us-central1"].endpoint
}

output "ca_certificate" {
  value = module.gke["us-central1"].ca_certificate
}