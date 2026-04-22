.equ SYS_read,   63
.equ SYS_write,  64
.equ SYS_exit,   93
.equ STDIN_FD,    0
.equ STDOUT_FD,   1

/*
===========================================================
Mini Cloud Log Analyzer - Variante C
Autor: Maldonado Avendaño Valeria 

Descripción:
Programa en ensamblador ARM64 que analiza códigos HTTP
desde la entrada estándar (stdin) y detecta el primer
evento crítico (503).

Pseudocódigo:

1. Leer datos desde stdin en bloques
2. Recorrer cada carácter leído
3. Si el carácter es un dígito:
      construir el número (ej. 5 -> 50 -> 503)
4. Si se detecta salto de línea:
      verificar el número construido
      si es 503:
          imprimir "CRITICAL 503 DETECTED"
          terminar programa
      si no:
          reiniciar variables
5. Si se termina la entrada:
      imprimir "NO CRITICAL EVENT"
6. Finalizar ejecución

===========================================================
*/

.section .bss
buffer: .skip 4096        // buffer para lectura

.section .data
msg_found:     .asciz "CRITICAL 503 DETECTED\n"
msg_notfound:  .asciz "NO CRITICAL EVENT\n"

.section .text
.global _start

_start:
    mov x22, #0      // numero_actual
    mov x23, #0      // bandera: indica si hay dígitos

// =====================
// Leer desde stdin
// =====================
leer:
    mov x0, #STDIN_FD

    adrp x1, buffer
    add  x1, x1, :lo12:buffer

    mov x2, #4096
    mov x8, #SYS_read
    svc #0

    cmp x0, #0
    beq no_found     // si no hay más datos

    mov x24, #0      // índice
    mov x25, x0      // bytes leídos

// =====================
// Recorrer buffer
// =====================
loop:
    cmp x24, x25
    b.ge leer        // si termina buffer, leer otra vez

    adrp x1, buffer
    add  x1, x1, :lo12:buffer

    ldrb w26, [x1, x24]   // leer byte
    add x24, x24, #1

    cmp w26, #10          // salto de línea '\n'
    beq check

    // verificar si es dígito
    cmp w26, #'0'
    b.lt loop
    cmp w26, #'9'
    b.gt loop

    // =====================
    // Construir número
    // =====================
    mov x27, #10
    mul x22, x22, x27

    sub w26, w26, #'0'    // convertir ASCII a número
    uxtw x26, w26
    add x22, x22, x26

    mov x23, #1           // marcar que hay dígitos
    b loop

// =====================
// Verificar número
// =====================
check:
    cbz x23, reset        // si no hay número, ignorar

    cmp x22, #503         // comparar con 503
    beq found

// =====================
// Reset variables
// =====================
reset:
    mov x22, #0
    mov x23, #0
    b loop

// =====================
// Caso encontrado
// =====================
found:
    adrp x0, msg_found
    add  x0, x0, :lo12:msg_found
    bl write_cstr
    b exit

// =====================
// Caso no encontrado
// =====================
no_found:
    adrp x0, msg_notfound
    add  x0, x0, :lo12:msg_notfound
    bl write_cstr

// =====================
// Salir del programa
// =====================
exit:
    mov x0, #0
    mov x8, #SYS_exit
    svc #0

// =====================
// Función: imprimir string
// =====================
write_cstr:
    mov x9, x0       // dirección string
    mov x10, #0      // contador longitud

len:
    ldrb w11, [x9, x10]
    cbz w11, done
    add x10, x10, #1
    b len

done:
    mov x1, x9
    mov x2, x10
    mov x0, #STDOUT_FD
    mov x8, #SYS_write
    svc #0
    ret
