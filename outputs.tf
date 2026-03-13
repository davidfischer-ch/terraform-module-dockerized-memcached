output "host" {
  description = "Hostname of the Memcached container."
  value       = docker_container.server.hostname
}

output "port" {
  description = "Port bound by Memcached."
  value       = var.port
}
