variable "do_token" {
  description = "DigitalOcean Personal Access Token"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "DigitalOcean datacenter region (sgp1 = Singapore, nyc1 = New York, fra1 = Frankfurt)"
  type        = string
  default     = "sgp1"
}

variable "droplet_size" {
  description = "Droplet plan size: 1CPU/1RAM (s-1vcpu-1gb)"
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "ubuntu_image" {
  description = "Operating System Image"
  type        = string
  default     = "ubuntu-22-04-x64"
}

variable "ssh_key_name" {
  description = "Name for the SSH key on DigitalOcean"
  type        = string
  default     = "mern-todo-ssh-key"
}

variable "public_key_path" {
  description = "Local path to your SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
