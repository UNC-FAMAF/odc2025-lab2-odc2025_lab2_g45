.globl main
main:
    mov x20, x0          // framebuffer base

    // Dibujo estático (solo una vez)
    bl dibujando_celeste
    bl dibujando_purpura_inferior
    bl dibujando_purpura_superior
    bl dibujando_arbustos_y_fondo
    bl dibujando_arboles_fondo
    bl dibujando_ODC2025
    bl dibujando_pasto
    bl dibujando_dustin
    bl dibujando_mike
    bl dibujando_lucas
    bl dibujando_max
    bl draw_demogorgon

    mov x19, #0          // contador de frames

animloop:
    // Parpadeo de estrellas
    and x1, x19, #1        // x1 = x19 % 2
    cbz x1, mostrar_estrellas

    // Si x19 es impar, saltear dibujo de estrellas
    b skip_estrellas

mostrar_estrellas:
    bl dibujando_estrellas

skip_estrellas:
    // Acá podés agregar animaciones de personajes si querés
    // bl dibujando_eleven
    // bl dibujando_will

    mov x0, #10
    bl delay

    add x19, x19, #1
    cmp x19, #120
    b.lt animloop

InfLoop:
    b InfLoop
