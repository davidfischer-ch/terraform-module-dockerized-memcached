variable "identifier" {
  type        = string
  description = "Identifier (must be unique, used to name resources)."

  validation {
    condition     = regex("^[a-z]+(-[a-z0-9]+)*$", var.identifier) != null
    error_message = "Argument `identifier` must match regex ^[a-z]+(-[a-z0-9]+)*$."
  }
}

variable "enabled" {
  type        = bool
  description = "Toggle the containers (started or stopped)."
  default     = true
}

variable "wait" {
  type        = bool
  description = "Wait for the container to reach an healthy state after creation."
  default     = true
}

variable "image_id" {
  type        = string
  description = "Memcached image's ID."
}

# Process ------------------------------------------------------------------------------------------

variable "app_uid" {
  type        = number
  description = "UID of the user running the container."
  default     = 11211
}

variable "app_gid" {
  type        = number
  description = "GID of the user running the container."
  default     = 11211
}

variable "privileged" {
  type        = bool
  description = "Run the container in privileged mode."
  default     = false
}

variable "cap_add" {
  type        = set(string)
  description = "Linux capabilities to add to the container."
  default     = []
  validation {
    condition = length(setsubtract(var.cap_add, local.linux_capabilities)) == 0
    error_message = "Each entry in `cap_add` must be a valid Linux capability name."
  }
}

variable "cap_drop" {
  type        = set(string)
  description = "Linux capabilities to drop from the container."
  default     = []
  validation {
    condition = length(setsubtract(var.cap_drop, local.linux_capabilities)) == 0
    error_message = "Each entry in `cap_drop` must be a valid Linux capability name."
  }
}

# Networking ---------------------------------------------------------------------------------------

variable "hosts" {
  type        = map(string)
  description = "Add entries to container hosts file."
  default     = {}
}

variable "network_aliases" {
  type        = set(string)
  description = "Network aliases of the container in the specific network"
  default     = []
}

variable "network_id" {
  type        = string
  description = "Attach the containers to given network."
}

variable "port" {
  type        = number
  description = "Bind the Memcached port."
  default     = 11211

  validation {
    condition     = var.port == 11211
    error_message = "Having `port` different than 11211 is not yet implemented."
  }
}

# Configuration ------------------------------------------------------------------------------------

variable "connection_limit" {
  type        = number
  description = "Connection limit (default is 1024)."
  default     = 1024

  validation {
    condition     = var.connection_limit >= 1
    error_message = "Argument `connection_limit` must be at least 1."
  }
}

variable "memory_limit" {
  type        = number
  description = "Memory limit (default is 64 MB)."
  default     = 64

  validation {
    condition     = var.memory_limit >= 64
    error_message = "Argument `memory_limit` must be at least 64 (MB)."
  }
}

variable "threads" {
  type        = number
  description = "Number of threads (default is 4)."
  default     = 4

  validation {
    condition     = var.threads >= 1
    error_message = "Argument `threads` must be at least 1."
  }
}
