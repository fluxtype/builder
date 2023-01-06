FROM k8s.gcr.io/kustomize/kustomize:v4.5.7 as kustomize
FROM mikefarah/yq:4 AS yq

FROM summerwind/actions-runner:latest

RUN sudo apt-get update -y \
 && sudo apt-get install -y gettext jq git \
 && sudo rm -rf /var/lib/apt/lists/*

COPY --from=kustomize /app/kustomize /bin/kustomize
COPY --from=yq /usr/bin/yq /bin/yq

RUN sudo wget -O /bin/kubectl "https://dl.k8s.io/release/v1.23.12/bin/linux/amd64/kubectl" \
  && sudo chmod +x /bin/kubectl

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
