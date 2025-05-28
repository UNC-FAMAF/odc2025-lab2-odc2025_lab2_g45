.equ SCREEN_WIDTH, 		640
	.equ SCREEN_HEIGH, 		480
	.equ BITS_PER_PIXEL,  	32

	.equ GPIO_BASE,      0x3f200000
	.equ GPIO_GPFSEL0,   0x00
	.equ GPIO_GPLEV0,    0x34

	.globl main

main:
	// x0 contiene la direccion base del framebuffer
 	mov x20, x0	// Guarda la dirección base del framebuffer en x20
	//---------------- CODE HERE ------------------------------------

	mov x2, SCREEN_HEIGH         // Y Size
loop1:
	mov x1, SCREEN_WIDTH         // X Size
	// ------------------- PINTAR FONDO NEGRO ----------------------

	// Color negro = 0xFF000000
	movz x10, 0x0000, lsl 0
	movk x10, 0x0000, lsl 16
	movk x10, 0xFF00, lsl 32     //

	mov x2, SCREEN_HEIGH         // Y Size
loop_fill:
	mov x1, SCREEN_WIDTH         // X Size
loop_fill_x:
	stur w10,[x0]  // Colorear el pixel negro
	add x0,x0,4	   // Siguiente pixel
	sub x1,x1,1	   // Decrementar contador X
	cbnz x1,loop_fill_x  // Si no terminó la fila, salto
	sub x2,x2,1	   // Decrementar contador Y
	cbnz x2,loop_fill  // Si no es la última fila, salto

	// ------------------- PINTAR LINEA verde* ----------------------

	// Color verde = 0xFF00FF00
	movz x11, 0xFF23, lsl 0     // parte baja (los dos bytes bajos)
	movk x11, 0x631F, lsl 16    // parte alta (los dos bytes altos)


	// fila donde va la linea
	mov x12, SCREEN_HEIGH
	lsr x12, x12, 1          // x12 = SCREEN_HEIGH / 2 = 240

	// índice base de la fila: (240 * 640) * 4 bytes
	mov x13, SCREEN_WIDTH
	mul x13, x13, x12        // x13 = 240 * 640 (cantidad de pixels previos
	lsl x13, x13, 2          // *4 bytes por pixel

	add x14, x20, x13        // dirección base del pixel de la fila 240
	mov x15, SCREEN_WIDTH    // ancho de la pantalla para pintar la línea

line_loop:
	str w11, [x14], #4       //  pixel blanco y avanzo 4 bytes osea 1 pixel
	sub x15, x15, 1
	cbnz x15, line_loop



	// ------------------- PROTOTIPO DEL FONDO CELESTE DE ARRIBA Y ABAJO -------------------	

