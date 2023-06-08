terraform {
  #the full backend conifg is defined in backend-configs/${env}.config
  backend "gcs" {}
}

data "google_client_config" "default" {}

data "terraform_remote_state" "gke" {
  backend = "gcs"
  config = {
    bucket  = "${var.project_id}-tfstate"
    prefix  = "core/100gke/${var.environment}"
  }
}

module "postgresql-db" {
  source = "GoogleCloudPlatform/sql-db/google//modules/postgresql"

  name                 = "${var.project}-${var.environment}"
  random_instance_name = true
  db_name              = var.project
  database_version     = "POSTGRES_9_6"
  project_id           = var.project_id
  zone                 = "europe-west2-c"
  region               = var.region
  tier                 = "db-custom-1-3840"
  user_name            = local.postgres_user
  user_password        = local.postgres_password
  deletion_protection  = false
  user_labels          = local.common_labels
}

resource "kubernetes_namespace" "sonarqube" {
  metadata {
    name = "sq"
  }
}

module "sonarqube-workload-identity" {
  depends_on = [ kubernetes_namespace.sonarqube ]

  source = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"

  name                = "${var.project}-${var.environment}"
  namespace           = "sq"
  project_id          = var.project_id
  gcp_sa_name         = local.service_account_name
  k8s_sa_name         = local.service_account_name
  roles               = ["roles/cloudsql.client"]
}

# resource "helm_release" "sonarqube" {
#   depends_on = [
#     module.postgresql-db,
#     module.sonarqube-workload-identity
#   ]
#
#   name              = "sonarqube"
#   repository        = "https://charts.bitnami.com/bitnami"
#   chart             = "sonarqube"
#   version           = "3.2.2"
#   namespace         = "sq"
#
#   values = [
#     templatefile(
#         "${path.module}/chart-values.yaml.tpl",
#         {
#           postgres_connection_name = module.postgresql-db.instance_connection_name
#           postgres_port            = local.postgres_port
#           postgres_user            = local.postgres_user
#           postgres_password        = local.postgres_password
#           service_account_name     = local.service_account_name
#           sonarqubeUsername        = local.sonarqubeUsername
#           sonarqubePassword        = local.sonarqubePassword
#         }
#     )
#   ]
# }
