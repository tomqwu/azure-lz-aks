#!/bin/bash
set -e

az account show > /dev/null 2>&1 || {
  echo "Please login to Azure CLI (az login)"
  exit 1
}

cd "$(dirname "$0")/../iac"
terraform init
terraform apply -auto-approve
