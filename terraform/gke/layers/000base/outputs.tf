
output "subnet" {
  value = google_compute_subnetwork.gke_subnet
}

output "vpc" {
  value = google_compute_network.vpc
}

output "pod_cidr" {
  value = var.gke_subnet_pods_cidr
}

output "services_cidr" {
  value = var.gke_subnet_services_cidr
}
