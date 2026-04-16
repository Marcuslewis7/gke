variable "project_id" {
  description = "Project ID for GCP"
  type        = string
}

variable "region" {
  description = "GCP Region for resources"
  type        = string
  default     = "europe-west3"
}

variable "network_name" {
  description = "name for network"
  type        = string
  default     = "gke-vpc"
}

variable "subnet_name" {
  description = "Name of subnet"
  type        = string
  default     = "gke-subnet"
}

variable "subnet_cidr" {
  description = "CIDR of the subnet for nodes"
  type        = string
  default     = "10.10.0.0/20"
}

variable "pods_range_name" {
  description = "Name of the pods"
  type        = string
  default     = "gke-pods"
}

variable "pods_cidr" {
  description = "CIDR of pods"
  type        = string
  default     = "10.20.0.0/16"
}

variable "services_range_name" {
  description = "Name of services in GKE"
  type        = string
  default     = "gke-services"
}

variable "services_cidr" {
  description = "CIDR of services in GKE"
  type        = string
  default     = "10.30.0.0/20"
}
