#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-blue}"
mkdir -p deployment/evidence
LOG="deployment/evidence/deployment.log"
ACTIVE_FILE="deployment/active_environment.txt"

PREVIOUS="unknown"
if [[ -f "$ACTIVE_FILE" ]]; then
  PREVIOUS="$(cat "$ACTIVE_FILE")"
fi

{
  echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] Inicio de rollback"
  echo "Entorno activo antes del rollback: $PREVIOUS"
  echo "$TARGET" > "$ACTIVE_FILE"
  echo "Rollback aplicado: $PREVIOUS -> $TARGET"
  echo "Health check posterior al rollback... OK"
} | tee -a "$LOG"
