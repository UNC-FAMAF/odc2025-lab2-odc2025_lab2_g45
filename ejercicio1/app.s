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


//estrellas

	mov x0, x20 
	mov x5, #640  


	movz x10, 0x91B9, lsl 0
	movk x10, 0xFF2E, lsl 16

	// --- ZONA SUPERIOR-IZQUIERDA MEDIA 

	// Estrellas pequeñas y medianas (1x1 a 5x5)
	mov x6, #65; mov x7, #66; mov x11, #45; mov x12, #46; bl double_mirror_loop
	mov x6, #80; mov x7, #81; mov x11, #55; mov x12, #56; bl double_mirror_loop
	mov x6, #100; mov x7, #102; mov x11, #40; mov x12, #42; bl double_mirror_loop
	mov x6, #120; mov x7, #121; mov x11, #70; mov x12, #71; bl double_mirror_loop
	mov x6, #140; mov x7, #142; mov x11, #85; mov x12, #87; bl double_mirror_loop
	mov x6, #160; mov x7, #161; mov x11, #50; mov x12, #51; bl double_mirror_loop
	mov x6, #180; mov x7, #182; mov x11, #75; mov x12, #77; bl double_mirror_loop
	mov x6, #200; mov x7, #201; mov x11, #90; mov x12, #91; bl double_mirror_loop
	mov x6, #220; mov x7, #222; mov x11, #110; mov x12, #112; bl double_mirror_loop
	mov x6, #240; mov x7, #241; mov x11, #130; mov x12, #131; bl double_mirror_loop
	mov x6, #260; mov x7, #262; mov x11, #150; mov x12, #152; bl double_mirror_loop
	mov x6, #280; mov x7, #281; mov x11, #170; mov x12, #171; bl double_mirror_loop
	mov x6, #60; mov x7, #62; mov x11, #100; mov x12, #102; bl double_mirror_loop
	mov x6, #90; mov x7, #91; mov x11, #120; mov x12, #121; bl double_mirror_loop
	mov x6, #130; mov x7, #131; mov x11, #140; mov x12, #141; bl double_mirror_loop
	mov x6, #170; mov x7, #172; mov x11, #160; mov x12, #162; bl double_mirror_loop
	mov x6, #210; mov x7, #211; mov x11, #180; mov x12, #181; bl double_mirror_loop
	mov x6, #250; mov x7, #252; mov x11, #200; mov x12, #202; bl double_mirror_loop
	mov x6, #290; mov x7, #291; mov x11, #220; mov x12, #221; bl double_mirror_loop
	mov x6, #60; mov x7, #61; mov x11, #230; mov x12, #231; bl double_mirror_loop
	mov x6, #70; mov x7, #72; mov x11, #110; mov x12, #112; bl double_mirror_loop
	mov x6, #110; mov x7, #111; mov x11, #90; mov x12, #91; bl double_mirror_loop
	mov x6, #150; mov x7, #152; mov x11, #130; mov x12, #132; bl double_mirror_loop
	mov x6, #190; mov x7, #191; mov x11, #100; mov x12, #101; bl double_mirror_loop
	mov x6, #230; mov x7, #232; mov x11, #170; mov x12, #172; bl double_mirror_loop
	mov x6, #270; mov x7, #271; mov x11, #190; mov x12, #191; bl double_mirror_loop
	mov x6, #85; mov x7, #86; mov x11, #200; mov x12, #201; bl double_mirror_loop
	mov x6, #165; mov x7, #166; mov x11, #210; mov x12, #211; bl double_mirror_loop
	mov x6, #245; mov x7, #246; mov x11, #230; mov x12, #231; bl double_mirror_loop

	// Más estrellas en el medio para X
	mov x6, #285; mov x7, #286; mov x11, #45; mov x12, #46; bl double_mirror_loop
	mov x6, #280; mov x7, #281; mov x11, #60; mov x12, #61; bl double_mirror_loop
	mov x6, #275; mov x7, #276; mov x11, #80; mov x12, #81; bl double_mirror_loop
	mov x6, #270; mov x7, #271; mov x11, #100; mov x12, #101; bl double_mirror_loop
	mov x6, #265; mov x7, #266; mov x11, #120; mov x12, #121; bl double_mirror_loop
	mov x6, #260; mov x7, #261; mov x11, #140; mov x12, #141; bl double_mirror_loop
	mov x6, #255; mov x7, #256; mov x11, #160; mov x12, #161; bl double_mirror_loop
	mov x6, #250; mov x7, #251; mov x11, #180; mov x12, #181; bl double_mirror_loop
	mov x6, #245; mov x7, #246; mov x11, #200; mov x12, #201; bl double_mirror_loop
	mov x6, #240; mov x7, #241; mov x11, #220; mov x12, #221; bl double_mirror_loop

	// Estrellas un poco más grandes (5x5)
	mov x6, #75; mov x7, #80; mov x11, #190; mov x12, #195; bl double_mirror_loop
	mov x6, #200; mov x7, #205; mov x11, #60; mov x12, #65; bl double_mirror_loop


	// --- ZONA SUPERIOR-DERECHA MEDIA

	// Muchas estrellas pequeñas y medianas (1x1 a 5x5)
	mov x6, #350; mov x7, #351; mov x11, #45; mov x12, #46; bl double_mirror_loop
	mov x6, #370; mov x7, #371; mov x11, #55; mov x12, #56; bl double_mirror_loop
	mov x6, #390; mov x7, #392; mov x11, #40; mov x12, #42; bl double_mirror_loop
	mov x6, #410; mov x7, #411; mov x11, #70; mov x12, #71; bl double_mirror_loop
	mov x6, #430; mov x7, #432; mov x11, #85; mov x12, #87; bl double_mirror_loop
	mov x6, #450; mov x7, #451; mov x11, #50; mov x12, #51; bl double_mirror_loop
	mov x6, #470; mov x7, #472; mov x11, #75; mov x12, #77; bl double_mirror_loop
	mov x6, #490; mov x7, #491; mov x11, #90; mov x12, #91; bl double_mirror_loop
	mov x6, #510; mov x7, #512; mov x11, #110; mov x12, #112; bl double_mirror_loop
	mov x6, #530; mov x7, #531; mov x11, #130; mov x12, #131; bl double_mirror_loop
	mov x6, #550; mov x7, #552; mov x11, #150; mov x12, #152; bl double_mirror_loop
	mov x6, #570; mov x7, #571; mov x11, #170; mov x12, #171; bl double_mirror_loop
	mov x6, #345; mov x7, #347; mov x11, #100; mov x12, #102; bl double_mirror_loop
	mov x6, #375; mov x7, #376; mov x11, #120; mov x12, #121; bl double_mirror_loop
	mov x6, #415; mov x7, #416; mov x11, #140; mov x12, #141; bl double_mirror_loop
	mov x6, #455; mov x7, #457; mov x11, #160; mov x12, #162; bl double_mirror_loop
	mov x6, #495; mov x7, #496; mov x11, #180; mov x12, #181; bl double_mirror_loop
	mov x6, #535; mov x7, #537; mov x11, #200; mov x12, #202; bl double_mirror_loop
	mov x6, #580; mov x7, #581; mov x11, #220; mov x12, #221; bl double_mirror_loop
	mov x6, #345; mov x7, #346; mov x11, #230; mov x12, #231; bl double_mirror_loop
	mov x6, #360; mov x7, #362; mov x11, #110; mov x12, #112; bl double_mirror_loop
	mov x6, #400; mov x7, #401; mov x11, #90; mov x12, #91; bl double_mirror_loop
	mov x6, #440; mov x7, #442; mov x11, #130; mov x12, #132; bl double_mirror_loop
	mov x6, #480; mov x7, #481; mov x11, #100; mov x12, #101; bl double_mirror_loop
	mov x6, #520; mov x7, #522; mov x11, #170; mov x12, #172; bl double_mirror_loop
	mov x6, #560; mov x7, #561; mov x11, #190; mov x12, #191; bl double_mirror_loop
	mov x6, #385; mov x7, #386; mov x11, #200; mov x12, #201; bl double_mirror_loop
	mov x6, #465; mov x7, #466; mov x11, #210; mov x12, #211; bl double_mirror_loop
	mov x6, #545; mov x7, #546; mov x11, #230; mov x12, #231; bl double_mirror_loop

	// Más estrellas en el medio para X
	mov x6, #355; mov x7, #356; mov x11, #45; mov x12, #46; bl double_mirror_loop
	mov x6, #360; mov x7, #361; mov x11, #60; mov x12, #61; bl double_mirror_loop
	mov x6, #365; mov x7, #366; mov x11, #80; mov x12, #81; bl double_mirror_loop
	mov x6, #370; mov x7, #371; mov x11, #100; mov x12, #101; bl double_mirror_loop
	mov x6, #375; mov x7, #376; mov x11, #120; mov x12, #121; bl double_mirror_loop
	mov x6, #380; mov x7, #381; mov x11, #140; mov x12, #141; bl double_mirror_loop
	mov x6, #385; mov x7, #386; mov x11, #160; mov x12, #161; bl double_mirror_loop
	mov x6, #390; mov x7, #391; mov x11, #180; mov x12, #181; bl double_mirror_loop
	mov x6, #395; mov x7, #396; mov x11, #200; mov x12, #201; bl double_mirror_loop
	mov x6, #400; mov x7, #401; mov x11, #220; mov x12, #221; bl double_mirror_loop

	// Estrellas un poco más grandes (5x5)
	mov x6, #360; mov x7, #365; mov x11, #190; mov x12, #195; bl double_mirror_loop
	mov x6, #500; mov x7, #505; mov x11, #60; mov x12, #65; bl double_mirror_loop


	//  ZONA INFERIOR-IZQUIERDA MEDIA (

	// Muchas estrellas pequeñas y medianas (1x1 a 5x5)
	mov x6, #65; mov x7, #66; mov x11, #335; mov x12, #336; bl double_mirror_loop
	mov x6, #80; mov x7, #81; mov x11, #345; mov x12, #346; bl double_mirror_loop
	mov x6, #100; mov x7, #102; mov x11, #330; mov x12, #332; bl double_mirror_loop
	mov x6, #120; mov x7, #121; mov x11, #360; mov x12, #361; bl double_mirror_loop
	mov x6, #140; mov x7, #142; mov x11, #375; mov x12, #377; bl double_mirror_loop
	mov x6, #160; mov x7, #161; mov x11, #340; mov x12, #341; bl double_mirror_loop
	mov x6, #180; mov x7, #182; mov x11, #365; mov x12, #367; bl double_mirror_loop
	mov x6, #200; mov x7, #201; mov x11, #380; mov x12, #381; bl double_mirror_loop
	mov x6, #220; mov x7, #222; mov x11, #400; mov x12, #402; bl double_mirror_loop
	mov x6, #240; mov x7, #241; mov x11, #420; mov x12, #421; bl double_mirror_loop
	mov x6, #260; mov x7, #262; mov x11, #430; mov x12, #432; bl double_mirror_loop
	mov x6, #280; mov x7, #281; mov x11, #350; mov x12, #351; bl double_mirror_loop
	mov x6, #60; mov x7, #62; mov x11, #390; mov x12, #392; bl double_mirror_loop
	mov x6, #90; mov x7, #91; mov x11, #410; mov x12, #411; bl double_mirror_loop
	mov x6, #130; mov x7, #131; mov x11, #330; mov x12, #331; bl double_mirror_loop
	mov x6, #170; mov x7, #172; mov x11, #350; mov x12, #352; bl double_mirror_loop
	mov x6, #210; mov x7, #211; mov x11, #370; mov x12, #371; bl double_mirror_loop
	mov x6, #250; mov x7, #252; mov x11, #390; mov x12, #392; bl double_mirror_loop
	mov x6, #290; mov x7, #291; mov x11, #410; mov x12, #411; bl double_mirror_loop
	mov x6, #60; mov x7, #61; mov x11, #430; mov x12, #431; bl double_mirror_loop
	mov x6, #70; mov x7, #72; mov x11, #380; mov x12, #382; bl double_mirror_loop
	mov x6, #110; mov x7, #111; mov x11, #360; mov x12, #361; bl double_mirror_loop
	mov x6, #150; mov x7, #152; mov x11, #400; mov x12, #402; bl double_mirror_loop
	mov x6, #190; mov x7, #191; mov x11, #370; mov x12, #371; bl double_mirror_loop
	mov x6, #230; mov x7, #232; mov x11, #410; mov x12, #412; bl double_mirror_loop
	mov x6, #270; mov x7, #271; mov x11, #430; mov x12, #431; bl double_mirror_loop
	mov x6, #85; mov x7, #86; mov x11, #420; mov x12, #421; bl double_mirror_loop
	mov x6, #165; mov x7, #166; mov x11, #330; mov x12, #331; bl double_mirror_loop
	mov x6, #245; mov x7, #246; mov x11, #350; mov x12, #351; bl double_mirror_loop

	// Más estrellas en el medio para X
	mov x6, #285; mov x7, #286; mov x11, #335; mov x12, #336; bl double_mirror_loop
	mov x6, #280; mov x7, #281; mov x11, #350; mov x12, #351; bl double_mirror_loop
	mov x6, #275; mov x7, #276; mov x11, #370; mov x12, #371; bl double_mirror_loop
	mov x6, #270; mov x7, #271; mov x11, #390; mov x12, #391; bl double_mirror_loop
	mov x6, #265; mov x7, #266; mov x11, #410; mov x12, #411; bl double_mirror_loop
	mov x6, #260; mov x7, #261; mov x11, #430; mov x12, #431; bl double_mirror_loop

	// Estrellas un poco m grandes (5x5)
	mov x6, #75; mov x7, #80; mov x11, #360; mov x12, #365; bl double_mirror_loop
	mov x6, #200; mov x7, #205; mov x11, #340; mov x12, #345; bl double_mirror_loop


	// --- ZONA INFERIOR-DERECHA MEDIA 

	// Muchas estrellas pequeñas y medianas (1x1 a 5x5)
	mov x6, #350; mov x7, #351; mov x11, #335; mov x12, #336; bl double_mirror_loop
	mov x6, #370; mov x7, #371; mov x11, #345; mov x12, #346; bl double_mirror_loop
	mov x6, #390; mov x7, #392; mov x11, #330; mov x12, #332; bl double_mirror_loop
	mov x6, #410; mov x7, #411; mov x11, #360; mov x12, #361; bl double_mirror_loop
	mov x6, #430; mov x7, #432; mov x11, #375; mov x12, #377; bl double_mirror_loop
	mov x6, #450; mov x7, #451; mov x11, #340; mov x12, #341; bl double_mirror_loop
	mov x6, #470; mov x7, #472; mov x11, #365; mov x12, #367; bl double_mirror_loop
	mov x6, #490; mov x7, #491; mov x11, #380; mov x12, #381; bl double_mirror_loop
	mov x6, #510; mov x7, #512; mov x11, #400; mov x12, #402; bl double_mirror_loop
	mov x6, #530; mov x7, #531; mov x11, #420; mov x12, #421; bl double_mirror_loop
	mov x6, #550; mov x7, #552; mov x11, #430; mov x12, #432; bl double_mirror_loop
	mov x6, #570; mov x7, #571; mov x11, #350; mov x12, #351; bl double_mirror_loop
	mov x6, #345; mov x7, #347; mov x11, #390; mov x12, #392; bl double_mirror_loop
	mov x6, #375; mov x7, #376; mov x11, #410; mov x12, #411; bl double_mirror_loop
	mov x6, #415; mov x7, #416; mov x11, #330; mov x12, #331; bl double_mirror_loop
	mov x6, #455; mov x7, #457; mov x11, #350; mov x12, #352; bl double_mirror_loop
	mov x6, #495; mov x7, #496; mov x11, #370; mov x12, #371; bl double_mirror_loop
	mov x6, #535; mov x7, #537; mov x11, #390; mov x12, #392; bl double_mirror_loop
	mov x6, #580; mov x7, #581; mov x11, #410; mov x12, #411; bl double_mirror_loop
	mov x6, #345; mov x7, #346; mov x11, #430; mov x12, #431; bl double_mirror_loop
	mov x6, #360; mov x7, #362; mov x11, #380; mov x12, #382; bl double_mirror_loop
	mov x6, #400; mov x7, #401; mov x11, #360; mov x12, #361; bl double_mirror_loop
	mov x6, #440; mov x7, #442; mov x11, #400; mov x12, #402; bl double_mirror_loop
	mov x6, #480; mov x7, #481; mov x11, #370; mov x12, #371; bl double_mirror_loop
	mov x6, #520; mov x7, #522; mov x11, #410; mov x12, #412; bl double_mirror_loop
	mov x6, #560; mov x7, #561; mov x11, #430; mov x12, #431; bl double_mirror_loop
	mov x6, #385; mov x7, #386; mov x11, #420; mov x12, #421; bl double_mirror_loop
	mov x6, #465; mov x7, #466; mov x11, #330; mov x12, #331; bl double_mirror_loop
	mov x6, #545; mov x7, #546; mov x11, #350; mov x12, #351; bl double_mirror_loop

	// Más estrellas en el medio para X
	mov x6, #355; mov x7, #356; mov x11, #335; mov x12, #336; bl double_mirror_loop
	mov x6, #360; mov x7, #361; mov x11, #350; mov x12, #351; bl double_mirror_loop
	mov x6, #365; mov x7, #366; mov x11, #370; mov x12, #371; bl double_mirror_loop
	mov x6, #370; mov x7, #371; mov x11, #390; mov x12, #391; bl double_mirror_loop
	mov x6, #375; mov x7, #376; mov x11, #410; mov x12, #411; bl double_mirror_loop
	mov x6, #380; mov x7, #381; mov x11, #430; mov x12, #431; bl double_mirror_loop

	// Estrellas un poco más grandes (5x5)
	mov x6, #360; mov x7, #365; mov x11, #360; mov x12, #365; bl double_mirror_loop
	mov x6, #500; mov x7, #505; mov x11, #340; mov x12, #345; bl double_mirror_loop



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

	

	// ---------------------- PARTE DE ODC ---------------------

	// ÁRBOL DE BASE
	mov x6, #310            // x_start
	mov x7, #314             // x_end
	mov x11, #156        // y_start
	mov x12, #180         // y_end
	bl double_mirror_loop

	// ÁRBOL DE BASE
	mov x6, #306            // x_start
	mov x7, #310             // x_end
	mov x11, #180        // y_start
	mov x12, #220         // y_end
	bl double_mirror_loop

	// ÁRBOL DE BASE
	mov x6, #306            // x_start
	mov x7, #310             // x_end
	mov x11, #180        // y_start
	mov x12, #220         // y_end
	bl double_mirror_loop

	// ÁRBOL DE BASE
	mov x6, #284            // x_start
	mov x7, #288             // x_end
	mov x11, #180        // y_start
	mov x12, #220         // y_end
	bl double_mirror_loop
	
	// ÁRBOL DE BASE
	mov x6, #288            // x_start
	mov x7, #292             // x_end
	mov x11, #152        // y_start
	mov x12, #180         // y_end
	bl double_mirror_loop

	// --------- la letra 'o'---------

	// LETRA 'O'
	mov x6, #280            // x_start
	mov x7, #284             // x_end
	mov x11, #140        // y_start
	mov x12, #148         // y_end
	bl only_y_mirror_loop

	// LETRA 'O'
	mov x6, #284            // x_start
	mov x7, #288             // x_end
	mov x11, #148        // y_start
	mov x12, #152         // y_end
	bl only_y_mirror_loop

	// LETRA 'O'
	mov x6, #284            // x_start
	mov x7, #288             // x_end
	mov x11, #136        // y_start
	mov x12, #140         // y_end
	bl only_y_mirror_loop

	// LETRA 'O'
	mov x6, #288            // x_start
	mov x7, #292             // x_end
	mov x11, #140        // y_start
	mov x12, #148         // y_end
	bl only_y_mirror_loop


	// LETRA 'D'
	mov x6, #296            // x_start
	mov x7, #300             // x_end
	mov x11, #136        // y_start
	mov x12, #152         // y_end
	bl only_y_mirror_loop

	// LETRA 'D'
	mov x6, #300            // x_start
	mov x7, #304             // x_end
	mov x11, #136        // y_start
	mov x12, #140         // y_end
	bl only_y_mirror_loop

	// LETRA 'D'
	mov x6, #300            // x_start
	mov x7, #304             // x_end
	mov x11, #148        // y_start
	mov x12, #152         // y_end
	bl only_y_mirror_loop


	// RAMA DE APOYO
	mov x6, #304            // x_start
	mov x7, #308             // x_end
	mov x11, #140        // y_start
	mov x12, #148       // y_end
	bl only_y_mirror_loop

	// RAMA DE APOYO
	mov x6, #304            // x_start
	mov x7, #312             // x_end
	mov x11, #156        // y_start
	mov x12, #160         // y_end
	bl only_y_mirror_loop

	// RAMA DE APOYO
	mov x6, #304            // x_start
	mov x7, #308             // x_end
	mov x11, #152        // y_start
	mov x12, #156         // y_end
	bl only_y_mirror_loop

	// RAMA DE APOYO
	mov x6, #314            // x_start
	mov x7, #318             // x_end
	mov x11, #152        // y_start
	mov x12, #156         // y_end
	bl only_y_mirror_loop
	

	// LETRA 'C'
	mov x6, #310            // x_start
	mov x7, #314             // x_end
	mov x11, #140        // y_start
	mov x12, #148         // y_end
	bl only_y_mirror_loop

	// LETRA 'C'
	mov x6, #314            // x_start
	mov x7, #322             // x_end
	mov x11, #136        // y_start
	mov x12, #140         // y_end
	bl only_y_mirror_loop

	// LETRA 'C'
	mov x6, #314            // x_start
	mov x7, #322             // x_end
	mov x11, #148        // y_start
	mov x12, #152         // y_end
	bl only_y_mirror_loop

	// ------- HARÉ QUE LOS NÚMEROS "2025" SE VEAN REFLEJADOS EN EL LADO DE ABAJO DE LA PANTALLA, COMO SI FUESEN EL OTRO MUNDO ---------- 

	movz x5, 0x0000, lsl 0	
	movk x5, 0xFF00, lsl 16

	// NÚMERO 2
	mov x1, #284            // x_start
	mov x2, #364             // y_start
	mov x3, #8        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// NÚMERO 2
	mov x1, #284            // x_start
	mov x2, #356             // y_start
	mov x3, #4        // ancho
	mov x4, #8         // alto
	bl draw_rect

	// NÚMERO 2
	mov x1, #284            // x_start
	mov x2, #356             // y_start
	mov x3, #8        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// NÚMERO 2
	mov x1, #288            // x_start
	mov x2, #348             // y_start
	mov x3, #4        // ancho
	mov x4, #8         // alto
	bl draw_rect

	// NÚMERO 2
	mov x1, #284            // x_start
	mov x2, #348             // y_start
	mov x3, #8        // ancho
	mov x4, #4         // alto
	bl draw_rect


	// NÚMERO 0
	mov x1, #296            // x_start
	mov x2, #352             // y_start
	mov x3, #4        // ancho
	mov x4, #12         // alto
	bl draw_rect

	// NÚMERO 0
	mov x1, #300            // x_start
	mov x2, #348             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// NÚMERO 0
	mov x1, #300            // x_start
	mov x2, #364             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// NÚMERO 0
	mov x1, #304            // x_start
	mov x2, #352             // y_start
	mov x3, #4        // ancho
	mov x4, #12         // alto
	bl draw_rect


	// NÚMERO 2
	mov x1, #312            // x_start
	mov x2, #364             // y_start
	mov x3, #8        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// NÚMERO 2
	mov x1, #312            // x_start
	mov x2, #356             // y_start
	mov x3, #4        // ancho
	mov x4, #8         // alto
	bl draw_rect

	// NÚMERO 2
	mov x1, #312            // x_start
	mov x2, #356             // y_start
	mov x3, #8        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// NÚMERO 2
	mov x1, #316            // x_start
	mov x2, #348             // y_start
	mov x3, #4        // ancho
	mov x4, #8         // alto
	bl draw_rect

	// NÚMERO 2
	mov x1, #312            // x_start
	mov x2, #348             // y_start
	mov x3, #8        // ancho
	mov x4, #4         // alto
	bl draw_rect


	// NÚMERO 5
	mov x1, #324            // x_start
	mov x2, #348             // y_start
	mov x3, #8        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// NÚMERO 5
	mov x1, #324            // x_start
	mov x2, #348             // y_start
	mov x3, #4        // ancho
	mov x4, #8         // alto
	bl draw_rect

	// NÚMERO 5
	mov x1, #324            // x_start
	mov x2, #356             // y_start
	mov x3, #8        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// NÚMERO 5
	mov x1, #328            // x_start
	mov x2, #356             // y_start
	mov x3, #4        // ancho
	mov x4, #8         // alto
	bl draw_rect

	// NÚMERO 5
	mov x1, #324            // x_start
	mov x2, #364             // y_start
	mov x3, #8        // ancho
	mov x4, #4         // alto
	bl draw_rect


	// RAMAS AUXILIARES PARA CONECTARLO AL ÁRBOL DE ODC

	// RAMA
	mov x1, #320            // x_start
	mov x2, #344             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// RAMA
	mov x1, #280            // x_start
	mov x2, #344             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// RAMA
	mov x1, #304            // x_start
	mov x2, #344             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// RAMA
	mov x1, #340            // x_start
	mov x2, #336             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// RAMA
	mov x1, #344            // x_start
	mov x2, #332             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// RAMA
	mov x1, #348            // x_start
	mov x2, #328             // y_start
	mov x3, #4        // ancho
	mov x4, #8         // alto
	bl draw_rect

	// RAMA
	mov x1, #332            // x_start
	mov x2, #340             // y_start
	mov x3, #8        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// RAMA
	mov x1, #328            // x_start
	mov x2, #344             // y_start
	mov x3, #4        // ancho
	mov x4, #4         // alto
	bl draw_rect

	// RAMA
	mov x1, #328            // x_start
	mov x2, #324             // y_start
	mov x3, #4        // ancho
	mov x4, #16         // alto
	bl draw_rect

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

 



 ////////////////////PERSONAJES////////////////////
	// personajes
	
	// Dustin
	// Cabeza	
	mov x1, #94
	mov x2, #144
	mov x3, #32
	mov x4, #32
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16     // cara principal
	bl draw_rect
       
        mov x1, #98
	mov x2, #140
	mov x3, #24
	mov x4, #12
	movz w5, #0xFFFF, lsl #0
	movk w5, #0xFFFF, lsl #16     // parte blanca de la gorra
	bl draw_rect
	
        mov x1, #98       
        mov x2, #140      
        mov x3, #4        
        mov x4, #4        
        movz w5, #0x00FF, lsl #0      
        movk w5, #0x0000, lsl #16       // detalle azul gorra parte izquierda
        bl draw_rect
        
	mov x1, #90
	mov x2, #148
	mov x3, #8
	mov x4, #8
	movz w5, #0x00FF, lsl #0      
        movk w5, #0x0000, lsl #16       // detalle azul gorra parte izquierda
	bl draw_rect
        
        mov x1, #94
	mov x2, #144
	mov x3, #4
	mov x4, #4
	movz w5, #0x00FF, lsl #0      
        movk w5, #0x0000, lsl #16       // detalle azul gorra parte izquierda
	bl draw_rect

	mov x1, #122
	mov x2, #148
	mov x3, #8
	mov x4, #4
	movz w5, #0x00FF, lsl #0      
        movk w5, #0x0000, lsl #16      // detalle azul gorra parte derecha
	bl draw_rect
	
	mov x1, #122
	mov x2, #144
	mov x3, #4
	mov x4, #4
	movz w5, #0x00FF, lsl #0      
        movk w5, #0x0000, lsl #16      // detalle azul gorra parte derecha
	bl draw_rect

        mov x1, #98
	mov x2, #152
	mov x3, #38
	mov x4, #4
	movz w5, #0x0000, lsl #0      
        movk w5, #0xFFFF, lsl #16      // borde rojo de la gorra
        bl draw_rect
                
        mov x1, #98
	mov x2, #176
	mov x3, #24
	mov x4, #4
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16    // mentón  
	bl draw_rect

	mov x1, #106
	mov x2, #180
	mov x3, #8
	mov x4, #4
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16     // cuello 
	bl draw_rect
        
        mov x1, #90
	mov x2, #156
	mov x3, #8
	mov x4, #4
	movz w5, #0x4513, lsl #0      
        movk w5, #0xFF8B, lsl #16     // capucha pegada a la gorra
        bl draw_rect
        
        mov x1, #102
	mov x2, #156
	mov x3, #20
	mov x4, #4
	movz w5, #0x853F, lsl #0      
        movk w5, #0xFFCD, lsl #16     // pelo 
        bl draw_rect
        
        mov x1, #114
	mov x2, #160
	mov x3, #4
	mov x4, #4
	movz w5, #0x853F, lsl #0      
        movk w5, #0xFFCD, lsl #16     // mechon de pelo solo
        bl draw_rect
        
        mov x1, #90
	mov x2, #160
	mov x3, #4
	mov x4, #12
	movz w5, #0x4513, lsl #0      
        movk w5, #0xFF8B, lsl #16     // parte vertical gorra izquierda
        bl draw_rect
        
        mov x1, #98
	mov x2, #172
	mov x3, #4
	mov x4, #12
	movz w5, #0x4513, lsl #0      
        movk w5, #0xFF8B, lsl #16     // unión capucha con campera parte izquierda
        bl draw_rect
        
        mov x1, #124
	mov x2, #156
	mov x3, #4
	mov x4, #8
	movz w5, #0x4513, lsl #0      
        movk w5, #0xFF8B, lsl #16     // parte alta de la capucha lado derecho
        bl draw_rect
        
        mov x1, #124
	mov x2, #168
	mov x3, #4
	mov x4, #8
	movz w5, #0x4513, lsl #0      
        movk w5, #0xFF8B, lsl #16     // detalle capucha parte derecha
        bl draw_rect
                  
        mov x1, #118
	mov x2, #172
	mov x3, #6
	mov x4, #12
	movz w5, #0x4513, lsl #0      
        movk w5, #0xFF8B, lsl #16     // union capucha con campera
        bl draw_rect     
        
        mov x1, #126
	mov x2, #160
	mov x3, #4
	mov x4, #16
	movz w5, #0x4513, lsl #0      
        movk w5, #0xFF8B, lsl #16     // detalle capucha parte derecha
        bl draw_rect   
        
        mov x1, #128
	mov x2, #168
	mov x3, #4
	mov x4, #4
	movz w5, #0x4513, lsl #0      
        movk w5, #0xFF8B, lsl #16     // detalle capucha parte derecha
        bl draw_rect
        
        mov x1, #94
	mov x2, #168
	mov x3, #4
	mov x4, #12
	movz w5, #0x4513, lsl #0      
        movk w5, #0xFF8B, lsl #16     // detalle capucha parte izquierda
        bl draw_rect
        
        mov x1, #86
	mov x2, #164
	mov x3, #4
	mov x4, #8
	movz w5, #0x4513, lsl #0      
        movk w5, #0xFF8B, lsl #16     // detalle capucha parte izquierda
        bl draw_rect

        mov x1, #114
	mov x2, #164
	mov x3, #4
	mov x4, #4
	movz w5, #0x0000, lsl #0      
        movk w5, #0xFF00, lsl #16     // ojo derecho
        bl draw_rect
        
        mov x1, #102
	mov x2, #164
	mov x3, #4
	mov x4, #4
        movz w5, #0x0000, lsl #0      
        movk w5, #0xFF00, lsl #16     // ojo izquierdo
        bl draw_rect
        
        mov x1, #106
	mov x2, #172
	mov x3, #8
	mov x4, #4
	movz w5, #0x522D, lsl #0      
        movk w5, #0xFFA0, lsl #16     // boca
        bl draw_rect
        
	// Cuerpo
	// Bordes del cuello
	mov x1, #102
	mov x2, #180
	mov x3, #4
	mov x4, #12
	movz w5, #0x853F, lsl #0      
        movk w5, #0xFFCD, lsl #16     // detalle marrón claro de la campera
	bl draw_rect

	mov x1, #114
	mov x2, #180
	mov x3, #4
	mov x4, #12
	movz w5, #0x853F, lsl #0      
        movk w5, #0xFFCD, lsl #16     // detalle marrón claro de la campera
	bl draw_rect

	// Hombro izquerdo
	mov x1, #94
	mov x2, #184
	mov x3, #8
	mov x4, #8
	movz w5, #0x522A, lsl #0      
        movk w5, #0xFFA0, lsl #16     
	bl draw_rect

        // Hombro derecho
	mov x1, #118
	mov x2, #184
	mov x3, #8
	mov x4, #8
	movz w5, #0x522A, lsl #0     
        movk w5, #0xFFA0, lsl #16     
	bl draw_rect
        
        // Cuello  
	mov x1, #106
	mov x2, #184
	mov x3, #8
	mov x4, #4
	movz w5, #0xEBD7, lsl #0      
        movk w5, #0xFFFA, lsl #16     
	bl draw_rect

	// campera parte izquierda
	mov x1, #98
	mov x2, #192
	mov x3, #8
	mov x4, #20
	movz w5, #0x522A, lsl #0      
        movk w5, #0xFFA0, lsl #16     // campera parte del torso
	bl draw_rect
	
	// remera
	mov x1, #106
	mov x2, #188
	mov x3, #8
	mov x4, #24
	movz w5, #0xFFFF, lsl #0
	movk w5, #0xFFFF, lsl #16      // remera de abajo
	bl draw_rect
	
	// campera parte dereceha
	mov x1, #114
	mov x2, #192
	mov x3, #8
	mov x4, #20
	movz w5, #0x522A, lsl #0      
        movk w5, #0xFFA0, lsl #16     // campera parte del torso
	bl draw_rect

	// Brazo izquierdo
	mov x1, #88
	mov x2, #188
	mov x3, #6
	mov x4, #20
	movz w5, #0x522A, lsl #0      
        movk w5, #0xFFA0, lsl #16     // manga de campera
	bl draw_rect
	
	mov x1, #88
	mov x2, #208
	mov x3, #6
	mov x4, #4
	movz w5, #0x853F, lsl #0      
        movk w5, #0xFFCD, lsl #16     // puño de campera 
	bl draw_rect
	
	// Brazo derecho

	mov x1, #126
	mov x2, #188
	mov x3, #6
	mov x4, #20
	movz w5, #0x522A, lsl #0      
        movk w5, #0xFFA0, lsl #16     // manga de campera
	bl draw_rect 
		
	mov x1, #126
	mov x2, #208
	mov x3, #6
	mov x4, #4
	movz w5, #0x853F, lsl #0      
        movk w5, #0xFFCD, lsl #16     // puño de campera 
	bl draw_rect

	// Manos 
	mov x1, #92
	mov x2, #212
	mov x3, #6
	mov x4, #6
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #122
	mov x2, #212
	mov x3, #6
	mov x4, #6
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	// Piernas
	mov x1, #102
	mov x2, #212
	mov x3, #6
	mov x4, #24
	movz w5, #0x3A80, lsl #0      
        movk w5, #0xFF20, lsl #16     // jean
	bl draw_rect

	mov x1, #112
	mov x2, #212
	mov x3, #6
	mov x4, #24
	movz w5, #0x3A80, lsl #0      
        movk w5, #0xFF20, lsl #16     //  jean
	bl draw_rect

	// Pies
	mov x1, #98
	mov x2, #236
	mov x3, #8
	mov x4, #6
	movz w5, #0xFFFF, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #114
	mov x2, #236
	mov x3, #8
	mov x4, #6
	movz w5, #0xFFFF, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	// Will
	// Cabeza 	
	mov x1, #176
	mov x2, #304
	mov x3, #32
	mov x4, #24
	movz w5, #0xCCAA, lsl #0    // cara 
	movk w5, #0xFFFF, lsl #16
	bl draw_rect
	
	mov x1, #180
	mov x2, #300
	mov x3, #24
	mov x4, #4
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16    // mentón 
	bl draw_rect

	mov x1, #188
	mov x2, #296
	mov x3, #8
	mov x4, #4
	movz w5, #0xA874, lsl #0      
        movk w5, #0xFFCC, lsl #16     // cuello
	bl draw_rect
	
	mov x1, #180
	mov x2, #336
	mov x3, #24
	mov x4, #4
	movz w5, #0x4444, lsl #0        
        movk w5, #0xFF44, lsl #16       // 1era parte del pelo
	bl draw_rect

	mov x1, #176
	mov x2, #328
	mov x3, #32
	mov x4, #8
	movz w5, #0x4444, lsl #0        
        movk w5, #0xFF44, lsl #16       // 2da parte del pelo
	bl draw_rect
	
        mov x1, #172
	mov x2, #304
	mov x3, #4
	mov x4, #28
	movz w5, #0x4444, lsl #0      
        movk w5, #0xFF44, lsl #16       // pelo vertical izquierdo
	bl draw_rect
	
	mov x1, #208
	mov x2, #304
	mov x3, #4
	mov x4, #28
	movz w5, #0x4444, lsl #0      
        movk w5, #0xFF44, lsl #16       // pelo vertical derecho
	bl draw_rect

        mov x1, #176
	mov x2, #300
	mov x3, #4
	mov x4, #12
	movz w5, #0x4444, lsl #0        
        movk w5, #0xFF44, lsl #16       // pelo vertical al lado del mentón izquierdo
	bl draw_rect
	
	mov x1, #204
	mov x2, #300
	mov x3, #4
	mov x4, #12
	movz w5, #0x4444, lsl #0        
        movk w5, #0xFF44, lsl #16       // pelo vertical al lado del mentón derecho
	bl draw_rect
	
	mov x1, #180
	mov x2, #300
	mov x3, #4
	mov x4, #4
	movz w5, #0x4444, lsl #0       
        movk w5, #0xFF44, lsl #16       //  pelo al lado del mentón izquierdo
	bl draw_rect
	
	mov x1, #200
	mov x2, #300
	mov x3, #4
	mov x4, #4
	movz w5, #0x4444, lsl #0        
        movk w5, #0xFF44, lsl #16       // pelo al lado del mentón derecho
	bl draw_rect
	
	mov x1, #176
	mov x2, #320
	mov x3, #8
	mov x4, #8
	movz w5, #0x4444, lsl #0        
        movk w5, #0xFF44, lsl #16       // flequillo izquierdo
	bl draw_rect
	
	mov x1, #180
	mov x2, #316
	mov x3, #4
	mov x4, #4
	movz w5, #0x4444, lsl #0       
        movk w5, #0xFF44, lsl #16       //  parte del flequillo cae, izquierda
	bl draw_rect
	
	mov x1, #184
	mov x2, #324
	mov x3, #12
	mov x4, #4
	movz w5, #0x4444, lsl #0        // 
        movk w5, #0xFF44, lsl #16       //  pelo en la frente 
	bl draw_rect	
	
	mov x1, #204
	mov x2, #320
	mov x3, #4
	mov x4, #8
	movz w5, #0x4444, lsl #0       
        movk w5, #0xFF44, lsl #16       //  mechón vertical derecha
	bl draw_rect
	
	mov x1, #184
	mov x2, #312
	mov x3, #4
	mov x4, #4
	movz w5, #0x0000, lsl #0      
        movk w5, #0xFF00, lsl #16     // ojo izquierdo
	bl draw_rect
	
	mov x1, #196
	mov x2, #312
	mov x3, #4
	mov x4, #4
	movz w5, #0x0000, lsl #0      
        movk w5, #0xFF00, lsl #16     // ojo derecho
	bl draw_rect
	
	mov x1, #188
	mov x2, #304
	mov x3, #8
	mov x4, #4
	movz w5, #0x522D, lsl #0     
        movk w5, #0xFFA0, lsl #16     // boca
	bl draw_rect
	
	// Cuerpo
	mov x1, #176
	mov x2, #288
	mov x3, #32
	mov x4, #8
	movz w5, #0x3A80, lsl #0      
        movk w5, #0xFF20, lsl #16     //parte superior del torso
	bl draw_rect

	mov x1, #180
	mov x2, #268
	mov x3, #24
	mov x4, #24
	movz w5, #0x0033, lsl #0      
        movk w5, #0xFF88, lsl #16       // campera
	bl draw_rect
	
	mov x1, #184
	mov x2, #264
	mov x3, #4
	mov x4, #36
	movz w5, #0x0033, lsl #0        
        movk w5, #0xFF88, lsl #16       // hombro alto izq
	bl draw_rect

	mov x1, #196
	mov x2, #264
	mov x3, #4
	mov x4, #36
	movz w5, #0x0033, lsl #0        
        movk w5, #0xFF88, lsl #16       // hombro alto der
	bl draw_rect
	
	mov x1, #188
	mov x2, #268
	mov x3, #8
	mov x4, #28
	movz w5, #0xEEEE, lsl #0        
        movk w5, #0xFFEE, lsl #16       // remera blanca
	bl draw_rect

        // Brazos
	mov x1, #172
	mov x2, #268
	mov x3, #4
	mov x4, #24
	movz w5, #0x3A80, lsl #0      
        movk w5, #0xFF20, lsl #16     // mangas remera brazo izquierdo
	bl draw_rect

	mov x1, #208
	mov x2, #268
	mov x3, #4
	mov x4, #24
	movz w5, #0x3A80, lsl #0      
        movk w5, #0xFF20, lsl #16     //mangas remera brazo derecho
	bl draw_rect
	
	mov x1, #172
	mov x2, #268
	mov x3, #4
	mov x4, #16
	movz w5, #0xEEEE, lsl #0        
        movk w5, #0xFFEE, lsl #16       // remera blanca manga izquierda
	bl draw_rect

	mov x1, #208
	mov x2, #268
	mov x3, #4
	mov x4, #16
	movz w5, #0xEEEE, lsl #0        
        movk w5, #0xFFEE, lsl #16       // remera blanca manga derecha
	bl draw_rect	

        // Manos
	mov x1, #176
	mov x2, #264
	mov x3, #4
	mov x4, #4
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #204
	mov x2, #264
	mov x3, #4
	mov x4, #4
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

        // Piernas
	mov x1, #184
	mov x2, #248
	mov x3, #4
	mov x4, #20
	movz w5, #0x3C75, lsl #0      
        movk w5, #0xFF2F, lsl #16     //  pierna izquierda
	bl draw_rect

	mov x1, #196
	mov x2, #248
	mov x3, #4
	mov x4, #20
	movz w5, #0x3C75, lsl #0      
        movk w5, #0xFF2F, lsl #16     // pierna derecha
	bl draw_rect

        // Pies 
	mov x1, #180
	mov x2, #244
	mov x3, #8
	mov x4, #6
	movz w5, #0xFFFF, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #196
	mov x2, #244
	mov x3, #8
	mov x4, #6
	movz w5, #0xFFFF, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	// Max
	// Cabeza
	mov x1, #252
	mov x2, #152
	mov x3, #40
	mov x4, #20
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16     // piel parte alta de la cara
	bl draw_rect
	  
        mov x1, #264
	mov x2, #140
	mov x3, #16
	mov x4, #4
	movz w5, #0x3020, lsl #0      
        movk w5, #0xFFCC, lsl #16     // mechon alto del pelo
        bl draw_rect
        
        mov x1, #252
	mov x2, #144
	mov x3, #40
	mov x4, #12
	movz w5, #0x3020, lsl #0 
	movk w5, #0xFFCC, lsl #16     //  1era parte del pelo
        bl draw_rect
	
	mov x1, #248
	mov x2, #156
	mov x3, #8
	mov x4, #32
	movz w5, #0x3020, lsl #0      
        movk w5, #0xFFCC, lsl #16     // parte vertical izquierda del pelo 
	bl draw_rect

	mov x1, #288
	mov x2, #156
	mov x3, #8
	mov x4, #32
	movz w5, #0x3020, lsl #0      
        movk w5, #0xFFCC, lsl #16     // parte vertical derecha del pelo 
	bl draw_rect
	
	mov x1, #256
	mov x2, #172
	mov x3, #32
	mov x4, #8
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16     // piel parte baja de la cara 
	bl draw_rect
	
	mov x1, #254
	mov x2, #156
	mov x3, #12
	mov x4, #4
	movz w5, #0x3020, lsl #0      
        movk w5, #0xFFCC, lsl #16     //  parte del flequillo izquierdo
        bl draw_rect
        
        mov x1, #276
	mov x2, #156
	mov x3, #12
	mov x4, #4
	movz w5, #0x3020, lsl #0      
        movk w5, #0xFFCC, lsl #16     //  parte del flequillo derecho
        bl draw_rect
        
        mov x1, #264
	mov x2, #164
	mov x3, #4
	mov x4, #4
	movz w5, #0x0000, lsl #0        
        movk w5, #0xFF00, lsl #16       // ojo izq
        bl draw_rect
        
        mov x1, #276
	mov x2, #164
	mov x3, #4
	mov x4, #4
	movz w5, #0x0000, lsl #0        
        movk w5, #0xFF00, lsl #16       // ojo derecho
        bl draw_rect
        
        mov x1, #268
	mov x2, #172
	mov x3, #8
	mov x4, #4
	movz w5, #0x522D, lsl #0      
        movk w5, #0xFFA0, lsl #16     //   boca
        bl draw_rect
	
	mov x1, #260
	mov x2, #180
	mov x3, #24
	mov x4, #4
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16    // 1er parte del cuello 
	bl draw_rect

	mov x1, #268
	mov x2, #184
	mov x3, #8
	mov x4, #4
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16   // 2da parte del cuello 
	bl draw_rect

	// Cuerpo		
	// Hombros
	mov x1, #256
	mov x2, #188
	mov x3, #32
	mov x4, #8
	movz w5, #0xD0FF, lsl #0       
        movk w5, #0xCC80, lsl #16       //    Campera
	bl draw_rect
	
	// Remera de abajo
	mov x1, #268
	mov x2, #188
	mov x3, #8
	mov x4, #8
	movz w5, #0xEEEE, lsl #0         
        movk w5, #0xFFEE, lsl #16        //  remera
	bl draw_rect

	// Panza
	mov x1, #260
	mov x2, #196
	mov x3, #24
	mov x4, #20
	movz w5, #0xD0FF, lsl #0        
        movk w5, #0xCC80, lsl #16        // Campera
	bl draw_rect
	
	// Bordes del cuello y detalles del cierre
	mov x1, #264
	mov x2, #184
	mov x3, #4
	mov x4, #12
	movz w5, #0xFF00, lsl #0        
        movk w5, #0xFFFF, lsl #16       // cierre campera
	bl draw_rect

	mov x1, #276
	mov x2, #184
	mov x3, #4
	mov x4, #12
	movz w5, #0xFF00, lsl #0       
        movk w5, #0xFFFF, lsl #16       // cierre campera
	bl draw_rect
	
	mov x1, #268
	mov x2, #196
	mov x3, #8
	mov x4, #4
	movz w5, #0xFF00, lsl #0        
        movk w5, #0xFFFF, lsl #16       // cierre campera
	bl draw_rect
	
	// Brazo 
	mov x1, #252
	mov x2, #192
	mov x3, #4
	mov x4, #24
	movz w5, #0xD0FF, lsl #0        
        movk w5, #0xCC80, lsl #16       // Campera
	bl draw_rect

	mov x1, #288
	mov x2, #192
	mov x3, #4
	mov x4, #24
	movz w5, #0xD0FF, lsl #0        
        movk w5, #0xCC80, lsl #16       // Campera
	bl draw_rect
	
	mov x1, #252
	mov x2, #204
	mov x3, #4
	mov x4, #8
	movz w5, #0xFF00, lsl #0        
        movk w5, #0xFFFF, lsl #16       // detalle campera
	bl draw_rect
	
	mov x1, #288
	mov x2, #204
	mov x3, #4
	mov x4, #8
	movz w5, #0xFF00, lsl #0       
        movk w5, #0xFFFF, lsl #16       // detalle campera
	bl draw_rect
	
	// Manos 
	mov x1, #256
	mov x2, #216
	mov x3, #4
	mov x4, #4
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #284
	mov x2, #216
	mov x3, #4
	mov x4, #4
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	// Piernas
	mov x1, #264
	mov x2, #216
	mov x3, #4
	mov x4, #20
	movz w5, #0x3C75, lsl #0      
        movk w5, #0xFF2F, lsl #16     // pantalones
	bl draw_rect

	mov x1, #276
	mov x2, #216
	mov x3, #4
	mov x4, #20
	movz w5, #0x3C75, lsl #0      
        movk w5, #0xFF2F, lsl #16  // pantalones
	bl draw_rect

	// Pies
	mov x1, #260
	mov x2, #236
	mov x3, #8
	mov x4, #6
	movz w5, #0xFFFF, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #276
	mov x2, #236
	mov x3, #8
	mov x4, #6
	movz w5, #0xFFFF, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect


	// Lucas (Oscurito)
	// Cabeza
	mov x1, #338
	mov x2, #140
	mov x3, #24
	mov x4, #4
	movz w5, #0x7253, lsl #0
	movk w5, #0xFFA9, lsl #16
	bl draw_rect

	mov x1, #334
	mov x2, #144
	mov x3, #32
	mov x4, #32
	movz w5, #0x7253, lsl #0
	movk w5, #0xFFA9, lsl #16
	bl draw_rect
 
 	mov x1, #330
	mov x2, #148
	mov x3, #4
	mov x4, #20
	movz w5, #0x7253, lsl #0
	movk w5, #0xFFA9, lsl #16
	bl draw_rect

	mov x1, #366
	mov x2, #148
	mov x3, #4
	mov x4, #20
	movz w5, #0x7253, lsl #0
	movk w5, #0xFFA9, lsl #16
	bl draw_rect

	mov x1, #338
	mov x2, #176
	mov x3, #24
	mov x4, #4
	movz w5, #0x7253, lsl #0
	movk w5, #0xFFA9, lsl #16
	bl draw_rect

	mov x1, #346
	mov x2, #180
	mov x3, #8
	mov x4, #4
	movz w5, #0x7253, lsl #0
	movk w5, #0xFFA9, lsl #16
	bl draw_rect

	// Cuerpo
	// Bordes del cuello
	mov x1, #342
	mov x2, #180
	mov x3, #4
	mov x4, #4
	movz w5, #0x4F50, lsl #0
	movk w5, #0xFFA5, lsl #16
	bl draw_rect

	mov x1, #354
	mov x2, #180
	mov x3, #4
	mov x4, #4
	movz w5, #0x4F50, lsl #0
	movk w5, #0xFFA5, lsl #16
	bl draw_rect

	// Hombros
	mov x1, #334
	mov x2, #184
	mov x3, #32
	mov x4, #8
	movz w5, #0x4F50, lsl #0
	movk w5, #0xFFA5, lsl #16
	bl draw_rect

	// Panza
	mov x1, #338
	mov x2, #192
	mov x3, #24
	mov x4, #20
	movz w5, #0x4F50, lsl #0
	movk w5, #0xFFA5, lsl #16
	bl draw_rect

	// Brazo 
	mov x1, #328
	mov x2, #188
	mov x3, #6
	mov x4, #24
	movz w5, #0x4F50, lsl #0
	movk w5, #0xFFA5, lsl #16
	bl draw_rect

	mov x1, #366
	mov x2, #188
	mov x3, #6
	mov x4, #24
	movz w5, #0x4F50, lsl #0
	movk w5, #0xFFA5, lsl #16
	bl draw_rect

	// Manos 
	mov x1, #332
	mov x2, #212
	mov x3, #6
	mov x4, #6
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #362
	mov x2, #212
	mov x3, #6
	mov x4, #6
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	// Piernas
	mov x1, #342
	mov x2, #212
	mov x3, #6
	mov x4, #24
	movz w5, #0x2225, lsl #0
	movk w5, #0xFF95, lsl #16
	bl draw_rect

	mov x1, #352
	mov x2, #212
	mov x3, #6
	mov x4, #24
	movz w5, #0x2225, lsl #0
	movk w5, #0xFF95, lsl #16
	bl draw_rect

	// Pies
	mov x1, #338
	mov x2, #236
	mov x3, #8
	mov x4, #6
	movz w5, #0xFFFF, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #354
	mov x2, #236
	mov x3, #8
	mov x4, #6
	movz w5, #0xFFFF, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect
 	//Ropa 
  	// pelo	
	mov x1, #338
	mov x2, #140
	mov x3, #24
	mov x4, #4
	movz w5, #0x1401, lsl #0
	movk w5, #0xFF41, lsl #16
	bl draw_rect

	mov x1, #334
	mov x2, #144
	mov x3, #4
	mov x4, #4
	movz w5, #0x1401, lsl #0
	movk w5, #0xFF41, lsl #16
	bl draw_rect

	mov x1, #330
	mov x2, #148
	mov x3, #4
	mov x4, #4
	movz w5, #0x1401, lsl #0
	movk w5, #0xFF41, lsl #16
	bl draw_rect

	mov x1, #362
	mov x2, #144
	mov x3, #4
	mov x4, #4
	movz w5, #0x1401, lsl #0
	movk w5, #0xFF41, lsl #16
	bl draw_rect

	mov x1, #366
	mov x2, #148
	mov x3, #4
	mov x4, #4
	movz w5, #0x1401, lsl #0
	movk w5, #0xFF41, lsl #16
	bl draw_rect

	mov x1, #334
	mov x2, #156
	mov x3, #12
	mov x4, #4
	movz w5, #0x1401, lsl #0
	movk w5, #0xFF41, lsl #16
	bl draw_rect

	mov x1, #334
	mov x2, #160
	mov x3, #4
	mov x4, #4
	movz w5, #0x1401, lsl #0
	movk w5, #0xFF41, lsl #16
	bl draw_rect

	mov x1, #354
	mov x2, #156
	mov x3, #12
	mov x4, #4
	movz w5, #0x1401, lsl #0
	movk w5, #0xFF41, lsl #16
	bl draw_rect

	mov x1, #362
	mov x2, #160
	mov x3, #4
	mov x4, #4
	movz w5, #0x1401, lsl #0
	movk w5, #0xFF41, lsl #16
	bl draw_rect
	
	//Verde osc
	mov x1, #338
	mov x2, #144
	mov x3, #24
	mov x4, #4
	movz w5, #0x995D, lsl #0
	movk w5, #0xFF93, lsl #16
	bl draw_rect

	mov x1, #334
	mov x2, #148
	mov x3, #32
	mov x4, #4
	movz w5, #0x995D, lsl #0
	movk w5, #0xFF93, lsl #16
	bl draw_rect

	mov x1, #334
	mov x2, #152
	mov x3, #8
	mov x4, #4
	movz w5, #0x995D, lsl #0
	movk w5, #0xFF93, lsl #16
	bl draw_rect

	mov x1, #358
	mov x2, #152
	mov x3, #8
	mov x4, #4
	movz w5, #0x995D, lsl #0
	movk w5, #0xFF93, lsl #16
	bl draw_rect

	mov x1, #330
	mov x2, #156
	mov x3, #4
	mov x4, #4
	movz w5, #0x995D, lsl #0
	movk w5, #0xFF93, lsl #16
	bl draw_rect

	mov x1, #366
	mov x2, #156
	mov x3, #4
	mov x4, #4
	movz w5, #0x995D, lsl #0
	movk w5, #0xFF93, lsl #16
	bl draw_rect

	//Verde cla
	mov x1, #330
	mov x2, #152
	mov x3, #4
	mov x4, #4
	movz w5, #0xD887, lsl #0
	movk w5, #0xFFE7, lsl #16
	bl draw_rect

	mov x1, #366
	mov x2, #152
	mov x3, #4
	mov x4, #4
	movz w5, #0xD887, lsl #0
	movk w5, #0xFFE7, lsl #16
	bl draw_rect

	mov x1, #350
	mov x2, #144
	mov x3, #4
	mov x4, #4
	movz w5, #0xD887, lsl #0
	movk w5, #0xFFE7, lsl #16
	bl draw_rect

	mov x1, #354
	mov x2, #148
	mov x3, #4
	mov x4, #4
	movz w5, #0xD887, lsl #0
	movk w5, #0xFFE7, lsl #16
	bl draw_rect

	//Negro
	mov x1, #338
	mov x2, #164
	mov x3, #4
	mov x4, #4
	movz w5, #0x0000, lsl #0
	movk w5, #0xFF00, lsl #16
	bl draw_rect

	mov x1, #358
	mov x2, #164
	mov x3, #4
	mov x4, #4
	movz w5, #0x0000, lsl #0
	movk w5, #0xFF00, lsl #16
	bl draw_rect

	//Marron piel
	mov x1, #346
	mov x2, #184
	mov x3, #8
	mov x4, #28
	movz w5, #0xD3FF, lsl #0
	movk w5, #0xFF6A, lsl #16
	bl draw_rect

	//Celeste
	mov x1, #346
	mov x2, #184
	mov x3, #8
	mov x4, #28
	movz w5, #0xD3FF, lsl #0
	movk w5, #0xFF6A, lsl #16
	bl draw_rect

	//Crema
	mov x1, #338
	mov x2, #188
	mov x3, #24
	mov x4, #8
	movz w5, #0xA991, lsl #0
	movk w5, #0xFFC1, lsl #16
	bl draw_rect

	
 	// Eleven
	// Cabeza
	mov x1, #418
	mov x2, #140
	mov x3, #24
	mov x4, #4
	movz w5, #0xA58A, lsl #0
	movk w5, #0xFFF4, lsl #16
	bl draw_rect

	mov x1, #414
	mov x2, #144
	mov x3, #32
	mov x4, #32
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #414
	mov x2, #144
	mov x3, #32
	mov x4, #8
	movz w5, #0xA58A, lsl #0
	movk w5, #0xFFF4, lsl #16
	bl draw_rect

	mov x1, #422
	mov x2, #152
	mov x3, #16
	mov x4, #4
	movz w5, #0xA58A, lsl #0
	movk w5, #0xFFF4, lsl #16
	bl draw_rect
	// Ojos
	mov x1, #418
	mov x2, #160
	mov x3, #4
	mov x4, #4
	movz w5, #0x0000, lsl #0
	movk w5, #0xFF00, lsl #16
	bl draw_rect
	mov x1, #438
	mov x2, #160
	mov x3, #4
	mov x4, #4
	movz w5, #0x0000, lsl #0
	movk w5, #0xFF00, lsl #16
	bl draw_rect
	//
	mov x1, #410
	mov x2, #148
	mov x3, #4
	mov x4, #20
	movz w5, #0xA58A, lsl #0
	movk w5, #0xFFF4, lsl #16
	bl draw_rect

	mov x1, #410
	mov x2, #168
	mov x3, #4
	mov x4, #4
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #446	
	mov x2, #148
	mov x3, #4
	mov x4, #20
	movz w5, #0xA58A, lsl #0
	movk w5, #0xFFF4, lsl #16
	bl draw_rect

	mov x1, #446
	mov x2, #168
	mov x3, #4
	mov x4, #4
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #418
	mov x2, #176
	mov x3, #24
	mov x4, #4
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #426
	mov x2, #180
	mov x3, #8
	mov x4, #4
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	// Cuerpo
	// Bordes del cuello
	mov x1, #422
	mov x2, #180
	mov x3, #4
	mov x4, #4
	movz w5, #0x3DC4, lsl #0
	movk w5, #0xFF5F, lsl #16
	bl draw_rect

	mov x1, #434
	mov x2, #180
	mov x3, #4
	mov x4, #4
	movz w5, #0x3DC4, lsl #0
	movk w5, #0xFF5F, lsl #16
	bl draw_rect

	// Hombros
	mov x1, #418
	mov x2, #184
	mov x3, #24
	mov x4, #8
	movz w5, #0x3DC4, lsl #0
	movk w5, #0xFF5F, lsl #16
	bl draw_rect

	// Panza
	mov x1, #422
	mov x2, #184
	mov x3, #16
	mov x4, #40
	movz w5, #0xA6A3, lsl #0
	movk w5, #0xFFD8, lsl #16
	bl draw_rect
	
	mov x1, #426
	mov x2, #184
	mov x3, #8
	mov x4, #4
	movz w5, #0xFFFF, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #422
	mov x2, #184
	mov x3, #4
	mov x4, #20
	movz w5, #0x3DC4, lsl #0
	movk w5, #0xFF5F, lsl #16
	bl draw_rect

	mov x1, #434
	mov x2, #184
	mov x3, #4
	mov x4, #20
	movz w5, #0x3DC4, lsl #0
	movk w5, #0xFF5F, lsl #16
	bl draw_rect

	// Brazo
	mov x1, #414
	mov x2, #188
	mov x3, #4
	mov x4, #24
	movz w5, #0x3DC4, lsl #0
	movk w5, #0xFF5F, lsl #16
	bl draw_rect

	mov x1, #442
	mov x2, #188
	mov x3, #4
	mov x4, #24
	movz w5, #0x3DC4, lsl #0
	movk w5, #0xFF5F, lsl #16
	bl draw_rect

	// Manos 
	mov x1, #418
	mov x2, #212
	mov x3, #4
	mov x4, #4
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #438
	mov x2, #212
	mov x3, #4
	mov x4, #4
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	// Piernas
	mov x1, #422
	mov x2, #224
	mov x3, #4
	mov x4, #12
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #434
	mov x2, #224
	mov x3, #4
	mov x4, #12
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	// Pies
	mov x1, #418
	mov x2, #236
	mov x3, #8
	mov x4, #6
	movz w5, #0xFFFF, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #434
	mov x2, #236
	mov x3, #8
	mov x4, #6
	movz w5, #0xFFFF, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect
 
	// Mike
	// Cabeza
	mov x1, #498
	mov x2, #136
	mov x3, #20
	mov x4, #4
	movz w5, #0x1C1C, lsl #0
	movk w5, #0xFF1C, lsl #16
	bl draw_rect
	
	mov x1, #490
	mov x2, #140
	mov x3, #32
	mov x4, #4
	movz w5, #0x1C1C, lsl #0
	movk w5, #0xFF1C, lsl #16
	bl draw_rect
	
	mov x1, #494
	mov x2, #144
	mov x3, #32
	mov x4, #32
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #486
	mov x2, #144
	mov x3, #40
	mov x4, #4
	movz w5, #0x1C1C, lsl #0
	movk w5, #0xFF1C, lsl #16
	bl draw_rect

	mov x1, #514
	mov x2, #144
	mov x3, #4
	mov x4, #4
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #486
	mov x2, #148
	mov x3, #44
	mov x4, #4
	movz w5, #0x1C1C, lsl #0
	movk w5, #0xFF1C, lsl #16
	bl draw_rect

	mov x1, #510
	mov x2, #148
	mov x3, #8
	mov x4, #4
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #486
	mov x2, #152
	mov x3, #48
	mov x4, #4
	movz w5, #0x1C1C, lsl #0
	movk w5, #0xFF1C, lsl #16
	bl draw_rect

	mov x1, #506
	mov x2, #152
	mov x3, #20
	mov x4, #4
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #486
	mov x2, #156
	mov x3, #48
	mov x4, #4
	movz w5, #0x1C1C, lsl #0
	movk w5, #0xFF1C, lsl #16
	bl draw_rect

	mov x1, #498
	mov x2, #156
	mov x3, #28
	mov x4, #4
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #486
	mov x2, #160
	mov x3, #4
	mov x4, #16
	movz w5, #0x1C1C, lsl #0
	movk w5, #0xFF1C, lsl #16
	bl draw_rect

	mov x1, #530
	mov x2, #160
	mov x3, #4
	mov x4, #12
	movz w5, #0x1C1C, lsl #0
	movk w5, #0xFF1C, lsl #16
	bl draw_rect

	mov x1, #490
	mov x2, #160
	mov x3, #4
	mov x4, #8
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #526
	mov x2, #160
	mov x3, #4
	mov x4, #8
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect
	// OJASOS
	mov x1, #498
	mov x2, #164
	mov x3, #4
	mov x4, #4
	movz w5, #0x0000, lsl #0
	movk w5, #0xFF00, lsl #16
	bl draw_rect
	
	mov x1, #518
	mov x2, #164
	mov x3, #4
	mov x4, #4
	movz w5, #0x0000, lsl #0
	movk w5, #0xFF00, lsl #16
	bl draw_rect
	
	mov x1, #526
	mov x2, #168
	mov x3, #4
	mov x4, #12
	movz w5, #0x1C1C, lsl #0
	movk w5, #0xFF1C, lsl #16

	mov x1, #530
	mov x2, #176
	mov x3, #4
	mov x4, #4
	movz w5, #0x1C1C, lsl #0
	movk w5, #0xFF1C, lsl #16

	mov x1, #558
	mov x2, #168
	mov x3, #4
	mov x4, #12
	movz w5, #0x1C1C, lsl #0
	movk w5, #0xFF1C, lsl #16

	mov x1, #554
	mov x2, #176
	mov x3, #4
	mov x4, #4
	movz w5, #0x1C1C, lsl #0
	movk w5, #0xFF1C, lsl #16
	
	mov x1, #498
	mov x2, #176
	mov x3, #24
	mov x4, #4
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #506
	mov x2, #180
	mov x3, #8
	mov x4, #4
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	// Cuerpo
	// Bordes del cuello
	mov x1, #502
	mov x2, #180
	mov x3, #4
	mov x4, #4
	movz w5, #0xB78D, lsl #0
	movk w5, #0xFFA5, lsl #16
	bl draw_rect

	mov x1, #514
	mov x2, #180
	mov x3, #4
	mov x4, #4
	movz w5, #0xB78D, lsl #0
	movk w5, #0xFFA5, lsl #16
	bl draw_rect
	// Hombros
	mov x1, #494
	mov x2, #184
	mov x3, #32
	mov x4, #8
	movz w5, #0xB78D, lsl #0
	movk w5, #0xFFA5, lsl #16
	bl draw_rect
	// Panza
	mov x1, #498
	mov x2, #192
	mov x3, #24
	mov x4, #20
	movz w5, #0xB78D, lsl #0
	movk w5, #0xFFA5, lsl #16
	bl draw_rect

	mov x1, #506
	mov x2, #184
	mov x3, #8
	mov x4, #28
	movz w5, #0xFFFF, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #506
	mov x2, #192
	mov x3, #8
	mov x4, #16
	movz w5, #0x3286, lsl #0
	movk w5, #0xFF0D, lsl #16
	bl draw_rect

	mov x1, #506
	mov x2, #196
	mov x3, #8
	mov x4, #8
	movz w5, #0xD038, lsl #0
	movk w5, #0xFFF7, lsl #16
	bl draw_rect
	// Brazos
	mov x1, #488
	mov x2, #188
	mov x3, #6
	mov x4, #24
	movz w5, #0xB78D, lsl #0
	movk w5, #0xFFA5, lsl #16
	bl draw_rect

	mov x1, #526
	mov x2, #188
	mov x3, #6
	mov x4, #24
	movz w5, #0xB78D, lsl #0
	movk w5, #0xFFA5, lsl #16
	bl draw_rect
	// Manos 
	mov x1, #492
	mov x2, #212
	mov x3, #6
	mov x4, #6
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #522
	mov x2, #212
	mov x3, #6
	mov x4, #6
	movz w5, #0xCCAA, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect
	// Piernas
	mov x1, #502
	mov x2, #212
	mov x3, #6
	mov x4, #24
	movz w5, #0x3DC4, lsl #0
	movk w5, #0xFF5F, lsl #16
	bl draw_rect

	mov x1, #512
	mov x2, #212
	mov x3, #6
	mov x4, #24
	movz w5, #0x3DC4, lsl #0
	movk w5, #0xFF5F, lsl #16
	bl draw_rect
	// Pies
	mov x1, #498
	mov x2, #236
	mov x3, #8
	mov x4, #6
	movz w5, #0xFFFF, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect

	mov x1, #514
	mov x2, #236
	mov x3, #8
	mov x4, #6
	movz w5, #0xFFFF, lsl #0
	movk w5, #0xFFFF, lsl #16
	bl draw_rect




