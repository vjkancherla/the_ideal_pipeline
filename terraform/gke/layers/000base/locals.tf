locals {
  common_labels = {
    created-by  = "terraform"
    environment = var.environment
    layer       = "000base"
    project     = "gke"
  }
}
