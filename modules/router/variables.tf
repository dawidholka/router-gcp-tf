variable "region" {
  type    = string
  default = "europe-west1"
}

variable "name" {
  type    = string
  default = "router"
}

variable "app_key_secret_id" {
  type = string
}

variable "database_database_secret_id" {
  type = string
}

variable "database_username_secret_id" {
  type = string
}

variable "database_password_secret_id" {
  type = string
}

variable "container_image" {
  type = string
}

variable "cloud_sql_connection_name" {
  type = string
}