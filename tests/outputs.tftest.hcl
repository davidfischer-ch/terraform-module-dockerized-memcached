mock_provider "docker" {}

variables {
  identifier = "my-app-cache"
  image_id   = "sha256:0123456789abcdef"
  network_id = "my-app"
}

run "outputs_describe_the_server" {
  command = plan

  assert {
    condition     = output.host == "my-app-cache"
    error_message = "`host` must be the container's hostname, its identifier."
  }

  assert {
    condition     = output.port == 11211
    error_message = "`port` must be the Memcached port."
  }
}
