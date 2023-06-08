terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.64.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "tfstate_bucket" {
  name                        = "${var.project_id}-tfstate"
  location                    = var.region
  force_destroy               = true
  uniform_bucket_level_access = true

  labels = {
    environment = var.environment
    created-by = "terraform"
  }

  versioning {
    enabled = true
  }

}
