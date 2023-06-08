
output "gke_autopilot_cluster_endpoint" {
  value = module.gke.endpoint
  sensitive = true
}

output "gke_autopilot_cluster_ca_certificate" {
  value = module.gke.ca_certificate
  sensitive = true
}
