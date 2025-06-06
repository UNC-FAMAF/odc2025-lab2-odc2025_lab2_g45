    .include "header.s"

//////////////////////////////////subrutinas para hacer formas (cuadrados, circulos, y para reflejar sobre los ejes//////////////////////////////

.globl mirror_loop
.globl mirror_loop_y
.globl mirror_loop_x
.globl double_mirror_loop
.globl double_mirror_loop_y
.globl double_mirror_loop_x
.globl inverted_mirror_loop
.globl inverted_mirror_loop_y
.globl inverted_mirror_loop_x
.globl only_y_mirror_loop
.globl only_y_mirror_loop_y
.globl only_y_mirror_loop_x
.globl draw_rect
.globl draw_circle
.globl render
.globl fillscreen
.global delay_loop

//////////////////////////////////subrutinas para hacer formas (cuadrados, circulos, y para reflejar sobre los ejes//////////////////////////////


//--Método de uso de mirror_loop--
//	movz x10, 0x667E, lsl 0		---> Establecer el color a usar
//	movk x10, 0xFF4A, lsl 16
//
//	mov x5, #640	---> Ancho total de la pantalla
//	mov x6, #80		---> Dirección de inicio de x para pintar
//	mov x7, #560	---> Dirección de fin de x para pintar
//	mov x11, #40	---> Dirección de inicio de y para pintar
//	mov x12, #239	---> Dirección de fin de y para pintar
//	bl mirror_loop	---> Llamado a la función


mirror_loop:			// ----Loops para pintar en reflejo respecto al eje Y----
	mov x3, x11

mirror_loop_y:
	mov x2, x6

mirror_loop_x:
	// offset = ((y * 640) + x) * 4
	mul x1, x3, x5			// x1 = y * 640
	add x1, x1, x2			// x1 = (y * 640) + x
	lsl x1, x1, #2			// x1 = ((y * 640) + x) * 4
	add x4, x0, x1
	str w10, [x4]             // Pinto del lado izquierdo de la pantalla

	mov x9, x5			// x9 = 640
	sub x8, x9, #1		// x8 = 640 - 1
	sub x8, x8, x2		// Calculo auxiliar para pintar en reflejo del lado derecho, x8 = 640 - x

	mul x1, x3, x5
	add x1, x1, x8
	lsl x1, x1, #2
	add x4, x0, x1
	str w10, [x4]		// Pinto del lado derecho de la pantalla

	add x2, x2, #1
	cmp x2, x7
	b.lt mirror_loop_x		

	add x3, x3, #1
	cmp x3, x12
	b.lt mirror_loop_y		

	ret


//--Método de uso de double_mirror_loop--
//	movz x10, 0x667E, lsl 0		---> Establecer el color a usar
//	movk x10, 0xFF4A, lsl 16x0
//
//	mov x5, #640	---> Ancho total de la pantalla
//	mov x6, #80		---> Dirección de inicio de x para pintar
//	mov x7, #560	---> Dirección de fin de x para pintar
//	mov x11, #40	---> Dirección de inicio de y para pintar
//	mov x12, #239	---> Dirección de fin de y para pintar
//
//	bl double_mirror_loop		----> Llamado a la función


double_mirror_loop:			// ----Loops para pintar en reflejo respecto a los ejes X e Y al mismo tiempo----
	mov x3, x11

double_mirror_loop_y:
	mov x2, x6

double_mirror_loop_x:
	// offset = ((y * 640) + x) * 4
	mul x1, x3, x5
	add x1, x1, x2
	lsl x1, x1, #2
	add x4, x0, x1
	str w10, [x4]             // Pinto del lado izquierdo de la pantalla

	mov x9, x5
	sub x8, x9, #1
	sub x8, x8, x2		// Calculo auxiliar para pintar en reflejo del lado derecho

	mul x1, x3, x5
	add x1, x1, x8
	lsl x1, x1, #2
	add x4, x0, x1
	str w10, [x4]		// Pinto del lado derecho de la pantalla

	mov x9, #479          // 480 - 1..........Cálculo auxiliar para pintar en reflejo respecto al eje X
	sub x15, x9, x3       // 479 - y es el reflejo vertical

	mul x1, x15, x5
	add x1, x1, x2
	lsl x1, x1, #2
	add x4, x0, x1
	str w10, [x4]             // Pinto del lado izquierdo de la pantalla

	mul x1, x15, x5
	add x1, x1, x8
	lsl x1, x1, #2
	add x4, x0, x1
	str w10, [x4]		// Pinto del lado derecho de la pantalla	

	add x2, x2, #1
	cmp x2, x7
	b.lt double_mirror_loop_x		

	add x3, x3, #1
	cmp x3, x12
	b.lt double_mirror_loop_y		

	ret

//--Método de uso de inverted_mirror_loop--
//	movz x10, 0x667E, lsl 0		--->Establecer el color a usar
//	movk x10, 0xFF4A, lsl 16
//
//	mov x5, #640	---> Ancho total de la pantalla
//	mov x6, #80		---> Dirección de inicio de x para pintar
//	mov x7, #560	---> Dirección de fin de x para pintar
//	mov x11, #40	---> Dirección de inicio de y para pintar
//	mov x12, #239	---> Dirección de fin de y para pintar
//	bl double_mirror_loop		----> Llamado a la función


inverted_mirror_loop:			// ----Loops para pintar en reflejo, solo usando la diagonal respecto a X e Y al mismo tiempo----
	mov x3, x11					// Por ejemplo, si pinto un pixel arriba izquierda, ese mismo va a reflejarse SOLO abajo derecha respecto al eje X e Y