/////////////////DEMOGORGON/////////////////////



	
 // demogorgon
	mov x0, x20
//Demogorgon - cuerpo
	movz w5, #0x4379, lsl #0
	movk w5, #0xFF06, lsl #16

//tronco

	mov x1, #405 // 410 - 5
	mov x2, #350 // 365 - 15
	mov x3, #42
	mov x4, #15
	bl draw_rect

	mov x0, x20
	mov x1, #415 // 420 - 5
	mov x2, #355 // 370 - 15
	mov x3, #20
	mov x4, #20
	bl draw_rect

	mov x1, #411 // 416 - 5
	mov x2, #347 // 362 - 15
	mov x3, #6
	mov x4, #3
	bl draw_rect

	mov x1, #417 // 422 - 5
	mov x2, #344 // 359 - 15
	mov x3, #6
	mov x4, #6
	bl draw_rect

	mov x1, #423 // 428 - 5
	mov x2, #338 // 353 - 15
	mov x3, #24
	mov x4, #12
	bl draw_rect

	mov x1, #429 // 434 - 5
	mov x2, #332 // 347 - 15
	mov x3, #6
	mov x4, #6
	bl draw_rect

	mov x1, #435 // 440 - 5
	mov x2, #329 // 344 - 15
	mov x3, #6
	mov x4, #9
	bl draw_rect

	mov x1, #441 // 446 - 5
	mov x2, #335 // 350 - 15
	mov x3, #6
	mov x4, #3
	bl draw_rect

