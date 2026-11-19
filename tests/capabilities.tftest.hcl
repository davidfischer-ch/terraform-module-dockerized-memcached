mock_provider "docker" {}

variables {
  identifier = "my-app-cache"
  image_id   = "sha256:0123456789abcdef"
  network_id = "my-app"
}

run "all_capabilities_keep_dockers_wildcard" {
  command = plan

  variables {
    cap_drop = ["ALL"]
    cap_add  = ["NET_BIND_SERVICE"]
  }

  assert {
    condition     = one(docker_container.server.capabilities).drop == toset(["ALL"])
    error_message = "Docker accepts ALL as the wildcard, and rejects CAP_ALL."
  }

  assert {
    condition     = one(docker_container.server.capabilities).add == toset(["CAP_NET_BIND_SERVICE"])
    error_message = "Every other capability reaches Docker with its CAP_ prefix."
  }
}
