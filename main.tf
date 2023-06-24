## Provider Config

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.69.1"
    }
  }
}

provider "google" {
  project     = "gke-tf-389810"
}


data "google_compute_network" "my-network" {
  name = "gcp-vpc"
}

/*output "gcp_vpc" {
    value = data.google_compute_network.my-network
}*/