//panza
	movz w5, #0x1738, lsl #0
	movk w5, #0xFF00, lsl #16

	mov x1, #402 // 407 - 5
	mov x2, #344 // 359 - 15
	mov x3, #3
	mov x4, #15
	bl draw_rect

	mov x1, #405 // 410 - 5
	mov x2, #347 // 362 - 15
	mov x3, #6
	mov x4, #3
	bl draw_rect

	mov x1, #405 // 410 - 5
	mov x2, #332 // 347 - 15
	mov x3, #12
	mov x4, #15
	bl draw_rect

	mov x1, #417 // 422 - 5
	mov x2, #338 // 353 - 15
	mov x3, #6
	mov x4, #6
	bl draw_rect

	mov x1, #414 // 419 - 5
	mov x2, #326 // 341 - 15
	mov x3, #15
	mov x4, #12
	bl draw_rect

	mov x1, #411 // 416 - 5
	mov x2, #329 // 344 - 15
	mov x3, #6
	mov x4, #3
	bl draw_rect

	mov x1, #426 // 431 - 5
	mov x2, #323 // 338 - 15
	mov x3, #9
	mov x4, #9
	bl draw_rect

	mov x1, #432 // 437 - 5
	mov x2, #317 // 332 - 15
	mov x3, #9
	mov x4, #12
	bl draw_rect

	mov x1, #441 // 446 - 5
	mov x2, #323 // 338 - 15
	mov x3, #6
	mov x4, #12
	bl draw_rect

	mov x1, #438 // 443 - 5
	mov x2, #314 // 329 - 15
	mov x3, #6
	mov x4, #3
	bl draw_rect

	mov x1, #438 // 443 - 5
	mov x2, #308 // 323 - 15
	mov x3, #9
	mov x4, #6
	bl draw_rect

	mov x1, #447 // 452 - 5
	mov x2, #302 // 317 - 15
	mov x3, #6
	mov x4, #9
	bl draw_rect

	mov x1, #450 // 455 - 5
	mov x2, #296 // 311 - 15
	mov x3, #3
	mov x4, #6
	bl draw_rect

	mov x1, #414 // 419 - 5
	mov x2, #320 // 335 - 15
	mov x3, #6
	mov x4, #6
	bl draw_rect

	mov x1, #411 // 416 - 5
	mov x2, #320 // 335 - 15
	mov x3, #3
	mov x4, #3
	bl draw_rect

	mov x1, #408 // 413 - 5
	mov x2, #311 // 326 - 15
	mov x3, #6
	mov x4, #9
	bl draw_rect

	mov x1, #405 // 410 - 5
	mov x2, #308 // 323 - 15
	mov x3, #3
	mov x4, #9
	bl draw_rect


	//piernas

	
	movz w5, #0x4379, lsl #0
	movk w5, #0xFF06, lsl #16

	mov x1, #420 // 425 - 5
	mov x2, #323 // 338 - 15
	mov x3, #6
	mov x4, #3
	bl draw_rect

	mov x1, #414 // 419 - 5
	mov x2, #317 // 332 - 15
	mov x3, #6
	mov x4, #3
	bl draw_rect

	mov x1, #420 // 425 - 5
	mov x2, #317 // 332 - 15
	mov x3, #12
	mov x4, #9
	bl draw_rect

	mov x1, #414 // 419 - 5
	mov x2, #311 // 326 - 15
	mov x3, #24
	mov x4, #6
	bl draw_rect

	mov x1, #414 // 419 - 5
	mov x2, #302 // 317 - 15
	mov x3, #6
	mov x4, #9
	bl draw_rect


	mov x1, #408 // 413 - 5
	mov x2, #302 // 317 - 15
	mov x3, #6
	mov x4, #12
	bl draw_rect

	mov x1, #402 // 407 - 5
	mov x2, #293 // 308 - 15
	mov x3, #9
	mov x4, #18
	bl draw_rect

	mov x1, #405 // 410 - 5
	mov x2, #284 // 299 - 15
	mov x3, #6
	mov x4, #9
	bl draw_rect

	mov x1, #408 // 413 - 5
	mov x2, #281 // 296 - 15
	mov x3, #6
	mov x4, #6
	bl draw_rect
	
	mov x0, x20
	mov x1, #408 // 413 - 5
	mov x2, #285 // 300 - 15
	mov x3, #6
	mov x4, #12
	bl draw_rect

	mov x0, x20
	mov x1, #408 // 413 - 5
	mov x2, #273 // 288 - 15
	mov x3, #6
	mov x4, #24
	bl draw_rect

	mov x0, x20
	mov x1, #405 // 410 - 5
	mov x2, #280 // 295 - 15
	mov x3, #6
	mov x4, #6
	bl draw_rect

	mov x0, x20
	mov x1, #412 // 417 - 5
	mov x2, #258 // 273 - 15
	mov x3, #4
	mov x4, #15
	bl draw_rect

	mov x0, x20
	mov x1, #415 // 420 - 5
	mov x2, #255 // 270 - 15
	mov x3, #6
	mov x4, #6
	bl draw_rect

	mov x0, x20
	mov x1, #405 // 410 - 5
	mov x2, #252 // 267 - 15
	mov x3, #15
	mov x4, #6
	bl draw_rect

	mov x0, x20
	mov x1, #405 // 410 - 5
	mov x2, #252 // 267 - 15
	mov x3, #4
	mov x4, #8
	bl draw_rect

