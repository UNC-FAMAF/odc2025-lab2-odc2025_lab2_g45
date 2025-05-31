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

	// ------------------- PROTOTIPO DEL FONDO CELESTE DE ARRIBA Y ABAJO -------------------	

loop2:
	mov x0, x20		// guardo la posición base del framebuffer de nuevo

	//color celeste claro de abajo = 0xFF4A667E
	movz x10, 0x667E, lsl 0	
	movk x10, 0xFF4A, lsl 16

	// Constantes a usar
	mov x5, #640              // SCREEN_WIDTH
	mov x6, #50              // x_start
	mov x7, #590              // x_end 
	mov x11, #40              // y_start
	mov x12, #239              // y_end 
	bl double_mirror_loop			// pinto el fondo de abajo

	//color celeste claro de arriba = 0xFF2E91B9
	movz x10, 0x91B9, lsl 0	
	movk x10, 0xFF2E, lsl 16
	bl mirror_loop		// pinto el fondo de arriba

	// ------------------- PROTOTIPO DEL FONDO PÚRPURA -------------------	

	//color púrpura inferior = 0xFF1F1D44
	movz x10, 0x1D44, lsl 0	
	movk x10, 0xFF1F, lsl 16

	// PÚRPURA INFERIOR
	mov x5, #640              // SCREEN_WIDTH
	mov x6, #52               // x_start
	mov x7, #68              // x_end 
	mov x11, #128              // y_start
	mov x12, #239              // y_end 
	bl double_mirror_loop
	
	// A partir de acá, dejaré de poner los registros x5 y x12 en la llamada, ya que los mismos no van a cambiar nunca. (x12 significa que siempre se pintará hasta la mitad de la pantalla)

	// PÚRPURA INFERIOR
	mov x6, #68               // x_start
	mov x7, #72              // x_end 
	mov x11, #136              // y_start
	bl double_mirror_loop
		
	// PÚRPURA INFERIOR
	mov x6, #72               // x_start
	mov x7, #84              // x_end 
	mov x11, #140              // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #84               // x_start
	mov x7, #92              // x_end 
	mov x11, #144              // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #92               // x_start
	mov x7, #104              // x_end 
	mov x11, #152              // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #104               // x_start
	mov x7, #108              // x_end 
	mov x11, #156              // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #108               // x_start
	mov x7, #116              // x_end 
	mov x11, #160              // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #116               // x_start
	mov x7, #128             // x_end 
	mov x11, #164              // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #128               // x_start
	mov x7, #132             // x_end 
	mov x11, #168              // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #132               // x_start
	mov x7, #140             // x_end 
	mov x11, #172              // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #140               // x_start
	mov x7, #148             // x_end 
	mov x11, #176              // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #148               // x_start
	mov x7, #156             // x_end 
	mov x11, #180              // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #156               // x_start
	mov x7, #172             // x_end 
	mov x11, #176              // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #172               // x_start
	mov x7, #180             // x_end 
	mov x11, #172              // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #180               // x_start
	mov x7, #188             // x_end 
	mov x11, #168              // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #188               // x_start
	mov x7, #196             // x_end 
	mov x11, #176            // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #196               // x_start
	mov x7, #208             // x_end 
	mov x11, #180            // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #208               // x_start
	mov x7, #228             // x_end 
	mov x11, #184            // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #228               // x_start
	mov x7, #232             // x_end 
	mov x11, #188            // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #232               // x_start
	mov x7, #240             // x_end 
	mov x11, #184            // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #240               // x_start
	mov x7, #244             // x_end 
	mov x11, #188            // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #244               // x_start
	mov x7, #248             // x_end 
	mov x11, #192            // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #248               // x_start
	mov x7, #252            // x_end 
	mov x11, #196            // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #252               // x_start
	mov x7, #264            // x_end 
	mov x11, #200            // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #264               // x_start
	mov x7, #280            // x_end 
	mov x11, #196            // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #280               // x_start
	mov x7, #284            // x_end 
	mov x11, #192            // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #284               // x_start
	mov x7, #288            // x_end 
	mov x11, #188            // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #288               // x_start
	mov x7, #300            // x_end 
	mov x11, #192            // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #300               // x_start
	mov x7, #312            // x_end 
	mov x11, #196            // y_start
	bl double_mirror_loop

	// PÚRPURA INFERIOR
	mov x6, #312               // x_start
	mov x7, #320            // x_end 
	mov x11, #200            // y_start
	bl double_mirror_loop



	//---- color púrpura superior = 0xFF2B3DA1 ----
	movz x10, 0x3DA1, lsl 0	
	movk x10, 0xFF2B, lsl 16

	// Para lograr el efecto de que arriba sea un tono más claro de púrpura, y abajo sea un tono más oscuro, lo que hago es utilizar mi función
	// double_mirror_loop para pintar primero con el color púrpura más oscuro. Esto hace que ya tenga pintado arriba y abajo un reflejo exactamente igual.
	// Luego, con la función mirror_loop pinto solo en la parte de arriba (con color púrpura claro) por encima de lo pintado anteriormente con púrpura oscuro.
	// De esta forma logro el efecto de que arriba sean colores más claros y luminosos, mientras que abajo son más oscuros y apagados.

	// PÚRPURA SUPERIOR
	mov x6, #52               // x_start
	mov x7, #68              // x_end 
	mov x11, #128              // y_start
	mov x12, #239              // y_end 
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #68               // x_start
	mov x7, #72              // x_end 
	mov x11, #136              // y_start
	bl mirror_loop
		
	// PÚRPURA SUPERIOR
	mov x6, #72               // x_start
	mov x7, #84              // x_end 
	mov x11, #140              // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #84               // x_start
	mov x7, #92              // x_end 
	mov x11, #144              // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #92               // x_start
	mov x7, #104              // x_end 
	mov x11, #152              // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #104               // x_start
	mov x7, #108              // x_end 
	mov x11, #156              // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #108               // x_start
	mov x7, #116              // x_end 
	mov x11, #160              // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #116               // x_start
	mov x7, #128             // x_end 
	mov x11, #164              // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #128               // x_start
	mov x7, #132             // x_end 
	mov x11, #168              // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #132               // x_start
	mov x7, #140             // x_end 
	mov x11, #172              // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #140               // x_start
	mov x7, #148             // x_end 
	mov x11, #176              // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #148               // x_start
	mov x7, #156             // x_end 
	mov x11, #180              // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #156               // x_start
	mov x7, #172             // x_end 
	mov x11, #176              // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #172               // x_start
	mov x7, #180             // x_end 
	mov x11, #172              // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #180               // x_start
	mov x7, #188             // x_end 
	mov x11, #168              // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #188               // x_start
	mov x7, #196             // x_end 
	mov x11, #176            // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #196               // x_start
	mov x7, #208             // x_end 
	mov x11, #180            // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #208               // x_start
	mov x7, #228             // x_end 
	mov x11, #184            // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #228               // x_start
	mov x7, #232             // x_end 
	mov x11, #188            // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #232               // x_start
	mov x7, #240             // x_end 
	mov x11, #184            // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #240               // x_start
	mov x7, #244             // x_end 
	mov x11, #188            // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #244               // x_start
	mov x7, #248             // x_end 
	mov x11, #192            // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #248               // x_start
	mov x7, #252            // x_end 
	mov x11, #196            // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #252               // x_start
	mov x7, #264            // x_end 
	mov x11, #200            // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #264               // x_start
	mov x7, #280            // x_end 
	mov x11, #196            // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #280               // x_start
	mov x7, #284            // x_end 
	mov x11, #192            // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #284               // x_start
	mov x7, #288            // x_end 
	mov x11, #188            // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #288               // x_start
	mov x7, #300            // x_end 
	mov x11, #192            // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #300               // x_start
	mov x7, #312            // x_end 
	mov x11, #196            // y_start
	bl mirror_loop

	// PÚRPURA SUPERIOR
	mov x6, #312               // x_start
	mov x7, #320            // x_end 
	mov x11, #200            // y_start
	bl mirror_loop

		// ------------------- PROTOTIPO DE LA FORMA DEL FONDO, LA PARTE DE LOS ARBUSTOS Y LA PARTE NEGRA DE ARRIBA DEL FONDO -------------------

	//color negro = 0xFF000000
	movz x10, 0x0000, lsl 0	
	movk x10, 0xFF00, lsl 16

	// En todas las siguientes instrucciones uso el color negro, estoy dibujando las siluetas del fondo

	// En todas aquellas repeticiones que son de la forma -----x-1-----, estoy dibujando la parte superior del fondo, para que parezca un domo arriba. 

	// DOMO
	mov x5, #640              // SCREEN_WIDTH
	mov x6, #50              // x_start
	mov x7, #54              // x_end
	mov x11, #30              // y_start
	mov x12, #220              // y_end
	mov x13, #480			//SCREEN_HEIGHT
	bl double_mirror_loop

	// DOMO
	mov x6, #54              // x_start
	mov x7, #62              // x_end
	mov x11, #30              // y_start
	mov x12, #150              // y_end
	bl double_mirror_loop

	// DOMO
	mov x6, #62              // x_start
	mov x7, #66              // x_end
	mov x11, #30              // y_start
	mov x12, #130              // y_end
	bl double_mirror_loop

	// DOMO
	mov x6, #66              // x_start
	mov x7, #74              // x_end
	mov x11, #30              // y_start
	mov x12, #100              // y_end
	bl double_mirror_loop

	// DOMO
	mov x6, #74              // x_start
	mov x7, #76              // x_end
	mov x11, #30              // y_start
	mov x12, #90              // y_end
	bl double_mirror_loop

	// DOMO
	mov x6, #76              // x_start
	mov x7, #78              // x_end
	mov x11, #30              // y_start
	mov x12, #85              // y_end
	bl double_mirror_loop

	// DOMO
	mov x6, #78              // x_start
	mov x7, #82              // x_end
	mov x11, #30              // y_start
	mov x12, #75              // y_end
	bl double_mirror_loop

	// DOMO
	mov x6, #82              // x_start
	mov x7, #84              // x_end
	mov x11, #30              // y_start
	mov x12, #69              // y_end
	bl double_mirror_loop

	// DOMO
	mov x6, #84              // x_start
	mov x7, #90              // x_end
	mov x11, #30              // y_start
	mov x12, #63              // y_end
	bl double_mirror_loop

	// DOMO
	mov x6, #90              // x_start
	mov x7, #100              // x_end
	mov x11, #30              // y_start
	mov x12, #58              // y_end
	bl double_mirror_loop

	// DOMO
	mov x6, #100              // x_start
	mov x7, #106              // x_end
	mov x11, #30              // y_start
	mov x12, #54              // y_end
	bl double_mirror_loop

	// DOMO
	mov x6, #106              // x_start
	mov x7, #118              // x_end
	mov x11, #30              // y_start
	mov x12, #50              // y_end
	bl double_mirror_loop

	// DOMO
	mov x6, #118              // x_start
	mov x7, #130              // x_end
	mov x11, #30              // y_start
	mov x12, #48              // y_end
	bl double_mirror_loop

	// DOMO
	mov x6, #130              // x_start
	mov x7, #150              // x_end
	mov x11, #30              // y_start
	mov x12, #46              // y_end
	bl double_mirror_loop

	// DOMO
	mov x6, #150              // x_start
	mov x7, #190              // x_end
	mov x11, #30              // y_start
	mov x12, #44              // y_end
	bl double_mirror_loop

	// DOMO
	mov x6, #190              // x_start
	mov x7, #220              // x_end
	mov x11, #30              // y_start
	mov x12, #42              // y_end
	bl double_mirror_loop

	// Las siguientes repeticiones son de arbustos

	// En las repeticiones -----x-2----- dibujo el primer arbusto de izquierda a derecha (Reflejado en el lado derecho también). 

	// ARBUSTO 1
	mov x6, #82              // x_start
	mov x7, #86              // x_end
	mov x11, #160              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 1
	mov x6, #86              // x_start
	mov x7, #94              // x_end
	mov x11, #164              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 1
	mov x6, #94              // x_start
	mov x7, #98              // x_end
	mov x11, #168              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 1
	mov x6, #98              // x_start
	mov x7, #102              // x_end
	mov x11, #172              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 1
	mov x6, #102              // x_start
	mov x7, #114              // x_end
	mov x11, #176              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 1
	mov x6, #114              // x_start
	mov x7, #118              // x_end
	mov x11, #180              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop


	// ARBUSTO 1
	mov x6, #118              // x_start
	mov x7, #122              // x_end
	mov x11, #184              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 1
	mov x6, #122              // x_start
	mov x7, #126              // x_end
	mov x11, #188              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 1
	mov x6, #126              // x_start
	mov x7, #130              // x_end
	mov x11, #192              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 1
	mov x6, #130              // x_start
	mov x7, #142              // x_end
	mov x11, #196              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 1
	mov x6, #142              // x_start
	mov x7, #146              // x_end
	mov x11, #200              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 1
	mov x6, #146              // x_start
	mov x7, #154              // x_end
	mov x11, #204              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 1
	mov x6, #50              // x_start
	mov x7, #54              // x_end
	mov x11, #178              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 1
	mov x6, #54              // x_start
	mov x7, #58              // x_end
	mov x11, #174              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 1
	mov x6, #58              // x_start
	mov x7, #64              // x_end
	mov x11, #170              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 1
	mov x6, #64              // x_start
	mov x7, #72              // x_end
	mov x11, #166              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 1
	mov x6, #72              // x_start
	mov x7, #76              // x_end
	mov x11, #162              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 1
	mov x6, #76              // x_start
	mov x7, #84              // x_end
	mov x11, #160              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// En las repeticiones -----x-3----- dibujo el segundo arbusto de izquierda a derecha (Reflejado en el lado derecho también). 

	// ARBUSTO 2 
	mov x6, #154              // x_start
	mov x7, #158              // x_end
	mov x11, #200              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 2 
	mov x6, #158              // x_start
	mov x7, #162              // x_end
	mov x11, #196              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 2 
	mov x6, #162              // x_start
	mov x7, #166              // x_end
	mov x11, #192              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 2 
	mov x6, #166              // x_start
	mov x7, #174              // x_end
	mov x11, #188              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 2 
	mov x6, #174              // x_start
	mov x7, #186              // x_end
	mov x11, #184              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 2 
	mov x6, #186              // x_start
	mov x7, #190              // x_end
	mov x11, #188              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop
	
	// ARBUSTO 2 
	mov x6, #190              // x_start
	mov x7, #198              // x_end
	mov x11, #192              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop
	
	// ARBUSTO 2 
	mov x6, #198              // x_start
	mov x7, #202              // x_end
	mov x11, #196              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 2 
	mov x6, #202              // x_start
	mov x7, #206              // x_end
	mov x11, #200              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 2
	mov x6, #206              // x_start
	mov x7, #210              // x_end
	mov x11, #204              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 2
	mov x6, #210              // x_start
	mov x7, #214              // x_end
	mov x11, #208              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 2
	mov x6, #214              // x_start
	mov x7, #218              // x_end
	mov x11, #208              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 2
	mov x6, #218              // x_start
	mov x7, #222              // x_end
	mov x11, #212              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 2
	mov x6, #222              // x_start
	mov x7, #226              // x_end
	mov x11, #216              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// En las repeticiones ----x-4---- dibujo el tercer arbusto de izquierda a derecha (Reflejado en el lado derecho también). 

	// ARBUSTO 3
	mov x6, #226              // x_start
	mov x7, #230              // x_end
	mov x11, #212              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 3
	mov x6, #230              // x_start
	mov x7, #234              // x_end
	mov x11, #208              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 3
	mov x6, #234              // x_start
	mov x7, #242              // x_end
	mov x11, #204              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 3
	mov x6, #242              // x_start
	mov x7, #250              // x_end
	mov x11, #208              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 3
	mov x6, #250              // x_start
	mov x7, #266              // x_end
	mov x11, #212              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 3
	mov x6, #266              // x_start
	mov x7, #274              // x_end
	mov x11, #216              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// En las repeticiones ----x-5---- dibujo el cuarto arbusto de izquierda a derecha (Reflejado en el lado derecho también). 

	// ARBUSTO 4
	mov x6, #274              // x_start
	mov x7, #278              // x_end
	mov x11, #212              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 4
	mov x6, #278              // x_start
	mov x7, #282              // x_end
	mov x11, #208              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 4
	mov x6, #282              // x_start
	mov x7, #290              // x_end
	mov x11, #204              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 4
	mov x6, #290              // x_start
	mov x7, #298              // x_end
	mov x11, #208              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 4
	mov x6, #298              // x_start
	mov x7, #302              // x_end
	mov x11, #212              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 4
	mov x6, #302              // x_start
	mov x7, #306              // x_end
	mov x11, #216              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop
	
	// ARBUSTO 4
	mov x6, #306              // x_start
	mov x7, #314              // x_end
	mov x11, #220              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop
	
	// ARBUSTO 4
	mov x6, #314              // x_start
	mov x7, #318              // x_end
	mov x11, #224              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop

	// ARBUSTO 4
	mov x6, #318              // x_start
	mov x7, #326              // x_end
	mov x11, #228              // y_start
	mov x12, #240              // y_end
	bl double_mirror_loop
	
	// ------------------- ÁRBOLES DEL FONDO, REFLEJADOS ARRIBA Y ABAJO -------------------

	// Determino que x10 sea el color negro = 0xFF000000
	movz x10, 0x0000, lsl #0
	movk x10, 0xFF00, lsl #16

	// --- El siguiente código es para los árboles de la izquierda hacia la derecha ---
	// ACLARACIÓN: Ya que estoy usando la función double_mirror_loop, los árboles son de izquierda a derecha, hasta llegar a la mitad de la pantalla.
	// A partir de la mitad a la derecha, son un reflejo del lado izquierdo.  

	// ÁRBOL 1
	mov x6, #78              // x_start
	mov x7, #92              // x_end
	mov x11, #144              // y_start
	mov x12, #164              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #66              // x_start
	mov x7, #70              // x_end
	mov x11, #120              // y_start
	mov x12, #128              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #70              // x_start
	mov x7, #74              // x_end
	mov x11, #100              // y_start
	mov x12, #120              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #66              // x_start
	mov x7, #70              // x_end
	mov x11, #96              // y_start
	mov x12, #112              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #82              // x_start
	mov x7, #94              // x_end
	mov x11, #108              // y_start
	mov x12, #144              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #94              // x_start
	mov x7, #98              // x_end
	mov x11, #124              // y_start
	mov x12, #132              // y_end
	bl double_mirror_loop
	
	// ÁRBOL 1
	mov x6, #98              // x_start
	mov x7, #102              // x_end
	mov x11, #120              // y_start
	mov x12, #124              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #102              // x_start
	mov x7, #106              // x_end
	mov x11, #116              // y_start
	mov x12, #120              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #94              // x_start
	mov x7, #102              // x_end
	mov x11, #112              // y_start
	mov x12, #116              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #102              // x_start
	mov x7, #106              // x_end
	mov x11, #140              // y_start
	mov x12, #160              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #98              // x_start
	mov x7, #102              // x_end
	mov x11, #136              // y_start
	mov x12, #140              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #106              // x_start
	mov x7, #110              // x_end
	mov x11, #120              // y_start
	mov x12, #140              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #108              // x_start
	mov x7, #112              // x_end
	mov x11, #92              // y_start
	mov x12, #100              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #112              // x_start
	mov x7, #116              // x_end
	mov x11, #100              // y_start
	mov x12, #104             // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #116              // x_start
	mov x7, #124              // x_end
	mov x11, #96              // y_start
	mov x12, #100             // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #120              // x_start
	mov x7, #124              // x_end
	mov x11, #92              // y_start
	mov x12, #96             // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #116              // x_start
	mov x7, #120              // x_end
	mov x11, #80              // y_start
	mov x12, #92             // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #110              // x_start
	mov x7, #114              // x_end
	mov x11, #132              // y_start
	mov x12, #136              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #114              // x_start
	mov x7, #118              // x_end
	mov x11, #112              // y_start
	mov x12, #132              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #78              // x_start
	mov x7, #86              // x_end
	mov x11, #80              // y_start
	mov x12, #108              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #72              // x_start
	mov x7, #78              // x_end
	mov x11, #72              // y_start
	mov x12, #80              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #86              // x_start
	mov x7, #90              // x_end
	mov x11, #60              // y_start
	mov x12, #80              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #92              // x_start
	mov x7, #100              // x_end
	mov x11, #90              // y_start
	mov x12, #112              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #100              // x_start
	mov x7, #108              // x_end
	mov x11, #82              // y_start
	mov x12, #100              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #92              // x_start
	mov x7, #96              // x_end
	mov x11, #58              // y_start
	mov x12, #70              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #96              // x_start
	mov x7, #100              // x_end
	mov x11, #70              // y_start
	mov x12, #74              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #100              // x_start
	mov x7, #104              // x_end
	mov x11, #74              // y_start
	mov x12, #78              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #104              // x_start
	mov x7, #108              // x_end
	mov x11, #78              // y_start
	mov x12, #82              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #108              // x_start
	mov x7, #112              // x_end
	mov x11, #62              // y_start
	mov x12, #86              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #112              // x_start
	mov x7, #116              // x_end
	mov x11, #46              // y_start
	mov x12, #58              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #104              // x_start
	mov x7, #112              // x_end
	mov x11, #58              // y_start
	mov x12, #62              // y_end
	bl double_mirror_loop

	// ÁRBOL 1
	mov x6, #100              // x_start
	mov x7, #104              // x_end
	mov x11, #50              // y_start
	mov x12, #62            // y_end
	bl double_mirror_loop



	// ÁRBOL 2
	mov x6, #132              // x_start
	mov x7, #136              // x_end
	mov x11, #160              // y_start
	mov x12, #240           // y_end
	bl double_mirror_loop
	
	// ÁRBOL 2
	mov x6, #128              // x_start
	mov x7, #132              // x_end
	mov x11, #100              // y_start
	mov x12, #160           // y_end
	bl double_mirror_loop

	// ÁRBOL 2
	mov x6, #128              // x_start
	mov x7, #136              // x_end
	mov x11, #88              // y_start
	mov x12, #100           // y_end
	bl double_mirror_loop

	// ÁRBOL 2
	mov x6, #136              // x_start
	mov x7, #140              // x_end
	mov x11, #64              // y_start
	mov x12, #88           // y_end
	bl double_mirror_loop

	// ÁRBOL 2
	mov x6, #140              // x_start
	mov x7, #144              // x_end
	mov x11, #52              // y_start
	mov x12, #64           // y_end
	bl double_mirror_loop
	
	// ÁRBOL 2
	mov x6, #140              // x_start
	mov x7, #148              // x_end
	mov x11, #48              // y_start
	mov x12, #52           // y_end
	bl double_mirror_loop

	// ÁRBOL 2
	mov x6, #148              // x_start
	mov x7, #152              // x_end
	mov x11, #44              // y_start
	mov x12, #48           // y_end
	bl double_mirror_loop

	// ÁRBOL 2
	mov x6, #124              // x_start
	mov x7, #128              // x_end
	mov x11, #72              // y_start
	mov x12, #88           // y_end
	bl double_mirror_loop

	// ÁRBOL 2
	mov x6, #120              // x_start
	mov x7, #124              // x_end
	mov x11, #60             // y_start
	mov x12, #72           // y_end
	bl double_mirror_loop

	// ÁRBOL 2
	mov x6, #124              // x_start
	mov x7, #128              // x_end
	mov x11, #64            // y_start
	mov x12, #68           // y_end
	bl double_mirror_loop

	// ÁRBOL 2
	mov x6, #128              // x_start
	mov x7, #132              // x_end
	mov x11, #60            // y_start
	mov x12, #64           // y_end
	bl double_mirror_loop

	// ÁRBOL 2
	mov x6, #128              // x_start
	mov x7, #132              // x_end
	mov x11, #60            // y_start
	mov x12, #64           // y_end
	bl double_mirror_loop


	// ÁRBOL 3
	mov x6, #144              // x_start
	mov x7, #152              // x_end
	mov x11, #140            // y_start
	mov x12, #220           // y_end
	bl double_mirror_loop

	// ÁRBOL 3
	mov x6, #152              // x_start
	mov x7, #156              // x_end
	mov x11, #108            // y_start
	mov x12, #152           // y_end
	bl double_mirror_loop
	
	// ÁRBOL 3
	mov x6, #156              // x_start
	mov x7, #160              // x_end
	mov x11, #96            // y_start
	mov x12, #112           // y_end
	bl double_mirror_loop
	
	// ÁRBOL 3
	mov x6, #160              // x_start
	mov x7, #164              // x_end
	mov x11, #80            // y_start
	mov x12, #96           // y_end
	bl double_mirror_loop

	// ÁRBOL 3
	mov x6, #160              // x_start
	mov x7, #168              // x_end
	mov x11, #76            // y_start
	mov x12, #80           // y_end
	bl double_mirror_loop

	// ÁRBOL 3
	mov x6, #164              // x_start
	mov x7, #168              // x_end
	mov x11, #72            // y_start
	mov x12, #76           // y_end
	bl double_mirror_loop

	// ÁRBOL 3
	mov x6, #136              // x_start
	mov x7, #140              // x_end
	mov x11, #108            // y_start
	mov x12, #128           // y_end
	bl double_mirror_loop

	// ÁRBOL 3
	mov x6, #140              // x_start
	mov x7, #144              // x_end
	mov x11, #128            // y_start
	mov x12, #132           // y_end
	bl double_mirror_loop

	// ÁRBOL 3
	mov x6, #144              // x_start
	mov x7, #148              // x_end
	mov x11, #132            // y_start
	mov x12, #144           // y_end
	bl double_mirror_loop

	// ÁRBOL 3
	mov x6, #156              // x_start
	mov x7, #160              // x_end
	mov x11, #140            // y_start
	mov x12, #144           // y_end
	bl double_mirror_loop

	// ÁRBOL 3
	mov x6, #160              // x_start
	mov x7, #164              // x_end
	mov x11, #136            // y_start
	mov x12, #140           // y_end
	bl double_mirror_loop

	// ÁRBOL 3
	mov x6, #164              // x_start
	mov x7, #168              // x_end
	mov x11, #132            // y_start
	mov x12, #136           // y_end
	bl double_mirror_loop

	// ÁRBOL 3
	mov x6, #168              // x_start
	mov x7, #172              // x_end
	mov x11, #128            // y_start
	mov x12, #132           // y_end
	bl double_mirror_loop

	// ÁRBOL 3
	mov x6, #172              // x_start
	mov x7, #176              // x_end
	mov x11, #112            // y_start
	mov x12, #128           // y_end
	bl double_mirror_loop

	// ÁRBOL 3
	mov x6, #172              // x_start
	mov x7, #180              // x_end
	mov x11, #112            // y_start
	mov x12, #116           // y_end
	bl double_mirror_loop

	// ÁRBOL 3
	mov x6, #152              // x_start
	mov x7, #160              // x_end
	mov x11, #180            // y_start
	mov x12, #184           // y_end
	bl double_mirror_loop

	// ÁRBOL 3
	mov x6, #160              // x_start
	mov x7, #164              // x_end
	mov x11, #176            // y_start
	mov x12, #180           // y_end
	bl double_mirror_loop

	// ÁRBOL 3
	mov x6, #164              // x_start
	mov x7, #168              // x_end
	mov x11, #172            // y_start
	mov x12, #176           // y_end
	bl double_mirror_loop

	// ÁRBOL 3
	mov x6, #168              // x_start
	mov x7, #172              // x_end
	mov x11, #168            // y_start
	mov x12, #172           // y_end
	bl double_mirror_loop
	
	// ÁRBOL 3
	mov x6, #168              // x_start
	mov x7, #172              // x_end
	mov x11, #156            // y_start
	mov x12, #168           // y_end
	bl double_mirror_loop

	// ÁRBOL 3
	mov x6, #164              // x_start
	mov x7, #168              // x_end
	mov x11, #144            // y_start
	mov x12, #156           // y_end
	bl double_mirror_loop

	// ÁRBOL 3
	mov x6, #168              // x_start
	mov x7, #176              // x_end
	mov x11, #156            // y_start
	mov x12, #160           // y_end
	bl double_mirror_loop



	// ÁRBOL 4
	mov x6, #164              // x_start
	mov x7, #192              // x_end
	mov x11, #40            // y_start
	mov x12, #60           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #152              // x_start
	mov x7, #164              // x_end
	mov x11, #52            // y_start
	mov x12, #56           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #156              // x_start
	mov x7, #160              // x_end
	mov x11, #44            // y_start
	mov x12, #48           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #160              // x_start
	mov x7, #164              // x_end
	mov x11, #48            // y_start
	mov x12, #52           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #120              // x_start
	mov x7, #128              // x_end
	mov x11, #52            // y_start
	mov x12, #56           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #124              // x_start
	mov x7, #136              // x_end
	mov x11, #44            // y_start
	mov x12, #52           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #136              // x_start
	mov x7, #140              // x_end
	mov x11, #52            // y_start
	mov x12, #56           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #180              // x_start
	mov x7, #184              // x_end
	mov x11, #60            // y_start
	mov x12, #64           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #176              // x_start
	mov x7, #180              // x_end
	mov x11, #64            // y_start
	mov x12, #68           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #164              // x_start
	mov x7, #168              // x_end
	mov x11, #60            // y_start
	mov x12, #64           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #168              // x_start
	mov x7, #172              // x_end
	mov x11, #64            // y_start
	mov x12, #68           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #192              // x_start
	mov x7, #196              // x_end
	mov x11, #56            // y_start
	mov x12, #60           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #192              // x_start
	mov x7, #196              // x_end
	mov x11, #40            // y_start
	mov x12, #52           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #196              // x_start
	mov x7, #200              // x_end
	mov x11, #52            // y_start
	mov x12, #56           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #200              // x_start
	mov x7, #204              // x_end
	mov x11, #48            // y_start
	mov x12, #52           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #196              // x_start
	mov x7, #200              // x_end
	mov x11, #44            // y_start
	mov x12, #48           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #204              // x_start
	mov x7, #216              // x_end
	mov x11, #48            // y_start
	mov x12, #64           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #204              // x_start
	mov x7, #212              // x_end
	mov x11, #36            // y_start
	mov x12, #52           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #220              // x_start
	mov x7, #224              // x_end
	mov x11, #40            // y_start
	mov x12, #44           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #216              // x_start
	mov x7, #220              // x_end
	mov x11, #40            // y_start
	mov x12, #48           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #216              // x_start
	mov x7, #220              // x_end
	mov x11, #52            // y_start
	mov x12, #56           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #220             // x_start
	mov x7, #224              // x_end
	mov x11, #48            // y_start
	mov x12, #52           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #224             // x_start
	mov x7, #228              // x_end
	mov x11, #44            // y_start
	mov x12, #48           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #228             // x_start
	mov x7, #232              // x_end
	mov x11, #40            // y_start
	mov x12, #60           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #228             // x_start
	mov x7, #236              // x_end
	mov x11, #40            // y_start
	mov x12, #44           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #236             // x_start
	mov x7, #240              // x_end
	mov x11, #40            // y_start
	mov x12, #52           // y_end
	bl double_mirror_loop

	// ÁRBOL 4
	mov x6, #232             // x_start
	mov x7, #236              // x_end
	mov x11, #44            // y_start
	mov x12, #48           // y_end
	bl double_mirror_loop



	// ÁRBOL 5
	mov x6, #216              // x_start
	mov x7, #220              // x_end
	mov x11, #180            // y_start
	mov x12, #220           // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #212              // x_start
	mov x7, #216              // x_end
	mov x11, #152            // y_start
	mov x12, #184           // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #208              // x_start
	mov x7, #212              // x_end
	mov x11, #144             // y_start
	mov x12, #152           // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #208              // x_start
	mov x7, #212              // x_end
	mov x11, #144             // y_start
	mov x12, #152           // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #204              // x_start
	mov x7, #208              // x_end
	mov x11, #140             // y_start
	mov x12, #144           // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #200              // x_start
	mov x7, #204              // x_end
	mov x11, #128             // y_start
	mov x12, #140           // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #216              // x_start
	mov x7, #220              // x_end
	mov x11, #148             // y_start
	mov x12, #152           // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #220              // x_start
	mov x7, #232              // x_end
	mov x11, #144             // y_start
	mov x12, #148           // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #216              // x_start
	mov x7, #220              // x_end
	mov x11, #132             // y_start
	mov x12, #144           // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #212              // x_start
	mov x7, #216              // x_end
	mov x11, #132             // y_start
	mov x12, #136           // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #208              // x_start
	mov x7, #212              // x_end
	mov x11, #116             // y_start
	mov x12, #132           // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #204             // x_start
	mov x7, #208              // x_end
	mov x11, #116          // y_start
	mov x12, #120           // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #204             // x_start
	mov x7, #208              // x_end
	mov x11, #124          // y_start
	mov x12, #128           // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #200             // x_start
	mov x7, #204              // x_end
	mov x11, #112          // y_start
	mov x12, #116           // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #228             // x_start
	mov x7, #232              // x_end
	mov x11, #104          // y_start
	mov x12, #148           // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #232             // x_start
	mov x7, #236              // x_end
	mov x11, #112          // y_start
	mov x12, #120           // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #232             // x_start
	mov x7, #236              // x_end
	mov x11, #128          // y_start
	mov x12, #136           // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #224             // x_start
	mov x7, #228              // x_end
	mov x11, #116          // y_start
	mov x12, #120         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #220             // x_start
	mov x7, #224              // x_end
	mov x11, #112          // y_start
	mov x12, #116         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #208             // x_start
	mov x7, #220              // x_end
	mov x11, #108          // y_start
	mov x12, #112         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #204             // x_start
	mov x7, #208              // x_end
	mov x11, #104         // y_start
	mov x12, #108         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #200             // x_start
	mov x7, #204              // x_end
	mov x11, #100          // y_start
	mov x12, #104        // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #216             // x_start
	mov x7, #224              // x_end
	mov x11, #160          // y_start
	mov x12, #164         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #220             // x_start
	mov x7, #224              // x_end
	mov x11, #152          // y_start
	mov x12, #160         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #224             // x_start
	mov x7, #228              // x_end
	mov x11, #148        // y_start
	mov x12, #152         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #224            // x_start
	mov x7, #228              // x_end
	mov x11, #108        // y_start
	mov x12, #112         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #220            // x_start
	mov x7, #224              // x_end
	mov x11, #104        // y_start
	mov x12, #108         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #216            // x_start
	mov x7, #220              // x_end
	mov x11, #100        // y_start
	mov x12, #104         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #212            // x_start
	mov x7, #216              // x_end
	mov x11, #84        // y_start
	mov x12, #100         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #208            // x_start
	mov x7, #212              // x_end
	mov x11, #84        // y_start
	mov x12, #88         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #204            // x_start
	mov x7, #208              // x_end
	mov x11, #76        // y_start
	mov x12, #84         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #232            // x_start
	mov x7, #236              // x_end
	mov x11, #96        // y_start
	mov x12, #104         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #236            // x_start
	mov x7, #240              // x_end
	mov x11, #108        // y_start
	mov x12, #116         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #240            // x_start
	mov x7, #244              // x_end
	mov x11, #104        // y_start
	mov x12, #108         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #260            // x_start
	mov x7, #272              // x_end
	mov x11, #148        // y_start
	mov x12, #192         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #260            // x_start
	mov x7, #276              // x_end
	mov x11, #192        // y_start
	mov x12, #220         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #256            // x_start
	mov x7, #260              // x_end
	mov x11, #152        // y_start
	mov x12, #164         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #252            // x_start
	mov x7, #256              // x_end
	mov x11, #148        // y_start
	mov x12, #156         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #248            // x_start
	mov x7, #252              // x_end
	mov x11, #128        // y_start
	mov x12, #152         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #244            // x_start
	mov x7, #248              // x_end
	mov x11, #140        // y_start
	mov x12, #148         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #240            // x_start
	mov x7, #244              // x_end
	mov x11, #140        // y_start
	mov x12, #144         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #240            // x_start
	mov x7, #244              // x_end
	mov x11, #132        // y_start
	mov x12, #136         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #244            // x_start
	mov x7, #248              // x_end
	mov x11, #136        // y_start
	mov x12, #140         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #244            // x_start
	mov x7, #248              // x_end
	mov x11, #116        // y_start
	mov x12, #128         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #248            // x_start
	mov x7, #260              // x_end
	mov x11, #128        // y_start
	mov x12, #132         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #252           // x_start
	mov x7, #256              // x_end
	mov x11, #124        // y_start
	mov x12, #128         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #260            // x_start
	mov x7, #268             // x_end
	mov x11, #100        // y_start
	mov x12, #148         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #264            // x_start
	mov x7, #268             // x_end
	mov x11, #88        // y_start
	mov x12, #108         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #268            // x_start
	mov x7, #276             // x_end
	mov x11, #60        // y_start
	mov x12, #104         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #272            // x_start
	mov x7, #280             // x_end
	mov x11, #40        // y_start
	mov x12, #64         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #280            // x_start
	mov x7, #284             // x_end
	mov x11, #52        // y_start
	mov x12, #60         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #284            // x_start
	mov x7, #288             // x_end
	mov x11, #44        // y_start
	mov x12, #52         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #280            // x_start
	mov x7, #284             // x_end
	mov x11, #40        // y_start
	mov x12, #44         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #288            // x_start
	mov x7, #292             // x_end
	mov x11, #40        // y_start
	mov x12, #44         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #260            // x_start
	mov x7, #272             // x_end
	mov x11, #44        // y_start
	mov x12, #48         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #256            // x_start
	mov x7, #260             // x_end
	mov x11, #40        // y_start
	mov x12, #44         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #264            // x_start
	mov x7, #272             // x_end
	mov x11, #36        // y_start
	mov x12, #52         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #264            // x_start
	mov x7, #272             // x_end
	mov x11, #68        // y_start
	mov x12, #80         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #260            // x_start
	mov x7, #264             // x_end
	mov x11, #56        // y_start
	mov x12, #72         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #244            // x_start
	mov x7, #260             // x_end
	mov x11, #52        // y_start
	mov x12, #56         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #256            // x_start
	mov x7, #260             // x_end
	mov x11, #60        // y_start
	mov x12, #64         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #252            // x_start
	mov x7, #256             // x_end
	mov x11, #56        // y_start
	mov x12, #60         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #248            // x_start
	mov x7, #252             // x_end
	mov x11, #52        // y_start
	mov x12, #56         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #252            // x_start
	mov x7, #256             // x_end
	mov x11, #48        // y_start
	mov x12, #52         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #248            // x_start
	mov x7, #252             // x_end
	mov x11, #44        // y_start
	mov x12, #48         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #276            // x_start
	mov x7, #280             // x_end
	mov x11, #80        // y_start
	mov x12, #100         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #280            // x_start
	mov x7, #284             // x_end
	mov x11, #76        // y_start
	mov x12, #96         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #284            // x_start
	mov x7, #288             // x_end
	mov x11, #60        // y_start
	mov x12, #88         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #280            // x_start
	mov x7, #284             // x_end
	mov x11, #64        // y_start
	mov x12, #72         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #276            // x_start
	mov x7, #280             // x_end
	mov x11, #60        // y_start
	mov x12, #64         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #288            // x_start
	mov x7, #296             // x_end
	mov x11, #84        // y_start
	mov x12, #88         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #296            // x_start
	mov x7, #300             // x_end
	mov x11, #72        // y_start
	mov x12, #84         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #292            // x_start
	mov x7, #296             // x_end
	mov x11, #64        // y_start
	mov x12, #72         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #300            // x_start
	mov x7, #304             // x_end
	mov x11, #64        // y_start
	mov x12, #72         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #296            // x_start
	mov x7, #300             // x_end
	mov x11, #52        // y_start
	mov x12, #64         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #292            // x_start
	mov x7, #296             // x_end
	mov x11, #48        // y_start
	mov x12, #52         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #288            // x_start
	mov x7, #292             // x_end
	mov x11, #44        // y_start
	mov x12, #48         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #284            // x_start
	mov x7, #288             // x_end
	mov x11, #36        // y_start
	mov x12, #44         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #300            // x_start
	mov x7, #304             // x_end
	mov x11, #72        // y_start
	mov x12, #80         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #304            // x_start
	mov x7, #312             // x_end
	mov x11, #68        // y_start
	mov x12, #72         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #312            // x_start
	mov x7, #316             // x_end
	mov x11, #60        // y_start
	mov x12, #68         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #316            // x_start
	mov x7, #320             // x_end
	mov x11, #52        // y_start
	mov x12, #60         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #324            // x_start
	mov x7, #328             // x_end
	mov x11, #44        // y_start
	mov x12, #52         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #328            // x_start
	mov x7, #332             // x_end
	mov x11, #36        // y_start
	mov x12, #44         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #310            // x_start
	mov x7, #314             // x_end
	mov x11, #156        // y_start
	mov x12, #180         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #306            // x_start
	mov x7, #310             // x_end
	mov x11, #180        // y_start
	mov x12, #220         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #306            // x_start
	mov x7, #310             // x_end
	mov x11, #144        // y_start
	mov x12, #156         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #298            // x_start
	mov x7, #306             // x_end
	mov x11, #148        // y_start
	mov x12, #152         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #294            // x_start
	mov x7, #298             // x_end
	mov x11, #140        // y_start
	mov x12, #148         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #290            // x_start
	mov x7, #294             // x_end
	mov x11, #136        // y_start
	mov x12, #140         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #286            // x_start
	mov x7, #290             // x_end
	mov x11, #132        // y_start
	mov x12, #136         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #302            // x_start
	mov x7, #306             // x_end
	mov x11, #128        // y_start
	mov x12, #144         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #306            // x_start
	mov x7, #310             // x_end
	mov x11, #124        // y_start
	mov x12, #128         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #306            // x_start
	mov x7, #310             // x_end
	mov x11, #132        // y_start
	mov x12, #136         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #314            // x_start
	mov x7, #318             // x_end
	mov x11, #160        // y_start
	mov x12, #164         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #318            // x_start
	mov x7, #322             // x_end
	mov x11, #148        // y_start
	mov x12, #160         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #314            // x_start
	mov x7, #318             // x_end
	mov x11, #140        // y_start
	mov x12, #148         // y_end
	bl double_mirror_loop

	// ÁRBOL 5
	mov x6, #310            // x_start
	mov x7, #314             // x_end
	mov x11, #136        // y_start
	mov x12, #144         // y_end
	bl double_mirror_loop


	// ------------------- PASTO EN EL QUE SE APOYAN LOS PERSONAJES -------------------

	// Pintaré el pasto utilizando la función draw_rect. Elegí esta ya que al ser una imagen pixelada, y el pasto no tener un patrón definido, es lo que más cómodo queda.

	//color verde oscuro = 0xFF35656F
	movz x5, 0x656F, lsl 0	
	movk x5, 0xFF35, lsl 16

	// PASTO
	mov x1, #52            // x_start
	mov x2, #236             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #56            // x_start
	mov x2, #232             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #60            // x_start
	mov x2, #236             // y_start
	mov x3, #260        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #352            // x_start
	mov x2, #236             // y_start
	mov x3, #200        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #552            // x_start
	mov x2, #240             // y_start
	mov x3, #8        // ancho
	mov x4, #4         // alto
	bl draw_rect
	
	// PASTO
	mov x1, #560            // x_start
	mov x2, #236             // y_start
	mov x3, #8        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #568            // x_start
	mov x2, #240             // y_start
	mov x3, #20        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #68            // x_start
	mov x2, #240             // y_start
	mov x3, #8        // ancho
	mov x4, #8         // alto
	bl draw_rect

	// PASTO
	mov x1, #100            // x_start
	mov x2, #240             // y_start
	mov x3, #4        // ancho
	mov x4, #8         // alto
	bl draw_rect

	// PASTO
	mov x1, #120            // x_start
	mov x2, #240             // y_start
	mov x3, #4        // ancho
	mov x4, #8         // alto
	bl draw_rect

	// PASTO
	mov x1, #148            // x_start
	mov x2, #240             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #156            // x_start
	mov x2, #240             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #176            // x_start
	mov x2, #240             // y_start
	mov x3, #160        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #340            // x_start
	mov x2, #240             // y_start
	mov x3, #120        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #464            // x_start
	mov x2, #240             // y_start
	mov x3, #80        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #80            // x_start
	mov x2, #232             // y_start
	mov x3, #8        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #116            // x_start
	mov x2, #232             // y_start
	mov x3, #12        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #160            // x_start
	mov x2, #232             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #168            // x_start
	mov x2, #232             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #176            // x_start
	mov x2, #232             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #180            // x_start
	mov x2, #232             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #260            // x_start
	mov x2, #232             // y_start
	mov x3, #8        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #272            // x_start
	mov x2, #232             // y_start
	mov x3, #20        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #320            // x_start
	mov x2, #232             // y_start
	mov x3, #32        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #404            // x_start
	mov x2, #232             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #412            // x_start
	mov x2, #232             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #448            // x_start
	mov x2, #232             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #456            // x_start
	mov x2, #232             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #464            // x_start
	mov x2, #232             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #500            // x_start
	mov x2, #232             // y_start
	mov x3, #12        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #128            // x_start
	mov x2, #244             // y_start
	mov x3, #116        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #268            // x_start
	mov x2, #244             // y_start
	mov x3, #168        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #60            // x_start
	mov x2, #244             // y_start
	mov x3, #48        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #480            // x_start
	mov x2, #244             // y_start
	mov x3, #8        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #512            // x_start
	mov x2, #244             // y_start
	mov x3, #12        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #72            // x_start
	mov x2, #248             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #100            // x_start
	mov x2, #248             // y_start
	mov x3, #12        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #204            // x_start
	mov x2, #248             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #248            // x_start
	mov x2, #248             // y_start
	mov x3, #24        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #320            // x_start
	mov x2, #248             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #364            // x_start
	mov x2, #248             // y_start
	mov x3, #8        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// PASTO
	mov x1, #400            // x_start
	mov x2, #248             // y_start
	mov x3, #12        // ancho
	mov x4, #4         // alto
	bl draw_rect




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

