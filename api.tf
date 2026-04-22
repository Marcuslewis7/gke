# Enable required APIs
resource "google_project_service" "required_apis" {
  for_each = toset([
    "container.googleapis.com",           # GKE
    "compute.googleapis.com",             # Compute Engine
    "cloudresourcemanager.googleapis.com",# Cloud Resource Manager
    "iam.googleapis.com",                 # IAM
    "servicenetworking.googleapis.com",   # Service Networking
  ])

  service            = each.value
  disable_on_destroy = false
}