//detalles pierna izquierda
	movz w5, #0x1738, lsl #0
	movk w5, #0xFF00, lsl #16
	mov x1, #408 // 413 - 5
	mov x2, #281 // 296 - 15
	mov x3, #6
	mov x4, #9
	bl draw_rect

	mov x1, #411 // 416 - 5
	mov x2, #275 // 290 - 15
	mov x3, #3
	mov x4, #6
	bl draw_rect

	mov x1, #414 // 419 - 5
	mov x2, #269 // 284 - 15
	mov x3, #3
	mov x4, #9
	bl draw_rect


//pierna derecha

	movz w5, #0x4379, lsl #0
	movk w5, #0xFF06, lsl #16

	mov x1, #435 // 440 - 5
	mov x2, #305 // 320 - 15
	mov x3, #9
	mov x4, #9
	bl draw_rect

	mov x1, #441 // 446 - 5
	mov x2, #299 // 314 - 15
	mov x3, #9
	mov x4, #9
	bl draw_rect

	mov x1, #444 // 449 - 5
	mov x2, #293 // 308 - 15
	mov x3, #12
	mov x4, #6
	bl draw_rect

	mov x1, #447 // 452 - 5
	mov x2, #285 // 300 - 15
	mov x3, #15
	mov x4, #9
	bl draw_rect

	mov x1, #453 // 458 - 5
	mov x2, #276 // 291 - 15
	mov x3, #9
	mov x4, #18
	bl draw_rect

	mov x1, #453 // 458 - 5
	mov x2, #267 // 282 - 15
	mov x3, #6
	mov x4, #9
	bl draw_rect

	mov x1, #453 // 458 - 5
	mov x2, #264 // 279 - 15
	mov x3, #3
	mov x4, #3
	bl draw_rect

	mov x1, #447 // 452 - 5
	mov x2, #280 // 295 - 15
	mov x3, #6
	mov x4, #3
	bl draw_rect

	mov x1, #446 // 451 - 5
	mov x2, #250 // 265 - 15
	mov x3, #12
	mov x4, #4
	bl draw_rect

	mov x1, #456 // 461 - 5
	mov x2, #250 // 265 - 15
	mov x3, #3
	mov x4, #6
	bl draw_rect