//////////////////////////////////subrutinas//////////////////////////////

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
    mov w10, w5                 // color (from w5 argument)
    mov x11, #640               // SCREEN_WIDTH (hardcoded, consider passing as argument or global .equ)

    // Calculate end coordinates
    add x12, x6, x8             // x_end = x_start + ancho
    add x13, x7, x9             // y_end = y_start + alto

    // Loop through y-coordinates
    mov x14, x7                 // y = y_start

loop_y_rect:
    cmp x14, x13                // Compare y with y_end
    b.ge end_draw_rect          // If y >= y_end, exit y-loop

    // Loop through x-coordinates
    mov x15, x6                 // x = x_start (reset for each row)

loop_x_rect:
    cmp x15, x12                // Compare x with x_end
    b.ge next_y_rect            // If x >= x_end, go to next row

    // Calculate pixel address
    mul x16, x14, x11           // y * SCREEN_WIDTH
    add x16, x16, x15           // (y * SCREEN_WIDTH) + x
    lsl x16, x16, #2            // * 4 bytes per pixel (assuming 32-bit color)

    add x17, x0, x16            // pixel_address = framebuffer_base + offset
    str w10, [x17]              // Write color to pixel

    add x15, x15, #1            // x++
    b loop_x_rect               // Continue x-loop

