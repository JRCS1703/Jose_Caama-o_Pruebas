# TA_7 — Automatización de Pruebas

**Estudiante:** José Caamaño Sepúlveda  
**Asignatura:** Automatización de Pruebas  
**Tecnologías:** Java 17, Maven, JUnit 5, Selenium, TestNG, GitHub Actions, Jenkins, Kubernetes (manifiestos), Bash

## 1. Descripción del proyecto

Este proyecto reúne en un único repositorio las evidencias técnicas solicitadas para las tres actividades del TA_7. La solución demuestra control de versiones, gestión de dependencias, automatización de build y pruebas, pipeline de integración continua y un pipeline de despliegue con acceptance tests y estrategia Canary con rollback.

La estructura está pensada para que los mismos artefactos puedan ejecutarse tanto localmente como dentro de CI/CD.

## 2. Estrategia de pruebas implementada

La estrategia se divide en tres niveles:

1. **Pruebas unitarias:** JUnit 5 valida lógica aislada, rápida y determinista.
2. **Pruebas de aceptación:** Maven Failsafe ejecuta pruebas `*IT.java` contra un ambiente de staging mediante `BASE_URL`.
3. **Validación de despliegue:** el pipeline verifica el ambiente antes de promover la versión Canary. Si las métricas se degradan, se ejecuta rollback.

Dependencias declaradas en `pom.xml`:

- JUnit 5
- Selenium 4
- TestNG 7

## 3. Flujo Git

Se documenta un **GitFlow simplificado**:

- `main`: versión estable.
- `develop`: integración.
- `feature/*`: nuevas funcionalidades o pruebas.
- `release/*`: preparación de release.
- `hotfix/*`: correcciones urgentes.

Ver: `docs/git-flow.md`.

## 4. Cómo ejecutar las pruebas

### Requisitos

- JDK 17
- Maven 3.9+
- Git
- Opcional: Docker/Kubernetes para un despliegue real

### Pruebas unitarias

```bash
mvn clean test
```

### Pruebas de aceptación

```bash
export BASE_URL=http://staging.example.local
mvn verify
```

En Windows PowerShell:

```powershell
$env:BASE_URL="http://staging.example.local"
mvn verify
```

## 5. Pipeline CI

Archivo principal:

```text
.github/workflows/ci-cd.yml
```

También se incluye:

```text
Jenkinsfile
```

El pipeline contiene los stages:

```text
Checkout
  ↓
Build
  ↓
Unit Tests
  ↓
Package
  ↓
Deploy Staging
  ↓
Acceptance Tests
  ↓
Canary Deploy
  ↓
Promote / Rollback
```

GitHub Actions ejecuta build y pruebas en `push` y `pull_request`. Los reportes Surefire y logs de despliegue se publican como artifacts.

## 6. Pipeline de despliegue

Scripts:

```text
scripts/deploy-staging.sh
scripts/deploy-canary.sh
scripts/rollback.sh
```

Manifiestos:

```text
k8s/deployment-stable.yaml
k8s/deployment-canary.yaml
k8s/service.yaml
```

### Despliegue de staging

```bash
bash scripts/deploy-staging.sh
```

### Canary

```bash
bash scripts/deploy-canary.sh
```

La estrategia propone comenzar con 10% del tráfico y aumentar a 25%, 50% y 100% solo si las métricas se mantienen dentro del umbral.

### Rollback

```bash
bash scripts/rollback.sh
```

El rollback retira la versión Canary y devuelve el tráfico a la versión estable.

## 7. Evidencias

Las evidencias del repositorio deben provenir de ejecuciones reales de GitHub Actions y, si se usa Kubernetes, de un entorno real de pruebas. Los logs demostrativos incluidos sirven como referencia técnica y deben distinguirse de evidencias reales.

## 8. Estructura del proyecto

```text
TA7_Automatizacion_Proyecto/
├── .github/workflows/ci-cd.yml
├── docs/git-flow.md
├── k8s/
├── logs/
├── scripts/
├── src/main/java/...
├── src/test/java/...
├── .gitignore
├── Jenkinsfile
├── pom.xml
└── README.md
```

## 9. Correspondencia con las actividades

### Actividad 1

- Configuración Git y flujo de ramas: `docs/git-flow.md`
- Maven: `pom.xml`
- Dependencias: JUnit 5, Selenium y TestNG
- Pruebas unitarias: `CalculatorTest.java`

### Actividad 2

- Pipeline: `.github/workflows/ci-cd.yml` y `Jenkinsfile`
- Build y pruebas automatizadas: stage `build-and-test`
- Evidencias reales: ejecuciones de GitHub Actions y reportes Surefire

### Actividad 3

- Pipeline de despliegue: stages `deploy-staging`, `Acceptance Tests` y `Canary Deploy`
- Scripts: `scripts/`
- Kubernetes: `k8s/`
- Rollback: `scripts/rollback.sh`

## 10. Nota para la entrega

Antes de entregar, verifica que GitHub Actions muestre build y pruebas exitosas. Si se dispone de un ambiente Kubernetes, ejecutar los manifiestos y capturar `kubectl get pods`, health checks y rollback.
