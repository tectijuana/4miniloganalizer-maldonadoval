.equ SYS_read,   63
.equ SYS_write,  64
.equ SYS_exit,   93
.equ STDIN_FD,    0
.equ STDOUT_FD,   1

.section .bss
buffer: .skip 4096

.section .data
msg_found: .asciz "CRITICAL 503 DETECTED\n"
msg_notfound: .asciz "NO CRITICAL EVENT\n"

.section .text
.global _start

_start:
    mov x22, #0      // numero_actual
    mov x23, #0      // tiene_digitos

leer:
    mov x0, #STDIN_FD
    adrp x1, buffer
    add x1, x1, :lo12:buffer
    mov x2, #4096
    mov x8, #SYS_read
    svc #0

    cmp x0, #0
    beq no_found

    mov x24, #0
    mov x25, x0

loop:
    cmp x24, x25
    b.ge leer

    adrp x1, buffer
    add x1, x1, :lo12:buffer
    ldrb w26, [x1, x24]
    add x24, x24, #1

    cmp w26, #10
    beq check

    cmp w26, #'0'
    b.lt loop
    cmp w26, #'9'
    b.gt loop

    mov x27, #10
    mul x22, x22, x27
    sub w26, w26, #'0'
    uxtw x26, w26
    add x22, x22, x26
    mov x23, #1
    b loop

check:
    cbz x23, reset

    cmp x22, #503
    beq found

reset:
    mov x22, #0
    mov x23, #0
    b loop

found:
    adrp x0, msg_found
    add x0, x0, :lo12:msg_found
    bl write_cstr
    b exit

no_found:
    adrp x0, msg_notfound
    add x0, x0, :lo12:msg_notfound
    bl write_cstr

exit:
    mov x0, #0
    mov x8, #SYS_exit
    svc #0

write_cstr:
    mov x9, x0
    mov x10, #0

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
