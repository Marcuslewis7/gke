# Add all dev deployments here

project_id = "marcuslewis-gke"
region = "europe-west3"
location = "europe-west-3a"

network_name = "gke-vpc"
subnet_name  = "gke-subnet"
subnet_cidr = "10.10.0.0/20"
pods_range_name = "gke-pods"
pods_cidr = "10.20.0.0/16"
services_range_name = "gke-services"
service_cidr = "10.30.0.0/20"

cluster_name = "basic-gke-dev"
node_count   = 1
machine_type = "e2-micro"
