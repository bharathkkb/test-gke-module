locals {
  project_id = "test-priv-w-1"
  region     = "us-central1"
}

resource "google_compute_network" "main" {
  project                 = local.project_id
  name                    = "gke-test"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "main" {
  project       = local.project_id
  name          = "gke-test"
  ip_cidr_range = "10.0.0.0/17"
  region        = local.region
  network       = google_compute_network.main.self_link

  secondary_ip_range {
    range_name    = "cft-gke-test-pods"
    ip_cidr_range = "192.168.0.0/18"
  }

  secondary_ip_range {
    range_name    = "cft-gke-test-services"
    ip_cidr_range = "192.168.64.0/18"
  }
}

module "gke_cluster" {
  source            = "./wrapper-gke-module"
  project_id        = local.project_id
  cluster_name      = "test-1"
  network           = google_compute_network.main.name
  subnetwork        = google_compute_subnetwork.main.name
  ip_range_pods     = google_compute_subnetwork.main.secondary_ip_range[0].range_name
  ip_range_services = google_compute_subnetwork.main.secondary_ip_range[1].range_name
}

data "google_client_config" "default" {

}

provider "kubernetes" {
  host                   = "https://${module.gke_cluster.clusters["us-central1"].endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke_cluster.clusters["us-central1"].ca_certificate)
}

