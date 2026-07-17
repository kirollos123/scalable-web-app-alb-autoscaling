#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/../source/infrastructure"

echo "==> terraform fmt -check"
terraform fmt -check -recursive

echo "==> terraform init (backend disabled for validation)"
terraform init -backend=false

echo "==> terraform validate"
terraform validate

echo "All checks passed."
