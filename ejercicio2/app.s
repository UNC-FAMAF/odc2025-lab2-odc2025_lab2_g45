.include "header.s"    // Solo incluye header para constantes

.globl main


main:
    mov x20, x0             // x0 contiene la direccion base del framebuffer (principal)

    bl dibujando_celeste
    bl dibujando_purpura_inferior
    bl dibujando_purpura_superior
    movz x10, 0xBFDE, lsl 0    
    movk x10, 0xFF9B, lsl 16
    bl dibujando_estrellas       // Dibuja las estrellas inicialmente encendidas
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
    bl animacion              // Llama a la animación al final del dibujo inicial


InfLoop:
    b InfLoop
