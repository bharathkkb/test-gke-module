variable "project_id" {
}

variable "cluster_name" {
}

variable "network" {
  description = "The VPC network to host the cluster in"
}

variable "subnetwork" {
  description = "The subnetwork to host the cluster in"
}

variable "ip_range_pods" {
  description = "The secondary ip range to use for pods"
}

variable "ip_range_services" {
  description = "The secondary ip range to use for services"
}