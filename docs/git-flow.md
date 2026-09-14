# Flujo de ramas

Se utiliza **GitFlow simplificado**:

- `main`: rama estable y liberable.
- `develop`: integración de cambios completados.
- `feature/*`: desarrollo de funcionalidades o pruebas.
- `release/*`: preparación de versiones.
- `hotfix/*`: correcciones urgentes desde `main`.

## Flujo aplicado en este repositorio

```text
feature/pruebas-automatizadas
        ↓ Pull Request
develop
        ↓ Pull Request
main
```

## Convención de commits

Se utilizan prefijos compatibles con Conventional Commits:

- `feat:` funcionalidad
- `test:` pruebas
- `ci:` pipeline
- `build:` configuración Maven
- `docs:` documentación
- `chore:` mantenimiento