loop2:
	mov x0, x20		// guardo la posición base del framebuffer de nuevo

	//color celeste claro de abajo = 0xFF4A667E
	movz x10, 0x667E, lsl 0	
	movk x10, 0xFF4A, lsl 16

	// Constantes a usar
	mov x20, x0
	mov x5, #640              // SCREEN_WIDTH
	mov x6, #80              // x_start
	mov x7, #560              // x_end 
	mov x11, #40              // y_start
	mov x12, #239              // y_end 
	bl double_mirror_loop			// pinto el fondo de abajo

	//color celeste claro de abajo = 0xFF339BC7
	movz x10, 0x9BC7, lsl 0	
	movk x10, 0xFF33, lsl 16
	bl mirror_loop		// pinto el fondo de arriba

	// ------------------- PROTOTIPO DEL FONDO PÚRPURA -------------------	

	//color púrpura inferior = 0xFF1F1D44
	movz x10, 0x1D44, lsl 0	
	movk x10, 0xFF1F, lsl 16

	// Constantes
	mov x5, #640              // SCREEN_WIDTH
	mov x6, #80               // x_start
	mov x7, #560              // x_end 
	mov x11, #130              // y_start
	mov x12, #239              // y_end 
	bl double_mirror_loop	

	//color púrpura superior = 0xFF2B3DA1
	movz x10, 0x3DA1, lsl 0	
	movk x10, 0xFF2B, lsl 16

	bl mirror_loop

	// ------------------- PROTOTIPO DE LA FORMA DEL FONDO, LA PARTE DE LOS ARBUSTOS Y LA PARTE NEGRA DE ARRIBA DEL FONDO -------------------

	//color negro = 0xFF000000
	movz x10, 0x0000, lsl 0	
	movk x10, 0xFF00, lsl 16

	// En todas las siguientes instrucciones uso el color negro, estoy dibujando las siluetas del fondo

	// En todas aquellas repeticiones que son de la forma -----x-1-----, estoy dibujando la parte superior del fondo, para que parezca un domo arriba. 

	// Repetición 1-1
	mov x5, #640              // SCREEN_WIDTH
	mov x6, #80              // x_start
	mov x7, #84              // x_end
	mov x11, #30              // y_start
	mov x12, #220              // y_end
	mov x13, #480			//SCREEN_HEIGHT
	bl double_mirror_loop

	// Repetición 2-1
	mov x6, #84              // x_start
	mov x7, #92              // x_end
	mov x11, #30              // y_start
	mov x12, #150              // y_end
	bl double_mirror_loop

	// Repetición 3-1
	mov x6, #92              // x_start
	mov x7, #96              // x_end
	mov x11, #30              // y_start
	mov x12, #130              // y_end
	bl double_mirror_loop

	// Repetición 3-1
	mov x6, #96              // x_start
	mov x7, #104              // x_end
	mov x11, #30              // y_start
	mov x12, #100              // y_end
	bl double_mirror_loop

	// Repetición 4-1
	mov x6, #104              // x_start
	mov x7, #106              // x_end
	mov x11, #30              // y_start
	mov x12, #86              // y_end
	bl double_mirror_loop

	// Repetición 5-1
	mov x6, #106              // x_start
	mov x7, #108              // x_end
	mov x11, #30              // y_start
	mov x12, #82              // y_end
	bl double_mirror_loop

	// Repetición 6-1
	mov x6, #108              // x_start
	mov x7, #112              // x_end
	mov x11, #30              // y_start
	mov x12, #72              // y_end
	bl double_mirror_loop

	// Repetición 7-1
	mov x6, #112              // x_start
	mov x7, #114              // x_end
	mov x11, #30              // y_start
	mov x12, #66              // y_end
	bl double_mirror_loop

	// Repetición 8-1
	mov x6, #114              // x_start
	mov x7, #120              // x_end
	mov x11, #30              // y_start
	mov x12, #62              // y_end
	bl double_mirror_loop

	// Repetición 9-1
	mov x6, #120              // x_start
	mov x7, #130              // x_end
	mov x11, #30              // y_start
	mov x12, #56              // y_end
	bl double_mirror_loop

	// Repetición 10-1
	mov x6, #130              // x_start
	mov x7, #136              // x_end
	mov x11, #30              // y_start
	mov x12, #54              // y_end
	bl double_mirror_loop

	// Repetición 11-1
	mov x6, #136              // x_start
	mov x7, #148              // x_end
	mov x11, #30              // y_start
	mov x12, #52              // y_end
	bl double_mirror_loop

	// Repetición 12-1
	mov x6, #148              // x_start
	mov x7, #160              // x_end
	mov x11, #30              // y_start
	mov x12, #48              // y_end
	bl double_mirror_loop

	// Repetición 13-1
	mov x6, #160              // x_start
	mov x7, #180              // x_end
	mov x11, #30              // y_start
	mov x12, #46              // y_end
	bl double_mirror_loop

	// Repetición 14-1
	mov x6, #180              // x_start
	mov x7, #220              // x_end
	mov x11, #30              // y_start
	mov x12, #44              // y_end
	bl double_mirror_loop

	// Repetición 15-1
	mov x6, #220              // x_start
	mov x7, #250              // x_end
	mov x11, #30              // y_start
	mov x12, #42              // y_end
	bl double_mirror_loop

	// Las siguientes repeticiones son de arbustos

	// En las repeticiones -----x-2----- dibujo el primer arbusto de izquierda a derecha (Reflejado en el lado derecho también). 

	// Repetición 1-2
	mov x6, #84              // x_start
	mov x7, #86              // x_end
	mov x11, #160              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 2-2
	mov x6, #86              // x_start
	mov x7, #94              // x_end
	mov x11, #164              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 3-2
	mov x6, #94              // x_start
	mov x7, #98              // x_end
	mov x11, #168              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 4-2
	mov x6, #98              // x_start
	mov x7, #102              // x_end
	mov x11, #172              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 5-2
	mov x6, #102              // x_start
	mov x7, #114              // x_end
	mov x11, #176              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 6-2
	mov x6, #114              // x_start
	mov x7, #118              // x_end
	mov x11, #180              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop


	// Repetición 7-2
	mov x6, #118              // x_start
	mov x7, #122              // x_end
	mov x11, #184              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 8-2
	mov x6, #122              // x_start
	mov x7, #126              // x_end
	mov x11, #188              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 9-2
	mov x6, #126              // x_start
	mov x7, #130              // x_end
	mov x11, #192              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 10-2
	mov x6, #130              // x_start
	mov x7, #142              // x_end
	mov x11, #196              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 11-2
	mov x6, #142              // x_start
	mov x7, #146              // x_end
	mov x11, #200              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 12-2
	mov x6, #146              // x_start
	mov x7, #154              // x_end
	mov x11, #204              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// En las repeticiones -----x-3----- dibujo el segundo arbusto de izquierda a derecha (Reflejado en el lado derecho también). 

	// Repetición 1-3
	mov x6, #154              // x_start
	mov x7, #158              // x_end
	mov x11, #200              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 2-3
	mov x6, #158              // x_start
	mov x7, #162              // x_end
	mov x11, #196              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 3-3
	mov x6, #162              // x_start
	mov x7, #166              // x_end
	mov x11, #192              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 4-3
	mov x6, #166              // x_start
	mov x7, #174              // x_end
	mov x11, #188              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 5-3
	mov x6, #174              // x_start
	mov x7, #186              // x_end
	mov x11, #184              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 6-3
	mov x6, #186              // x_start
	mov x7, #190              // x_end
	mov x11, #188              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop
	
	// Repetición 7-3
	mov x6, #190              // x_start
	mov x7, #198              // x_end
	mov x11, #192              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop
	
	// Repetición 8-3
	mov x6, #198              // x_start
	mov x7, #202              // x_end
	mov x11, #196              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 9-3
	mov x6, #202              // x_start
	mov x7, #206              // x_end
	mov x11, #200              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 10-3
	mov x6, #206              // x_start
	mov x7, #210              // x_end
	mov x11, #204              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 11-3
	mov x6, #210              // x_start
	mov x7, #214              // x_end
	mov x11, #208              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 12-3
	mov x6, #214              // x_start
	mov x7, #218              // x_end
	mov x11, #208              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 13-3
	mov x6, #218              // x_start
	mov x7, #222              // x_end
	mov x11, #212              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 14-3
	mov x6, #222              // x_start
	mov x7, #226              // x_end
	mov x11, #216              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// En las repeticiones ----x-4---- dibujo el tercer arbusto de izquierda a derecha (Reflejado en el lado derecho también). 

	// Repetición 1-4
	mov x6, #226              // x_start
	mov x7, #230              // x_end
	mov x11, #212              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 2-4
	mov x6, #230              // x_start
	mov x7, #234              // x_end
	mov x11, #208              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 3-4
	mov x6, #234              // x_start
	mov x7, #242              // x_end
	mov x11, #204              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 4-4
	mov x6, #242              // x_start
	mov x7, #250              // x_end
	mov x11, #208              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 5-4
	mov x6, #250              // x_start
	mov x7, #266              // x_end
	mov x11, #212              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 6-4
	mov x6, #266              // x_start
	mov x7, #274              // x_end
	mov x11, #216              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// En las repeticiones ----x-5---- dibujo el cuarto arbusto de izquierda a derecha (Reflejado en el lado derecho también). 

	// Repetición 1-5
	mov x6, #274              // x_start
	mov x7, #278              // x_end
	mov x11, #212              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 2-5
	mov x6, #278              // x_start
	mov x7, #282              // x_end
	mov x11, #208              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop


	// Repetición 3-5
	mov x6, #282              // x_start
	mov x7, #290              // x_end
	mov x11, #204              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 4-5
	mov x6, #290              // x_start
	mov x7, #298              // x_end
	mov x11, #208              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 4-5
	mov x6, #298              // x_start
	mov x7, #302              // x_end
	mov x11, #212              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 5-5
	mov x6, #302              // x_start
	mov x7, #306              // x_end
	mov x11, #216              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop
	
	// Repetición 6-5
	mov x6, #306              // x_start
	mov x7, #314              // x_end
	mov x11, #220              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop
	
	// Repetición 7-5
	mov x6, #314              // x_start
	mov x7, #318              // x_end
	mov x11, #224              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// Repetición 8-5
	mov x6, #318              // x_start
	mov x7, #326              // x_end
	mov x11, #228              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop
	




	// personajes

	// dustin
	mov x0, x20
	mov x1, #80       // x start
	mov x2, #160      // y start
	mov x3, #60       // ancho
	mov x4, #80       // alto
	movz w5, #0xCCAA, lsl #0        
	movk w5, #0xFFFF, lsl #16      
	bl draw_rect

	// will
	mov x0, x20
	mov x1, #160
	mov x2, #240
	mov x3, #60
	mov x4, #80
	movz w5, #0xCEA3, lsl #0        
	movk w5, #0xFFE3, lsl #16       
	bl draw_rect