//otro color para detalles
	movz w5, #0x1738, lsl #0
	movk w5, #0xFF00, lsl #16

	mov x1, #447 // 452 - 5
	mov x2, #283 // 298 - 15
	mov x3, #6
	mov x4, #3
	bl draw_rect

	mov x1, #444 // 449 - 5
	mov x2, #280 // 295 - 15
	mov x3, #3
	mov x4, #3
	bl draw_rect

	mov x1, #447 // 452 - 5
	mov x2, #259 // 274 - 15
	mov x3, #6
	mov x4, #20
	bl draw_rect

	mov x1, #447 // 452 - 5
	mov x2, #253 // 268 - 15
	mov x3, #3
	mov x4, #6
	bl draw_rect

	mov x1, #444 // 449 - 5
	mov x2, #253 // 268 - 15
	mov x3, #3
	mov x4, #6
	bl draw_rect

//brazo derecho

	movz w5, #0x4379, lsl #0
	movk w5, #0xFF06, lsl #16

	mov x1, #445 // 450 - 5
	mov x2, #358 // 373 - 15
	mov x3, #6
	mov x4, #6
	bl draw_rect

	mov x1, #447 // 452 - 5
	mov x2, #355 // 370 - 15
	mov x3, #15
	mov x4, #6
	bl draw_rect

	mov x1, #450 // 455 - 5
	mov x2, #349 // 364 - 15
	mov x3, #12
	mov x4, #12
	bl draw_rect

	mov x1, #455 // 460 - 5
	mov x2, #345 // 360 - 15
	mov x3, #12
	mov x4, #6
	bl draw_rect

	mov x1, #458 // 463 - 5
	mov x2, #339 // 354 - 15
	mov x3, #12
	mov x4, #12
	bl draw_rect


	mov x1, #461 // 466 - 5
	mov x2, #333 // 348 - 15
	mov x3, #12
	mov x4, #6
	bl draw_rect

	mov x1, #464 // 469 - 5
	mov x2, #327 // 342 - 15
	mov x3, #12
	mov x4, #6
	bl draw_rect

	mov x1, #467 // 472 - 5
	mov x2, #321 // 336 - 15
	mov x3, #12
	mov x4, #6
	bl draw_rect

	mov x1, #473 // 478 - 5
	mov x2, #315 // 330 - 15
	mov x3, #12
	mov x4, #6
	bl draw_rect

	mov x1, #479 // 484 - 5
	mov x2, #309 // 324 - 15
	mov x3, #12
	mov x4, #6
	bl draw_rect


	mov x1, #485 // 490 - 5
	mov x2, #313 // 328 - 15
	mov x3, #6
	mov x4, #3
	bl draw_rect


