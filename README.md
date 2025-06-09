# 🐳 joshuafigueroa/az-k8s-helm

A lightweight Alpine-based Docker image with **Azure CLI**, **kubectl**, and **Helm** preinstalled. Perfect for CI/CD pipelines, Kubernetes automation, and Azure deployments.

---

## 🧰 Installed Tools

| Tool         | Version        |
|--------------|----------------|
| Azure CLI    | [latest from base image](https://hub.docker.com/_/microsoft-azure-cli) |
| kubectl      | v1.33.1        |
| Helm         | v3.18.2        |
| Curl, Git, Tar, Bash | latest |

---

## 📦 Usage

### 📥 Pull the image

```bash
docker pull joshuafigueroa/az-k8s-helm:latest
```

### 🛠 Run interactively

```bash
docker run -it joshuafigueroa/az-k8s-helm bash
```

### 🔄 Common use case in CI

```yaml
image: joshuafigueroa/az-k8s-helm:latest

pipelines:
  default:
    - step:
        name: Deploy to AKS
        script:
          - az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID
          - az aks get-credentials --resource-group my-rg --name my-cluster
          - kubectl apply -f k8s/deployment.yaml
```

---

## 🛑 Troubleshooting

**Error: `no match for platform in manifest`**  
Make sure you're using `linux/amd64` platform:

```bash
docker buildx build --platform linux/amd64 --push -t joshuafigueroa/az-k8s-helm:latest .
```

---

## 📁 Source

This image is based on:

- [`mcr.microsoft.com/azure-cli`](https://hub.docker.com/_/microsoft-azure-cli)
- With `kubectl` and `helm` manually installed

---

## 🧑‍💻 Maintainer

**Joshua Figueroa**  
For questions or issues, [open a GitHub issue](https://github.com/joshua-figueroa/az-k8s-helm/issues) or reach out directly.
