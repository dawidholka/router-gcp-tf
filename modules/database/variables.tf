variable "region" {
  type    = string
  default = "europe-west1"
}

variable "database_instance_name" {
  type    = string
  default = "router"
}

variable "database_database_name" {
  type    = string
  default = "router"
}

variable "database_user" {
  type    = string
  default = "router"
}

variable "database_version" {
  type    = string
  default = "MYSQL_5_7"
}

variable "database_tier" {
  type    = string
  default = "db-f1-micro"
}

variable "database_password" {
  type = string
}