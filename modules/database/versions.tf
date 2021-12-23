terraform {
  required_version = ">= 0.13"
  required_providers {
    null   = {
      source  = "hashicorp/null"
      version = "~> 3.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.5.0"
    }
    docker = {
      source = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}