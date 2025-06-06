.include "header.s"    // Solo incluye header para constantes

.globl main

.section .bss
.align 12
BackFB: .skip 1228800

.section .text

main:
    mov x20, x0             // x0 contiene la direccion base del framebuffer (principal)

    bl dibujando_celeste
    bl dibujando_purpura_inferior
    bl dibujando_purpura_superior
    bl dibujando_arbustos_y_fondo
    bl dibujando_arboles_fondo
    bl dibujando_ODC2025
    bl dibujando_pasto
    bl dibujando_dustin
    bl dibujando_eleven
    bl dibujando_mike
    bl dibujando_lucas
    bl dibujando_will
    bl dibujando_max
    bl draw_demogorgon

InfLoop:
    b InfLoop
