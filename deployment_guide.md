# HƯỚNG DẪN CHẠY ANSIBLE DEPLOY LÊN VPS DIGITALOCEAN

VPS của bạn đã được tạo thành công với IP: **`178.128.111.160`**!

---

## 1. Các file Ansible đã được chuẩn bị sẵn:
1. [ansible/hosts.ini](file:///e:/CODE/CYBERSOFT_D/mern-todo-app/mern-todo-app/ansible/hosts.ini): Đã điền sẵn IP `178.128.111.160` và SSH Key `~/.ssh/keygen`.
2. [ansible/playbook.yml](file:///e:/CODE/CYBERSOFT_D/mern-todo-app/mern-todo-app/ansible/playbook.yml): Tự động cài đặt Docker, Docker Compose, copy toàn bộ source code lên VPS và khởi chạy toàn bộ 7 container (Frontend, Backend, MongoDB, Prometheus, Grafana, Node Exporter, MongoDB Exporter).

---

## 2. Cách chạy Ansible Playbook

### Cách 1: Chạy qua Container `ubuntu-ansible` trong Docker Desktop (Khuyên dùng nếu dùng Windows)

1. Mở PowerShell ở máy thật và copy thư mục dự án cùng SSH Key vào container:
   ```powershell
   docker cp "E:\CODE\CYBERSOFT_D\mern-todo-app\mern-todo-app" ubuntu-ansible:/root/
   docker cp "C:\Users\ACER\.ssh" ubuntu-ansible:/root/
   ```

2. Vào tab **Exec** của container `ubuntu-ansible` (trên Docker Desktop) và chạy:
   ```bash
   # Phân quyền cho SSH key (bắt buộc)
   chmod 600 /root/.ssh/keygen

   # Cài đặt ansible (nếu chưa có)
   apt update && apt install -y ansible

   # Di chuyển vào thư mục ansible và chạy deploy
   cd /root/mern-todo-app/ansible
   ansible-playbook -i hosts.ini playbook.yml
   ```

---

### Cách 2: Chạy trực tiếp từ WSL (Ubuntu trên Windows)

Nếu bạn có cài WSL:
```bash
cd /mnt/e/CODE/CYBERSOFT_D/mern-todo-app/mern-todo-app/ansible
chmod 600 ~/.ssh/keygen
ansible-playbook -i hosts.ini playbook.yml
```

---

## 3. Kiểm tra kết quả sau khi Ansible chạy xong:

| Ứng dụng / Dịch vụ | Địa chỉ truy cập | Ghi chú |
| :--- | :--- | :--- |
| **Frontend Web UI** | `http://178.128.111.160:3000` | Todo App React |
| **Backend REST API** | `http://178.128.111.160:8000` | Node.js Express API |
| **Grafana Dashboard** | `http://178.128.111.160:3001` | User: `admin` / Password: `admin` |
| **Prometheus Explorer** | `http://178.128.111.160:9090` | Metrics Scraper |
