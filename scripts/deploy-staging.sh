#!/usr/bin/env bash
set -euo pipefail

PORT="${STAGING_PORT:-8080}"
mkdir -p logs

echo "[$(date -u +%FT%TZ)] STAGE=deploy-staging PORT=${PORT}" | tee logs/deploy-staging.log
nohup java -cp target/classes cl.iplacex.qa.HealthServer "${PORT}" >> logs/staging-server.log 2>&1 &
echo $! > logs/staging.pid

for attempt in {1..20}; do
  if curl --fail --silent "http://127.0.0.1:${PORT}/actuator/health" | tee -a logs/deploy-staging.log; then
    echo | tee -a logs/deploy-staging.log
    echo "RESULT=STAGING_READY" | tee -a logs/deploy-staging.log
    exit 0
  fi
  sleep 1
done

echo "RESULT=STAGING_FAILED" | tee -a logs/deploy-staging.log
exit 1
