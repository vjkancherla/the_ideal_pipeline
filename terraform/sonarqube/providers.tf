terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.64.0"
    }
    helm = {
      source  = "hashicorp/helm"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "helm" {
  kubernetes {
    host  = "https://${data.terraform_remote_state.gke.outputs.gke_autopilot_cluster_endpoint}"
    token = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(
      data.terraform_remote_state.gke.outputs.gke_autopilot_cluster_ca_certificate
    )
  }
}

provider "kubernetes" {
  host  = "https://${data.terraform_remote_state.gke.outputs.gke_autopilot_cluster_endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    data.terraform_remote_state.gke.outputs.gke_autopilot_cluster_ca_certificate
  )
}
