locals {
  common_labels = {
    created-by  = "terraform"
    environment = var.environment
    layer       = "100gke"
    project     = "gke"
  }
}
