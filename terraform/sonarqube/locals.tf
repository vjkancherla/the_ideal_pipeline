locals {
  common_labels = {
    created-by  = "terraform"
    environment = var.environment
    project     = var.project
  }

  postgres_user        = "postgres"
  postgres_password    = "Password555!"
  service_account_name = "sonarqube-sa"
  postgres_port        = "5432"

  sonarqubeUsername = "admin"
  sonarqubePassword = "Changeme555!"
}
