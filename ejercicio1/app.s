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

	movz x10, 0xC7, lsl 16
	movk x10, 0x1585, lsl 00

	mov x2, SCREEN_HEIGH         // Y Size
loop1:
	mov x1, SCREEN_WIDTH         // X Size
	// ------------------- PINTAR FONDO NEGRO ----------------------

	// Color negro = 0xFF000000
	movz x10, 0x0000, lsl 0
	movk x10, 0x0000, lsl 16
	movk x10, 0x0000, lsl 32
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

	// ------------------- PINTAR LINEA BLANCA ----------------------

	// Color blanco = 0xFFFFFFFF
	movz x11, 0xFFFF, lsl 16
	movk x11, 0xFFFF, lsl 0

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

	// ------------------- PROTOTIPO DEL FONDO CELESTE CENTRADO -------------------	

loop2:
	mov x0, x20		// guardo la posición base del framebuffer de nuevo

	//color celeste claro = 0xFF339BC7
	movz x10, 0x9BC7, lsl 0	
	movk x10, 0xFF33, lsl 16

	// Constantes a usar
	mov x5, #640              // SCREEN_WIDTH
	mov x6, #100              // x_start
	mov x7, #540              // x_end 
	mov x8, #50              // y_start
	mov x9, #239              // y_end 

	mov x3, x8                // y = 100, posición inicial

loop2_y:
	mov x2, x6                // x = 100, posición inicial

loop2_x_1:
	// offset = ((y * 640) + x) * 4
	mul x1, x3, x5
	add x1, x1, x2		
	lsl x1, x1, #2
	add x4, x20, x1
	str w10, [x4]             // pintar pixel

	add x2, x2, #1
	cmp x2, x7
	b.lt loop2_x_1			// Repetir el ciclo hasta llegar a x = 540
	
	mov x2, x8

	add x3, x3, #1
	cmp x3, x9
	b.lt loop2_y		// Repetir el ciclo hasta llegar a y = 239
	
	// ------------------- PROTOTIPO DEL FONDO PÚRPURA DEBAJO DEL CELESTE -------------------	

	//color púrpura = 0xFF2B3DA1
	movz x10, 0x3DA1, lsl 0	
	movk x10, 0xFF2B, lsl 16

	// Constantes
	mov x5, #640              // SCREEN_WIDTH
	mov x6, #150              // x_start
	mov x7, #490              // x_end 
	mov x8, #130              // y_start
	mov x9, #239              // y_end 

	mov x3, x8                // y = 130

loop3_y:
	mov x2, x6                // x = 150

loop3_x_1:
	// offset = ((y * 640) + x) * 4
	mul x1, x3, x5
	add x1, x1, x2
	lsl x1, x1, #2
	add x4, x20, x1
	str w10, [x4]             // pintar pixel

	add x2, x2, #1
	cmp x2, x7
	b.lt loop3_x_1		// Repetir el ciclo hasta llegar a x = 490
	
	mov x2, x8

	add x3, x3, #1
	cmp x3, x9
	b.lt loop3_y		// Repetir el ciclo hasta llegar a y = 239







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