next_y_rect:
    add x14, x14, #1            // y++
    b loop_y_rect               // Continue y-loop

end_draw_rect:
    // Restore callee-saved registers if they were saved at the beginning
    // ldp x21, x22, [sp], #16
    // ldp x19, x20, [sp], #16
    ret


// draw_circle:
// Entrada:
// x0 = puntero framebuffer base
// x1 = center_x (coordenada X del centro del círculo)
// x2 = center_y (coordenada Y del centro del círculo)
// x3 = radio (radio del círculo)
// w5 = color (color del círculo, formato de 32 bits)

draw_circle:

    // Mover argumentos a registros de trabajo para claridad y consistencia
    mov x6, x1                  // x6 = center_x
    mov x7, x2                  // x7 = center_y
    mov x8, x3                  // x8 = radio
    mov w9, w5                  // w9 = color

    // Definir el ancho de la pantalla (asumiendo 640 píxeles, como en draw_rect)
    mov x10, #640               // x10 = SCREEN_WIDTH

    // Calcular el radio al cuadrado (radio * radio) para la comparación de distancia
    // Esto evita la necesidad de calcular la raíz cuadrada en cada píxel.
    mul x11, x8, x8             // x11 = radio_squared

    // Calcular las coordenadas del cuadro delimitador (bounding box) del círculo
    // Esto define el área rectangular mínima que contiene el círculo.
    sub x12, x6, x8             // x12 = x_start (center_x - radio)
    add x13, x6, x8             // x13 = x_end   (center_x + radio)
    sub x14, x7, x8             // x14 = y_start (center_y - radio)
    add x15, x7, x8             // x15 = y_end   (center_y + radio)

    // Bucle principal para las coordenadas Y (filas) dentro del cuadro delimitador
    mov x16, x14                // x16 = current_y (inicializar con y_start)