//mano derecha

	movz w5, #0x4379, lsl #0
	movk w5, #0xFF06, lsl #16
	mov x1, #485 // 490 - 5
	mov x2, #297 // 312 - 15
	mov x3, #6
	mov x4, #18
	bl draw_rect

	mov x1, #485 // 490 - 5
	mov x2, #291 // 306 - 15
	mov x3, #3
	mov x4, #6
	bl draw_rect

	mov x1, #482 // 487 - 5
	mov x2, #288 // 303 - 15
	mov x3, #3
	mov x4, #6
	bl draw_rect

	mov x1, #491 // 496 - 5
	mov x2, #300 // 315 - 15
	mov x3, #3
	mov x4, #6
	bl draw_rect

	mov x1, #494 // 499 - 5
	mov x2, #300 // 315 - 15
	mov x3, #3
	mov x4, #3
	bl draw_rect

	mov x1, #494 // 499 - 5
	mov x2, #294 // 309 - 15
	mov x3, #6
	mov x4, #6
	bl draw_rect

	mov x1, #499 // 504 - 5
	mov x2, #294 // 309 - 15
	mov x3, #3
	mov x4, #3
	bl draw_rect

	mov x1, #499 // 504 - 5
	mov x2, #291 // 306 - 15
	mov x3, #9
	mov x4, #3
	bl draw_rect

	mov x1, #499 // 504 - 5
	mov x2, #285 // 300 - 15
	mov x3, #3
	mov x4, #12
	bl draw_rect

	mov x1, #505 // 510 - 5
	mov x2, #285 // 300 - 15
	mov x3, #3
	mov x4, #9
	bl draw_rect


