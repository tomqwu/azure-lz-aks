#!/bin/bash
set -e

ACR_NAME="${ACR_NAME:-aksmeshdemoacr}"
IMAGE_TAG="${IMAGE_TAG:-v1}"
ACR_LOGIN_SERVER="${ACR_NAME}.azurecr.io"

az account show > /dev/null 2>&1 || {
  echo "Please login to Azure CLI (az login)"
  exit 1
}
az acr login --name "$ACR_NAME"

cd "$(dirname "$0")/../app"
docker build -t "${ACR_LOGIN_SERVER}/demo-app:${IMAGE_TAG}" .
docker push "${ACR_LOGIN_SERVER}/demo-app:${IMAGE_TAG}"

echo "Image pushed: ${ACR_LOGIN_SERVER}/demo-app:${IMAGE_TAG}"
echo "Flux will sync and deploy the updated image automatically."
