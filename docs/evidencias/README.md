# Evidencias reales de ejecución

Este directorio no contiene capturas simuladas. Las evidencias válidas se obtienen directamente desde GitHub Actions.

## Evidencia de build y pruebas

Abrir la ejecución del workflow **CI-CD TA7** y revisar el job `build-and-test`.

Debe mostrar:

- `mvn -B clean test`
- pruebas JUnit ejecutadas
- artifact `surefire-reports`

## Evidencia de staging y acceptance tests

Revisar el job `deploy-staging`.

Debe mostrar:

- arranque real de `HealthServer` en el runner
- health check HTTP 200
- ejecución de `HealthCheckIT`
- artifact `staging-and-acceptance-logs`

## Evidencia Canary y rollback

Después de integrar a `main`, revisar el job `canary-and-rollback`.

Debe mostrar:

- despliegue stable en puerto 8080
- despliegue Canary en puerto 8081
- health check Canary exitoso
- ejecución real de `scripts/rollback.sh`
- validación de que stable continúa disponible y Canary queda detenido
- artifact `canary-rollback-logs`

Las capturas para la entrega deben tomarse desde esas ejecuciones reales del repositorio.
