# Cluster Outputs
output "kubernetes_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.primary.endpoint
  description = "GKE Cluster Host/Endpoint"
  sensitive   = true
}

output "region" {
  value       = var.region
  description = "GCP region"
}

output "project_id" {
  value       = var.project_id
  description = "GCP Project ID"
}

# Network Outputs
output "vpc_network_id" {
  value       = google_compute_network.gke.id
  description = "The ID of the VPC network"
}

output "vpc_network_name" {
  value       = google_compute_network.gke.name
  description = "The name of the VPC network"
}

output "subnet_id" {
  value       = google_compute_subnetwork.gke.id
  description = "The ID of the subnet"
}

output "subnet_name" {
  value       = google_compute_subnetwork.gke.name
  description = "The name of the subnet"
}

# Node Pool Outputs
output "node_pool_name" {
  value       = google_container_node_pool.primary_nodes.name
  description = "Name of the primary node pool"
}

output "node_pool_id" {
  value       = google_container_node_pool.primary_nodes.id
  description = "ID of the primary node pool"
}

# Kubeconfig Data
output "kubernetes_cluster_host_decoded" {
  value       = google_container_cluster.primary.endpoint
  description = "Cluster endpoint for kubeconfig"
  sensitive   = true
}

output "generate_kubectl_config" {
  value       = "gcloud container clusters get-credentials ${google_container_cluster.primary.name} --region ${var.region} --project ${var.project_id}"
  description = "Command to configure kubectl access to the cluster"
}

output "nginx_service_url" {
  value       = "http://${kubernetes_service.nginx.status[0].load_balancer[0].ingress[0].ip}"
  description = "URL to access NGINX service"
}
