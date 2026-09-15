terraform {
  required_version = ">= 1.5.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

# Lấy tất cả các SSH Key đã có sẵn trong tài khoản DigitalOcean của bạn
data "digitalocean_ssh_keys" "all" {
  sort {
    key       = "name"
    direction = "asc"
  }
}

# Create DigitalOcean Droplet (VPS)
resource "digitalocean_droplet" "vps" {
  image      = var.ubuntu_image
  name       = "mern-todo-vps"
  region     = var.region
  size       = var.droplet_size
  ssh_keys   = data.digitalocean_ssh_keys.all.ssh_keys[*].id
  monitoring = true
  ipv6       = false

  tags = ["mern", "production", "monitoring"]
}

# Cloud Firewall to protect and expose required ports
resource "digitalocean_firewall" "mern_fw" {
  name = "mern-todo-firewall"

  droplet_ids = [digitalocean_droplet.vps.id]

  # SSH Access
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # HTTP
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # HTTPS (Bắt buộc để truy cập web bảo mật SSL)
  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Frontend App (React)
  inbound_rule {
    protocol         = "tcp"
    port_range       = "3000"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Backend API (Express)
  inbound_rule {
    protocol         = "tcp"
    port_range       = "8000"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Prometheus
  inbound_rule {
    protocol         = "tcp"
    port_range       = "9090"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Grafana
  inbound_rule {
    protocol         = "tcp"
    port_range       = "3001"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Outbound rules (allow all outgoing traffic)
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
