output "database" {
  value     = google_sql_database.database.name
  sensitive = true
}

output "username" {
  value     = google_sql_user.users.name
  sensitive = true
}

output "password" {
  value     = google_sql_user.users.password
  sensitive = true
}

output "connection_name" {
  value = google_sql_database_instance.instance.connection_name
}

output "database_host" {
  value = google_sql_database_instance.instance.public_ip_address
}