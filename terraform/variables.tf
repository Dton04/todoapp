variable "do_token" {
  description = "DigitalOcean Personal Access Token (Lấy từ DigitalOcean -> API -> Generate New Token)"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "DigitalOcean datacenter region (sgp1 = Singapore, nyc1 = New York, fra1 = Frankfurt)"
  type        = string
  default     = "sgp1"
}

variable "droplet_size" {
  description = "Droplet plan size (s-2vcpu-2gb = 2 vCPU, 2GB RAM; s-1vcpu-2gb = 1 vCPU, 2GB RAM; s-1vcpu-1gb = 1 vCPU, 1GB RAM)"
  type        = string
  default     = "s-2vcpu-2gb"
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
