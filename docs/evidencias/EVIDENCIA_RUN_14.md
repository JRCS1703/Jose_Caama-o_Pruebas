# Evidencia de ejecución - GitHub Actions

Repositorio: `JRCS1703/Jose_Caama-o_Pruebas`

Workflow: **CI-CD TA7**  
Run verificado: **#14**  
Run ID: `34900751211`  
Commit: `f93e18f6a87416b45847a4c12644b518f7405c22`  
Fecha UTC: `2026-09-14T21:47:40Z`  
Conclusión: **success**

## Jobs verificados

- `build-and-test`: success.
  - Java 17 configurado correctamente.
  - Maven `clean test` finalizó con `BUILD SUCCESS`.
  - `CalculatorTest`: 2 pruebas, 0 fallos, 0 errores, 0 omitidas.
  - Artifact: `surefire-reports`.
- `deploy-staging`: success.
  - `STAGE=deploy-staging PORT=8080`.
  - Health check: `{"status":"UP"}`.
  - `RESULT=STAGING_READY`.
  - `HealthCheckIT`: 1 prueba, 0 fallos, 0 errores, 0 omitidas.
  - Artifact: `staging-and-acceptance-logs`.
- `canary-and-rollback`: success.
  - Canary desplegado en puerto 8081.
  - `CANARY_TRAFFIC=10%`.
  - `CANARY_HEALTH=OK`.
  - `PROMOTION_DECISION=CANARY_HEALTHY`.
  - `STABLE_HEALTH=OK`.
  - `ROLLBACK_VALIDATION=OK`.
  - `RESULT=ROLLBACK_SUCCESS`.
  - Artifact: `canary-rollback-logs`.

## Enlace de la ejecución

https://github.com/JRCS1703/Jose_Caama-o_Pruebas/actions/runs/34900751211

Este archivo se agrega como evidencia trazable de una ejecución real del pipeline. Los logs y artifacts originales continúan disponibles en GitHub Actions mientras no expiren.
