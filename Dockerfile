FROM alpine:3.21.3

LABEL maintainer="Joshua Figueroa"

ENV KUBECTL_VERSION=v1.33.1
ENV HELM_VERSION=v3.18.2

# Install system dependencies
RUN apk add --no-cache --update \
  python3 \
  py3-pip \
  gcc \
  musl-dev \
  python3-dev \
  libffi-dev \
  openssl-dev \
  cargo \
  git \
  make \
  bash \
  curl \
  tar

# Create and activate a virtual environment for Azure CLI
RUN python3 -m venv /opt/venv \
  && . /opt/venv/bin/activate \
  && pip install --upgrade pip \
  && pip install --no-cache-dir azure-cli \
  && deactivate

# Update PATH to include the virtual environment
ENV PATH="/opt/venv/bin:$PATH"

# Install kubectl (pinned version)
RUN curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm kubectl

# Install helm (pinned version)
RUN curl -LO "https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz" \
    && tar -zxvf helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && rm -rf linux-amd64 helm-${HELM_VERSION}-linux-amd64.tar.gz

# Clean up unnecessary build tools
RUN apk del \
  gcc \
  musl-dev \
  python3-dev \
  libffi-dev \
  openssl-dev \
  cargo \
  && rm -rf /var/cache/apk/*

CMD ["bash"]