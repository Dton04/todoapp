output "vps_public_ip" {
  description = "Public IP address of the DigitalOcean Droplet"
  value       = digitalocean_droplet.vps.ipv4_address
}

output "ssh_command" {
  description = "Command to SSH directly into the Droplet"
  value       = "ssh root@${digitalocean_droplet.vps.ipv4_address}"
}

output "frontend_url" {
  description = "URL to access the Frontend"
  value       = "http://${digitalocean_droplet.vps.ipv4_address}:3000"
}

output "backend_api_url" {
  description = "URL to access the Backend API"
  value       = "http://${digitalocean_droplet.vps.ipv4_address}:8000"
}

output "prometheus_url" {
  description = "URL to access Prometheus Metrics Explorer"
  value       = "http://${digitalocean_droplet.vps.ipv4_address}:9090"
}

output "grafana_url" {
  description = "URL to access Grafana Dashboard"
  value       = "http://${digitalocean_droplet.vps.ipv4_address}:3001"
}
