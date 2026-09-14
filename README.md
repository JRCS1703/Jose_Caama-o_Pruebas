# TA_7 — Automatización de Pruebas

**Estudiante:** José Caamaño Sepúlveda  
**Asignatura:** Automatización de Pruebas  
**Tecnologías:** Java 17, Maven, JUnit 5, Selenium, TestNG, GitHub Actions, Jenkins, Bash y Kubernetes (manifiestos)

## 1. Descripción del proyecto

Este repositorio implementa los entregables de las tres actividades del TA_7: control de versiones y flujo de ramas, gestión de dependencias Maven, pruebas automatizadas, integración continua, acceptance tests, despliegue de staging, Canary y validación de rollback.

El pipeline de GitHub Actions genera evidencia real de ejecución. No se utilizan capturas simuladas como evidencia final.

## 2. Estrategia de pruebas

1. **Pruebas unitarias:** JUnit 5 valida lógica aislada mediante `CalculatorTest`.
2. **Acceptance tests:** Maven Failsafe ejecuta `HealthCheckIT` contra un proceso desplegado en el runner de GitHub Actions.
3. **Validación de despliegue:** el workflow levanta un ambiente stable, luego un proceso Canary y finalmente ejecuta un rollback verificable.

El `pom.xml` declara JUnit 5, Selenium 4 y TestNG 7, además de Surefire y Failsafe.

## 3. Estrategia Git

Se utiliza GitFlow simplificado:

- `main`: versión estable y liberable.
- `develop`: integración.
- `feature/*`: desarrollo de funcionalidades y automatización.
- `release/*`: preparación de versiones.
- `hotfix/*`: correcciones urgentes.

Flujo aplicado:

```text
feature/pruebas-automatizadas
        ↓ Pull Request
develop
        ↓ Pull Request
main
```

Ver `docs/git-flow.md`.

## 4. Ejecución local

### Requisitos

- JDK 17
- Maven 3.9+
- Git

### Pruebas unitarias

```bash
mvn clean test
```

### Preparar staging local

```bash
mvn -DskipTests package
bash scripts/deploy-staging.sh
```

### Acceptance tests

```bash
export BASE_URL=http://127.0.0.1:8080
mvn failsafe:integration-test failsafe:verify
```

En PowerShell:

```powershell
$env:BASE_URL="http://127.0.0.1:8080"
mvn failsafe:integration-test failsafe:verify
```

## 5. Pipeline CI/CD

Pipeline principal:

```text
.github/workflows/ci-cd.yml
```

Pipeline equivalente adicional:

```text
Jenkinsfile
```

Flujo automatizado:

```text
Checkout
  ↓
Setup Java 17
  ↓
Build + Unit Tests
  ↓
Publish Surefire Reports
  ↓
Package
  ↓
Deploy Staging
  ↓
Acceptance Tests
  ↓
Canary
  ↓
Rollback Validation
```

## 6. Despliegue y rollback

### Staging

`scripts/deploy-staging.sh` inicia una instancia real de `HealthServer` en el puerto 8080 del runner y valida su endpoint `/actuator/health`.

### Canary

`scripts/deploy-canary.sh` inicia una segunda instancia en el puerto 8081 y valida su disponibilidad antes de considerar la versión saludable.

### Rollback

`scripts/rollback.sh` detiene la instancia Canary, comprueba que la instancia stable sigue disponible y verifica que el puerto Canary ya no responda.

Este procedimiento se ejecuta en GitHub Actions cuando hay un push a `main`, generando logs descargables como artifact.

## 7. Kubernetes

Se incluyen manifiestos de referencia:

```text
k8s/deployment-stable.yaml
k8s/deployment-canary.yaml
k8s/service.yaml
```

Estos manifiestos documentan cómo trasladar la estrategia a un clúster Kubernetes real. La evidencia automática del repositorio se basa en procesos reales ejecutados en el runner de GitHub Actions, mientras que Kubernetes queda como configuración preparada para un entorno con clúster disponible.

## 8. Evidencias reales

Las evidencias se obtienen desde **GitHub → Actions → CI-CD TA7**.

### Build + pruebas

Revisar el job `build-and-test` y descargar el artifact:

```text
surefire-reports
```

### Staging + acceptance tests

Revisar el job `deploy-staging` y descargar:

```text
staging-and-acceptance-logs
```

### Canary + rollback

Después de integrar a `main`, revisar `canary-and-rollback` y descargar:

```text
canary-rollback-logs
```

Instrucciones de evidencia: `docs/evidencias/README.md`.

## 9. Correspondencia con las actividades

### Actividad 1

- Configuración Git y GitFlow: `docs/git-flow.md`
- Maven: `pom.xml`
- JUnit, Selenium y TestNG: `pom.xml`
- Pruebas unitarias: `src/test/java/cl/iplacex/qa/CalculatorTest.java`

### Actividad 2

- GitHub Actions: `.github/workflows/ci-cd.yml`
- Jenkins: `Jenkinsfile`
- Build y pruebas: job `build-and-test`
- Evidencias: logs reales y artifacts de GitHub Actions

### Actividad 3

- Acceptance tests: `HealthCheckIT.java`
- Staging: `scripts/deploy-staging.sh`
- Canary: `scripts/deploy-canary.sh`
- Rollback: `scripts/rollback.sh`
- Kubernetes: `k8s/`
- Evidencia: jobs y artifacts del workflow

## 10. Estructura principal

```text
.
├── .github/workflows/ci-cd.yml
├── docs/
│   ├── evidencias/README.md
│   └── git-flow.md
├── k8s/
├── scripts/
├── src/main/java/cl/iplacex/qa/
├── src/test/java/cl/iplacex/qa/
├── .gitignore
├── Jenkinsfile
├── pom.xml
└── README.md
```
