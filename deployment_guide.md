# HƯỚNG DẪN CHẠY ANSIBLE DEPLOY LÊN VPS DIGITALOCEAN

VPS mới (1CPU/1RAM) đã được tạo thành công với IP: **`206.189.92.243`**!

---

## 1. File cấu hình Ansible:
- [ansible/hosts.ini](file:///e:/CODE/CYBERSOFT_D/mern-todo-app/mern-todo-app/ansible/hosts.ini): Đã cập nhật IP `206.189.92.243`.

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