//e3cea3
	// max
	mov x0, x20
	mov x1, #240
	mov x2, #160
	mov x3, #60
	mov x4, #80
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	// Rectángulo 4
	mov x0, x20
	mov x1, #320
	mov x2, #160
	mov x3, #60
	mov x4, #80
	movz w5, #0x370B, lsl #0
	movk w5, #0xFF4D, lsl #16
	bl draw_rect
	//4d370b

	// eleven
	mov x0, x20
	mov x1, #400
	mov x2, #160
	mov x3, #60
	mov x4, #80
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	// mike
	mov x0, x20
	mov x1, #480
	mov x2, #160
	mov x3, #60
	mov x4, #80
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	// PELIRROJA
	mov x0, x20
	mov x1, #240
	mov x2, #160
	mov x3, #60
	mov x4, #30
	movz w5, #0x0000, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect


// demogorgon

//cabeza
	mov x0, x20
	mov x1, #420
	mov x2, #400
	mov x3, #30
	mov x4, #30
	movz w5, #0x1B49, lsl #0
	movk w5, #0xFF00, lsl #16
	bl draw_rect

	mov x0, x20
	mov x1, #427
	mov x2, #406
	mov x3, #20
	mov x4, #23
	movz w5, #0x0000, lsl #0
	movk w5, #0xFF00, lsl #16
	bl draw_rect

	mov x0, x20
	mov x1, #420
	mov x2, #410
	mov x3, #29
	mov x4, #13
	movz w5, #0x0000, lsl #0
	movk w5, #0xFF00, lsl #16
	bl draw_rect

	mov x0, x20
	mov x1, #430
	mov x2, #400
	mov x3, #15
	mov x4, #30
	movz w5, #0x0000, lsl #0
	movk w5, #0xFF00, lsl #16
	bl draw_rect

	mov x0, x20
	mov x1, #425
	mov x2, #403
	mov x3, #20
	mov x4, #25
	movz w5, #0x0000, lsl #0
	movk w5, #0xFF00, lsl #16
	bl draw_rect

	mov x0, x20
	mov x1, #434
	mov x2, #406
	mov x3, #5
	mov x4, #1
	movz w5, #0x0000, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect



