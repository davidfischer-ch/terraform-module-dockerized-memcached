# Memcached Terraform Module (Dockerized)

Manage Memcached server.

* Runs in bridge networking mode
* No persistent storage (in-memory cache)
* Configurable connection limit, memory, and threads

## Usage

See [examples/default](examples/default) for a complete working configuration.

```hcl
module "cache" {
  source = "git::https://github.com/davidfischer-ch/terraform-module-dockerized-memcached.git?ref=1.1.0"

  identifier     = "my-app-cache"
  enabled        = true
  image_id       = docker_image.memcached.image_id

  memory_limit     = 256
  connection_limit = 1024
  threads          = 4

  hosts           = { "myserver" = "10.0.0.1" }
  network_id      = docker_network.app.id
  network_aliases = ["memcached"]
}
```

## Variables

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `identifier` | `string` | — | Unique name for resources (must match `^[a-z]+(-[a-z0-9]+)*$`). |
| `enabled` | `bool` | — | Start or stop the container. |
| `wait` | `bool` | `false` | Wait for the container to reach a healthy state after creation. |
| `image_id` | `string` | — | [Memcached](https://hub.docker.com/_/memcached/tags) Docker image's ID. |
| `app_uid` | `number` | `11211` | UID of the user running the container. |
| `app_gid` | `number` | `11211` | GID of the user running the container. |
| `privileged` | `bool` | `false` | Run the container in privileged mode. |
| `cap_add` | `set(string)` | `[]` | Linux capabilities to add to the container. |
| `cap_drop` | `set(string)` | `[]` | Linux capabilities to drop from the container. |
| `connection_limit` | `number` | `1024` | Connection limit. |
| `memory_limit` | `number` | `64` | Memory limit in MB. |
| `threads` | `number` | `4` | Number of threads. |
| `hosts` | `map(string)` | `{}` | Extra `/etc/hosts` entries for the container. |
| `network_aliases` | `set(string)` | `[]` | Network aliases for the container. |
| `network_id` | `string` | — | Docker network to attach to. |
| `port` | `number` | `11211` | Memcached port (changing not yet implemented). |

## Outputs

| Name | Description |
|------|-------------|
| `host` | Container hostname. |
| `port` | Memcached port. |

## Requirements

* Terraform >= 1.6
* [kreuzwerker/docker](https://github.com/kreuzwerker/terraform-provider-docker) >= 3.0.2

## References

* https://hub.docker.com/_/memcached
* https://github.com/davidfischer-ch/ansible-role-memcache
