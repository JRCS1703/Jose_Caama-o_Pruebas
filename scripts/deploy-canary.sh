#!/usr/bin/env bash
set -euo pipefail

PORT="${CANARY_PORT:-8081}"
mkdir -p logs

echo "[$(date -u +%FT%TZ)] STAGE=canary-deploy PORT=${PORT}" | tee logs/canary.log
nohup java -cp target/classes cl.iplacex.qa.HealthServer "${PORT}" >> logs/canary-server.log 2>&1 &
echo $! > logs/canary.pid

for attempt in {1..20}; do
  if curl --fail --silent "http://127.0.0.1:${PORT}/actuator/health" | tee -a logs/canary.log; then
    echo | tee -a logs/canary.log
    echo "CANARY_TRAFFIC=10%" | tee -a logs/canary.log
    echo "CANARY_HEALTH=OK" | tee -a logs/canary.log
    echo "RESULT=CANARY_READY" | tee -a logs/canary.log
    exit 0
  fi
  sleep 1
done

echo "RESULT=CANARY_FAILED" | tee -a logs/canary.log
exit 1