//labios?
//labio 1
	mov x0, x20
	mov x1, #400
	mov x2, #384
	mov x3, #14
	mov x4, #12
	movz w5, #0x1735, lsl #0
	movk w5, #0xFF00, lsl #16
	bl draw_rect

	mov x0, x20
	mov x1, #404
	mov x2, #386
	mov x3, #18
	mov x4, #16
	movz w5, #0x1735, lsl #0
	movk w5, #0xFF00, lsl #16
	bl draw_rect

	mov x0, x20
	mov x1, #410
	mov x2, #394
	mov x3, #18
	mov x4, #16
	movz w5, #0x1735, lsl #0
	movk w5, #0xFF00, lsl #16
	bl draw_rect

//labio 2 

	mov x0, x20
	mov x1, #410
	mov x2, #394
	mov x3, #18
	mov x4, #16
	movz w5, #0x1735, lsl #0
	movk w5, #0xFF00, lsl #16
	bl draw_rect


    // Supongamos que x0 ya tiene la dirección base del framebuffer

    mov x1, #320          // cx = 320
    mov x2, #240          // cy = 240
    mov x3, #50           // radio = 50
    mov w4, #0x00FF00FF   // color (magenta)
    mov x5, #640          // SCREEN_WIDTH

    bl draw_circle        // llamar a la función para dibujar el círculo




