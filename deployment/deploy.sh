#!/usr/bin/env bash
# Usage: ./deploy.sh <plan|apply|destroy> [aws-profile]
set -euo pipefail

ACTION="${1:-plan}"
PROFILE="${2:-default}"

cd "$(dirname "$0")/../source/infrastructure"

export AWS_PROFILE="$PROFILE"

if [ ! -f terraform.tfvars ]; then
  echo "!! terraform.tfvars not found. Copy terraform.tfvars.example to terraform.tfvars and fill it in first."
  exit 1
fi

if [ -z "${TF_VAR_db_password:-}" ]; then
  echo "!! TF_VAR_db_password is not set. Run: export TF_VAR_db_password='YourStrongPassword'"
  exit 1
fi

terraform init

case "$ACTION" in
  plan)
    terraform plan -out=tfplan
    ;;
  apply)
    terraform apply tfplan 2>/dev/null || terraform apply
    ;;
  destroy)
    terraform destroy
    ;;
  *)
    echo "Unknown action: $ACTION (use plan | apply | destroy)"
    exit 1
    ;;
esac
