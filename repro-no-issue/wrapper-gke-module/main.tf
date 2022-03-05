locals {
  regions = toset(["us-central1"])
}

module "gke" {
  source                  = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  for_each                = local.regions
  project_id              = var.project_id
  name                    = var.cluster_name
  regional                = false
  region                  = each.value
  zones                   = ["us-central1-a"]
  network                 = var.network
  subnetwork              = var.subnetwork
  ip_range_pods           = var.ip_range_pods
  ip_range_services       = var.ip_range_services
  create_service_account  = true
  enable_private_endpoint = true
  enable_private_nodes    = true
  master_ipv4_cidr_block  = "172.16.0.0/28"
}