terraform {
  #the full backend conifg is defined in backend-configs/${env}.config
  backend "gcs" {}
}

data "terraform_remote_state" "base" {
  backend = "gcs"
  config = {
    bucket  = "${var.project_id}-tfstate"
    prefix  = "core/000base/${var.environment}"
  }
}

##### GKE Autopilot ######

module "gke" {
  source = "terraform-google-modules/kubernetes-engine/google//modules/beta-autopilot-public-cluster"

  project_id                      = var.project_id
  name                            = "simple-autopilot-${var.environment}-cluster"
  regional                        = true
  region                          = var.region
  zones                           = ["europe-west2-a", "europe-west2-b", "europe-west2-c"]
  network                         = data.terraform_remote_state.base.outputs.vpc.name
  subnetwork                      = data.terraform_remote_state.base.outputs.subnet.name
  ip_range_pods                   = "gke-pods-range"
  ip_range_services               = "gke-services-range"
  release_channel                 = "REGULAR"
  network_tags                    = ["simple-autopilot-${var.environment}-cluster"]
  cluster_resource_labels         = local.common_labels
  create_service_account          = false

  master_authorized_networks = [
    {
      cidr_block   = "78.136.22.232/32",
      display_name = "rax_office"
    },
    {
      cidr_block   = "80.189.143.218/32",
      display_name = "home"
    }
  ]
}
