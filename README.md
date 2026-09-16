# Automatización de Pruebas — Examen Final

Repositorio de apoyo para el examen final de **Automatización de Pruebas**. El proyecto demuestra control de versiones con Git, gestión de dependencias con Maven, pruebas unitarias e integración, acceptance tests y un pipeline CI/CD con estrategia de despliegue Blue-Green y simulación reproducible de rollback.

## Stack

- Java 17
- Maven
- JUnit 5
- Maven Surefire / Failsafe
- GitHub Actions
- Jenkinsfile equivalente para Pipeline as Code

## Estrategia de ramas

Se utiliza un flujo tipo **GitFlow** simplificado:

- `main`: versión estable.
- `develop`: integración de cambios.
- `feature/primer-test`: ejemplo de rama de funcionalidad/pruebas.

Los cambios deben integrarse mediante commits pequeños y descriptivos, por ejemplo `test: agrega prueba unitaria de suma`.

## Estructura

```text
.
├── .github/workflows/ci-cd.yml
├── Jenkinsfile
├── pom.xml
├── scripts/
│   ├── deploy-blue-green.sh
│   └── rollback.sh
├── src/main/java/cl/iplacex/qa/
│   ├── Calculator.java
│   └── LoginService.java
└── src/test/java/cl/iplacex/qa/
    ├── CalculatorTest.java
    ├── LoginServiceIT.java
    └── PurchaseFlowAT.java
```

## Ejecución local

```bash
mvn clean test
mvn clean verify
mvn -Dtest=PurchaseFlowAT test
```

- `mvn test`: ejecuta pruebas unitarias (`*Test`).
- `mvn verify`: ejecuta unitarias y pruebas de integración (`*IT`) mediante Failsafe.
- `mvn -Dtest=PurchaseFlowAT test`: ejecuta la prueba de aceptación.

## Pipeline CI/CD

El workflow de GitHub Actions ejecuta:

1. **Build** con Maven.
2. **Unit tests**.
3. **Integration tests**.
4. **Acceptance tests**.
5. **Deploy staging** mediante una simulación Blue-Green.
6. **Rollback drill** para validar el retorno al entorno Blue.
7. Publicación de logs como artefacto de evidencia.

El pipeline aplica *fail fast*: cualquier etapa fallida impide avanzar al despliegue.

## Estrategia Blue-Green y rollback

El script `scripts/deploy-blue-green.sh` simula el despliegue de una versión candidata al entorno Green, ejecuta un health check y conmuta el entorno activo. `scripts/rollback.sh` valida la capacidad de volver a Blue. Ambos scripts generan trazabilidad en `deployment/evidence/deployment.log`.

## Evidencias

Las evidencias reales de ejecución se encuentran en la pestaña **Actions** del repositorio. Cada ejecución conserva el resultado de los jobs y un artefacto `deployment-evidence` con el log de despliegue/rollback.

## Buenas prácticas aplicadas

- Dependencias con versiones explícitas en `pom.xml`.
- Código y pruebas versionados en el mismo repositorio.
- Separación de pruebas unitarias, integración y aceptación por convención de nombres.
- Pipeline as Code.
- Despliegue controlado y rollback reproducible.
- Logs de evidencia conservados como artefactos.