//////////////////////////////////subrutinas/////////////////////////////////////

// draw_rect:
// Entrada:
// x0 = puntero framebuffer base
// x1 = x_start
// x2 = y_start
// x3 = ancho
// x4 = alto
// w5 = color

draw_rect:
    mov x6, x1              // x_start
    mov x7, x2              // y_start
    mov x8, x3              // ancho
    mov x9, x4              // alto
    mov w10, w5             // color
    mov x11, #640           // SCREEN_WIDTH (puede ser .equ y usar registro)

    add x12, x6, x8         // x_end = x_start + ancho
    add x13, x7, x9         // y_end = y_start + alto

    mov x14, x7             // y = y_start

loop_y:
    mov x15, x6             // x = x_start

loop_x:
    mul x16, x14, x11       // y * SCREEN_WIDTH
    add x16, x16, x15       // x + y*SCREEN_WIDTH
    lsl x16, x16, #2        // *4 bytes por pixel

    add x17, x0, x16        // dirección pixel en framebuffer
    str w10, [x17]          // escribir color

    add x15, x15, #1
    cmp x15, x12
    b.lt loop_x

    add x14, x14, #1
    cmp x14, x13
    b.lt loop_y

    ret

draw_circle:
    // Entradas:
    // x0 = dirección framebuffer
    // x1 = cx (centro x)
    // x2 = cy (centro y)
    // x3 = radio (r)
    // w4 = color
    // x5 = SCREEN_WIDTH (ej: 640)

    // Conservar registros callee-saved si se modifican
    // (Ejemplo: si este código se llama como una función y modifica registros que el llamador espera conservar)
    // stp x19, x20, [sp, #-16]! // Guardar x19, x20
    // stp x21, x22, [sp, #-16]! // Guardar x21, x22

    mov x6, x1                  // cx
    mov x7, x2                  // cy
    mov x8, x3                  // radio
    mov w9, w4                  // color
    mov x10, x5                 // SCREEN_WIDTH

    // Calcular límites del cuadro que contiene el círculo
    // Asegurarse de que los límites estén dentro de la pantalla
    // x_start = max(0, cx - r)
    // x_end   = min(SCREEN_WIDTH, cx + r + 1)
    sub x11, x6, x8             // x_start_temp = cx - r
    cmp x11, #0
    b.lt .set_x_start_zero      // Si x_start_temp < 0, x_start = 0
    mov x18, x11                // x_start = x_start_temp
    b .x_start_ok
