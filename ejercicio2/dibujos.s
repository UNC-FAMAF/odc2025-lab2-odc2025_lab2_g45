    .include "header.s"      

.globl dibujando_celeste
.globl dibujando_purpura_inferior
.globl dibujando_purpura_superior
.globl dibujando_estrellas
.globl dibujando_arbustos_y_fondo
.globl dibujando_arboles_fondo
.globl dibujando_ODC2025
.globl dibujando_pasto
.globl dibujando_dustin
.globl dibujando_eleven
.globl dibujando_mike
.globl dibujando_lucas
.globl dibujando_will
.globl dibujando_max
.globl draw_demogorgon
.globl animacion
.globl dibujando_estrellas_apagadas


.section .text

	// -------------------FONDO CELESTE DE ARRIBA Y ABAJO -------------------	
dibujando_celeste:
 mov x0, x20
stp x29, x30, [sp, #-16]! 
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
	ldp x29, x30, [sp], #16    
    ret                        
	// -------------------FONDO PÚRPURA -------------------	

dibujando_purpura_inferior:

    stp x29, x30, [sp, #-16]!  
    // color púrpura inferior = 0xFF1F1D44
    movz x10, 0x1D44, lsl 0
    movk x10, 0xFF1F, lsl 16

    mov x5, #640        // SCREEN_WIDTH
    mov x12, #239       // y_end (constante)

    ldr x13, =purpura_coords // puntero a la tabla de coordenadas púrpura al final del código
    mov x14, #30        // cantidad de entradas
loop_purpura:
    ldr w6, [x13], #4   // x_start
    ldr w7, [x13], #4   // x_end
    ldr w11, [x13], #4  // y_start

    bl double_mirror_loop

    subs x14, x14, #1 //resta 1
    b.ne loop_purpura
	ldp x29, x30, [sp], #16    
    ret                        
	

	// Para lograr el efecto de que arriba sea un tono más claro de púrpura, y abajo sea un tono más oscuro, lo que hago es utilizar mi función
	// double_mirror_loop para pintar primero con el color púrpura más oscuro. Esto hace que ya tenga pintado arriba y abajo un reflejo exactamente igual.
	// Luego, con la función mirror_loop pinto solo en la parte de arriba (con color púrpura claro) por encima de lo pintado anteriormente con púrpura oscuro.
	// De esta forma logro el efecto de que arriba sean colores más claros y luminosos, mientras que abajo son más oscuros y apagados.

dibujando_purpura_superior:    // Cargar color púrpura superior en x10

    stp x29, x30, [sp, #-16]! 
    movz x10, 0x3DA1, lsl 0	
    movk x10, 0xFF2B, lsl 16

    ldr x13, =purpura_superior_coords  // puntero a la tabla
    mov x14, #30                      // cantidad de entradas (30)

loop_purpura_superior:
    ldr w6, [x13], #4     // x_start
    ldr w7, [x13], #4     // x_end
    ldr w11, [x13], #4    // y_start

    bl mirror_loop

    subs x14, x14, #1
    b.ne loop_purpura_superior
	ldp x29, x30, [sp], #16    
    ret                        

//estrellas
dibujando_estrellas:
    stp x29, x30, [sp, #-16]! 
    ldr x19, =tabla_estrellas   
    mov x21, #79              

loop_dibujar_estrellas_interno:
    cbz x21, fin_dibujar_estrellas_con_color // contador = 0, salir

    ldr w6, [x19], #4           
    ldr w7, [x19], #4          
    ldr w11, [x19], #4         
    ldr w12, [x19], #4         

    bl mirror_loop      

    subs x21, x21, #1          
    b.ne loop_dibujar_estrellas_interno

fin_dibujar_estrellas_con_color:
    ldp x29, x30, [sp], #16    
    ret                        

		// ------------------- FONDO, LA PARTE DE LOS ARBUSTOS Y LA PARTE NEGRA DE ARRIBA DEL FONDO -------------------
dibujando_arbustos_y_fondo:

    stp x29, x30, [sp, #-16]!  
	//color negro = 0xFF000000
	movz x10, 0x0000, lsl 0	
	movk x10, 0xFF00, lsl 16

    mov x10, #0xFF000000     // Color negro
    movz x10, 0, lsl 0      

    ldr x19, =tabla_domo_arbustos   // dirección base de la tabla
    mov x21, #63           // número de entradas
	
loop_fondo_arbustos:
    cbz x21, fin_fondo_arbustos     // si x21 == 0, fin del loop

    ldr w6, [x19], #4               // cargar x_start, avanzar puntero 4 bytes
    ldr w7, [x19], #4               // cargar x_end
    ldr w11, [x19], #4              // cargar y_start
    ldr w12, [x19], #4              // cargar y_end

    bl double_mirror_loop           // llamada a función

    subs x21, x21, #1               // decrementar contador
    b.ne loop_fondo_arbustos

fin_fondo_arbustos:
	ldp x29, x30, [sp], #16    
    ret                        


	// ------------------- ÁRBOLES DEL FONDO, REFLEJADOS ARRIBA Y ABAJO -------------------
dibujando_arboles_fondo:

    stp x29, x30, [sp, #-16]!  
	// Determino que x10 sea el color negro = 0xFF000000
	// --- El siguiente código es para los árboles de la izquierda hacia la derecha ---
	// ACLARACIÓN: Ya que estoy usando la función double_mirror_loop, los árboles son de izquierda a derecha, hasta llegar a la mitad de la pantalla.
	// A partir de la mitad a la derecha, son un reflejo del lado izquierdo.  
    // Color negro = 0xFF000000
    movz x10, 0x0000, lsl #0
    movk x10, 0xFF00, lsl #16

    ldr x19, =tabla_arboles_fondo   // dirección de la tabla de árboles
    mov x21, #179                    // cantidad de entradas 

loop_arboles_fondo:
    cbz x21, fin_arboles_fondo

    ldr w6, [x19], #4   // x_start
    ldr w7, [x19], #4   // x_end
    ldr w11, [x19], #4  // y_start
    ldr w12, [x19], #4  // y_end

    bl double_mirror_loop

    subs x21, x21, #1
    b.ne loop_arboles_fondo

fin_arboles_fondo:
    ldp x29, x30, [sp], #16    
    ret                        

dibujando_ODC2025:

    stp x29, x30, [sp, #-16]! 
    // ---------------------- PARTE DE ODC ---------------------

    // ----------- Llamadas a double_mirror_loop -----------

    ldr x19, =tabla_dibujo_odc_double
    mov x21, #5   // cantidad de bloques

loop_odc_double:
    cbz x21, siguiente_only_y

    ldr w6, [x19], #4
    ldr w7, [x19], #4
    ldr w11, [x19], #4
    ldr w12, [x19], #4

    bl double_mirror_loop

    subs x21, x21, #1
    b.ne loop_odc_double

siguiente_only_y:

    // ----------- Llamadas a only_y_mirror_loop -----------

    ldr x19, =tabla_dibujo_odc_only_y
    mov x21, #14   // cantidad de bloques

loop_odc_only_y:
    cbz x21, fin_dibujando_ODC2025

    ldr w6, [x19], #4
    ldr w7, [x19], #4
    ldr w11, [x19], #4
    ldr w12, [x19], #4

    bl only_y_mirror_loop

    subs x21, x21, #1
    b.ne loop_odc_only_y

fin_dibujando_ODC2025:

	movz x5, 0x0000, lsl 0	
	movk x5, 0xFF00, lsl 16
	
    movz x5, 0x0000, lsl 0
    movk x5, 0xFF00, lsl 16

    ldr x19, =tabla_rectangulos
    mov x21, #28  // cantidad de rectángulos

loop_rectangulos:
    cbz x21, fin_rectangulos

    ldr w1, [x19], #4
    ldr w2, [x19], #4
    ldr w3, [x19], #4
    ldr w4, [x19], #4

    bl draw_rect

    subs x21, x21, #1
    b.ne loop_rectangulos

fin_rectangulos:
    ldp x29, x30, [sp], #16    
    ret                        

	// ------------------- PASTO EN EL QUE SE APOYAN LOS PERSONAJES -------------------
dibujando_pasto:

    stp x29, x30, [sp, #-16]! 
	// Pintaré el pasto utilizando la función draw_rect. Elegí esta ya que al ser una imagen pixelada, y el pasto no tener un patrón definido, es lo que más cómodo queda.
    // Color verde oscuro = 0xFF35656F
    movz x5, 0x656F, lsl #0
    movk x5, 0xFF35, lsl #16

    ldr x19, =tabla_pasto        // dirección de la tabla con los datos
    mov x21, #42                // cantidad de entradas (número de rectángulos)

loop_pasto:
    cbz x21, fin_pasto

    ldr w1, [x19], #4          // x_start
    ldr w2, [x19], #4          // y_start
    ldr w3, [x19], #4          // ancho
    ldr w4, [x19], #4          // alto

    bl draw_rect

    subs x21, x21, #1
    b.ne loop_pasto

fin_pasto:
    ldp x29, x30, [sp], #16    
    ret                        

/////////////////DEMOGORGON/////////////////////

draw_demogorgon:

    stp x29, x30, [sp, #-16]!  
 // demogorgon
	mov x0, x20
//Demogorgon - cuerpo
	movz w5, #0x4379, lsl #0
	movk w5, #0xFF06, lsl #16

//tronco
	mov x1, #405 
	mov x2, #350 
	mov x3, #42
	mov x4, #15
	bl draw_rect

	mov x1, #415 
	mov x2, #355 
	mov x3, #20
	mov x4, #20
	bl draw_rect

	mov x1, #411 
	mov x2, #347 
	mov x3, #6
	mov x4, #3
	bl draw_rect

	mov x1, #417 
	mov x2, #344 
	mov x3, #6
	mov x4, #6
	bl draw_rect

	mov x1, #423
	mov x2, #338 
	mov x3, #24
	mov x4, #12
	bl draw_rect

	mov x1, #429 
	mov x2, #332
	mov x3, #6
	mov x4, #6
	bl draw_rect

	mov x1, #435 
	mov x2, #329 
	mov x3, #6
	mov x4, #9
	bl draw_rect

	mov x1, #441 
	mov x2, #335 
	mov x3, #6
	mov x4, #3
	bl draw_rect

//panza
	movz w5, #0x1738, lsl #0
	movk w5, #0xFF00, lsl #16

	mov x1, #402 
	mov x2, #344 
	mov x3, #3
	mov x4, #15
	bl draw_rect

	mov x1, #405 
	mov x2, #347 
	mov x3, #6
	mov x4, #3
	bl draw_rect

	mov x1, #405 
	mov x2, #332 
	mov x3, #12
	mov x4, #15
	bl draw_rect

	mov x1, #417 
	mov x2, #338 
	mov x3, #6
	mov x4, #6
	bl draw_rect

	mov x1, #414 
	mov x2, #326 
	mov x3, #15
	mov x4, #12
	bl draw_rect

	mov x1, #411 
	mov x2, #329 
	mov x3, #6
	mov x4, #3
	bl draw_rect

	mov x1, #426 
	mov x2, #323 
	mov x3, #9
	mov x4, #9
	bl draw_rect

	mov x1, #432 
	mov x2, #317
	mov x3, #9
	mov x4, #12
	bl draw_rect

	mov x1, #441 
	mov x2, #323 
	mov x3, #6
	mov x4, #12
	bl draw_rect

	mov x1, #438
	mov x2, #314 
	mov x3, #6
	mov x4, #3
	bl draw_rect

	mov x1, #438 
	mov x2, #308 
	mov x3, #9
	mov x4, #6
	bl draw_rect

	mov x1, #447 
	mov x2, #302 
	mov x3, #6
	mov x4, #9
	bl draw_rect

	mov x1, #450 
	mov x2, #296 
	mov x3, #3
	mov x4, #6
	bl draw_rect

	mov x1, #414 
	mov x2, #320 
	mov x3, #6
	mov x4, #6
	bl draw_rect

	mov x1, #411 
	mov x2, #320 
	mov x3, #3
	mov x4, #3
	bl draw_rect

	mov x1, #408 
	mov x2, #311 
	mov x3, #6
	mov x4, #9
	bl draw_rect

	mov x1, #405 
	mov x2, #308 
	mov x3, #3
	mov x4, #9
	bl draw_rect


	//piernas

	
	movz w5, #0x4379, lsl #0
	movk w5, #0xFF06, lsl #16

	mov x1, #420 
	mov x2, #323 
	mov x3, #6
	mov x4, #3
	bl draw_rect

	mov x1, #414 
	mov x2, #317 
	mov x3, #6
	mov x4, #3
	bl draw_rect

	mov x1, #420 
	mov x2, #317 
	mov x3, #12
	mov x4, #9
	bl draw_rect

	mov x1, #414 
	mov x2, #311 
	mov x3, #24
	mov x4, #6
	bl draw_rect

	mov x1, #414
	mov x2, #302 
	mov x3, #6
	mov x4, #9
	bl draw_rect


	mov x1, #408 
	mov x2, #302 
	mov x3, #6
	mov x4, #12
	bl draw_rect

	mov x1, #402 
	mov x2, #293 
	mov x3, #9
	mov x4, #18
	bl draw_rect

	mov x1, #405 
	mov x2, #284 
	mov x3, #6
	mov x4, #9
	bl draw_rect

	mov x1, #408 
	mov x2, #281 
	mov x3, #6
	mov x4, #6
	bl draw_rect
	

	mov x1, #408 
	mov x2, #285 
	mov x3, #6
	mov x4, #12
	bl draw_rect


	mov x1, #408 
	mov x2, #273
	mov x3, #6
	mov x4, #24
	bl draw_rect


	mov x1, #405
	mov x2, #280 
	mov x3, #6
	mov x4, #6
	bl draw_rect


	mov x1, #412 
	mov x2, #258
	mov x3, #4
	mov x4, #15
	bl draw_rect


	mov x1, #415 
	mov x2, #255 
	mov x3, #6
	mov x4, #6
	bl draw_rect


	mov x1, #405 
	mov x2, #252
	mov x3, #15
	mov x4, #6
	bl draw_rect


	mov x1, #405 
	mov x2, #252 
	mov x3, #4
	mov x4, #8
	bl draw_rect

//detalles pierna izquierda
	movz w5, #0x1738, lsl #0
	movk w5, #0xFF00, lsl #16
	mov x1, #408 
	mov x2, #281 
	mov x3, #6
	mov x4, #9
	bl draw_rect

	mov x1, #411 
	mov x2, #275 
	mov x3, #3
	mov x4, #6
	bl draw_rect

	mov x1, #414 
	mov x2, #269
	mov x3, #3
	mov x4, #9
	bl draw_rect


//pierna derecha

	movz w5, #0x4379, lsl #0
	movk w5, #0xFF06, lsl #16

	mov x1, #435 
	mov x2, #305 
	mov x3, #9
	mov x4, #9
	bl draw_rect

	mov x1, #441 
	mov x2, #299 
	mov x3, #9
	mov x4, #9
	bl draw_rect

	mov x1, #444
	mov x2, #293 
	mov x3, #12
	mov x4, #6
	bl draw_rect

	mov x1, #447 
	mov x2, #285 
	mov x3, #15
	mov x4, #9
	bl draw_rect

	mov x1, #453 
	mov x2, #276 
	mov x3, #9
	mov x4, #18
	bl draw_rect

	mov x1, #453 
	mov x2, #267 
	mov x3, #6
	mov x4, #9
	bl draw_rect

	mov x1, #453
	mov x2, #264 
	mov x3, #3
	mov x4, #3
	bl draw_rect

	mov x1, #447 
	mov x2, #280 
	mov x3, #6
	mov x4, #3
	bl draw_rect

	mov x1, #446
	mov x2, #250 
	mov x3, #12
	mov x4, #4
	bl draw_rect

	mov x1, #456
	mov x2, #250 
	mov x3, #3
	mov x4, #6
	bl draw_rect

//otro color para detalles
	movz w5, #0x1738, lsl #0
	movk w5, #0xFF00, lsl #16

	mov x1, #447 
	mov x2, #283 
	mov x3, #6
	mov x4, #3
	bl draw_rect

	mov x1, #444 
	mov x2, #280 
	mov x3, #3
	mov x4, #3
	bl draw_rect

	mov x1, #447 
	mov x2, #259 
	mov x3, #6
	mov x4, #20
	bl draw_rect

	mov x1, #447
	mov x2, #253 
	mov x3, #3
	mov x4, #6
	bl draw_rect

	mov x1, #444 
	mov x2, #253 
	mov x3, #3
	mov x4, #6
	bl draw_rect

//brazo derecho

	movz w5, #0x4379, lsl #0
	movk w5, #0xFF06, lsl #16

	mov x1, #445 
	mov x2, #358 
	mov x3, #6
	mov x4, #6
	bl draw_rect

	mov x1, #447
	mov x2, #355 
	mov x3, #15
	mov x4, #6
	bl draw_rect

	mov x1, #450 
	mov x2, #349 
	mov x3, #12
	mov x4, #12
	bl draw_rect

	mov x1, #455 
	mov x2, #345 
	mov x3, #12
	mov x4, #6
	bl draw_rect

	mov x1, #458 
	mov x2, #339 
	mov x3, #12
	mov x4, #12
	bl draw_rect


	mov x1, #461 
	mov x2, #333 
	mov x3, #12
	mov x4, #6
	bl draw_rect

	mov x1, #464 
	mov x2, #327 
	mov x3, #12
	mov x4, #6
	bl draw_rect

	mov x1, #467 
	mov x2, #321
	mov x3, #12
	mov x4, #6
	bl draw_rect

	mov x1, #473 
	mov x2, #315 
	mov x3, #12
	mov x4, #6
	bl draw_rect

	mov x1, #479
	mov x2, #309 
	mov x3, #12
	mov x4, #6
	bl draw_rect


	mov x1, #485
	mov x2, #313 
	mov x3, #6
	mov x4, #3
	bl draw_rect


//mano derecha

	movz w5, #0x4379, lsl #0
	movk w5, #0xFF06, lsl #16
	mov x1, #485 
	mov x2, #297
	mov x3, #6
	mov x4, #18
	bl draw_rect

	mov x1, #485 
	mov x2, #291 
	mov x3, #3
	mov x4, #6
	bl draw_rect

	mov x1, #482 
	mov x2, #288 
	mov x3, #3
	mov x4, #6
	bl draw_rect

	mov x1, #491 
	mov x2, #300 
	mov x3, #3
	mov x4, #6
	bl draw_rect

	mov x1, #494 
	mov x2, #300 
	mov x3, #3
	mov x4, #3
	bl draw_rect

	mov x1, #494
	mov x2, #294 
	mov x3, #6
	mov x4, #6
	bl draw_rect

	mov x1, #499 
	mov x2, #294 
	mov x3, #3
	mov x4, #3
	bl draw_rect

	mov x1, #499 
	mov x2, #291 
	mov x3, #9
	mov x4, #3
	bl draw_rect

	mov x1, #499 
	mov x2, #285 
	mov x3, #3
	mov x4, #12
	bl draw_rect

	mov x1, #505 
	mov x2, #285 
	mov x3, #3
	mov x4, #9
	bl draw_rect


// brazo izquierdo
	mov x1, #393 
	mov x2, #355
	mov x3, #12
	mov x4, #6
	bl draw_rect

	mov x1, #390 
	mov x2, #334 
	mov x3, #9
	mov x4, #21
	bl draw_rect

	mov x1, #384 
	mov x2, #330 
	mov x3, #12
	mov x4, #6
	bl draw_rect

	mov x1, #381 
	mov x2, #324 
	mov x3, #9
	mov x4, #9
	bl draw_rect

	mov x1, #378 
	mov x2, #321 
	mov x3, #6
	mov x4, #6
	bl draw_rect

	mov x1, #378 
	mov x2, #319 
	mov x3, #3
	mov x4, #3
	bl draw_rect


	mov x1, #372 
	mov x2, #317 
	mov x3, #6
	mov x4, #6
	bl draw_rect

	//mano izquierda
	mov x1, #372
	mov x2, #296 
	mov x3, #3
	mov x4, #21
	bl draw_rect

	mov x1, #375 
	mov x2, #290 
	mov x3, #3
	mov x4, #12
	bl draw_rect

	mov x1, #366
	mov x2, #302 
	mov x3, #9
	mov x4, #9
	bl draw_rect

	mov x1, #363 
	mov x2, #299 
	mov x3, #6
	mov x4, #6
	bl draw_rect

	mov x1, #360 
	mov x2, #290 
	mov x3, #3
	mov x4, #15
	bl draw_rect

	mov x1, #360 
	mov x2, #290 
	mov x3, #3
	mov x4, #15
	bl draw_rect

	mov x1, #354 
	mov x2, #290 
	mov x3, #3
	mov x4, #9
	bl draw_rect

	mov x1, #357 
	mov x2, #296 
	mov x3, #6
	mov x4, #6
	bl draw_rect



// DEMOGORGON - CABEZA
// PETALO DERECHA ARRIBA

    mov x1, #440 
    mov x2, #372 
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle

    mov x1, #443 
    mov x2, #371 
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle

    mov x1, #442 
    mov x2, #373 
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle


//detalles
    mov x1, #445 
    mov x2, #369 
    mov x3, #5
    movz w5, #0x8BD1, lsl #0
    movk w5, #0xFF1A, lsl #16
    bl draw_circle

    mov x1, #441 
    mov x2, #373 
    mov x3, #8
    movz w5, #0x3A6C, lsl #0
    movk w5, #0xFF04, lsl #16
    bl draw_circle

    mov x1, #448
    mov x2, #372 
    mov x3, #2
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle

    mov x1, #441
    mov x2, #369
    mov x3, #1
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle




// PETALO DERECHA ABAJO

    mov x1, #440 
    mov x2, #390 
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle

    mov x1, #447 
    mov x2, #391 
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle

    mov x1, #443 
    mov x2, #391 
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle


//detalles
    mov x1, #450 
    mov x2, #390 
    mov x3, #5
    movz w5, #0x8BD1, lsl #0
    movk w5, #0xFF1A, lsl #16
    bl draw_circle

    mov x1, #450 
    mov x2, #391 
    mov x3, #5
    movz w5, #0x8BD1, lsl #0
    movk w5, #0xFF1A, lsl #16
    bl draw_circle

    mov x1, #444 
    mov x2, #391 
    mov x3, #8
    movz w5, #0x3A6C, lsl #0
    movk w5, #0xFF04, lsl #16
    bl draw_circle

    mov x1, #445 
    mov x2, #395 
    mov x3, #1
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle

    mov x1, #449 
    mov x2, #388 
    mov x3, #2
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle




// PETALO IZQUIERDA ARRIBA

    mov x1, #410 
    mov x2, #372 
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle

    mov x1, #407 
    mov x2, #371
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle

    mov x1, #408 
    mov x2, #373
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle


//detalles (reflejo de los de DERECHA ARRIBA)
    mov x1, #405 
    mov x2, #369 
    mov x3, #5
    movz w5, #0x8BD1, lsl #0
    movk w5, #0xFF1A, lsl #16
    bl draw_circle

    mov x1, #409
    mov x2, #373 
    mov x3, #8
    movz w5, #0x3A6C, lsl #0
    movk w5, #0xFF04, lsl #16
    bl draw_circle

    mov x1, #404 
    mov x2, #373 
    mov x3, #2
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle

    mov x1, #409 
    mov x2, #369 
    mov x3, #1
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle


// PETALO IZQUIERDA ABAJO

    mov x1, #410 
    mov x2, #390 
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle

    mov x1, #403 
    mov x2, #391
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle

    mov x1, #407 
    mov x2, #391 
    mov x3, #10
    movz w5, #0x1637, lsl #0
    bl draw_circle


//detalles (reflejo de los de DERECHA ABAJO)
    mov x1, #400 
    mov x2, #390 
    mov x3, #5
    movz w5, #0x8BD1, lsl #0
    movk w5, #0xFF1A, lsl #16
    bl draw_circle

    mov x1, #400 
    mov x2, #391 
    mov x3, #5
    movz w5, #0x8BD1, lsl #0
    movk w5, #0xFF1A, lsl #16
    bl draw_circle

    mov x1, #406 
    mov x2, #391 
    mov x3, #8
    movz w5, #0x3A6C, lsl #0
    movk w5, #0xFF04, lsl #16
    bl draw_circle

    mov x1, #405 
    mov x2, #392 
    mov x3, #1
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle

    mov x1, #403 
    mov x2, #388 
    mov x3, #1
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle

// Gran pétalo hacia abajo

    mov x1, #420 
    mov x2, #400 
    mov x3, #12
    movz w5, #0x1637, lsl #0
    bl draw_circle

    mov x1, #430 
    mov x2, #400 
    mov x3, #12
    movz w5, #0x1637, lsl #0
    bl draw_circle

    mov x1, #425 
    mov x2, #405 
    mov x3, #15
    movz w5, #0x1637, lsl #0
    bl draw_circle



  // Detalles 

    mov x1, #425 
    mov x2, #403 
    mov x3, #13
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle


    mov x1, #422 
    mov x2, #398 
    mov x3, #12
    movz w5, #0x3A6C, lsl #0
    movk w5, #0xFF04, lsl #16
    bl draw_circle

    mov x1, #427 
    mov x2, #398 
    mov x3, #12
    movz w5, #0x3A6C, lsl #0
    movk w5, #0xFF04, lsl #16
    bl draw_circle

    mov x1, #425 
    mov x2, #401 
    mov x3, #12
    movz w5, #0x3A6C, lsl #0
    movk w5, #0xFF04, lsl #16
    bl draw_circle



    mov x1, #431 
    mov x2, #408 
    mov x3, #1
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle

    mov x1, #418 
    mov x2, #407 
    mov x3, #1
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle

    mov x1, #425 
    mov x2, #404 
    mov x3, #1
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle

    mov x1, #422 
    mov x2, #410 
    mov x3, #1
    movz w5, #0x7BBC, lsl #0
    movk w5, #0xFF14, lsl #16
    bl draw_circle

// Centro de la cabeza

    mov x1, #425 
    mov x2, #385 
    mov x3, #20
    movz w5, #0x1C4A, lsl #0
    bl draw_circle

    mov x1, #425 
    mov x2, #385 
    mov x3, #15
    movz w5, #0x0014, lsl #0
    bl draw_circle

// Centro de la cabeza con profundidad
// Degradado
    //  Azul oscuro
    movz w5, #0x1C4A, lsl #0  
    movk w5, #0xFF00, lsl #16   
    mov x1, #425 
    mov x2, #385 
    mov x3, #20
    bl draw_circle

    // Azul más oscuro, un poco menos azul
    movz w5, #0x163D, lsl #0  
    movk w5, #0xFF00, lsl #16  
    mov x1, #425
    mov x2, #385 
    mov x3, #18
    bl draw_circle

    // Azul casi negro
    movz w5, #0x0A21, lsl #0   
    movk w5, #0xFF00, lsl #16    
    mov x1, #425 
    mov x2, #385
    mov x3, #16
    bl draw_circle

    //  Negro con un poco de azul
    movz w5, #0x0408, lsl #0 
    movk w5, #0xFF00, lsl #16  
    mov x1, #425 
    mov x2, #385 
    mov x3, #14
    bl draw_circle

    // Negro puro
    movz w5, #0x0000, lsl #0 
    movk w5, #0xFF00, lsl #16
    mov x1, #425 
    mov x2, #385 
    mov x3, #12
    bl draw_circle

    // Negro con rojo leve 
    movz w5, #0x0100, lsl #0  
    movk w5, #0xFF00, lsl #16     
    mov x1, #425 
    mov x2, #385 
    mov x3, #10
    bl draw_circle

    // Capa 7 
    movz w5, #0x0000, lsl #0
    movk w5, #0xFF33, lsl #16     
    mov x1, #425 
    mov x2, #385 
    mov x3, #8
    bl draw_circle

    // Capa 8 - Rojo bordó oscuro
    movz w5, #0x0000, lsl #0
    movk w5, #0xFF55, lsl #16 
    mov x1, #425 
    mov x2, #385
    mov x3, #6
    bl draw_circle

    // 
    movz w5, #0x0000, lsl #0
    movk w5, #0xFF77, lsl #16 
    mov x1, #425 
    mov x2, #385 
    mov x3, #4
    bl draw_circle

    //  Rojo bordó 
    movz w5, #0x0000, lsl #0
    movk w5, #0xFF99, lsl #16 
    mov x1, #425
    mov x2, #385
    mov x3, #2
    bl draw_circle

	
	movz w5, #0x90D6, lsl #0
	movk w5, #0xFF1B, lsl #16

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
	
    ldp x29, x30, [sp], #16    
    ret                        

 ////////////////////PERSONAJES////////////////////
	// personajes
dibujando_dustin:
    stp x29, x30, [sp, #-16]!  
	
    ldr x19, =tabla_dustin      // dirección tabla
    mov x21, #45               // cantidad de rectángulos 

loop_dustin:
    cbz x21, fin_dustin

    ldr x1, [x19], #8          // x_start (64 bits)
    ldr x2, [x19], #8          // y_start
    ldr x3, [x19], #8          // ancho
    ldr x4, [x19], #8          // alto
    ldr x5, [x19], #8          // color

    bl draw_rect

    subs x21, x21, #1
    b.ne loop_dustin

fin_dustin:
    ldp x29, x30, [sp], #16    
    ret                        
	
dibujando_will:

    stp x29, x30, [sp, #-16]!  
    ldr x19, =tabla_will      // dirección tabla
    mov x21, #34               // cantidad de rectángulos 

loop_will:
    cbz x21, fin_will

    ldr x1, [x19], #8          // x_start (64 bits)
    ldr x2, [x19], #8          // y_start
    ldr x3, [x19], #8          // ancho
    ldr x4, [x19], #8          // alto
    ldr x5, [x19], #8          // color

    bl draw_rect

    subs x21, x21, #1
    b.ne loop_will
fin_will:
    ldp x29, x30, [sp], #16    
    ret                        
	
dibujando_max:
    stp x29, x30, [sp, #-16]!  
	// Maxdibujando_max:
    ldr x19, =tabla_max       // dirección de la tabla
    mov x21, #29              // cantidad de rectángulos

loop_max:
    cbz x21, fin_max

    ldr x1, [x19], #8         // x_start
    ldr x2, [x19], #8         // y_start
    ldr x3, [x19], #8         // ancho
    ldr x4, [x19], #8         // alto
    ldr x5, [x19], #8         // color

    bl draw_rect

    subs x21, x21, #1
    b.ne loop_max
	
fin_max:
    ldp x29, x30, [sp], #16    
    ret                        

dibujando_lucas:
stp x29, x30, [sp, #-16]!  

    ldr x19, =tabla_lucas       // dirección de la tabla
    mov x21, #44              // cantidad de rectángulos 

loop_lucas:
    cbz x21, fin_lucas

    ldr x1, [x19], #8         // x_start
    ldr x2, [x19], #8         // y_start
    ldr x3, [x19], #8         // ancho
    ldr x4, [x19], #8         // alto
    ldr x5, [x19], #8         // color

    bl draw_rect

    subs x21, x21, #1
    b.ne loop_lucas
fin_lucas:
	ldp x29, x30, [sp], #16    
    ret                        


dibujando_eleven:
    stp x29, x30, [sp, #-16]!  
	// dibujando_eleven:
    ldr x19, =tabla_eleven       // dirección de la tabla
    mov x21, #29              // cantidad de rectángulos 

loop_eleven:
    cbz x21, fin_eleven

    ldr x1, [x19], #8         // x_start
    ldr x2, [x19], #8         // y_start
    ldr x3, [x19], #8         // ancho
    ldr x4, [x19], #8         // alto
    ldr x5, [x19], #8         // color

    bl draw_rect

    subs x21, x21, #1
    b.ne loop_eleven

fin_eleven:
    ldp x29, x30, [sp], #16    
    ret                        
	
dibujando_mike:

    stp x29, x30, [sp, #-16]! 
	// dibujando_mike:
    ldr x19, =tabla_mike       // dirección de la tabla
    mov x21, #39              // cantidad de rectángulos 

loop_mike:
    cbz x21, fin_mike

    ldr x1, [x19], #8         // x_start
    ldr x2, [x19], #8         // y_start
    ldr x3, [x19], #8         // ancho
    ldr x4, [x19], #8         // alto
    ldr x5, [x19], #8         // color

    bl draw_rect

    subs x21, x21, #1
    b.ne loop_mike

fin_mike:
    ldp x29, x30, [sp], #16    
    ret                        





animacion:

    stp x29, x30, [sp, #-16]!  
////////////////////////////////ANIMACIÓN////////////////////
// Delay 1 segundo
    movz x20, #15000, lsl #0
    movk x20, #49000, lsl 16
bl delay_loop

// Primer Movimiento
    mov x1, #414
    mov x2, #188
    mov x3, #4
    mov x4, #24
    movz x5, 0x3DC4, lsl #0
    movk x5, 0xFF5F, lsl #16
    bl draw_rect

    mov x1, #414
    mov x2, #212
    mov x3, #4
    mov x4, #4
    movz x5, 0xCCAA, lsl #0
    movk x5, 0xFFFF, lsl #16
    bl draw_rect

    mov x1, #418
    mov x2, #212
    mov x3, #4
    mov x4, #4
    movz x5, 0x0000, lsl #0
    movk x5, 0xFF00, lsl #16
    bl draw_rect

    // primera gota
    mov x1, #432
    mov x2, #166
    mov x3, #2
    mov x4, #2
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16
    bl draw_rect

// Will (Arriba 5ta oscura)        
    mov x1, #176
    mov x2, #148
    mov x3, #32
    mov x4, #28
    movz x5, 0x2018, lsl #0
    movk x5, 0xFF2C, lsl #16
    bl draw_rect

    mov x1, #180
    mov x2, #176
    mov x3, #24
    mov x4, #4
    movz x5, 0x2018, lsl #0
    movk x5, 0xFF2C, lsl #16
    bl draw_rect

    mov x1, #188
    mov x2, #180
    mov x3, #8
    mov x4, #4
    movz x5, 0x160D, lsl #0
    movk x5, 0xFF20, lsl #16
    bl draw_rect

    mov x1, #180
    mov x2, #140
    mov x3, #24
    mov x4, #4
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect

    mov x1, #176
    mov x2, #144
    mov x3, #32
    mov x4, #8
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect

    mov x1, #208
    mov x2, #148
    mov x3, #4
    mov x4, #28
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect

    mov x1, #172
    mov x2, #148
    mov x3, #4
    mov x4, #28
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect

    mov x1, #204
    mov x2, #168
    mov x3, #4
    mov x4, #12
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect

    mov x1, #176
    mov x2, #168
    mov x3, #4
    mov x4, #12
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect

    mov x1, #200
    mov x2, #176
    mov x3, #4
    mov x4, #4
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect

    mov x1, #180
    mov x2, #176
    mov x3, #4
    mov x4, #4
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect

    mov x1, #188
    mov x2, #152
    mov x3, #20
    mov x4, #4
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect

    mov x1, #200
    mov x2, #160
    mov x3, #4
    mov x4, #4
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect

    mov x1, #200
    mov x2, #156
    mov x3, #8
    mov x4, #4
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect

    mov x1, #176
    mov x2, #152
    mov x3, #4
    mov x4, #8
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect

    mov x1, #196
    mov x2, #164
    mov x3, #4
    mov x4, #4
    movz x5, 0x0101, lsl #0
    movk x5, 0xFF01, lsl #16
    bl draw_rect

    mov x1, #184
    mov x2, #164
    mov x3, #4
    mov x4, #4
    movz x5, 0x0101, lsl #0
    movk x5, 0xFF01, lsl #16
    bl draw_rect

    mov x1, #188
    mov x2, #172
    mov x3, #8
    mov x4, #4
    movz x5, 0x0804, lsl #0
    movk x5, 0xFF1A, lsl #16
    bl draw_rect

    mov x1, #176
    mov x2, #184
    mov x3, #32
    mov x4, #8
    movz x5, 0x0911, lsl #0
    movk x5, 0xFF04, lsl #16
    bl draw_rect

    mov x1, #180
    mov x2, #188
    mov x3, #24
    mov x4, #24
    movz x5, 0x0008, lsl #0
    movk x5, 0xFF17, lsl #16
    bl draw_rect

    mov x1, #196
    mov x2, #180
    mov x3, #4
    mov x4, #36
    movz x5, 0x0008, lsl #0
    movk x5, 0xFF17, lsl #16
    bl draw_rect

    mov x1, #184
    mov x2, #180
    mov x3, #4
    mov x4, #36
    movz x5, 0x0008, lsl #0
    movk x5, 0xFF17, lsl #16
    bl draw_rect

    mov x1, #188
    mov x2, #184
    mov x3, #8
    mov x4, #28
    movz x5, 0x1F1F, lsl #0
    movk x5, 0xFF1F, lsl #16
    bl draw_rect

    mov x1, #208
    mov x2, #188
    mov x3, #4
    mov x4, #24
    movz x5, 0x0911, lsl #0
    movk x5, 0xFF04, lsl #16
    bl draw_rect

    mov x1, #172
    mov x2, #188
    mov x3, #4
    mov x4, #24
    movz x5, 0x0911, lsl #0
    movk x5, 0xFF04, lsl #16
    bl draw_rect

    mov x1, #208
    mov x2, #196
    mov x3, #4
    mov x4, #16
    movz x5, 0x1F1F, lsl #0
    movk x5, 0xFF1F, lsl #16
    bl draw_rect
    
    mov x2, #196
    mov x3, #4
    mov x4, #16
    movz x5, 0x1F1F, lsl #0
    movk x5, 0xFF1F, lsl #16
    bl draw_rect

    mov x1, #204
    mov x2, #212
    mov x3, #4
    mov x4, #4
    movz x5, 0x2018, lsl #0
    movk x5, 0xFF2C, lsl #16
    bl draw_rect

    mov x1, #176
    mov x2, #212
    mov x3, #4
    mov x4, #4
    movz x5, 0x2018, lsl #0
    movk x5, 0xFF2C, lsl #16
    bl draw_rect

    mov x1, #196
    mov x2, #212
    mov x3, #4
    mov x4, #24
    movz x5, 0x0912, lsl #0
    movk x5, 0xFF06, lsl #16
    bl draw_rect

    mov x1, #184
    mov x2, #212
    mov x3, #4
    mov x4, #24
    movz x5, 0x0912, lsl #0
    movk x5, 0xFF06, lsl #16
    bl draw_rect

    mov x1, #196
    mov x2, #232
    mov x3, #8
    mov x4, #6
    movz x5, 0x1F1F, lsl #0
    movk x5, 0xFF1F, lsl #16
    bl draw_rect

    mov x1, #180
    mov x2, #232
    mov x3, #8
    mov x4, #6
    movz x5, 0x1F1F, lsl #0
    movk x5, 0xFF1F, lsl #16
    bl draw_rect

    // Will (Abajo 2do oscura)
    mov x1, #176
    mov x2, #304
    mov x3, #32
    mov x4, #24
    movz x5, 0x8066, lsl #0
    movk x5, 0xFFB8, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #300
    mov x3, #24
    mov x4, #4
    movz x5, 0x8066, lsl #0
    movk x5, 0xFFB8, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #296
    mov x3, #8
    mov x4, #4
    movz x5, 0x5A3F, lsl #0
    movk x5, 0xFF7A, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #336
    mov x3, #24
    mov x4, #4
    movz x5, 0x2A2A, lsl #0
    movk x5, 0xFF2A, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #328
    mov x3, #32
    mov x4, #8
    movz x5, 0x2A2A, lsl #0
    movk x5, 0xFF2A, lsl #16
    bl draw_rect
    mov x1, #172
    mov x2, #304
    mov x3, #4
    mov x4, #28
    movz x5, 0x2A2A, lsl #0
    movk x5, 0xFF2A, lsl #16
    bl draw_rect
    mov x1, #208
    mov x2, #304
    mov x3, #4
    mov x4, #28
    movz x5, 0x2A2A, lsl #0
    movk x5, 0xFF2A, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #300
    mov x3, #4
    mov x4, #12
    movz x5, 0x2A2A, lsl #0
    movk x5, 0xFF2A, lsl #16
    bl draw_rect
    mov x1, #204
    mov x2, #300
    mov x3, #4
    mov x4, #12
    movz x5, 0x2A2A, lsl #0
    movk x5, 0xFF2A, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #300
    mov x3, #4
    mov x4, #4
    movz x5, 0x2A2A, lsl #0
    movk x5, 0xFF2A, lsl #16
    bl draw_rect
    mov x1, #200
    mov x2, #300
    mov x3, #4
    mov x4, #4
    movz x5, 0x2A2A, lsl #0
    movk x5, 0xFF2A, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #320
    mov x3, #8
    mov x4, #8
    movz x5, 0x2A2A, lsl #0
    movk x5, 0xFF2A, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #316
    mov x3, #4
    mov x4, #4
    movz x5, 0x2A2A, lsl #0
    movk x5, 0xFF2A, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #324
    mov x3, #12
    mov x4, #4
    movz x5, 0x2A2A, lsl #0
    movk x5, 0xFF2A, lsl #16
    bl draw_rect
    mov x1, #204
    mov x2, #320
    mov x3, #4
    mov x4, #8
    movz x5, 0x2A2A, lsl #0
    movk x5, 0xFF2A, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #312
    mov x3, #4
    mov x4, #4
    movz x5, 0x1212, lsl #0
    movk x5, 0xFF12, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #312
    mov x3, #4
    mov x4, #4
    movz x5, 0x1212, lsl #0
    movk x5, 0xFF12, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #304
    mov x3, #8
    mov x4, #4
    movz x5, 0x3319, lsl #0
    movk x5, 0xFF60, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #288
    mov x3, #32
    mov x4, #8
    movz x5, 0x2C5A, lsl #0
    movk x5, 0xFF1A, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #268
    mov x3, #24
    mov x4, #24
    movz x5, 0x1122, lsl #0
    movk x5, 0xFF66, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #264
    mov x3, #4
    mov x4, #36
    movz x5, 0x1122, lsl #0
    movk x5, 0xFF66, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #264
    mov x3, #4
    mov x4, #36
    movz x5, 0x1122, lsl #0
    movk x5, 0xFF66, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #268
    mov x3, #8
    mov x4, #28
    movz x5, 0xD0D0, lsl #0
    movk x5, 0xFFD0, lsl #16
    bl draw_rect
    mov x1, #172
    mov x2, #268
    mov x3, #4
    mov x4, #24
    movz x5, 0x2C5A, lsl #0
    movk x5, 0xFF1A, lsl #16
    bl draw_rect
    mov x1, #208
    mov x2, #268
    mov x3, #4
    mov x4, #24
    movz x5, 0x2C5A, lsl #0
    movk x5, 0xFF1A, lsl #16
    bl draw_rect
    mov x1, #172
    mov x2, #268
    mov x3, #4
    mov x4, #16
    movz x5, 0xD0D0, lsl #0
    movk x5, 0xFFD0, lsl #16
    bl draw_rect
    mov x1, #208
    mov x2, #268
    mov x3, #4
    mov x4, #16
    movz x5, 0xD0D0, lsl #0
    movk x5, 0xFFD0, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #264
    mov x3, #4
    mov x4, #4
    movz x5, 0x8066, lsl #0
    movk x5, 0xFFB8, lsl #16
    bl draw_rect
    mov x1, #204
    mov x2, #264
    mov x3, #4
    mov x4, #4
    movz x5, 0x8066, lsl #0
    movk x5, 0xFFB8, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #248
    mov x3, #4
    mov x4, #20
    movz x5, 0x2E55, lsl #0
    movk x5, 0xFF20, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #248
    mov x3, #4
    mov x4, #20
    movz x5, 0x2E55, lsl #0
    movk x5, 0xFF20, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #244
    mov x3, #8
    mov x4, #6
    movz x5, 0xB0B0, lsl #0
    movk x5, 0xFFB0, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #244
    mov x3, #8
    mov x4, #6
    movz x5, 0xB0B0, lsl #0
    movk x5, 0xFFB0, lsl #16
    bl draw_rect

    // Delay 1 segundo
        movz x20, #15000, lsl #0
        movk x20, #49000, lsl 16
    bl delay_loop

    // Segundo Movimiento
        mov x1, #414
        mov x2, #188
        mov x3, #4
        mov x4, #24
        movz x5, 0x3DC4, lsl #0
        movk x5, 0xFF5F, lsl #16
        bl draw_rect

        mov x1, #410
        mov x2, #212
        mov x3, #4
        mov x4, #4
        movz x5, 0xCCAA, lsl #0
        movk x5, 0xFFFF, lsl #16
        bl draw_rect

        mov x1, #414
        mov x2, #212
        mov x3, #4
        mov x4, #4
        movz x5, 0x3DA1, lsl #0
        movk x5, 0xFF2B, lsl #16
        bl draw_rect

        // segunda gota
        mov x1, #432
        mov x2, #168
        mov x3, #2
        mov x4, #2
        movz x5, 0x0000, lsl #0
        movk x5, 0xFFFF, lsl #16
        bl draw_rect

    // Will (Arriba 4to oscuro)
            mov x1, #176
    mov x2, #148
    mov x3, #32
    mov x4, #28
    movz x5, 0x4532, lsl #0
    movk x5, 0xFF5E, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #176
    mov x3, #24
    mov x4, #4
    movz x5, 0x4532, lsl #0
    movk x5, 0xFF5E, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #180
    mov x3, #8
    mov x4, #4
    movz x5, 0x321B, lsl #0
    movk x5, 0xFF4B, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #140
    mov x3, #24
    mov x4, #4
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #144
    mov x3, #32
    mov x4, #8
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #208
    mov x2, #148
    mov x3, #4
    mov x4, #28
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #172
    mov x2, #148
    mov x3, #4
    mov x4, #28
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #204
    mov x2, #168
    mov x3, #4
    mov x4, #12
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #168
    mov x3, #4
    mov x4, #12
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #200
    mov x2, #176
    mov x3, #4
    mov x4, #4
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #176
    mov x3, #4
    mov x4, #4
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #152
    mov x3, #20
    mov x4, #4
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #200
    mov x2, #160
    mov x3, #4
    mov x4, #4
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #200
    mov x2, #156
    mov x3, #8
    mov x4, #4
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #152
    mov x3, #4
    mov x4, #8
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #164
    mov x3, #4
    mov x4, #4
    movz x5, 0x0303, lsl #0
    movk x5, 0xFF03, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #164
    mov x3, #4
    mov x4, #4
    movz x5, 0x0303, lsl #0
    movk x5, 0xFF03, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #172
    mov x3, #8
    mov x4, #4
    movz x5, 0x1107, lsl #0
    movk x5, 0xFF30, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #184
    mov x3, #32
    mov x4, #8
    movz x5, 0x1025, lsl #0
    movk x5, 0xFF06, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #188
    mov x3, #24
    mov x4, #24
    movz x5, 0x0011, lsl #0
    movk x5, 0xFF2A, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #180
    mov x3, #4
    mov x4, #36
    movz x5, 0x0011, lsl #0
    movk x5, 0xFF2A, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #180
    mov x3, #4
    mov x4, #36
    movz x5, 0x0011, lsl #0
    movk x5, 0xFF2A, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #184
    mov x3, #8
    mov x4, #28
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #208
    mov x2, #188
    mov x3, #4
    mov x4, #24
    movz x5, 0x1025, lsl #0
    movk x5, 0xFF06, lsl #16
    bl draw_rect
    mov x1, #172
    mov x2, #188
    mov x3, #4
    mov x4, #24
    movz x5, 0x1025, lsl #0
    movk x5, 0xFF06, lsl #16
    bl draw_rect
    mov x1, #208
    mov x2, #196
    mov x3, #4
    mov x4, #16
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #172
    mov x2, #196
    mov x3, #4
    mov x4, #16
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #204
    mov x2, #212
    mov x3, #4
    mov x4, #4
    movz x5, 0x4532, lsl #0
    movk x5, 0xFF5E, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #212
    mov x3, #4
    mov x4, #4
    movz x5, 0x4532, lsl #0
    movk x5, 0xFF5E, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #212
    mov x3, #4
    mov x4, #24
    movz x5, 0x0F24, lsl #0
    movk x5, 0xFF0A, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #212
    mov x3, #4
    mov x4, #24
    movz x5, 0x0F24, lsl #0
    movk x5, 0xFF0A, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #232
    mov x3, #8
    mov x4, #6
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #232
    mov x3, #8
    mov x4, #6
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect

    // Will (Abajo 3ero oscuro)
            mov x1, #176
    mov x2, #304
    mov x3, #32
    mov x4, #24
    movz x5, 0x4033, lsl #0
    movk x5, 0xFF7F, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #300
    mov x3, #24
    mov x4, #4
    movz x5, 0x4033, lsl #0
    movk x5, 0xFF7F, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #296
    mov x3, #8
    mov x4, #4
    movz x5, 0x2D22, lsl #0
    movk x5, 0xFF4C, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #336
    mov x3, #24
    mov x4, #4
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #328
    mov x3, #32
    mov x4, #8
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #172
    mov x2, #304
    mov x3, #4
    mov x4, #28
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #208
    mov x2, #304
    mov x3, #4
    mov x4, #28
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #300
    mov x3, #4
    mov x4, #12
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #204
    mov x2, #300
    mov x3, #4
    mov x4, #12
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #300
    mov x3, #4
    mov x4, #4
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #200
    mov x2, #300
    mov x3, #4
    mov x4, #4
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #320
    mov x3, #8
    mov x4, #8
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #316
    mov x3, #4
    mov x4, #4
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #324
    mov x3, #12
    mov x4, #4
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #204
    mov x2, #320
    mov x3, #4
    mov x4, #8
    movz x5, 0x1111, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #312
    mov x3, #4
    mov x4, #4
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #312
    mov x3, #4
    mov x4, #4
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #304
    mov x3, #8
    mov x4, #4
    movz x5, 0x2010, lsl #0
    movk x5, 0xFF50, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #288
    mov x3, #32
    mov x4, #8
    movz x5, 0x1B35, lsl #0
    movk x5, 0xFF10, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #268
    mov x3, #24
    mov x4, #24
    movz x5, 0x0011, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #264
    mov x3, #4
    mov x4, #36
    movz x5, 0x0011, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #264
    mov x3, #4
    mov x4, #36
    movz x5, 0x0011, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #268
    mov x3, #8
    mov x4, #28
    movz x5, 0x8888, lsl #0
    movk x5, 0xFF88, lsl #16
    bl draw_rect
    mov x1, #172
    mov x2, #268
    mov x3, #4
    mov x4, #24
    movz x5, 0x1B35, lsl #0
    movk x5, 0xFF10, lsl #16
    bl draw_rect
    mov x1, #208
    mov x2, #268
    mov x3, #4
    mov x4, #24
    movz x5, 0x1B35, lsl #0
    movk x5, 0xFF10, lsl #16
    bl draw_rect
    mov x1, #172
    mov x2, #268
    mov x3, #4
    mov x4, #16
    movz x5, 0x8888, lsl #0
    movk x5, 0xFF88, lsl #16
    bl draw_rect
    mov x1, #208
    mov x2, #268
    mov x3, #4
    mov x4, #16
    movz x5, 0x8888, lsl #0
    movk x5, 0xFF88, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #264
    mov x3, #4
    mov x4, #4
    movz x5, 0x4033, lsl #0
    movk x5, 0xFF7F, lsl #16
    bl draw_rect
    mov x1, #204
    mov x2, #264
    mov x3, #4
    mov x4, #4
    movz x5, 0x4033, lsl #0
    movk x5, 0xFF7F, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #248
    mov x3, #4
    mov x4, #20
    movz x5, 0x1D39, lsl #0
    movk x5, 0xFF15, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #248
    mov x3, #4
    mov x4, #20
    movz x5, 0x1D39, lsl #0
    movk x5, 0xFF15, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #244
    mov x3, #8
    mov x4, #6
    movz x5, 0x7A7A, lsl #0
    movk x5, 0xFF7A, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #244
    mov x3, #8
    mov x4, #6
    movz x5, 0x7A7A, lsl #0
    movk x5, 0xFF7A, lsl #16
    bl draw_rect

    // Delay 1 segundo
        movz x20, #15000, lsl #0
        movk x20, #49000, lsl 16
    bl delay_loop

    // Tercer Movimiento
        mov x1, #414
        mov x2, #188
        mov x3, #4
        mov x4, #8
        movz x5, 0x3DC4, lsl #0
        movk x5, 0xFF5F, lsl #16
        bl draw_rect

        mov x1, #410
        mov x2, #188
        mov x3, #4
        mov x4, #16
        movz x5, 0x3DC4, lsl #0
        movk x5, 0xFF5F, lsl #16
        bl draw_rect

        mov x1, #406
        mov x2, #200
        mov x3, #4
        mov x4, #12
        movz x5, 0x3DC4, lsl #0
        movk x5, 0xFF5F, lsl #16
        bl draw_rect

        mov x1, #402
        mov x2, #212
        mov x3, #4
        mov x4, #4
        movz x5, 0xCCAA, lsl #0
        movk x5, 0xFFFF, lsl #16
        bl draw_rect

        mov x1, #410
        mov x2, #212
        mov x3, #4
        mov x4, #4
        movz x5, 0x0000, lsl #0
        movk x5, 0xFF00, lsl #16
        bl draw_rect

        mov x1, #414
        mov x2, #196
        mov x3, #4
        mov x4, #16
        movz x5, 0x3DA1, lsl #0
        movk x5, 0xFF2B, lsl #16
        bl draw_rect

        // tercera gota
        mov x1, #432
        mov x2, #170
        mov x3, #2
        mov x4, #2
        movz x5, 0x0000, lsl #0
        movk x5, 0xFFFF, lsl #16
        bl draw_rect

    // Will (Arriba 3ero oscuro)
            mov x1, #176
    mov x2, #148
    mov x3, #32
    mov x4, #28
    movz x5, 0x7254, lsl #0
    movk x5, 0xFF93, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #176
    mov x3, #24
    mov x4, #4
    movz x5, 0x7254, lsl #0
    movk x5, 0xFF93, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #180
    mov x3, #8
    mov x4, #4
    movz x5, 0x4C2C, lsl #0
    movk x5, 0xFF6F, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #140
    mov x3, #24
    mov x4, #4
    movz x5, 0x1F1F, lsl #0
    movk x5, 0xFF1F, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #144
    mov x3, #32
    mov x4, #8
    movz x5, 0x1F1F, lsl #0
    movk x5, 0xFF1F, lsl #16
    bl draw_rect
    mov x1, #208
    mov x2, #148
    mov x3, #4
    mov x4, #28
    movz x5, 0x1F1F, lsl #0
    movk x5, 0xFF1F, lsl #16
    bl draw_rect
    mov x1, #172
    mov x2, #148
    mov x3, #4
    mov x4, #28
    movz x5, 0x1F1F, lsl #0
    movk x5, 0xFF1F, lsl #16
    bl draw_rect
    mov x1, #204
    mov x2, #168
    mov x3, #4
    mov x4, #12
    movz x5, 0x1F1F, lsl #0
    movk x5, 0xFF1F, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #168
    mov x3, #4
    mov x4, #12
    movz x5, 0x1F1F, lsl #0
    movk x5, 0xFF1F, lsl #16
    bl draw_rect
    mov x1, #200
    mov x2, #176
    mov x3, #4
    mov x4, #4
    movz x5, 0x1F1F, lsl #0
    movk x5, 0xFF1F, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #176
    mov x3, #4
    mov x4, #4
    movz x5, 0x1F1F, lsl #0
    movk x5, 0xFF1F, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #152
    mov x3, #20
    mov x4, #4
    movz x5, 0x1F1F, lsl #0
    movk x5, 0xFF1F, lsl #16
    bl draw_rect
    mov x1, #200
    mov x2, #160
    mov x3, #4
    mov x4, #4
    movz x5, 0x1F1F, lsl #0
    movk x5, 0xFF1F, lsl #16
    bl draw_rect
    mov x1, #200
    mov x2, #156
    mov x3, #8
    mov x4, #4
    movz x5, 0x1F1F, lsl #0
    movk x5, 0xFF1F, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #152
    mov x3, #4
    mov x4, #8
    movz x5, 0x1F1F, lsl #0
    movk x5, 0xFF1F, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #164
    mov x3, #4
    mov x4, #4
    movz x5, 0x0707, lsl #0
    movk x5, 0xFF07, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #164
    mov x3, #4
    mov x4, #4
    movz x5, 0x0707, lsl #0
    movk x5, 0xFF07, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #172
    mov x3, #8
    mov x4, #4
    movz x5, 0x1F0E, lsl #0
    movk x5, 0xFF4E, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #184
    mov x3, #32
    mov x4, #8
    movz x5, 0x1A3B, lsl #0
    movk x5, 0xFF0D, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #188
    mov x3, #24
    mov x4, #24
    movz x5, 0x0016, lsl #0
    movk x5, 0xFF4A, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #180
    mov x3, #4
    mov x4, #36
    movz x5, 0x0016, lsl #0
    movk x5, 0xFF4A, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #180
    mov x3, #4
    mov x4, #36
    movz x5, 0x0016, lsl #0
    movk x5, 0xFF4A, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #184
    mov x3, #8
    mov x4, #28
    movz x5, 0x8888, lsl #0
    movk x5, 0xFF88, lsl #16
    bl draw_rect
    mov x1, #208
    mov x2, #188
    mov x3, #4
    mov x4, #24
    movz x5, 0x1A3B, lsl #0
    movk x5, 0xFF0D, lsl #16
    bl draw_rect
    mov x1, #172
    mov x2, #188
    mov x3, #4
    mov x4, #24
    movz x5, 0x1A3B, lsl #0
    movk x5, 0xFF0D, lsl #16
    bl draw_rect
    mov x1, #208
    mov x2, #196
    mov x3, #4
    mov x4, #16
    movz x5, 0x8888, lsl #0
    movk x5, 0xFF88, lsl #16
    bl draw_rect
    mov x1, #172
    mov x2, #196
    mov x3, #4
    mov x4, #16
    movz x5, 0x8888, lsl #0
    movk x5, 0xFF88, lsl #16
    bl draw_rect
    mov x1, #204
    mov x2, #212
    mov x3, #4
    mov x4, #4
    movz x5, 0x7254, lsl #0
    movk x5, 0xFF93, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #212
    mov x3, #4
    mov x4, #4
    movz x5, 0x7254, lsl #0
    movk x5, 0xFF93, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #212
    mov x3, #4
    mov x4, #24
    movz x5, 0x1C38, lsl #0
    movk x5, 0xFF14, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #212
    mov x3, #4
    mov x4, #24
    movz x5, 0x1C38, lsl #0
    movk x5, 0xFF14, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #232
    mov x3, #8
    mov x4, #6
    movz x5, 0x8888, lsl #0
    movk x5, 0xFF88, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #232
    mov x3, #8
    mov x4, #6
    movz x5, 0x8888, lsl #0
    movk x5, 0xFF88, lsl #16
    bl draw_rect

    // Will (Abajo 4to oscuro)
            mov x1, #176
    mov x2, #304
    mov x3, #32
    mov x4, #24
    movz x5, 0x2018, lsl #0
    movk x5, 0xFF40, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #300
    mov x3, #24
    mov x4, #4
    movz x5, 0x2018, lsl #0
    movk x5, 0xFF40, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #296
    mov x3, #8
    mov x4, #4
    movz x5, 0x1710, lsl #0
    movk x5, 0xFF26, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #336
    mov x3, #24
    mov x4, #4
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #328
    mov x3, #32
    mov x4, #8
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect
    mov x1, #172
    mov x2, #304
    mov x3, #4
    mov x4, #28
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect
    mov x1, #208
    mov x2, #304
    mov x3, #4
    mov x4, #28
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #300
    mov x3, #4
    mov x4, #12
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect
    mov x1, #204
    mov x2, #300
    mov x3, #4
    mov x4, #12
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #300
    mov x3, #4
    mov x4, #4
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect
    mov x1, #200
    mov x2, #300
    mov x3, #4
    mov x4, #4
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #320
    mov x3, #8
    mov x4, #8
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #316
    mov x3, #4
    mov x4, #4
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #324
    mov x3, #12
    mov x4, #4
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect
    mov x1, #204
    mov x2, #320
    mov x3, #4
    mov x4, #8
    movz x5, 0x0808, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #312
    mov x3, #4
    mov x4, #4
    movz x5, 0x0303, lsl #0
    movk x5, 0xFF03, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #312
    mov x3, #4
    mov x4, #4
    movz x5, 0x0303, lsl #0
    movk x5, 0xFF03, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #304
    mov x3, #8
    mov x4, #4
    movz x5, 0x1008, lsl #0
    movk x5, 0xFF30, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #288
    mov x3, #32
    mov x4, #8
    movz x5, 0x0F1A, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #268
    mov x3, #24
    mov x4, #24
    movz x5, 0x0008, lsl #0
    movk x5, 0xFF22, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #264
    mov x3, #4
    mov x4, #36
    movz x5, 0x0008, lsl #0
    movk x5, 0xFF22, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #264
    mov x3, #4
    mov x4, #36
    movz x5, 0x0008, lsl #0
    movk x5, 0xFF22, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #268
    mov x3, #8
    mov x4, #28
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #172
    mov x2, #268
    mov x3, #4
    mov x4, #24
    movz x5, 0x0F1A, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect
    mov x1, #208
    mov x2, #268
    mov x3, #4
    mov x4, #24
    movz x5, 0x0F1A, lsl #0
    movk x5, 0xFF08, lsl #16
    bl draw_rect
    mov x1, #172
    mov x2, #268
    mov x3, #4
    mov x4, #16
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #208
    mov x2, #268
    mov x3, #4
    mov x4, #16
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #264
    mov x3, #4
    mov x4, #4
    movz x5, 0x2018, lsl #0
    movk x5, 0xFF40, lsl #16
        bl draw_rect
    mov x1, #204
    mov x2, #264
    mov x3, #4
    mov x4, #4
    movz x5, 0x2018, lsl #0
    movk x5, 0xFF40, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #248
    mov x3, #4
    mov x4, #20
    movz x5, 0x101D, lsl #0
    movk x5, 0xFF0A, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #248
    mov x3, #4
    mov x4, #20
    movz x5, 0x101D, lsl #0
    movk x5, 0xFF0A, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #244
    mov x3, #8
    mov x4, #6
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #244
    mov x3, #8
    mov x4, #6
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect

    // Delay 1 segundo
        movz x20, #15000, lsl #0
        movk x20, #49000, lsl 16
    bl delay_loop

    // Cuarto Movimiento
        // tercera gota
        mov x1, #432
        mov x2, #172
        mov x3, #2
        mov x4, #2
        movz x5, 0x0000, lsl #0
        movk x5, 0xFFFF, lsl #16
        bl draw_rect

    // Will (Arriba Original)
            mov x1, #176
    mov x2, #148
    mov x3, #32
    mov x4, #28
    movz x5, 0xCCAA, lsl #0
    movk x5, 0xFFFF, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #176
    mov x3, #24
    mov x4, #4
    movz x5, 0xCCAA, lsl #0
    movk x5, 0xFFFF, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #180
    mov x3, #8
    mov x4, #4
    movz x5, 0xA874, lsl #0
    movk x5, 0xFFCC, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #140
    mov x3, #24
    mov x4, #4
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #144
    mov x3, #32
    mov x4, #8
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #208
    mov x2, #148
    mov x3, #4
    mov x4, #28
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #172
    mov x2, #148
    mov x3, #4
    mov x4, #28
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #204
    mov x2, #168
    mov x3, #4
    mov x4, #12
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #168
    mov x3, #4
    mov x4, #12
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #200
    mov x2, #176
    mov x3, #4
    mov x4, #4
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #176
    mov x3, #4
    mov x4, #4
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #152
    mov x3, #20
    mov x4, #4
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #200
    mov x2, #160
    mov x3, #4
    mov x4, #4
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #200
    mov x2, #156
    mov x3, #8
    mov x4, #4
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #152
    mov x3, #4
    mov x4, #8
    movz x5, 0x4444, lsl #0
    movk x5, 0xFF44, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #164
    mov x3, #4
    mov x4, #4
    movz x5, 0x0000, lsl #0
    movk x5, 0xFF00, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #164
    mov x3, #4
    mov x4, #4
    movz x5, 0x0000, lsl #0
    movk x5, 0xFF00, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #172
    mov x3, #8
    mov x4, #4
    movz x5, 0x522D, lsl #0
    movk x5, 0xFFA0, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #184
    mov x3, #32
    mov x4, #8
    movz x5, 0x3A80, lsl #0
    movk x5, 0xFF20, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #188
    mov x3, #24
    mov x4, #24
    movz x5, 0x0033, lsl #0
    movk x5, 0xFF88, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #180
    mov x3, #4
    mov x4, #36
    movz x5, 0x0033, lsl #0
    movk x5, 0xFF88, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #180
    mov x3, #4
    mov x4, #36
    movz x5, 0x0033, lsl #0
    movk x5, 0xFF88, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #184
    mov x3, #8
    mov x4, #28
    movz x5, 0xEEEE, lsl #0
    movk x5, 0xFFEE, lsl #16
    bl draw_rect
    mov x1, #208
    mov x2, #188
    mov x3, #4
    mov x4, #24
    movz x5, 0x3A80, lsl #0
    movk x5, 0xFF20, lsl #16
    bl draw_rect
    mov x1, #172
    mov x2, #188
    mov x3, #4
    mov x4, #24
    movz x5, 0x3A80, lsl #0
    movk x5, 0xFF20, lsl #16
    bl draw_rect
    mov x1, #208
    mov x2, #196
    mov x3, #4
    mov x4, #16
    movz x5, 0xEEEE, lsl #0
    movk x5, 0xFFEE, lsl #16
    bl draw_rect
    mov x1, #172
    mov x2, #196
    mov x3, #4
    mov x4, #16
    movz x5, 0xEEEE, lsl #0
    movk x5, 0xFFEE, lsl #16
    bl draw_rect
    mov x1, #204
    mov x2, #212
    mov x3, #4
    mov x4, #4
    movz x5, 0xCCAA, lsl #0
    movk x5, 0xFFFF, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #212
    mov x3, #4
    mov x4, #4
    movz x5, 0xCCAA, lsl #0
    movk x5, 0xFFFF, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #212
    mov x3, #4
    mov x4, #24
    movz x5, 0x3C75, lsl #0
    movk x5, 0xFF2F, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #212
    mov x3, #4
    mov x4, #24
    movz x5, 0x3C75, lsl #0
    movk x5, 0xFF2F, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #232
    mov x3, #8
    mov x4, #6
    movz x5, 0xFFFF, lsl #0
    movk x5, 0xFFFF, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #232
    mov x3, #8
    mov x4, #6
    movz x5, 0xFFFF, lsl #0
    movk x5, 0xFFFF, lsl #16
    bl draw_rect

    // Will (Abajo 5to oscuro)
            mov x1, #176
    mov x2, #304
    mov x3, #32
    mov x4, #24
    movz x5, 0x0D08, lsl #0
    movk x5, 0xFF1A, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #300
    mov x3, #24
    mov x4, #4
    movz x5, 0x0D08, lsl #0
    movk x5, 0xFF1A, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #296
    mov x3, #8
    mov x4, #4
    movz x5, 0x0A05, lsl #0
    movk x5, 0xFF11, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #336
    mov x3, #24
    mov x4, #4
    movz x5, 0x0202, lsl #0
    movk x5, 0xFF02, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #328
    mov x3, #32
    mov x4, #8
    movz x5, 0x0202, lsl #0
    movk x5, 0xFF02, lsl #16
    bl draw_rect
    mov x1, #172
    mov x2, #304
    mov x3, #4
    mov x4, #28
    movz x5, 0x0202, lsl #0
    movk x5, 0xFF02, lsl #16
    bl draw_rect
    mov x1, #208
    mov x2, #304
    mov x3, #4
    mov x4, #28
    movz x5, 0x0202, lsl #0
    movk x5, 0xFF02, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #300
    mov x3, #4
    mov x4, #12
    movz x5, 0x0202, lsl #0
    movk x5, 0xFF02, lsl #16
    bl draw_rect
    mov x1, #204
    mov x2, #300
    mov x3, #4
    mov x4, #12
    movz x5, 0x0202, lsl #0
    movk x5, 0xFF02, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #300
    mov x3, #4
    mov x4, #4
    movz x5, 0x0202, lsl #0
    movk x5, 0xFF02, lsl #16
    bl draw_rect
    mov x1, #200
    mov x2, #300
    mov x3, #4
    mov x4, #4
    movz x5, 0x0202, lsl #0
    movk x5, 0xFF02, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #320
    mov x3, #8
    mov x4, #8
    movz x5, 0x0202, lsl #0
    movk x5, 0xFF02, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #316
    mov x3, #4
    mov x4, #4
    movz x5, 0x0202, lsl #0
    movk x5, 0xFF02, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #324
    mov x3, #12
    mov x4, #4
    movz x5, 0x0202, lsl #0
    movk x5, 0xFF02, lsl #16
    bl draw_rect
    mov x1, #204
    mov x2, #320
    mov x3, #4
    mov x4, #8
    movz x5, 0x0202, lsl #0
    movk x5, 0xFF02, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #312
    mov x3, #4
    mov x4, #4
    movz x5, 0x0000, lsl #0
    movk x5, 0xFF00, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #312
    mov x3, #4
    mov x4, #4
    movz x5, 0x0000, lsl #0
    movk x5, 0xFF00, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #304
    mov x3, #8
    mov x4, #4
    movz x5, 0x0A05, lsl #0
    movk x5, 0xFF16, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #288
    mov x3, #32
    mov x4, #8
    movz x5, 0x040A, lsl #0
    movk x5, 0xFF01, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #268
    mov x3, #24
    mov x4, #24
    movz x5, 0x0003, lsl #0
    movk x5, 0xFF0B, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #264
    mov x3, #4
    mov x4, #36
    movz x5, 0x0003, lsl #0
    movk x5, 0xFF0B, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #264
    mov x3, #4
    mov x4, #36
    movz x5, 0x0003, lsl #0
    movk x5, 0xFF0B, lsl #16
    bl draw_rect
    mov x1, #188
    mov x2, #268
    mov x3, #8
    mov x4, #28
    movz x5, 0x1C1C, lsl #0
    movk x5, 0xFF1C, lsl #16
    bl draw_rect
    mov x1, #172
    mov x2, #268
    mov x3, #4
    mov x4, #24
    movz x5, 0x040A, lsl #0
    movk x5, 0xFF01, lsl #16
    bl draw_rect
    mov x1, #208
    mov x2, #268
    mov x3, #4
    mov x4, #24
    movz x5, 0x040A, lsl #0
    movk x5, 0xFF01, lsl #16
    bl draw_rect
    mov x1, #172
    mov x2, #268
    mov x3, #4
    mov x4, #16
    movz x5, 0x1C1C, lsl #0
    movk x5, 0xFF1C, lsl #16
    bl draw_rect
    mov x1, #208
    mov x2, #268
    mov x3, #4
    mov x4, #16
    movz x5, 0x1C1C, lsl #0
    movk x5, 0xFF1C, lsl #16
    bl draw_rect
    mov x1, #176
    mov x2, #264
    mov x3, #4
    mov x4, #4
    movz x5, 0x0D08, lsl #0
    movk x5, 0xFF1A, lsl #16
    bl draw_rect
    mov x1, #204
    mov x2, #264
    mov x3, #4
    mov x4, #4
    movz x5, 0x0D08, lsl #0
    movk x5, 0xFF1A, lsl #16
    bl draw_rect
    mov x1, #184
    mov x2, #248
    mov x3, #4
    mov x4, #20
    movz x5, 0x0408, lsl #0
    movk x5, 0xFF02, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #248
    mov x3, #4
    mov x4, #20
    movz x5, 0x0408, lsl #0
    movk x5, 0xFF02, lsl #16
    bl draw_rect
    mov x1, #180
    mov x2, #244
    mov x3, #8
    mov x4, #6
    movz x5, 0x1C1C, lsl #0
    movk x5, 0xFF1C, lsl #16
    bl draw_rect
    mov x1, #196
    mov x2, #244
    mov x3, #8
    mov x4, #6
    movz x5, 0x1C1C, lsl #0
    movk x5, 0xFF1C, lsl #16
    bl draw_rect
        // tercera gota
        mov x1, #432
        mov x2, #174
        mov x3, #2
        mov x4, #2
        movz x5, 0x0000, lsl #0
        movk x5, 0xFFFF, lsl #16
        bl draw_rect

// Delay final
       movz x20, #15000, lsl #0
       movk x20, #49000, lsl 16
bl delay_loop


       // ------ VOY A HACER ACÁ LA ANIMACIÓN DEL FONDO NEGRO QUE SE VA COMIENDO TODO -----
      
    // Primera parte
    movz x5, 0x0000, lsl #0
    movk x5, 0xFF00, lsl #16        // Establezco el color negro

    // Establezo el tiempo antes de que se pinte
    movz x20, #50000, lsl 16
    bl delay_loop
    
    mov x1, #100 // Centro X       // Círculo de arriba a la derecha
    mov x2, #40 // Centro Y
    mov x3, #16   // Radio
    bl draw_circle

    mov x1, #500 // Centro X       // Círculo de arriba a la izquierda
    mov x2, #40 // Centro Y
    mov x3, #16   // Radio
    bl draw_circle

    mov x1, #100 // Centro X       // Círculo de abajo a la derecha
    mov x2, #440 // Centro Y
    mov x3, #16   // Radio
    bl draw_circle

    mov x1, #500 // Centro X       // Círculo de abajo a la izquierda
    mov x2, #440 // Centro Y
    mov x3, #16   // Radio
    bl draw_circle

    // Segunda parte
    movz x20, #50000, lsl 16

    bl delay_loop

    mov x1, #100 // Centro X        // Círculo de arriba a la derecha
    mov x2, #40 // Centro Y
    mov x3, #28   // Radio
    bl draw_circle

    mov x1, #500 // Centro X       // Círculo de arriba a la izquierda
    mov x2, #40 // Centro Y
    mov x3, #28   // Radio
    bl draw_circle

	mov x1, #100 // Centro X       // Círculo de abajo a la derecha
    mov x2, #440 // Centro Y
    mov x3, #28   // Radio
    bl draw_circle

    mov x1, #500 // Centro X       // Círculo de abajo a la izquierda
    mov x2, #440 // Centro Y
    mov x3, #28   // Radio
    bl draw_circle


    // Tercera parte
    movz x20, #50000, lsl 16

    bl delay_loop

    mov x1, #100 // Centro X
    mov x2, #35 // Centro Y
    mov x3, #42   // Radio
    bl draw_circle

    mov x1, #500 // Centro X
    mov x2, #35 // Centro Y
    mov x3, #42   // Radio
    bl draw_circle

    mov x1, #100 // Centro X       // Círculo de abajo a la derecha
    mov x2, #440 // Centro Y
    mov x3, #42   // Radio
    bl draw_circle

    mov x1, #500 // Centro X       // Círculo de abajo a la izquierda
    mov x2, #440 // Centro Y
    mov x3, #42   // Radio
    bl draw_circle


    // Cuarta parte
    movz x20, #50000, lsl 16

    bl delay_loop

    mov x1, #100 // Centro X
    mov x2, #30 // Centro Y
    mov x3, #64   // Radio
    bl draw_circle

    mov x1, #500 // Centro X
    mov x2, #30 // Centro Y
    mov x3, #64   // Radio
    bl draw_circle

    mov x1, #100 // Centro X    
    mov x2, #440 // Centro Y
    mov x3, #64   // Radio
    bl draw_circle

    mov x1, #500 // Centro X   
    mov x2, #440 // Centro Y
    mov x3, #64   // Radio
    bl draw_circle

    // Quinta parte
    movz x20, #50000, lsl 16

    bl delay_loop

    mov x1, #100 // Centro X
    mov x2, #28 // Centro Y
    mov x3, #84   // Radio
    bl draw_circle

    mov x1, #500 // Centro X
    mov x2, #28 // Centro Y
    mov x3, #84   // Radio
    bl draw_circle

    mov x1, #100 // Centro X    
    mov x2, #440 // Centro Y
    mov x3, #84   // Radio
    bl draw_circle

    mov x1, #500 // Centro X   
    mov x2, #440 // Centro Y
    mov x3, #84   // Radio
    bl draw_circle

    // Sexta parte
    movz x20, #50000, lsl 16
    bl delay_loop

    mov x1, #100 // Centro X
    mov x2, #28 // Centro Y
    mov x3, #110   // Radio
    bl draw_circle

    mov x1, #500 // Centro X
    mov x2, #28 // Centro Y
    mov x3, #110   // Radio
    bl draw_circle

    mov x1, #100 // Centro X    
    mov x2, #440 // Centro Y
    mov x3, #110   // Radio
    bl draw_circle

    mov x1, #500 // Centro X   
    mov x2, #440 // Centro Y
    mov x3, #110   // Radio
    bl draw_circle

    mov x1, #100 // Centro X    
    mov x2, #220 // Centro Y
    mov x3, #120   // Radio
    bl draw_circle

    mov x1, #555 // Centro X   
    mov x2, #220 // Centro Y
    mov x3, #120   // Radio
    bl draw_circle

    mov x1, #320 // Centro X    
    mov x2, #0 // Centro Y
    mov x3, #110   // Radio
    bl draw_circle

    mov x1, #320 // Centro X   
    mov x2, #480 // Centro Y
    mov x3, #110   // Radio
    bl draw_circle

    // Séptima parte
    movz x20, #50000, lsl 16
    bl delay_loop

    mov x1, #100 // Centro X
    mov x2, #28 // Centro Y
    mov x3, #150   // Radio
    bl draw_circle

    mov x1, #500 // Centro X
    mov x2, #28 // Centro Y
    mov x3, #150   // Radio
    bl draw_circle

    mov x1, #100 // Centro X    
    mov x2, #440 // Centro Y
    mov x3, #150   // Radio
    bl draw_circle

    mov x1, #500 // Centro X   
    mov x2, #440 // Centro Y
    mov x3, #150   // Radio
    bl draw_circle

    mov x1, #100 // Centro X    
    mov x2, #220 // Centro Y
    mov x3, #160   // Radio
    bl draw_circle

    mov x1, #555 // Centro X   
    mov x2, #220 // Centro Y
    mov x3, #160   // Radio
    bl draw_circle

    mov x1, #320 // Centro X    
    mov x2, #0 // Centro Y
    mov x3, #150   // Radio
    bl draw_circle

    mov x1, #320 // Centro X   
    mov x2, #480 // Centro Y
    mov x3, #150   // Radio
    bl draw_circle

    // Octava parte
    movz x20, #50000, lsl 16
    bl delay_loop

    mov x1, #100 // Centro X
    mov x2, #28 // Centro Y
    mov x3, #250   // Radio
    bl draw_circle

    mov x1, #500 // Centro X
    mov x2, #28 // Centro Y
    mov x3, #250   // Radio
    bl draw_circle

    mov x1, #100 // Centro X    
    mov x2, #440 // Centro Y
    mov x3, #250   // Radio
    bl draw_circle

    mov x1, #500 // Centro X   
    mov x2, #440 // Centro Y
    mov x3, #250   // Radio
    bl draw_circle

    // Novena parte
    movz x20, #50000, lsl 16
    bl delay_loop

    mov x1, #320 // Centro X
    mov x2, #220 // Centro Y
    mov x3, #200   // Radio
    bl draw_circle




    movz x20, #60000, lsl 16
    bl delay_loop



//ODC 2025 TIPO STRANGER THINGS
       movz x5, 0x0000, lsl #0
       movk x5, 0xFFFF, lsl #16    //rojo puro
//ARRIBA
	mov x1, #319 // x
	mov x2, #50 //y
	mov x3, #2//ancho
	mov x4, #20//alto
	bl draw_rect

//ABAJO
	mov x1, #319 // x
	mov x2, #420 //y
	mov x3, #2//ancho
	mov x4, #20//alto
	bl draw_rect

       movz x20, #15000, lsl #0
    movk x20, #10000, lsl 16
       bl delay_loop


//ARRIBA
    mov x1, #317 //  x
	mov x2, #50 // y
	mov x3, #6//ancho
	mov x4, #20//alto
	bl draw_rect

//ABAJO
	mov x1, #317 // x
	mov x2, #420 //y
	mov x3, #6//ancho
	mov x4, #20//alto
	bl draw_rect

    movz x20, #15000, lsl #0
    movk x20, #10000, lsl 16
    bl delay_loop

    mov x21, #315
    mov x22, #10
    mov x23, #319
    mov x24, #2
    mov x25, #0 
loop_start:
    cmp x21, #70
    blt loop_end


    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 
    mov x1, x21
    mov x2, #50
    mov x3, x22
    mov x4, #20
    bl draw_rect

    movz x5, 0x0000, lsl #0
    movk x5, 0xFF00, lsl #16 
    mov x1, x23
    mov x2, #52
    mov x3, x24
    mov x4, #15
    bl draw_rect


    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 
    mov x1, x21
    mov x2, #420
    mov x3, x22
    mov x4, #20
    bl draw_rect

    movz x5, 0x0000, lsl #0
    movk x5, 0xFF00, lsl #16 
    mov x1, x23
    mov x2, #422
    mov x3, x24
    mov x4, #15
    bl draw_rect

    movz x20, #1500, lsl #0
    movk x20, #1000, lsl 16
    bl delay_loop

 
    sub x21, x21, #2
    sub x23, x23, #2
    add x24, x24, #4

    // Calculate x3_red increment (+2 then +6)
    and x26, x25, #1
    cmp x26, #0
    beq increment_by_2
    b increment_by_6

increment_by_2:
    add x22, x22, #2
    b end_increment

increment_by_6:
    add x22, x22, #6

end_increment:
    add x25, x25, #1

    b loop_start

loop_end:


///////////////////////////O////////////////////////
    mov x28, #105 // x_actual (inicio en 440)
    mov x29, #115 // x_fin_bucle
    mov x27, #95  // y_actual (parte superior)
bucle_dibujar_vertical_izquo:
    cmp x28, x29
    bgt fin_bucle_dibujar_vertical_izquo // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (X incrementando)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #115
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_vertical_izquo

fin_bucle_dibujar_vertical_izquo:
       movz x5, 0x0000, lsl #0
       movk x5, 0xFFFF, lsl #16        // Establezco el color rojo
/////////////0////////////
    mov x28, #110 // x_actual (inicio en 440)
    mov x29, #200 // x_fin_bucle
    mov x27, #90  // y_actual (parte superior)
bucle_dibujar_horizontal_o:
    cmp x28, x29
    bgt fin_bucle_dibujar_horizontal_o // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (parte superior)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Dibujar rectángulo ROJO (parte inferior, y=193)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, #200
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_horizontal_o

fin_bucle_dibujar_horizontal_o:




    mov x28, #195 // x_actual (inicio en 440)
    mov x29, #205 // x_fin_bucle
    mov x27, #95  // y_actual (parte superior)
bucle_dibujar_vertical_dero:
    cmp x28, x29
    bgt fin_bucle_dibujar_vertical_dero // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (X incrementando)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #115
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_vertical_dero

fin_bucle_dibujar_vertical_dero:

///////////////////////////////D///////////////////////////////7

// Animación de la letra 'D' (barra izquierda)
    mov x21, #90 // y_actual (inicio en 90)

bucle_dibujar_barra_izquierda_D:
    cmp x21, #200
    bgt fin_bucle_dibujar_barra_izquierda_D // Si y_actual > 200, terminar

    // Dibujar rectángulo ROJO
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, #260
    mov x2, x21
    mov x3, #20
    mov x4, #2
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x21, x21, #1 // Incrementar y_actual
    b bucle_dibujar_barra_izquierda_D

fin_bucle_dibujar_barra_izquierda_D:

// Animación de la letra 'D' (líneas horizontales superior e inferior)
    mov x28, #260 // x_actual (inicio en 260)
    mov x29, #330 // x_fin_bucle
    mov x27, #88  // y_actual (parte superior)

bucle_dibujar_lineas_horizontales_D:
    cmp x28, x29
    bgt fin_bucle_dibujar_lineas_horizontales_D // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (parte superior)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Dibujar rectángulo ROJO (parte inferior, y=200)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, #200
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_lineas_horizontales_D

fin_bucle_dibujar_lineas_horizontales_D:

// Animación de la letra 'D' (curva parte 1)
    mov x28, #310 // x_actual (inicio en 310)
    mov x29, #350 // x_fin_bucle
    mov x27, #95  // y_actual (parte superior)

bucle_dibujar_lineas_curvas_D_parte_1:
    cmp x28, x29
    bgt fin_bucle_dibujar_lineas_curvas_D_parte_1 // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (parte superior)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Dibujar rectángulo ROJO (parte inferior, y=193)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, #193
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_lineas_curvas_D_parte_1

fin_bucle_dibujar_lineas_curvas_D_parte_1:

// Animación de la letra 'D' (curva parte 2)
    mov x28, #340 // x_actual (inicio en 340)
    mov x29, #360 // x_fin_bucle
    mov x27, #100 // y_actual (parte superior)

bucle_dibujar_lineas_curvas_D_parte_2:
    cmp x28, x29
    bgt fin_bucle_dibujar_lineas_curvas_D_parte_2 // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (parte superior)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Dibujar rectángulo ROJO (parte inferior, y=187)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, #187
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_lineas_curvas_D_parte_2

fin_bucle_dibujar_lineas_curvas_D_parte_2:

// Animación de la letra 'D' (línea vertical derecha)
    mov x28, #345 // x_actual (inicio en 345)
    mov x29, #366 // x_fin_bucle
    mov x27, #110 // y_actual (constante)
bucle_dibujar_linea_derecha_D:
    cmp x28, x29
    bgt fin_bucle_dibujar_linea_derecha_D // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (X incrementando)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #80
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_linea_derecha_D
fin_bucle_dibujar_linea_derecha_D:


///////////////////C//////////

// Animación de la letra 'C' (barra izquierda)
    mov x28, #420 // x_actual (inicio en 420)
    mov x29, #441 // x_fin_bucle
    mov x27, #110 // y_actual (constante)
bucle_dibujar_barra_izquierda_C:
    cmp x28, x29
    bgt fin_bucle_dibujar_barra_izquierda_C // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (X incrementando)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #80
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_barra_izquierda_C

fin_bucle_dibujar_barra_izquierda_C:

// Animación de la letra 'C' (línea horizontal inferior)
    mov x28, #430 // x_actual (inicio en 430)
    mov x29, #450 // x_fin_bucle
    mov x27, #100 // y_actual (parte superior)

bucle_dibujar_horizontal_inferior_C:
    cmp x28, x29
    bgt fin_bucle_dibujar_horizontal_inferior_C // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (parte superior)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Dibujar rectángulo ROJO (parte inferior, y=187)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, #187
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_horizontal_inferior_C

fin_bucle_dibujar_horizontal_inferior_C:

// Animación de la letra 'C' (línea horizontal media)
    mov x28, #440 // x_actual (inicio en 440)
    mov x29, #480 // x_fin_bucle
    mov x27, #95  // y_actual (parte superior)
bucle_dibujar_horizontal_media_C:
    cmp x28, x29
    bgt fin_bucle_dibujar_horizontal_media_C // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (parte superior)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Dibujar rectángulo ROJO (parte inferior, y=193)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, #193
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_horizontal_media_C

fin_bucle_dibujar_horizontal_media_C:

// Animación de la letra 'C' (línea horizontal superior)
    mov x28, #460 // x_actual (inicio en 460)
    mov x29, #515 // x_fin_bucle
    mov x27, #90  // y_actual (parte superior)

bucle_dibujar_horizontal_superior_C:
    cmp x28, x29
    bgt fin_bucle_dibujar_horizontal_superior_C // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (parte superior)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Dibujar rectángulo ROJO (parte inferior, y=198)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, #198
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_horizontal_superior_C

fin_bucle_dibujar_horizontal_superior_C:

// Animación de la letra 'C' (línea horizontal de cierre)
    mov x28, #505 // x_actual (inicio en 505)
    mov x29, #520 // x_fin_bucle
    mov x27, #93  // y_actual (parte superior)


///////////////////////////2////////////////////////

    mov x28, #120 // x_actual (era 120, se mantiene para la posición izquierda)
    mov x29, #200 // x_fin_bucle (era 200)
    mov x27, #280  // y_actual (parte superior)
bucle_dibujar_horizontal_dos:
    cmp x28, x29
    bgt fin_bucle_dibujar_horizontal_dos // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (parte superior)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Dibujar rectángulo ROJO (parte inferior)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, #380 // Ajustado para ser como el segundo '2'
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_horizontal_dos

fin_bucle_dibujar_horizontal_dos:

    mov x28, #130 // x_actual (antes 130, se mantiene el ajuste del original)
    mov x29, #190 // x_fin_bucle (antes 190)
    mov x27, #330  // y_actual (parte media)
bucle_dibujar_horizontal_1dos:
    cmp x28, x29
    bgt fin_bucle_dibujar_horizontal_1dos // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (parte media)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_horizontal_1dos

fin_bucle_dibujar_horizontal_1dos:

    mov x28, #120 // x_actual (ajustado de 340 para la izquierda)
    mov x29, #130 // x_fin_bucle (ajustado de 350 para la izquierda)
    mov x27, #335  // y_actual (parte vertical izquierda superior)
bucle_dibujar_vertical_izquseg2_ajustado: // Nuevo nombre para evitar conflicto
    cmp x28, x29
    bgt fin_bucle_dibujar_vertical_izquseg2_ajustado // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (X incrementando)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #20
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_vertical_izquseg2_ajustado

fin_bucle_dibujar_vertical_izquseg2_ajustado:


    mov x28, #115 // x_actual (ajustado de 335 para la izquierda)
    mov x29, #125 // x_fin_bucle (ajustado de 345 para la izquierda)
    mov x27, #355 // y_actual (parte vertical izquierda inferior)
bucle_dibujar_vertical_izquseg_ajustado: // Nuevo nombre para evitar conflicto
    cmp x28, x29
    bgt fin_bucle_dibujar_vertical_izquseg_ajustado // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (X incrementando)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #30
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_vertical_izquseg_ajustado

fin_bucle_dibujar_vertical_izquseg_ajustado:


    mov x28, #190 // x_actual (ajustado de 410 para la izquierda)
    mov x29, #200 // x_fin_bucle (ajustado de 420 para la izquierda)
    mov x27, #320  // y_actual (parte vertical derecha superior)
bucle_dibujar_vertical_derseg2_ajustado: // Nuevo nombre para evitar conflicto
    cmp x28, x29
    bgt fin_bucle_dibujar_vertical_derseg2_ajustado // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (X incrementando)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #20
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_vertical_derseg2_ajustado

fin_bucle_dibujar_vertical_derseg2_ajustado:

    mov x28, #195 // x_actual (ajustado de 415 para la izquierda)
    mov x29, #205 // x_fin_bucle (ajustado de 425 para la izquierda)
    mov x27, #290 // y_actual (parte vertical derecha inferior)
bucle_dibujar_vertical_derseg_ajustado: // Nuevo nombre para evitar conflicto
    cmp x28, x29
    bgt fin_bucle_dibujar_vertical_derseg_ajustado // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (X incrementando)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #35
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_vertical_derseg_ajustado

fin_bucle_dibujar_vertical_derseg_ajustado:



/////////////0////////////
    mov x28, #240 // x_actual (inicio en 440)
    mov x29, #300 // x_fin_bucle
    mov x27, #280  // y_actual (parte superior)
bucle_dibujar_horizontal_cero:
    cmp x28, x29
    bgt fin_bucle_dibujar_horizontal_cero // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (parte superior)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Dibujar rectángulo ROJO (parte inferior, y=193)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, #380
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_horizontal_cero

fin_bucle_dibujar_horizontal_cero:


    mov x28, #235 // x_actual (inicio en 440)
    mov x29, #245 // x_fin_bucle
    mov x27, #285  // y_actual (parte superior)
bucle_dibujar_vertical_izqucero:
    cmp x28, x29
    bgt fin_bucle_dibujar_vertical_izqucero // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (X incrementando)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #100
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_vertical_izqucero

fin_bucle_dibujar_vertical_izqucero:


    mov x28, #295 // x_actual (inicio en 440)
    mov x29, #305 // x_fin_bucle
    mov x27, #285  // y_actual (parte superior)
bucle_dibujar_vertical_dercero:
    cmp x28, x29
    bgt fin_bucle_dibujar_vertical_dercero // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (X incrementando)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #100
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_vertical_dercero

fin_bucle_dibujar_vertical_dercero:

////////////////////////"///////////////////2//////////////////"

//dibujar segundo 2 (original, sin modificar):
    mov x28, #340 // x_actual (inicio en 440)
    mov x29, #420 // x_fin_bucle
    mov x27, #280  // y_actual (parte superior)
bucle_dibujar_horizontal_segundodos:
    cmp x28, x29
    bgt fin_bucle_dibujar_horizontal_segundodos // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (parte superior)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Dibujar rectángulo ROJO (parte inferior, y=193)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, #380
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_horizontal_segundodos

fin_bucle_dibujar_horizontal_segundodos:


    mov x28, #350 // x_actual (inicio en 440)
    mov x29, #410 // x_fin_bucle
    mov x27, #330  // y_actual (parte superior)
bucle_dibujar_horizontal_2dos:
    cmp x28, x29
    bgt fin_bucle_dibujar_horizontal_2dos // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (parte superior)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_horizontal_2dos

fin_bucle_dibujar_horizontal_2dos:

    mov x28, #340 // x_actual (inicio en 440)
    mov x29, #350 // x_fin_bucle
    mov x27, #335  // y_actual (parte superior)
bucle_dibujar_vertical_izquseg2:
    cmp x28, x29
    bgt fin_bucle_dibujar_vertical_izquseg2 // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (X incrementando)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #20
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_vertical_izquseg2

fin_bucle_dibujar_vertical_izquseg2:


    mov x28, #335 // x_actual (inicio en 420)
    mov x29, #345 // x_fin_bucle
    mov x27, #355 // y_actual (constante)
bucle_dibujar_vertical_izquseg:
    cmp x28, x29
    bgt fin_bucle_dibujar_vertical_izquseg // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (X incrementando)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #30
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_vertical_izquseg

fin_bucle_dibujar_vertical_izquseg:


    mov x28, #410 // x_actual (inicio en 440)
    mov x29, #420 // x_fin_bucle
    mov x27, #320  // y_actual (parte superior)
bucle_dibujar_vertical_derseg2:
    cmp x28, x29
    bgt fin_bucle_dibujar_vertical_derseg2 // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (X incrementando)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #20
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_vertical_derseg2

fin_bucle_dibujar_vertical_derseg2:

    mov x28, #415 // x_actual (inicio en 420)
    mov x29, #425 // x_fin_bucle
    mov x27, #290 // y_actual (constante)
bucle_dibujar_vertical_derseg:
    cmp x28, x29
    bgt fin_bucle_dibujar_vertical_derseg // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (X incrementando)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #35
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_vertical_derseg

fin_bucle_dibujar_vertical_derseg:


//////////////////////////5///////////////////////

    mov x28, #450 // x_actual (inicio en 440)
    mov x29, #520 // x_fin_bucle
    mov x27, #280  // y_actual (parte superior)
bucle_dibujar_horizontal1_cinco:
    cmp x28, x29
    bgt fin_bucle_dibujar_horizontal1_cinco // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (parte superior)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Dibujar rectángulo ROJO (parte inferior, y=193)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, #380
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_horizontal1_cinco

fin_bucle_dibujar_horizontal1_cinco:

    mov x28, #445 // x_actual (inicio en 335 + 110 = 445)
    mov x29, #455 // x_fin_bucle (345 + 110 = 455)
    mov x27, #290 // y_actual (constante)
bucle_dibujar_vertical_izqucinco:
    cmp x28, x29
    bgt fin_bucle_dibujar_vertical_izqucinco // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (X incrementando)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #30
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_vertical_izqucinco

fin_bucle_dibujar_vertical_izqucinco:

mov x28, #450 // x_actual (inicio en 340 + 110 = 450)
    mov x29, #460 // x_fin_bucle (350 + 110 = 460)
        mov x27, #320  // y_actual (parte superior)

bucle_dibujar_vertical1_izqucinco:
    cmp x28, x29
    bgt fin_bucle_dibujar_vertical1_izqucinco // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (X incrementando)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #20
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_vertical1_izqucinco
fin_bucle_dibujar_vertical1_izqucinco:


    mov x28, #460 // x_actual (inicio en 440)
    mov x29, #510 // x_fin_bucle
    mov x27, #330  // y_actual (parte superior)
bucle_dibujar_horizontal_cinco:
    cmp x28, x29
    bgt fin_bucle_dibujar_horizontal_cinco // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (parte superior)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #15
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_horizontal_cinco

fin_bucle_dibujar_horizontal_cinco:


    mov x28, #510 // x_actual (inicio en 410 + 110 = 520)
    mov x29, #520 // x_fin_bucle (420 + 110 = 530)
    mov x27, #335  // y_actual (parte superior)
bucle_dibujar_vertical1_dercinco:
    cmp x28, x29
    bgt fin_bucle_dibujar_vertical1_dercinco // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (X incrementando)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #20
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_vertical1_dercinco

fin_bucle_dibujar_vertical1_dercinco:

    mov x28, #515 // x_actual (inicio en 415 + 110 = 525)
    mov x29, #525 // x_fin_bucle (425 + 110 = 535)
    mov x27, #355 // y_actual 
bucle_dibujar_vertical_dercinco:
    cmp x28, x29
    bgt fin_bucle_dibujar_vertical_dercinco // Si x_actual > x_fin_bucle, terminar

    // Dibujar rectángulo ROJO (X incrementando)
    movz x5, 0x0000, lsl #0
    movk x5, 0xFFFF, lsl #16 // Color: Rojo
    mov x1, x28
    mov x2, x27
    mov x3, #2
    mov x4, #35
    bl draw_rect

    // Retraso
movz x20, #375, lsl #0  

movk x20, #250, lsl 16
    bl delay_loop

    add x28, x28, #1 // Incrementar x_actual
    b bucle_dibujar_vertical_dercinco

fin_bucle_dibujar_vertical_dercinco:


//cierre
       movz x20, #15000, lsl #0
       movk x20, #49000, lsl 16
       bl delay_loop

//hacemos branch main al ultimo para que se repita
b main
    ldp x29, x30, [sp], #16    
    ret                        
// MÉTODO DE USO DE DELAY LOOP: 

delay_loop:
    subs x20, x20, #5 //
    b.ne delay_loop
end_delay_loop:
    ret
