resource "docker_container" "server" {

  image = var.image_id
  name  = var.identifier

  must_run = var.enabled
  start    = var.enabled
  restart  = "always"
  wait     = var.wait

  privileged = var.privileged

  dynamic "capabilities" {
    for_each = length(var.cap_add) + length(var.cap_drop) > 0 ? [1] : []
    content {
      add  = var.cap_add
      drop = var.cap_drop
    }
  }

  user = "${var.app_uid}:${var.app_gid}"

  # shm_size = 256 # MB

  command = [
    "memcached",
    "--conn-limit=${var.connection_limit}",
    "--memory-limit=${var.memory_limit}",
    "--threads=${var.threads}"
  ]

  env = []

  dynamic "host" {
    for_each = var.hosts
    content {
      host = host.key
      ip   = host.value
    }
  }

  hostname = var.identifier

  networks_advanced {
    aliases = var.network_aliases
    name    = var.network_id
  }

  network_mode = "bridge"
}
