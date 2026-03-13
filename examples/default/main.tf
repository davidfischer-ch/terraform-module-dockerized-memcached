resource "docker_image" "memcached" {
  name         = "memcached:1.6.32"
  keep_locally = true
}

resource "docker_network" "app" {
  name   = "my-app"
  driver = "bridge"
}

module "cache" {
  source = "git::https://github.com/davidfischer-ch/terraform-module-dockerized-memcached.git?ref=1.1.0"

  identifier = "my-app-cache"
  enabled    = true
  image_id   = docker_image.memcached.image_id

  memory_limit     = 256
  connection_limit = 1024
  threads          = 4

  network_id      = docker_network.app.id
  network_aliases = ["memcached"]
}