inverted_mirror_loop_y:
	mov x2, x6

inverted_mirror_loop_x:
	// offset = ((y * 640) + x) * 4
	mul x1, x3, x5
	add x1, x1, x2
	lsl x1, x1, #2
	add x4, x0, x1
	str w10, [x4]             // Pinto del lado izquierdo de la pantalla

	mov x9, #639		// x9 = 639
	sub x8, x9, x2		// Calculo auxiliar para pintar en reflejo del lado derecho, x8 = 639 - x

	mov x9, #479          // 480 - 1........ Cálculo auxiliar para pintar en reflejo respecto al eje X
	sub x15, x9, x3       // 479 - y es el reflejo vertical

	mul x1, x15, x5
	add x1, x1, x8
	lsl x1, x1, #2
	add x4, x0, x1
	str w10, [x4]		// Pinto del lado derecho de la pantalla	

	add x2, x2, #1
	cmp x2, x7
	b.lt inverted_mirror_loop_x		

	add x3, x3, #1
	cmp x3, x12
	b.lt inverted_mirror_loop_y		

	ret

//--Método de uso de only_y_mirror_loop--
//	movz x10, 0x667E, lsl 0		---> Establecer el color a usar
//	movk x10, 0xFF4A, lsl 16x0
//
//	mov x5, #640	---> Ancho total de la pantalla
//	mov x6, #80		---> Dirección de inicio de x para pintar
//	mov x7, #560	---> Dirección de fin de x para pintar
//	mov x11, #40	---> Dirección de inicio de y para pintar
//	mov x12, #239	---> Dirección de fin de y para pintar
//
//	bl only_y_mirror_loop		----> Llamado a la función


only_y_mirror_loop:			// ----Loops para pintar en reflejo SOLO respecto al eje X ----
	mov x3, x11

only_y_mirror_loop_y:
	mov x2, x6

only_y_mirror_loop_x:
	// offset = ((y * 640) + x) * 4
	mul x1, x3, x5
	add x1, x1, x2
	lsl x1, x1, #2
	add x4, x0, x1
	str w10, [x4]             // Pinto del lado izquierdo de la pantalla

	mov x9, #479          // 480 - 1, Cálculo auxiliar para pintar en reflejo respecto al eje X
	sub x15, x9, x3       // 479 - y es el reflejo vertical

	mul x1, x15, x5
	add x1, x1, x2
	lsl x1, x1, #2
	add x4, x0, x1
	str w10, [x4]             // Pinto invertido respecto al eje X

	add x2, x2, #1
	cmp x2, x7
	b.lt only_y_mirror_loop_x		

	add x3, x3, #1
	cmp x3, x12
	b.lt only_y_mirror_loop_y		

	ret
 

// draw_rect:
// Entrada:
// x0 = puntero framebuffer base
// x1 = x_start
// x2 = y_start
// x3 = ancho
// x4 = alto
// w5 = color

draw_rect:

    mov x6, x1                  // x_start
    mov x7, x2                  // y_start
    mov x8, x3                  // ancho
    mov x9, x4                  // alto
    mov w10, w5                 // color 
    mov x11, #640               // 

    
    add x12, x6, x8             // x_end = x_start + ancho
    add x13, x7, x9             // y_end = y_start + alto

    
    mov x14, x7                 // y = y_start

loop_y_rect:
    cmp x14, x13                // comparo y con y_end
    b.ge end_draw_rect          // si i>= y_end, salgo de y_loop

    mov x15, x6                 // x = x_start 

loop_x_rect:
    cmp x15, x12                // comparo x con x_end
    b.ge next_y_rect            // si x>= x_end, sigo 

    mul x16, x14, x11           // y * SCREEN_WIDTH
    add x16, x16, x15           // (y * SCREEN_WIDTH) + x
    lsl x16, x16, #2            // * 4 bytes por pixel (assumiendo colores de 32-bit )

    add x17, x0, x16            // pixel_address = framebuffer_base + offset
    str w10, [x17]              

    add x15, x15, #1            // x++
    b loop_x_rect               

next_y_rect:
    add x14, x14, #1            // y++
    b loop_y_rect               

end_draw_rect:
    ret


// draw_circle:
// Entrada:
// x0 = puntero framebuffer base
// x1 = center_x (coordenada X del centro del círculo)
// x2 = center_y (coordenada Y del centro del círculo)
// x3 = radio (radio del círculo)
// w5 = color (color del círculo, formato de 32 bits)

draw_circle:

    mov x6, x1
    mov x7, x2
    mov x8, x3
    mov w9, w5

    mov x10, #640

    // radio al cuadrado 
    mul x11, x8, x8

    
    sub x12, x6, x8
    add x13, x6, x8
    sub x14, x7, x8
    add x15, x7, x8

    
    mov x16, x14

loop_y_circle:
    cmp x16, x15
    b.ge end_draw_circle

    
    mov x17, x12

loop_x_circle:
    cmp x17, x13
    b.ge next_y_circle

    sub x18, x17, x6 
    sub x19, x16, x7 
    mul x25, x18, x18  
    mul x21, x19, x19  

    add x22, x25, x21  

    cmp x22, x11
    b.gt skip_pixel_circle

    mul x23, x16, x10
    add x23, x23, x17
    lsl x23, x23, #2

    add x24, x0, x23
    str w9, [x24]

skip_pixel_circle:
    add x17, x17, #1
    b loop_x_circle

next_y_circle:
    add x16, x16, #1
    b loop_y_circle

end_draw_circle:
    ret