.set_x_start_zero:
    mov x18, #0                 // x_start = 0
.x_start_ok:

    add x12, x6, x8             // x_end_temp = cx + r
    add x12, x12, #1            // x_end_temp = cx + r + 1 (no inclusivo)
    cmp x12, x10                // Comparar con SCREEN_WIDTH
    b.gt .set_x_end_width       // Si x_end_temp > SCREEN_WIDTH, x_end = SCREEN_WIDTH
    mov x19, x12                // x_end = x_end_temp
    b .x_end_ok
.set_x_end_width:
    mov x19, x10                // x_end = SCREEN_WIDTH
.x_end_ok:

    // y_start = max(0, cy - r)
    // y_end   = min(SCREEN_HEIGHT, cy + r + 1) - Asumiendo que sabes SCREEN_HEIGHT
    // Para simplificar, asumo un SCREEN_HEIGHT implícito o que la lógica es similar a SCREEN_WIDTH
    // Si SCREEN_HEIGHT no se pasa, necesitarías un registro para ello o un valor hardcodeado.
    sub x13, x7, x8             // y_start_temp = cy - r
    cmp x13, #0
    b.lt .set_y_start_zero      // Si y_start_temp < 0, y_start = 0
    mov x20, x13                // y_start = y_start_temp
    b .y_start_ok
.set_y_start_zero:
    mov x20, #0                 // y_start = 0
.y_start_ok:

    add x14, x7, x8             // y_end_temp = cy + r
    add x14, x14, #1            // y_end_temp = cy + r + 1 (no inclusivo)
    // Aquí necesitarías un SCREEN_HEIGHT para hacer la misma comprobación que con SCREEN_WIDTH
    // Por ahora, asumiré que y_end no excede los límites si no se proporciona SCREEN_HEIGHT.
    // Si tienes SCREEN_HEIGHT, la lógica sería:
    // cmp x14, X_SCREEN_HEIGHT_REG
    // b.gt .set_y_end_height
    // mov x21, x14
    // b .y_end_ok
    // .set_y_end_height:
    // mov x21, X_SCREEN_HEIGHT_REG
    // .y_end_ok:
    mov x21, x14                // y_end = y_end_temp (sin clamp a SCREEN_HEIGHT por ahora)


    mul x15, x8, x8             // r^2, para comparar distancia

    mov x22, x20                // y = y_start (usamos x22 para el contador y)

loop_y_circle:
    cmp x22, x21
    b.ge end_circle             // Si y >= y_end, salir

    mov x23, x18                // x = x_start (usamos x23 para el contador x)

loop_x_circle:
    cmp x23, x19
    b.ge next_y_circle          // Si x >= x_end, ir a la siguiente fila

    // Calcular dx = x - cx
    sub x24, x23, x6
    // Calcular dy = y - cy
    sub x25, x22, x7

    // Calcular dx*dx + dy*dy
    smull x26, w24, w24         // dx*dx (usar w24 para multiplicación 32x32 -> 64)
    smull x27, w25, w25         // dy*dy (usar w25 para multiplicación 32x32 -> 64)
    add x28, x26, x27           // distancia_cuadrada = dx*dx + dy*dy

    // Comparar con r^2
    cmp x28, x15
    b.gt skip_pixel             // Si distancia_cuadrada > r^2, no pintar

    // Pintar pixel:
    // Calcular índice del pixel: (y * SCREEN_WIDTH + x) * BYTES_PER_PIXEL
    // Asumiendo que cada pixel es un word (4 bytes), como indica lsl #2
    mul x29, x22, x10           // y * SCREEN_WIDTH
    add x29, x29, x23           // (y * SCREEN_WIDTH) + x
    lsl x29, x29, #2            // * 4 (para bytes) -> offset en bytes
    add x30, x0, x29            // dirección del pixel en framebuffer = framebuffer_base + offset
    str w9, [x30]               // Almacenar el color en la dirección del pixel

