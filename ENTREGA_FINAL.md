# Entrega Final — TA_7 Automatización de Pruebas

**Estudiante:** José Caamaño Sepúlveda  
**Repositorio:** JRCS1703/Jose_Caama-o_Pruebas  
**Rama principal:** `main`  
**Fecha de validación:** 14-09-2026

## Resumen de la entrega

El repositorio contiene la solución completa solicitada para las actividades del TA_7, organizada con control de versiones, pruebas automatizadas, integración continua, acceptance tests y pipeline de despliegue con validación Canary y rollback.

La evidencia principal corresponde a una ejecución real de GitHub Actions en la rama `main`, con los tres jobs del workflow finalizados exitosamente.

## Actividad 1 — Configuración del proyecto y pruebas automatizadas

Se implementó un flujo GitFlow simplificado con las ramas:

- `main`
- `develop`
- `feature/pruebas-automatizadas`

El flujo aplicado fue:

```text
feature/pruebas-automatizadas
        ↓ PR #1
develop
        ↓ PR #2
main
```

Archivos principales:

```text
pom.xml
docs/git-flow.md
src/main/java/cl/iplacex/qa/
src/test/java/cl/iplacex/qa/
```

El archivo `pom.xml` contiene dependencias para:

- JUnit 5
- Selenium 4
- TestNG 7
- Maven Surefire
- Maven Failsafe

Las pruebas unitarias se ejecutan mediante:

```bash
mvn clean test
```

## Actividad 2 — Pipeline CI y evidencias

Pipeline principal:

```text
.github/workflows/ci-cd.yml
```

Pipeline equivalente:

```text
Jenkinsfile
```

Ejecución real validada:

- Workflow: `CI-CD TA7`
- Run: `#12`
- Rama: `main`
- Resultado: `success`
- URL: https://github.com/JRCS1703/Jose_Caama-o_Pruebas/actions/runs/34890686150

### Job build-and-test

Resultado: **success**

Etapas ejecutadas:

```text
Checkout
Setup Java 17
Build + unit tests
Publish unit test results
Package application
```

Artifact generado:

```text
surefire-reports
```

Este artifact contiene los reportes reales generados por Maven Surefire.

## Actividad 3 — Deployment pipeline, acceptance tests, Canary y rollback

### Staging + acceptance tests

Job:

```text
deploy-staging
```

Resultado: **success**

Etapas principales:

```text
Build staging artifact
Deploy staging
Acceptance tests against staging
Upload staging evidence
```

Artifact generado:

```text
staging-and-acceptance-logs
```

### Canary + rollback

Job:

```text
canary-and-rollback
```

Resultado: **success**

Etapas principales:

```text
Build release artifact
Deploy stable environment
Deploy Canary at 10 percent
Validate Canary health
Validate rollback procedure
Upload Canary and rollback evidence
```

Artifact generado:

```text
canary-rollback-logs
```

La validación comprueba el ambiente stable, levanta una instancia Canary independiente, valida su health check y luego ejecuta el procedimiento de rollback verificando que stable permanezca disponible.

## Pull Requests utilizados

### Pull Request #1

**Título:** `feat: incorpora automatización de pruebas y pipeline CI/CD`

Flujo:

```text
feature/pruebas-automatizadas → develop
```

Estado: **merged**

URL:

https://github.com/JRCS1703/Jose_Caama-o_Pruebas/pull/1

### Pull Request #2

**Título:** `release: integra TA7 en main`

Flujo:

```text
develop → main
```

Estado: **merged**

URL:

https://github.com/JRCS1703/Jose_Caama-o_Pruebas/pull/2

## Evidencias reales disponibles

Desde la ejecución del workflow se pueden descargar los siguientes artifacts:

```text
surefire-reports
staging-and-acceptance-logs
canary-rollback-logs
```

Las capturas recomendadas para anexar a la entrega son:

1. Vista general del repositorio y sus ramas.
2. Pull Request #1 integrado a `develop`.
3. Pull Request #2 integrado a `main`.
4. Workflow `CI-CD TA7` con estado verde.
5. Job `build-and-test` mostrando `Build + unit tests` exitoso.
6. Job `deploy-staging` mostrando acceptance tests exitosos.
7. Job `canary-and-rollback` mostrando validación Canary y rollback exitosa.
8. Sección de artifacts mostrando los tres paquetes generados.

## Archivos de la entrega

```text
.github/workflows/ci-cd.yml
.gitignore
Jenkinsfile
README.md
ENTREGA_FINAL.md
pom.xml
docs/git-flow.md
docs/evidencias/README.md
k8s/deployment-stable.yaml
k8s/deployment-canary.yaml
k8s/service.yaml
scripts/deploy-staging.sh
scripts/deploy-canary.sh
scripts/rollback.sh
src/main/java/cl/iplacex/qa/
src/test/java/cl/iplacex/qa/
```

## Resultado final

La solución cumple con los entregables técnicos solicitados: control de versiones con ramas, Maven y librerías de automatización, pipeline CI, build y pruebas automatizadas, acceptance tests, deployment pipeline, Canary, rollback, documentación y evidencias reales generadas por GitHub Actions.