loop_y_circle:
    cmp x16, x15                // Comparar current_y con y_end
    b.ge end_draw_circle        // Si current_y >= y_end, salir del bucle Y

    // Bucle anidado para las coordenadas X (columnas) dentro del cuadro delimitador
    mov x17, x12                // x17 = current_x (reiniciar con x_start para cada nueva fila)

loop_x_circle:
    cmp x17, x13                // Comparar current_x con x_end
    b.ge next_y_circle          // Si current_x >= x_end, pasar a la siguiente fila (siguiente Y)

    // Calcular dx = current_x - center_x
    // dx es la distancia horizontal del píxel actual al centro del círculo.
    sub x18, x17, x6            // x18 = dx

    // Calcular dy = current_y - center_y
    // dy es la distancia vertical del píxel actual al centro del círculo.
    sub x19, x16, x7            // x19 = dy

    // Calcular dx_squared = dx * dx
    mul x20, x18, x18           // x20 = dx_squared

    // Calcular dy_squared = dy * dy
    mul x21, x19, x19           // x21 = dy_squared

    // Calcular distance_squared = dx_squared + dy_squared
    // Esta es la distancia euclidiana al cuadrado desde el centro del círculo al píxel actual.
    add x22, x20, x21           // x22 = distance_squared

    // Comparar distance_squared con radio_squared
    // Si la distancia al cuadrado es mayor que el radio al cuadrado, el píxel está fuera del círculo.
    cmp x22, x11                // Comparar distance_squared con radio_squared
    b.gt skip_pixel_circle      // Si distance_squared > radio_squared, saltar el dibujo de este píxel

    // Si el píxel está dentro del círculo, calcular su dirección en el framebuffer y dibujarlo
    // Calcular el desplazamiento del píxel: (current_y * SCREEN_WIDTH) + current_x
    mul x23, x16, x10           // x23 = current_y * SCREEN_WIDTH
    add x23, x23, x17           // x23 = (current_y * SCREEN_WIDTH) + current_x

    // Multiplicar por 4 para obtener el desplazamiento en bytes (asumiendo 32 bits por píxel)
    lsl x23, x23, #2            // x23 = offset_in_bytes

    // Calcular la dirección de memoria del píxel: framebuffer_base + offset_in_bytes
    add x24, x0, x23            // x24 = pixel_address

    // Almacenar el color en la dirección de memoria del píxel
    str w9, [x24]               // Escribir el color (w9) en la dirección [x24]

skip_pixel_circle:
    add x17, x17, #1            // Incrementar current_x (x++)
    b loop_x_circle             // Continuar con el bucle X

next_y_circle:
    add x16, x16, #1            // Incrementar current_y (y++)
    b loop_y_circle             // Continuar con el bucle Y

end_draw_circle:
    // Restaurar registros guardados por la función si fuera necesario.
    // (Siguiendo el ejemplo de draw_rect, no se realizan operaciones de guardar/restaurar explícitas aquí)
    ret                         // Retornar de la función



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
