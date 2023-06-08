terraform {
  #the full backend conifg is defined in backend-configs/${env}.config
  backend "gcs" {}
}

##### VPC + Subnets ######

resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "gke_subnet" {
  name                     = "${var.vpc_name}-subnet"
  ip_cidr_range            = var.gke_subnet_primary_cidr
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
  region                   = var.region

  secondary_ip_range {
    range_name    = "gke-pods-range"
    ip_cidr_range = var.gke_subnet_pods_cidr
  }

  secondary_ip_range {
    range_name    = "gke-services-range"
    ip_cidr_range = var.gke_subnet_services_cidr
  }
}


##### Firewall Rules ######
resource "google_compute_firewall" "default-allow-internal" {
  name        = "${var.vpc_name}-default-allow-internal"
  network     = google_compute_network.vpc.id
  priority    = 65534
  description = "Allow internal traffic on the ${var.vpc_name} network"

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = [var.vpc_cidr]
}

resource "google_compute_firewall" "default-allow-icmp" {
  name        = "${var.vpc_name}-default-allow-icmp"
  network     = google_compute_network.vpc.id
  priority    = 65534
  description = "Allow ICMP from anywhere"

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "default-allow-ssh" {
  name        = "${var.vpc_name}-default-allow-ssh"
  network     = google_compute_network.vpc.id
  priority    = 65534
  description = "Allow SSH from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}