skip_pixel:
    add x23, x23, #1            // x++
    b loop_x_circle

next_y_circle:
    add x22, x22, #1            // y++
    b loop_y_circle

end_circle:
    // Ldps para restaurar registros callee-saved si fueron guardados
    // ldp x21, x22, [sp], #16
    // ldp x19, x20, [sp], #16
    ret

mirror_loop:			// ----Loops para pintar en reflejo respecto a X----
	mov x3, x11

mirror_loop_y:
	mov x2, x6

mirror_loop_x:
	// offset = ((y * 640) + x) * 4
	mul x1, x3, x5
	add x1, x1, x2
	lsl x1, x1, #2
	add x4, x20, x1
	str w10, [x4]             // Pinto del lado izquierdo de la pantalla

	mov x9, x5
	sub x8, x9, #1
	sub x8, x8, x2		// Calculo auxiliar para pintar en reflejo del lado derecho

	mul x1, x3, x5
	add x1, x1, x8
	lsl x1, x1, #2
	add x4, x20, x1
	str w10, [x4]		// Pinto del lado derecho de la pantalla

	add x2, x2, #1
	cmp x2, x7
	b.lt mirror_loop_x		

	add x3, x3, #1
	cmp x3, x12
	b.lt mirror_loop_y		

	ret

double_mirror_loop:			// ----Loops para pintar en reflejo respecto a X e Y al mismo tiempo----
	mov x3, x11

double_mirror_loop_y:
	mov x2, x6

double_mirror_loop_x:
	// offset = ((y * 640) + x) * 4
	mul x1, x3, x5
	add x1, x1, x2
	lsl x1, x1, #2
	add x4, x20, x1
	str w10, [x4]             // Pinto del lado izquierdo de la pantalla

	mov x9, x5
	sub x8, x9, #1
	sub x8, x8, x2		// Calculo auxiliar para pintar en reflejo del lado derecho

	mul x1, x3, x5
	add x1, x1, x8
	lsl x1, x1, #2
	add x4, x20, x1
	str w10, [x4]		// Pinto del lado derecho de la pantalla

	mov x9, #479          // 480 - 1
	sub x15, x9, x3       // 479 - y es el reflejo vertical

	mul x1, x15, x5
	add x1, x1, x2
	lsl x1, x1, #2
	add x4, x20, x1
	str w10, [x4]             // Pinto del lado izquierdo de la pantalla

	mul x1, x15, x5
	add x1, x1, x8
	lsl x1, x1, #2
	add x4, x20, x1
	str w10, [x4]		// Pinto del lado derecho de la pantalla	

	add x2, x2, #1
	cmp x2, x7
	b.lt double_mirror_loop_x		

	add x3, x3, #1
	cmp x3, x12
	b.lt double_mirror_loop_y		

	ret



	// Ejemplo de uso de gpios
	mov x9, GPIO_BASE

	// Atención: se utilizan registros w porque la documentación de broadcom
	// indica que los registros que estamos leyendo y escribiendo son de 32 bits

	// Setea gpios 0 - 9 como lectura
	str wzr, [x9, GPIO_GPFSEL0]

	// Lee el estado de los GPIO 0 - 31
	ldr w10, [x9, GPIO_GPLEV0]

	// And bit a bit mantiene el resultado del bit 2 en w10
	and w11, w10, 0b10

	// w11 será 1 si había un 1 en la posición 2 de w10, si no será 0
	// efectivamente, su valor representará si GPIO 2 está activo
	lsr w11, w11, 1

	//---------------------------------------------------------------
	// Infinite Loop

InfLoop:
	b InfLoop
