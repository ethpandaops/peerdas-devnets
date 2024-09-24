terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.11.1"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.4.1"
    }

    kubectl = {
      source  = "alekc/kubectl"
      version = "2.0.4"
    }

    sops = {
      source  = "carlpett/sops"
      version = "0.7.1"
    }

    bcrypt = {
      source  = "viktorradnai/bcrypt"
      version = "0.1.2"
    }
  }

  backend "s3" {
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    endpoints                   = { s3 = "https://ams3.digitaloceanspaces.com" }
    region                      = "us-east-1" // needed
    bucket                      = "efdevops-terraform-remote-state"
    key                         = "peerdas-kubernetes/terraform.tfstate"
  }
}


variable "do_token" {
  sensitive = true
}

variable "rancher_access_key" {
  sensitive = true
}

variable "rancher_secret_key" {
  sensitive = true
}
