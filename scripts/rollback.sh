#!/usr/bin/env bash
set -euo pipefail

mkdir -p logs
{
  echo "[$(date -u +%FT%TZ)] STAGE=rollback"
  if [[ -f logs/canary.pid ]]; then
    PID="$(cat logs/canary.pid)"
    if kill -0 "${PID}" 2>/dev/null; then
      kill "${PID}"
      wait "${PID}" 2>/dev/null || true
      echo "CANARY_PROCESS_STOPPED=${PID}"
    else
      echo "CANARY_PROCESS_ALREADY_STOPPED=${PID}"
    fi
  else
    echo "CANARY_PID_NOT_FOUND"
  fi

  if curl --fail --silent http://127.0.0.1:8080/actuator/health >/dev/null; then
    echo "STABLE_HEALTH=OK"
  else
    echo "STABLE_HEALTH=FAILED"
    exit 1
  fi

  if curl --fail --silent http://127.0.0.1:8081/actuator/health >/dev/null; then
    echo "ROLLBACK_VALIDATION=FAILED_CANARY_STILL_RUNNING"
    exit 1
  fi

  echo "ROLLBACK_VALIDATION=OK"
  echo "RESULT=ROLLBACK_SUCCESS"
} | tee logs/rollback.log
