terraform {
  required_version = ">= 1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  backend "gcs" {
    bucket = "tfstate-marcuslewis-gke-dev"
    prefix = "gke/dev"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
