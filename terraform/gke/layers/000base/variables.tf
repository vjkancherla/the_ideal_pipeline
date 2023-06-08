variable "environment" {
  description = "The Environment that the resources will be created in"
  type        = string
}

variable "project_id" {
  description = "The GCP Project Name to use"
  type        = string
}

variable "gke_subnet_primary_cidr" {
  description = "The primary subnet cidrs"
  type        = string
}

variable "gke_subnet_pods_cidr" {
  description = "The secondary subnet cidr that will be used for GKE Pods"
  type        = string
}

variable "gke_subnet_services_cidr" {
  description = "The secondary subnet cidr that will be used for GKE Services"
  type        = string
}

variable "region" {
  description = "The Region to use"
  type        = string
}

variable "vpc_cidr" {
  description = "The VPC CIDR"
  type        = string
}

variable "vpc_name" {
  description = "The VPC Name to use"
  type        = string
}