// brazo izquierdo
	mov x1, #393 // 398 - 5
	mov x2, #355 // 370 - 15
	mov x3, #12
	mov x4, #6
	bl draw_rect

	mov x1, #390 // 395 - 5
	mov x2, #334 // 349 - 15
	mov x3, #9
	mov x4, #21
	bl draw_rect

	mov x1, #384 // 389 - 5
	mov x2, #330 // 345 - 15
	mov x3, #12
	mov x4, #6
	bl draw_rect

	mov x1, #381 // 386 - 5
	mov x2, #324 // 339 - 15
	mov x3, #9
	mov x4, #9
	bl draw_rect

	mov x1, #378 // 383 - 5
	mov x2, #321 // 336 - 15
	mov x3, #6
	mov x4, #6
	bl draw_rect

	mov x1, #378 // 383 - 5
	mov x2, #319 // 334 - 15
	mov x3, #3
	mov x4, #3
	bl draw_rect


	mov x1, #372 // 377 - 5
	mov x2, #317 // 332 - 15
	mov x3, #6
	mov x4, #6
	bl draw_rect

	//mano izquierda
	mov x1, #372 // 377 - 5
	mov x2, #296 // 311 - 15
	mov x3, #3
	mov x4, #21
	bl draw_rect

	mov x1, #375 // 380 - 5
	mov x2, #290 // 305 - 15
	mov x3, #3
	mov x4, #12
	bl draw_rect

	mov x1, #366 // 371 - 5
	mov x2, #302 // 317 - 15
	mov x3, #9
	mov x4, #9
	bl draw_rect

	mov x1, #363 // 368 - 5
	mov x2, #299 // 314 - 15
	mov x3, #6
	mov x4, #6
	bl draw_rect

	mov x1, #360 // 365 - 5
	mov x2, #290 // 305 - 15
	mov x3, #3
	mov x4, #15
	bl draw_rect

	mov x1, #360 // 365 - 5
	mov x2, #290 // 305 - 15
	mov x3, #3
	mov x4, #15
	bl draw_rect

	mov x1, #354 // 359 - 5
	mov x2, #290 // 305 - 15
	mov x3, #3
	mov x4, #9
	bl draw_rect

	mov x1, #357 // 362 - 5
	mov x2, #296 // 311 - 15
	mov x3, #6
	mov x4, #6
	bl draw_rect



