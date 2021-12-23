variable "gcp_project" {
  type = string
}

variable "gcp_region" {
  type    = string
  default = "europe-west1"
}

variable "image_tag" {
  type    = string
  default = "latest"
}

variable "app_key" {
  type = string
}

variable "database_password" {
  type = string
}

variable "migrate_database" {
  type    = bool
  default = true
}