    .include "data.s"
	.include "subrutinas.s"

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

.section .text

	// -------------------FONDO CELESTE DE ARRIBA Y ABAJO -------------------	
dibujando_celeste:
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

	// -------------------FONDO PÚRPURA -------------------	

dibujando_purpura_inferior:
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

/*
	adr x13, tabla_purpura   // puntero base a la tabla
	mov x14, #30             // cantidad de entradas que tiene la tabla (30)
    ldr w6, [x13], #4    // carga x_start y avanza el puntero 4 bytes (1 palabra)
    ldr w7, [x13], #4    // carga x_end y avanza el puntero 4 bytes
    ldr w11, [x13], #4   // carga y_start y avanza el puntero 4 bytes
*/

	// Para lograr el efecto de que arriba sea un tono más claro de púrpura, y abajo sea un tono más oscuro, lo que hago es utilizar mi función
	// double_mirror_loop para pintar primero con el color púrpura más oscuro. Esto hace que ya tenga pintado arriba y abajo un reflejo exactamente igual.
	// Luego, con la función mirror_loop pinto solo en la parte de arriba (con color púrpura claro) por encima de lo pintado anteriormente con púrpura oscuro.
	// De esta forma logro el efecto de que arriba sean colores más claros y luminosos, mientras que abajo son más oscuros y apagados.

dibujando_purpura_superior:    // Cargar color púrpura superior en x10
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


//estrellas
dibujando_estrellas:
	movz x10, 0x91B9, lsl 0	
	movk x10, 0xFF2E, lsl 16
	
    ldr x19, =tabla_estrellas   //dirección base de la tabla en x19
    mov x21, #79                 //  grupos a procesar

loop_estrellas:
    cbz x21, fin_dibujar_estrellas   // contador = 0, salir del loop

    ldr w6, [x19], #4          //  puntero 4 bytes
    ldr w7, [x19], #4          // 
    ldr w11, [x19], #4         // 
    ldr w12, [x19], #4         // 

    bl double_mirror_loop      // 

    subs x21, x21, #1          // 
    b.ne loop_estrellas            //

fin_dibujar_estrellas:


		// ------------------- FONDO, LA PARTE DE LOS ARBUSTOS Y LA PARTE NEGRA DE ARRIBA DEL FONDO -------------------
dibujando_arbustos_y_fondo:
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



	// ------------------- ÁRBOLES DEL FONDO, REFLEJADOS ARRIBA Y ABAJO -------------------
dibujando_arboles_fondo:
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

dibujando_ODC2025:
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

	// ------------------- PASTO EN EL QUE SE APOYAN LOS PERSONAJES -------------------
dibujando_pasto:
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


/////////////////DEMOGORGON/////////////////////

draw_demogorgon:
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
	

	mov x1, #408 // 413 - 5
	mov x2, #285 // 300 - 15
	mov x3, #6
	mov x4, #12
	bl draw_rect


	mov x1, #408 // 413 - 5
	mov x2, #273 // 288 - 15
	mov x3, #6
	mov x4, #24
	bl draw_rect


	mov x1, #405 // 410 - 5
	mov x2, #280 // 295 - 15
	mov x3, #6
	mov x4, #6
	bl draw_rect


	mov x1, #412 // 417 - 5
	mov x2, #258 // 273 - 15
	mov x3, #4
	mov x4, #15
	bl draw_rect


	mov x1, #415 // 420 - 5
	mov x2, #255 // 270 - 15
	mov x3, #6
	mov x4, #6
	bl draw_rect


	mov x1, #405 // 410 - 5
	mov x2, #252 // 267 - 15
	mov x3, #15
	mov x4, #6
	bl draw_rect


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


 ////////////////////PERSONAJES////////////////////
	// personajes
dibujando_dustin:
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

dibujando_will:
    ldr x19, =tabla_will      // dirección tabla
    mov x21, #45               // cantidad de rectángulos 

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

dibujando_max:
	// Maxdibujando_max:
    ldr x19, =tabla_max       // dirección de la tabla
    mov x21, #52              // cantidad de rectángulos

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
dibujando_lucas:
	// dibujando_lucas:
    ldr x19, =tabla_lucas       // dirección de la tabla
    mov x21, #52              // cantidad de rectángulos 

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

dibujando_eleven:
	// dibujando_eleven:
    ldr x19, =tabla_eleven       // dirección de la tabla
    mov x21, #52              // cantidad de rectángulos 

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

 dibujando_mike:
	// dibujando_mike:
    ldr x19, =tabla_mike       // dirección de la tabla
    mov x21, #52              // cantidad de rectángulos 

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
