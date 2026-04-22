# Asignación de variantes para Mini Cloud Log Analyzer

Este documento está dirigido al profesorado para organizar la práctica tipo **GitHub Classroom**.

## Resumen de variantes

- **Variante A**: contar códigos **2xx, 4xx y 5xx**.
- **Variante B**: encontrar el **código más frecuente**.
- **Variante C**: detectar la **primera aparición de 503**.
- **Variante D**: detectar **3 errores consecutivos** (4xx/5xx).
- **Variante E**: calcular un **health score** del servicio.

## Método sugerido de asignación

### Opción 1 (recomendada): por lista oficial
1. Exportar lista de estudiantes con matrícula.
2. Ordenar alfabéticamente.
3. Asignar en patrón circular: A, B, C, D, E, A, B, C...
4. Publicar tabla de correspondencia (matrícula → variante) en el LMS.

### Opción 2: por hash de matrícula
1. Convertir matrícula a entero (o usar últimos 3 dígitos).
2. Calcular `matricula % 5`.
3. Mapear: `0→A`, `1→B`, `2→C`, `3→D`, `4→E`.
4. Compartir regla y ejemplos para transparencia.

## Recomendación didáctica

- Mantener **misma rúbrica base** para todas las variantes.
- Evaluar por componentes:
  - Correctitud lógica (40%)
  - Uso de syscalls y ensamblador ARM64 limpio (25%)
  - Pruebas y reproducibilidad (20%)
  - Documentación técnica breve (15%)

## Sugerencia de control anti-copia

- Cambiar periódicamente datasets de entrada.
- Usar defensa oral corta (3–5 minutos) donde cada estudiante explique:
  - su parser de enteros,
  - su estructura de control,
  - y su manejo de casos borde.

## Entregables mínimos por estudiante

- `src/analyzer.s` completo para su variante.
- Evidencia de compilación y ejecución en AWS ARM64.
- Resultado de `make test`.
- Mini reporte técnico (máximo 1 página).
