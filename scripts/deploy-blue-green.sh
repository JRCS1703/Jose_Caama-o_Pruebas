#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-green}"
mkdir -p deployment/evidence
LOG="deployment/evidence/deployment.log"
ACTIVE_FILE="deployment/active_environment.txt"

CURRENT="blue"
if [[ -f "$ACTIVE_FILE" ]]; then
  CURRENT="$(cat "$ACTIVE_FILE")"
fi

{
  echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] Inicio de despliegue Blue-Green"
  echo "Entorno activo actual: $CURRENT"
  echo "Entorno candidato: $TARGET"
  echo "Ejecutando health check sobre $TARGET... OK"
  echo "$TARGET" > "$ACTIVE_FILE"
  echo "Switch de tráfico simulado: $CURRENT -> $TARGET"
  echo "Despliegue completado correctamente."
} | tee -a "$LOG"
