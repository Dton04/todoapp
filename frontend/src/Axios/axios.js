import axios from "axios";

// Tu dong nhan dien moi truong (Localhost, Domain HTTPS hoac IP VPS)
let baseURL = process.env.REACT_APP_API_URL;

if (!baseURL) {
    if (typeof window !== "undefined") {
        const { protocol, hostname } = window.location;
        if (hostname === "localhost" || hostname === "127.0.0.1") {
            baseURL = "http://localhost:8000/api";
        } else if (hostname.endsWith("tondat.online")) {
            baseURL = "https://api.tondat.online/api";
        } else {
            baseURL = `${protocol}//${hostname}:8000/api`;
        }
    } else {
        baseURL = "http://localhost:8000/api";
    }
}

const instance = axios.create({
    baseURL: baseURL
});

export default instance;