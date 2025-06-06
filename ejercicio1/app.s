.globl main

main:
	// x0 contiene la direccion base del framebuffer
 	mov x20, x0	// Guarda la dirección base del framebuffer en x20
	//---------------- CODE HERE ------------------------------------
	bl dibujando_celeste
	bl dibujando_purpura_inferior
	bl dibujando_purpura_superior
	bl dibujando_estrellas
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

    
	//---------------------------------------------------------------
	// Infinite Loop

InfLoop:
	b InfLoop
