resource "google_container_registry" "registry" {
  project  = var.gcp_project
  location = "EU"
}

module "mirror" {
  source      = "neomantra/mirror/docker"
  version     = "0.5.0"
  image_name  = "dawidholka/router"
  image_tag   = var.image_tag
  dest_prefix = "eu.gcr.io/${var.gcp_project}"
}

output "container_image" {
  value = module.mirror.dest_full
}