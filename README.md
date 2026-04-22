# Mini Cloud Log Analyzer – Variante C

## Descripción
Este programa en ARM64 Assembly analiza códigos HTTP desde stdin y detecta el primer evento crítico (503).

## Objetivo
Implementar lógica de análisis de logs utilizando ensamblador ARM64 sin uso de libc, empleando syscalls de Linux.

## Funcionamiento
1. Lee entrada estándar (stdin)
2. Convierte caracteres a números
3. Compara cada valor leído
4. Detecta si existe un código 503
5. Imprime mensaje y termina ejecución

## Ejecución

Compilar:
make

Ejecutar:
cat data/logs_C.txt | ./analyzer

## Resultado esperado
CRITICAL 503 DETECTED

## Tecnologías
- ARM64 Assembly (AArch64)
- GNU Assembler (as, ld)
- AWS Ubuntu 24 ARM64

## Evidencia de ejecución

<img width="896" height="597" alt="evidenciaimg" src="https://github.com/user-attachments/assets/b959380a-4764-4724-8072-4b81a4527c17" />

## Asciinema: https://asciinema.org/a/LBMUwGmrV1RqHSGI 

## Autor
Maldonado Avendaño Valeria
