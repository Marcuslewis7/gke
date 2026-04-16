resource "google_container_cluster" "primary" {
  name = var.cluster_name
  location = var.location

  network = google_compute_network.gke.id
  subnetwork = google_compute_subnetwork.gke.name

  networking_mode = "VPC_NATIVE"

  ip_allocation_policy {
    cluster_secondary_range_name = var.pods_range_name
    services_secondary_range_name = var.services_range_name
  }

  remove_default_node_pool = true
  initial_node_count       = 1

  release_channel {
    channel = "REGULAR"
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-np"
  location   = var.location
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count

  node_config {
    machine_type = var.machine_type

    labels = {
      cluster = var.cluster_name
    }
  
    metadata = {
      disable-legacy-endpoints = "true"
    }
  
    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }

    management {
      auto_repair  = true
      auto_upgrade = true
    }

}