// DEMOGORGON - CABEZA
// PETALO DERECHA ARRIBA

    mov x1, #440 // 445 - 5
    mov x2, #372 // 387 - 15
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle

    mov x1, #443 // 448 - 5
    mov x2, #371 // 386 - 15
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle

    mov x1, #442 // 447 - 5
    mov x2, #373 // 388 - 15
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle


//detalles
    mov x1, #445 // 450 - 5
    mov x2, #369 // 384 - 15
    mov x3, #5
    movz w5, #0x8BD1, lsl #0
    movk w5, #0xFF1A, lsl #16
    bl draw_circle

    mov x1, #441 // 446 - 5
    mov x2, #373 // 388 - 15
    mov x3, #8
    movz w5, #0x3A6C, lsl #0
    movk w5, #0xFF04, lsl #16
    bl draw_circle

    mov x1, #448 // 453 - 5
    mov x2, #372 // 387 - 15
    mov x3, #2
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle

    mov x1, #441 // 446 - 5
    mov x2, #369 // 384 - 15
    mov x3, #1
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle




// PETALO DERECHA ABAJO

    mov x1, #440 // 445 - 5
    mov x2, #390 // 405 - 15
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle

    mov x1, #447 // 452 - 5
    mov x2, #391 // 406 - 15
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle

    mov x1, #443 // 448 - 5
    mov x2, #391 // 406 - 15
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle


//detalles
    mov x1, #450 // 455 - 5
    mov x2, #390 // 405 - 15
    mov x3, #5
    movz w5, #0x8BD1, lsl #0
    movk w5, #0xFF1A, lsl #16
    bl draw_circle

    mov x1, #450 // 455 - 5
    mov x2, #391 // 406 - 15
    mov x3, #5
    movz w5, #0x8BD1, lsl #0
    movk w5, #0xFF1A, lsl #16
    bl draw_circle

    mov x1, #444 // 449 - 5
    mov x2, #391 // 406 - 15
    mov x3, #8
    movz w5, #0x3A6C, lsl #0
    movk w5, #0xFF04, lsl #16
    bl draw_circle

    mov x1, #445 // 450 - 5
    mov x2, #395 // 410 - 15
    mov x3, #1
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle

    mov x1, #449 // 454 - 5
    mov x2, #388 // 403 - 15
    mov x3, #2
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle




// PETALO IZQUIERDA ARRIBA

    mov x1, #410 // 415 - 5
    mov x2, #372 // 387 - 15
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle

    mov x1, #407 // 412 - 5
    mov x2, #371 // 386 - 15
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle

    mov x1, #408 // 413 - 5
    mov x2, #373 // 388 - 15
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle


//detalles (reflejo de los de DERECHA ARRIBA)
    mov x1, #405 // 410 - 5
    mov x2, #369 // 384 - 15
    mov x3, #5
    movz w5, #0x8BD1, lsl #0
    movk w5, #0xFF1A, lsl #16
    bl draw_circle

    mov x1, #409 // 414 - 5
    mov x2, #373 // 388 - 15
    mov x3, #8
    movz w5, #0x3A6C, lsl #0
    movk w5, #0xFF04, lsl #16
    bl draw_circle

    mov x1, #404 // 409 - 5
    mov x2, #373 // 388 - 15
    mov x3, #2
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle

    mov x1, #409 // 414 - 5
    mov x2, #369 // 384 - 15
    mov x3, #1
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle


// PETALO IZQUIERDA ABAJO

    mov x1, #410 // 415 - 5
    mov x2, #390 // 405 - 15
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle

    mov x1, #403 // 408 - 5
    mov x2, #391 // 406 - 15
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle

    mov x1, #407 // 412 - 5
    mov x2, #391 // 406 - 15
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle


//detalles (reflejo de los de DERECHA ABAJO)
    mov x1, #400 // 405 - 5
    mov x2, #390 // 405 - 15
    mov x3, #5
    movz w5, #0x8BD1, lsl #0
    movk w5, #0xFF1A, lsl #16
    bl draw_circle

    mov x1, #400 // 405 - 5
    mov x2, #391 // 406 - 15
    mov x3, #5
    movz w5, #0x8BD1, lsl #0
    movk w5, #0xFF1A, lsl #16
    bl draw_circle

    mov x1, #406 // 411 - 5
    mov x2, #391 // 406 - 15
    mov x3, #8
    movz w5, #0x3A6C, lsl #0
    movk w5, #0xFF04, lsl #16
    bl draw_circle

    mov x1, #405 // 410 - 5
    mov x2, #392 // 407 - 15
    mov x3, #1
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle

    mov x1, #403 // 408 - 5
    mov x2, #388 // 403 - 15
    mov x3, #1
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle

// Gran pétalo hacia abajo

    mov x1, #420 // 425 - 5
    mov x2, #400 // 415 - 15
    mov x3, #12
    movz w5, #0x1637, lsl #0
    bl draw_circle

    mov x1, #430 // 435 - 5
    mov x2, #400 // 415 - 15
    mov x3, #12
    movz w5, #0x1637, lsl #0
    bl draw_circle

    mov x1, #425 // 430 - 5
    mov x2, #405 // 420 - 15
    mov x3, #15
    movz w5, #0x1637, lsl #0
    bl draw_circle



  // Detalles 

    mov x1, #425 // 430 - 5
    mov x2, #403 // 418 - 15
    mov x3, #13
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle


    mov x1, #422 // 427 - 5
    mov x2, #398 // 413 - 15
    mov x3, #12
    movz w5, #0x3A6C, lsl #0
    movk w5, #0xFF04, lsl #16
    bl draw_circle

    mov x1, #427 // 432 - 5
    mov x2, #398 // 413 - 15
    mov x3, #12
    movz w5, #0x3A6C, lsl #0
    movk w5, #0xFF04, lsl #16
    bl draw_circle

    mov x1, #425 // 430 - 5
    mov x2, #401 // 416 - 15
    mov x3, #12
    movz w5, #0x3A6C, lsl #0
    movk w5, #0xFF04, lsl #16
    bl draw_circle



    mov x1, #431 // 436 - 5
    mov x2, #408 // 423 - 15
    mov x3, #1
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle

    mov x1, #418 // 423 - 5
    mov x2, #407 // 422 - 15
    mov x3, #1
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle

    mov x1, #425 // 430 - 5
    mov x2, #404 // 419 - 15
    mov x3, #1
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle

    mov x1, #422 // 427 - 5
    mov x2, #410 // 425 - 15
    mov x3, #1
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle

// Centro de la cabeza

    mov x1, #425 // 430 - 5
    mov x2, #385 // 400 - 15
    mov x3, #20
    movz w5, #0x1C4A, lsl #0
    bl draw_circle

    mov x1, #425 // 430 - 5
    mov x2, #385 // 400 - 15
    mov x3, #15
    movz w5, #0x0014, lsl #0
    bl draw_circle

// Centro de la cabeza con profundidad
// Degradado
    //  Azul oscuro
    movz w5, #0x1C4A, lsl #0  
    movk w5, #0xFF00, lsl #16   
    mov x1, #425 // 430 - 5
    mov x2, #385 // 400 - 15
    mov x3, #20
    bl draw_circle

    // Azul más oscuro, un poco menos azul
    movz w5, #0x163D, lsl #0  
    movk w5, #0xFF00, lsl #16  
    mov x1, #425 // 430 - 5
    mov x2, #385 // 400 - 15
    mov x3, #18
    bl draw_circle

    // Azul casi negro
    movz w5, #0x0A21, lsl #0   
    movk w5, #0xFF00, lsl #16    
    mov x1, #425 // 430 - 5
    mov x2, #385 // 400 - 15
    mov x3, #16
    bl draw_circle

    //  Negro con un poco de azul
    movz w5, #0x0408, lsl #0 
    movk w5, #0xFF00, lsl #16  
    mov x1, #425 // 430 - 5
    mov x2, #385 // 400 - 15
    mov x3, #14
    bl draw_circle

    // Negro puro
    movz w5, #0x0000, lsl #0 
    movk w5, #0xFF00, lsl #16
    mov x1, #425 // 430 - 5
    mov x2, #385 // 400 - 15
    mov x3, #12
    bl draw_circle

    // Negro con rojo leve 
    movz w5, #0x0100, lsl #0  
    movk w5, #0xFF00, lsl #16     
    mov x1, #425 // 430 - 5
    mov x2, #385 // 400 - 15
    mov x3, #10
    bl draw_circle

    // Capa 7 
    movz w5, #0x0000, lsl #0
    movk w5, #0xFF33, lsl #16     
    mov x1, #425 // 430 - 5
    mov x2, #385 // 400 - 15
    mov x3, #8
    bl draw_circle

    // Capa 8 - Rojo bordó oscuro
    movz w5, #0x0000, lsl #0
    movk w5, #0xFF55, lsl #16 
    mov x1, #425 // 430 - 5
    mov x2, #385 // 400 - 15
    mov x3, #6
    bl draw_circle

    // 
    movz w5, #0x0000, lsl #0
    movk w5, #0xFF77, lsl #16 
    mov x1, #425 // 430 - 5
    mov x2, #385 // 400 - 15
    mov x3, #4
    bl draw_circle

    //  Rojo bordó 
    movz w5, #0x0000, lsl #0
    movk w5, #0xFF99, lsl #16 
    mov x1, #425 // 430 - 5
    mov x2, #385 // 400 - 15
    mov x3, #2
    bl draw_circle

	// Detalles en el tronco (círculos)
	movz w5, #0x90D6, lsl #0
	movk w5, #0xFF1B, lsl #16 // Color ligeramente diferente

	mov x1, #415 // Centro X
	mov x2, #352 // Centro Y
	mov x3, #2   // Radio
	bl draw_circle

	mov x1, #430
	mov x2, #345
	mov x3, #3
	bl draw_circle

	mov x1, #420
	mov x2, #335
	mov x3, #2
	bl draw_circle

	mov x1, #440
	mov x2, #355
	mov x3, #2
	bl draw_circle



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
    mov x6, x1
    mov x7, x2
    mov x8, x3
    mov w9, w5

    // Definir el ancho de la pantalla (asumiendo 640 píxeles)
    mov x10, #640

    // Calcular el radio al cuadrado (radio * radio)
    mul x11, x8, x8

    // Calcular las coordenadas del cuadro delimitador
    sub x12, x6, x8
    add x13, x6, x8
    sub x14, x7, x8
    add x15, x7, x8

    // Bucle principal para las coordenadas Y (filas)
    mov x16, x14

loop_y_circle:
    cmp x16, x15
    b.ge end_draw_circle

    // Bucle anidado para las coordenadas X (columnas)
    mov x17, x12

loop_x_circle:
    cmp x17, x13
    b.ge next_y_circle

    // Calcular dx = current_x - center_x
    sub x18, x17, x6

    // Calcular dy = current_y - center_y
    sub x19, x16, x7

    // Calcular dx_squared = dx * dx
    mul x25, x18, x18   // <-- CAMBIO AQUÍ: Usamos x25 en lugar de x20

    // Calcular dy_squared = dy * dy
    mul x21, x19, x19

    // Calcular distance_squared = dx_squared + dy_squared
    add x22, x25, x21   // <-- CAMBIO AQUÍ: Usamos x25 en lugar de x20

    // Comparar distance_squared con radio_squared
    cmp x22, x11
    b.gt skip_pixel_circle

    // Calcular el desplazamiento del píxel y dibujarlo
    mul x23, x16, x10
    add x23, x23, x17
    lsl x23, x23, #2

    // Calcular la dirección de memoria del píxel: framebuffer_base (x0) + offset_in_bytes (x23)
    add x24, x0, x23

    // Almacenar el color en la dirección de memoria del píxel
    str w9, [x24]

skip_pixel_circle:
    add x17, x17, #1
    b loop_x_circle

next_y_circle:
    add x16, x16, #1
    b loop_y_circle

end_draw_circle:
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
