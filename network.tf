resource "google_compute_network" "gke" {
  name                    = var.network_name
  auto_create_subnetworks = false
  routing                 = "REGIONAL"
}

resource "google_compute_subnetwork" "gke" {
  name          = var.subnet_name
  region        = var.region
  network       = google_compute_network.gke.id
  ip_cidr_range = var.subnet_cidr

  private_ip_google_access = true

  secondary_ip_range {
    range_name    = var.pods_range_name
    ip_cidr_range = var.pods_cidr
  }

  secondary_ip_range {
    range_name    = var.services_range_name
    ip_cidr_range = var.services_cidr
  }
}
