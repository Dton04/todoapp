import axios from "axios";

// Tự động nhận diện host đang chạy (localhost hoặc IP VPS) kèm port 8000
const host = typeof window !== "undefined" ? window.location.hostname : "localhost";
const baseURL = process.env.REACT_APP_API_URL || `http://${host}:8000/api`;

const instance = axios.create({
    baseURL: baseURL
});

export default instance;