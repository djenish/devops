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
  project     = "hbl-uat-sharedsvc-prj-spk-4d"
}


/*data "google_compute_network" "my-network" {
  name = "gcp-vpc"
}*/

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-medium"
  zone         = "asia-south1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "test_sentinel"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "projects/hbl-uat-host-prj-hub-4d/global/networks/hbl-gcp-sharedsvc-common-uat-vpc-01"
    subnetwork = "projects/hbl-uat-host-prj-hub-4d/regions/asia-south1/subnetworks/hbl-gcp-sharedsvc-common-uat-as1-infratools-subnet"
  }

  metadata = {
    foo = "bar"
  }

  # metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "tfe-migrate-gcp@hbl-uat-sharedsvc-prj-spk-4d.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
}

/*output "gcp_vpc" {
    value = data.google_compute_network.my-network
}*/
