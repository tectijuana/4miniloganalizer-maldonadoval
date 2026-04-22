<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/a44bb0d7-30f9-4fff-95bf-f08277476255" />


# Mini Cloud Log Analyzer (Bash + ARM64 + GNU Make)

Práctica universitaria orientada a estudiantes principiantes para reforzar fundamentos de:
- Ensamblador **ARM64 (AArch64 Linux)**,
- uso de **syscalls Linux** sin libc,
- automatización con **Bash**,
- y flujo de trabajo con **GitHub Classroom**.

---

## 1) Enunciado formal de la práctica

Implemente un analizador de logs de servidor en ARM64 Assembly que reciba por `stdin` una secuencia de códigos HTTP (un entero por línea), y procese la información según la variante asignada por el docente.

La versión base proporcionada (Variante A) ya compila y ejecuta, y cuenta:
- códigos de éxito **2xx**,
- errores de cliente **4xx**,
- errores de servidor **5xx**.

Ejecución esperada:

```bash
cat logs.txt | ./analyzer
```

---

## 2) Objetivos de aprendizaje

Al finalizar esta práctica, el estudiante será capaz de:
1. Compilar y enlazar un programa ARM64 sin C ni libc.
2. Invocar syscalls Linux (`read`, `write`, `exit`).
3. Parsear enteros desde flujo de bytes (`stdin`).
4. Diseñar lógica condicional para análisis de códigos HTTP.
5. Validar resultados con scripts de prueba reproducibles.

---

## 3) Estructura del repositorio

```text
cloud-log-analyzer/
├── README.md
├── Makefile
├── run.sh
├── src/
│   └── analyzer.s
├── data/
│   ├── logs_A.txt
│   ├── logs_B.txt
│   ├── logs_C.txt
│   ├── logs_D.txt
│   └── logs_E.txt
├── tests/
│   ├── test.sh
│   └── expected_outputs.txt
└── instructor/
    └── VARIANTES.md
```

---

## 4) Requisitos técnicos

- Sistema objetivo: **AWS Ubuntu 24 ARM64**.
- Arquitectura: **AArch64 Linux**.
- Ensamblador: **GNU assembler** (o equivalente compatible para construir en entorno alterno).
- Restricciones:
  - Sin libc.
  - Sin lenguaje C.
  - Solo syscalls Linux + Bash + Make.

---

## 5) Flujo sugerido en GitHub Classroom

1. El docente crea la actividad en GitHub Classroom.
2. Cada estudiante acepta su repositorio individual.
3. Clona su repositorio en instancia AWS ARM64.
4. Implementa su variante en `src/analyzer.s`.
5. Ejecuta:
   - `make`
   - `make run`
   - `make test`
6. Hace commit/push y entrega el enlace del repositorio.

---

## 6) Instrucciones de uso en AWS Ubuntu 24 ARM64

### 6.1 Compilar

```bash
make
```

### 6.2 Ejecutar ejemplo base

```bash
make run
```

### 6.3 Ejecutar pruebas

```bash
make test
```

### 6.4 Limpiar artefactos

```bash
make clean
```

---

## 7) Variantes de práctica

- **A**: contar 2xx, 4xx, 5xx.
- **B**: encontrar código más frecuente.
- **C**: detectar primer 503.
- **D**: detectar 3 errores consecutivos.
- **E**: calcular health score.

Detalles de asignación docente: ver `instructor/VARIANTES.md`.

---

## 8) Rúbrica propuesta

Toda solución debe tener:
1. Encabezado del programador
2. Pseudocódigo
3. Código ARM64 comentado

| Criterio | Ponderación |
|---|---:|
| Correctitud funcional de la variante asignada | 40% |
| Dominio técnico de ARM64 + syscalls | 25% |
| Pruebas automatizadas y reproducibilidad | 20% |
| Calidad de documentación y claridad de código | 15% |

### Criterios de descuento sugeridos
- No compila en ARM64: hasta -40%.
- Usa C/libc: evaluación inválida por incumplir restricción.
- Sin evidencia de pruebas: hasta -20%. Utiliar Asciinema (con su nombre y preferente), o tambien LOOM.com compartido link

---

## 9) Notas para estudiantes

- Lean y entiendan el pseudocódigo al inicio de `src/analyzer.s`.
- Mantengan comentarios técnicos claros y breves.
- Trabajen incrementalmente: primero parser, luego lógica de variante, luego pruebas.
- Si trabajan en host x86_64, se recomienda emulación con `qemu-aarch64` o compilar/ejecutar directamente en AWS ARM64.
