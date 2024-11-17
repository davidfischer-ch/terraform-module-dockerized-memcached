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
}

variable "image_id" {
  type        = string
  description = "Memcached image's ID."
}

# Settings -----------------------------------------------------------------------------------------

variable "connection_limit" {
  type        = number
  default     = 1024
  description = "Connection limit (default is 1024)."
}

variable "memory_limit" {
  type        = number
  default     = 64
  description = "Memory limit (default is 64 MB)."
}

variable "threads" {
  type        = number
  default     = 4
  description = "Number of threads (default is 4)."
}

# Networking ---------------------------------------------------------------------------------------

variable "hosts" {
  type        = map(string)
  default     = {}
  description = "Add entries to container hosts file."
}

variable "network_id" {
  type        = string
  description = "Attach the containers to given network."
}

variable "port" {
  type    = number
  default = 11211

  validation {
    condition     = var.port == 11211
    error_message = "Having `port` different than 11211 is not yet implemented."
  }
}
