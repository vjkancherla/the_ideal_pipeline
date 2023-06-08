variable "environment" {
  description = "The Environment that the resources will be created in"
  type        = string
}

variable "project_id" {
  description = "The GCP Project Id to use"
  type        = string
}

variable "region" {
  description = "The Region to use"
  type        = string
}
