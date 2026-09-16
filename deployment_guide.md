
VPS mới (1CPU/1RAM) đã được tạo thành công với IP: **`206.189.92.243`**!

---

## 1. File cấu hình Ansible:
- [ansible/hosts.ini](file:///e:/CODE/CYBERSOFT_D/mern-todo-app/mern-todo-app/ansible/hosts.ini): Đã cập nhật IP `206.189.92.243`.
- terraform apply
---

## 2. Lệnh chạy Ansible Deploy (PowerShell):

```powershell
docker run --rm -it `
  -e ANSIBLE_CONFIG=/workspace/ansible/ansible.cfg `
  -v "${PWD}:/workspace" `
  -v "$HOME/.ssh:/tmp/ssh_keys:ro" `
  -w /workspace/ansible `
  cytopia/ansible:latest-tools `
  sh -c "mkdir -p /root/.ssh && chmod 700 /root/.ssh && cp /tmp/ssh_keys/keygen /root/.ssh/keygen && chmod 600 /root/.ssh/keygen && ansible-playbook -i hosts.ini playbook.yml"
```

---

## 3. Đường link truy cập sau khi deploy:
* **Frontend:** http://206.189.92.243:3000
* **Backend API:** http://206.189.92.243:8000
* **Grafana Dashboard:** http://206.189.92.243:3001 *(User: `admin` / Pass: `admin`)*
* **Prometheus:** http://206.189.92.243:9090









### Map DOMAIN
apt update
apt install -y nginx certbot python3-certbot-nginx

nano /etc/nginx/sites-available/todoapp

#Frontend
server {
    listen 80;
    server_name tondat.online www.tondat.online;
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
#Backend
server {
    listen 80;
    server_name api.tondat.online;
    location / {
        proxy_pass http://localhost:8000;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
#Grafana
server {
    listen 80;
    server_name grafana.tondat.online;
    location / {
        proxy_pass http://localhost:3001;
        proxy_set_header Host $host;
    }
}





ln -sf /etc/nginx/sites-available/todoapp /etc/nginx/sites-enabled/

systemctl restart nginx

certbot --nginx -d tondat.online -d www.tondat.online -d api.tondat.online -d grafana.tondat.online --non-interactive --agree-tos -m tandat081104@gmail.com
