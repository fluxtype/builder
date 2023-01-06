FROM k8s.gcr.io/kustomize/kustomize:v4.5.7 as kustomize
FROM gcr.io/go-containerregistry/crane:v0.8.0 AS crane

FROM summerwind/actions-runner:latest

RUN sudo apt-get update -y \
 && sudo apt-get install gettext yq jq git
 && sudo rm -rf /var/lib/apt/lists/*

COPY --from=kustomize /app/kustomize /app/kustomize

RUN wget -O /app/kubectl "https://dl.k8s.io/release/v1.23.12/bin/linux/amd64/kubectl" \
  && chmod +x /app/kubectl

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

WORKDIR /app
ENV PATH "$PATH:/app"
