    .include "header.s" // Si data.s usa alguna constante de header.s

//////////////tablas de entradas para optimizar //////////
// Tabla con entradas de 3 valores (x_start, x_end, y_start) de 32 bits

// ***************************************************************
// ASEGÚRATE de que TODAS estas líneas .globl estén presentes:
.globl purpura_coords
.globl purpura_superior_coords
.globl tabla_estrellas
.globl tabla_domo_arbustos
.globl tabla_arboles_fondo
.globl tabla_dibujo_odc_double
.globl tabla_dibujo_odc_only_y
.globl tabla_rectangulos
.globl tabla_pasto
.globl tabla_dustin
.globl tabla_will
.globl tabla_max
.globl tabla_lucas
.globl tabla_eleven
.globl tabla_mike
.globl tabla_demogorgon
//////////////tablas de entradas para optimizar //////////
// Tabla con entradas de 3 valores (x_start, x_end, y_start) de 32 bits
.data
.align 3
purpura_coords:
    .word 52,  68,  128
    .word 68,  72,  136
    .word 72,  84,  140
    .word 84,  92,  144
    .word 92,  104, 152
    .word 104, 108, 156
    .word 108, 116, 160
    .word 116, 128, 164
    .word 128, 132, 168
    .word 132, 140, 172
    .word 140, 148, 176
    .word 148, 156, 180
    .word 156, 172, 176
    .word 172, 180, 172
    .word 180, 188, 168
    .word 188, 196, 176
    .word 196, 208, 180
    .word 208, 228, 184
    .word 228, 232, 188
    .word 232, 240, 184
    .word 240, 244, 188
    .word 244, 248, 192
    .word 248, 252, 196
    .word 252, 264, 200
    .word 264, 280, 196
    .word 280, 284, 192
    .word 284, 288, 188
    .word 288, 300, 192
    .word 300, 312, 196
    .word 312, 320, 200

purpura_superior_coords:
    .word 52, 68, 128
    .word 68, 72, 136
    .word 72, 84, 140
    .word 84, 92, 144
    .word 92, 104, 152
    .word 104, 108, 156
    .word 108, 116, 160
    .word 116, 128, 164
    .word 128, 132, 168
    .word 132, 140, 172
    .word 140, 148, 176
    .word 148, 156, 180
    .word 156, 172, 176
    .word 172, 180, 172
    .word 180, 188, 168
    .word 188, 196, 176
    .word 196, 208, 180
    .word 208, 228, 184
    .word 228, 232, 188
    .word 232, 240, 184
    .word 240, 244, 188
    .word 244, 248, 192
    .word 248, 252, 196
    .word 252, 264, 200
    .word 264, 280, 196
    .word 280, 284, 192
    .word 284, 288, 188
    .word 288, 300, 192
    .word 300, 312, 196
    .word 312, 320, 200


tabla_estrellas:
    .word 65, 66, 45, 46
    .word 80, 81, 55, 56
    .word 100, 102, 40, 42
    .word 120, 121, 70, 71
    .word 140, 142, 85, 87
    .word 160, 161, 50, 51
    .word 180, 182, 75, 77
    .word 200, 201, 90, 91
    .word 220, 222, 110, 112
    .word 240, 241, 130, 131
    .word 260, 262, 150, 152
    .word 280, 281, 170, 171
    .word 60, 62, 100, 102
    .word 90, 91, 120, 121
    .word 130, 131, 140, 141
    .word 170, 172, 160, 162
    .word 210, 211, 180, 181
    .word 250, 252, 200, 202
    .word 290, 291, 220, 221
    .word 60, 61, 230, 231
    .word 70, 72, 110, 112
    .word 110, 111, 90, 91
    .word 150, 152, 130, 132
    .word 190, 191, 100, 101
    .word 230, 232, 170, 172
    .word 270, 271, 190, 191
    .word 85, 86, 200, 201
    .word 165, 166, 210, 211
    .word 245, 246, 230, 231

    .word 285, 286, 45, 46
    .word 280, 281, 60, 61
    .word 275, 276, 80, 81
    .word 270, 271, 100, 101
    .word 265, 266, 120, 121
    .word 260, 261, 140, 141
    .word 255, 256, 160, 161
    .word 250, 251, 180, 181
    .word 245, 246, 200, 201
    .word 240, 241, 220, 221

    .word 75, 80, 190, 195
    .word 200, 205, 60, 65

    .word 350, 351, 45, 46
    .word 370, 371, 55, 56
    .word 390, 392, 40, 42
    .word 410, 411, 70, 71
    .word 430, 432, 85, 87
    .word 450, 451, 50, 51
    .word 470, 472, 75, 77
    .word 490, 491, 90, 91
    .word 510, 512, 110, 112
    .word 530, 531, 130, 131
    .word 550, 552, 150, 152
    .word 570, 571, 170, 171
    .word 345, 347, 100, 102
    .word 375, 376, 120, 121
    .word 415, 416, 140, 141
    .word 455, 457, 160, 162
    .word 495, 496, 180, 181
    .word 535, 537, 200, 202
    .word 580, 581, 220, 221
    .word 345, 346, 230, 231
    .word 360, 362, 110, 112
    .word 400, 401, 90, 91
    .word 440, 442, 130, 132
    .word 480, 481, 100, 101
    .word 520, 522, 170, 172
    .word 560, 561, 190, 191
    .word 385, 386, 200, 201
    .word 465, 466, 210, 211
    .word 545, 546, 230, 231

    .word 355, 356, 45, 46
    .word 360, 361, 60, 61
    .word 365, 366, 80, 81
    .word 370, 371, 100, 101
    .word 375, 376, 120, 121
    .word 380, 381, 140, 141
    .word 385, 386, 160, 161
    .word 390, 391, 180, 181
    .word 395, 396, 200, 201



	tabla_domo_arbustos:
    .word 50, 54, 30, 220
    .word 54, 62, 30, 150
    .word 62, 66, 30, 130
    .word 66, 74, 30, 100
    .word 74, 76, 30, 90
    .word 76, 78, 30, 85
    .word 78, 82, 30, 75
    .word 82, 84, 30, 69
    .word 84, 90, 30, 63
    .word 90, 100, 30, 58
    .word 100, 106, 30, 54
    .word 106, 118, 30, 50
    .word 118, 130, 30, 48
    .word 130, 150, 30, 46
    .word 150, 190, 30, 44
    .word 190, 220, 30, 42

    // Arbusto 1
    .word 82, 86, 160, 240
    .word 86, 94, 164, 240
    .word 94, 98, 168, 240
    .word 98, 102, 172, 240
    .word 102, 114, 176, 240
    .word 114, 118, 180, 240
    .word 118, 122, 184, 240
    .word 122, 126, 188, 240
    .word 126, 130, 192, 240
    .word 130, 142, 196, 240
    .word 142, 146, 200, 240
    .word 146, 154, 204, 240
    .word 50, 54, 178, 240
    .word 54, 58, 174, 240
    .word 58, 64, 170, 240
    .word 64, 72, 166, 240
    .word 72, 76, 162, 240
    .word 76, 84, 160, 240

    // Arbusto 2
    .word 154, 158, 200, 240
    .word 158, 162, 196, 240
    .word 162, 166, 192, 240
    .word 166, 174, 188, 240
    .word 174, 186, 184, 240
    .word 186, 190, 188, 240
    .word 190, 198, 192, 240
    .word 198, 202, 196, 240
    .word 202, 206, 200, 240
    .word 206, 210, 204, 240
    .word 210, 214, 208, 240
    .word 214, 218, 208, 240
    .word 218, 222, 212, 240
    .word 222, 226, 216, 240

    // Arbusto 3
	.word 226, 230, 212, 240
	.word 230, 234, 208, 240
	.word 234, 242, 204, 240
	.word 242, 250, 208, 240
	.word 250, 266, 212, 240
	.word 266, 274, 216, 240

	//Arbusto 4
	.word 274, 278, 212, 240
	.word 278, 282, 208, 240
	.word 282, 290, 204, 240
	.word 290, 298, 208, 240
	.word 298, 302, 212, 240
	.word 302, 306, 216, 240
	.word 306, 314, 220, 240
	.word 314, 318, 224, 240
	.word 318, 326, 228, 240

tabla_arboles_fondo:
    // ÁRBOL 1
    .word 78, 92, 144, 164
    .word 66, 70, 120, 128
    .word 70, 74, 100, 120
    .word 66, 70, 96, 112
    .word 82, 94, 108, 144
    .word 94, 98, 124, 132
    .word 98, 102, 120, 124
    .word 102, 106, 116, 120
    .word 94, 102, 112, 116
    .word 102, 106, 140, 160
    .word 98, 102, 136, 140
    .word 106, 110, 120, 140
    .word 108, 112, 92, 100
    .word 112, 116, 100, 104
    .word 116, 124, 96, 100
    .word 120, 124, 92, 96
    .word 116, 120, 80, 92
    .word 110, 114, 132, 136
    .word 114, 118, 112, 132
    .word 78, 86, 80, 108
    .word 72, 78, 72, 80
    .word 86, 90, 60, 80
    .word 92, 100, 90, 112
    .word 100, 108, 82, 100
    .word 92, 96, 58, 70
    .word 96, 100, 70, 74
    .word 100, 104, 74, 78
    .word 104, 108, 78, 82
    .word 108, 112, 62, 86
    .word 112, 116, 46, 58
    .word 104, 112, 58, 62
    .word 100, 104, 50, 62

	 // ÁRBOL 2
    .word 132, 136, 160, 240
    .word 128, 132, 100, 160
    .word 128, 136, 88, 100
    .word 136, 140, 64, 88
    .word 140, 144, 52, 64
    .word 140, 148, 48, 52
    .word 148, 152, 44, 48
    .word 124, 128, 72, 88
    .word 120, 124, 60, 72
    .word 124, 128, 64, 68
    .word 128, 132, 60, 64
    .word 128, 132, 60, 64

    // ÁRBOL 3
   .word 144, 152, 140, 220
    .word 152, 156, 108, 152
    .word 156, 160, 96, 112
    .word 160, 164, 80, 96
    .word 160, 168, 76, 80
    .word 164, 168, 72, 76
    .word 136, 140, 108, 128
    .word 140, 144, 128, 132
    .word 144, 148, 132, 144
    .word 156, 160, 140, 144
    .word 160, 164, 136, 140
    .word 164, 168, 132, 136
    .word 168, 172, 128, 132
    .word 172, 176, 112, 128
    .word 172, 180, 112, 116
    .word 152, 160, 180, 184
    .word 160, 164, 176, 180
    .word 164, 168, 172, 176
    .word 168, 172, 168, 172
    .word 168, 172, 156, 168
    .word 164, 168, 144, 156
    .word 168, 176, 156, 160

 // ÁRBOL 4
    .word 164, 192, 40, 60
    .word 152, 164, 52, 56
    .word 156, 160, 44, 48
    .word 160, 164, 48, 52
    .word 120, 128, 52, 56
    .word 124, 136, 44, 52
    .word 136, 140, 52, 56
    .word 180, 184, 60, 64
    .word 176, 180, 64, 68
    .word 164, 168, 60, 64
    .word 168, 172, 64, 68
    .word 192, 196, 56, 60
    .word 192, 196, 40, 52
    .word 196, 200, 52, 56
    .word 200, 204, 48, 52
    .word 196, 200, 44, 48
    .word 204, 216, 48, 64
    .word 204, 212, 36, 52
    .word 220, 224, 40, 44
    .word 216, 220, 40, 48
    .word 216, 220, 52, 56
    .word 220, 224, 48, 52
    .word 224, 228, 44, 48
    .word 228, 232, 40, 60
    .word 228, 236, 40, 44
    .word 236, 240, 40, 52
    .word 232, 236, 44, 48
    // ÁRBOL 5
    .word 216, 220, 180, 220
    .word 212, 216, 152, 184
    .word 208, 212, 144, 152
    .word 208, 212, 144, 152
    .word 204, 208, 140, 144
    .word 200, 204, 128, 140
    .word 216, 220, 148, 152
    .word 220, 232, 144, 148
    .word 216, 220, 132, 144
    .word 212, 216, 132, 136
    .word 208, 212, 116, 132
    .word 204, 208, 116, 120
    .word 204, 208, 124, 128
    .word 200, 204, 112, 116
    .word 228, 232, 104, 148
    .word 232, 236, 112, 120
    .word 232, 236, 128, 136
    .word 224, 228, 116, 120
    .word 220, 224, 112, 116
    .word 208, 220, 108, 112
    .word 204, 208, 104, 108
    .word 200, 204, 100, 104
    .word 216, 224, 160, 164
    .word 220, 224, 152, 160
    .word 224, 228, 148, 152
    .word 224, 228, 108, 112
    .word 220, 224, 104, 108
    .word 216, 220, 100, 104
    .word 212, 216, 84, 100
    .word 208, 212, 84, 88
    .word 204, 208, 76, 84
    .word 232, 236, 96, 104
    .word 236, 240, 108, 116
    .word 240, 244, 104, 108
    .word 260, 272, 148, 192
    .word 260, 276, 192, 220
    .word 256, 260, 152, 164
    .word 252, 256, 148, 156
    .word 248, 252, 128, 152
    .word 244, 248, 140, 148
    .word 240, 244, 140, 144
    .word 240, 244, 132, 136
    .word 244, 248, 136, 140
    .word 244, 248, 116, 128
    .word 248, 260, 128, 132
    .word 252, 256, 124, 128
    .word 260, 268, 100, 148
    .word 264, 268, 88, 108
    .word 268, 276, 60, 104
    .word 272, 280, 40, 64
    .word 280, 284, 52, 60
    .word 284, 288, 44, 52
    .word 280, 284, 40, 44
    .word 288, 292, 40, 44
    .word 260, 272, 44, 48
    .word 256, 260, 40, 44
    .word 264, 272, 36, 52
    .word 264, 272, 68, 80
    .word 260, 264, 56, 72
    .word 244, 260, 52, 56
    .word 256, 260, 60, 64
    .word 252, 256, 56, 60
    .word 248, 252, 52, 56
    .word 252, 256, 48, 52
    .word 248, 252, 44, 48
    .word 276, 280, 80, 100
    .word 280, 284, 76, 96
    .word 284, 288, 60, 88
    .word 280, 284, 64, 72
    .word 276, 280, 60, 64
    .word 288, 296, 84, 88
    .word 296, 300, 72, 84
    .word 292, 296, 64, 72
    .word 300, 304, 64, 72
    .word 296, 300, 52, 64
    .word 292, 296, 48, 52
    .word 288, 292, 44, 48
    .word 284, 288, 36, 44
    .word 300, 304, 72, 80
    .word 304, 312, 68, 72
    .word 312, 316, 60, 68
    .word 316, 320, 52, 60
    .word 324, 328, 44, 52
    .word 328, 332, 36, 44
    .word 310, 314, 156, 180
    .word 306, 310, 180, 220

tabla_dibujo_odc_double:
    .word 310, 314, 156, 180
    .word 306, 310, 180, 220
    .word 306, 310, 180, 220
    .word 284, 288, 180, 220
    .word 288, 292, 152, 180


tabla_dibujo_odc_only_y:
    // Letra 'O'
    .word 280, 284, 140, 148
    .word 284, 288, 148, 152
    .word 284, 288, 136, 140
    .word 288, 292, 140, 148

    // Letra 'D'
    .word 296, 300, 136, 152
    .word 300, 304, 136, 140
    .word 300, 304, 148, 152

    // Rama de apoyo
    .word 304, 308, 140, 148
    .word 304, 312, 156, 160
    .word 304, 308, 152, 156
    .word 314, 318, 152, 156

    // Letra 'C'
    .word 310, 314, 140, 148
    .word 314, 322, 136, 140
    .word 314, 322, 148, 152


tabla_rectangulos:
    .word 284, 364, 8, 4
    .word 284, 356, 4, 8
    .word 284, 356, 8, 4
    .word 288, 348, 4, 8
    .word 284, 348, 8, 4

    .word 296, 352, 4, 12
    .word 300, 348, 4, 4
    .word 300, 364, 4, 4
    .word 304, 352, 4, 12

    .word 312, 364, 8, 4
    .word 312, 356, 4, 8
    .word 312, 356, 8, 4
    .word 316, 348, 4, 8
    .word 312, 348, 8, 4

    .word 324, 348, 8, 4
    .word 324, 348, 4, 8
    .word 324, 356, 8, 4
    .word 328, 356, 4, 8
    .word 324, 364, 8, 4

    .word 320, 344, 4, 4
    .word 280, 344, 4, 4
    .word 304, 344, 4, 4
    .word 340, 336, 4, 4
    .word 344, 332, 4, 4
    .word 348, 328, 4, 8
    .word 332, 340, 8, 4
    .word 328, 344, 4, 4
    .word 328, 324, 4, 16

tabla_pasto:
    .word 52, 236, 4, 4
    .word 56, 232, 4, 4
    .word 60, 236, 260, 4
    .word 352, 236, 200, 4
    .word 552, 240, 8, 4
    .word 560, 236, 8, 4
    .word 568, 240, 20, 4
    .word 68, 240, 8, 8
    .word 100, 240, 4, 8
    .word 120, 240, 4, 8
    .word 148, 240, 4, 4
    .word 156, 240, 4, 4
    .word 176, 240, 160, 4
    .word 340, 240, 120, 4
    .word 464, 240, 80, 4
    .word 80, 232, 8, 4
    .word 116, 232, 12, 4
    .word 160, 232, 4, 4
    .word 168, 232, 4, 4
    .word 176, 232, 4, 4
    .word 180, 232, 4, 4
    .word 260, 232, 8, 4
    .word 272, 232, 20, 4
    .word 320, 232, 32, 4
    .word 404, 232, 4, 4
    .word 412, 232, 4, 4
    .word 448, 232, 4, 4
    .word 456, 232, 4, 4
    .word 464, 232, 4, 4
    .word 500, 232, 12, 4
    .word 128, 244, 116, 4
    .word 268, 244, 168, 4
    .word 60, 244, 48, 4
    .word 480, 244, 8, 4
    .word 512, 244, 12, 4
    .word 72, 248, 4, 4
    .word 100, 248, 12, 4
    .word 204, 248, 4, 4
    .word 248, 248, 24, 4
    .word 320, 248, 4, 4
    .word 364, 248, 8, 4
    .word 400, 248, 12, 4

tabla_dustin: //usamos .quad (quad=4), 4Words = 4*2Byte = 8Byte = 64 bits para almacenar el color. Para crearlos originalmente usabamos: movz, para "limpiar" el registro y cargabamos la parte menos significativa con lsl #0, y la parte mas significativa usando movk, (que no limipia el registro), para cargar la parte mas signficativa con lsl #!6

    .quad 94, 144, 32, 32, 0xFFFFCCAA      // cara
    .quad 98, 140, 24, 12, 0xFFFFFFFF      // parte blanca de la gorra
    .quad 98, 140, 4, 4,   0x000000FF      // azul gorra izq
    .quad 90, 148, 8, 8,   0x000000FF      // azul gorra izq
    .quad 94, 144, 4, 4,   0x000000FF      // azul gorra izq
    .quad 122,148, 8, 4,   0x000000FF      // azul gorra der
    .quad 122,144, 4, 4,   0x000000FF      // azul gorra der
    .quad 98, 152, 38, 4,  0xFFFF0000      // borde rojo gorra

    // Cabeza - Mentón y Cuello
    .quad 98, 176, 24, 4,  0xFFFFCCAA      // mentón
    .quad 106, 180, 8, 4,  0xFFFFCCAA      // cuello

    // Capucha y Pelo
    .quad 90, 156, 8, 4,   0xFF8B4513      // capucha pegada a la gorra (color de fondo)
    .quad 102, 156, 20, 4, 0xFFCD853F      // pelo
    .quad 114, 160, 4, 4,  0xFFCD853F      // mechón de pelo solo
    .quad 90, 160, 4, 12,  0xFF8B4513      // parte vertical gorra izquierda
    .quad 98, 172, 4, 12,  0xFF8B4513      // unión capucha con campera parte izquierda
    .quad 124, 156, 4, 8,  0xFF8B4513      // parte alta de la capucha lado derecho
    .quad 124, 168, 4, 8,  0xFF8B4513      // detalle capucha parte derecha
    .quad 118, 172, 6, 12, 0xFF8B4513      // unión capucha con campera (derecha)
    .quad 126, 160, 4, 16, 0xFF8B4513      // detalle capucha parte derecha (más abajo)
    .quad 128, 168, 4, 4,  0xFF8B4513      // detalle capucha parte derecha (pequeño)
    .quad 94, 168, 4, 12,  0xFF8B4513      // detalle capucha parte izquierda (más abajo)
    .quad 86, 164, 4, 8,   0xFF8B4513      // detalle capucha parte izquierda (exterior)

    // Ojos y Boca
    .quad 114, 164, 4, 4,  0xFF000000      // ojo derecho (negro)
    .quad 102, 164, 4, 4,  0xFF000000      // ojo izquierdo (negro)
    .quad 106, 172, 8, 4,  0xFFA0522D      // boca

    // Cuerpo - Bordes del cuello y Hombros
    .quad 102, 180, 4, 12, 0xFFCD853F      // detalle marrón claro de la campera (izquierda)
    .quad 114, 180, 4, 12, 0xFFCD853F      // detalle marrón claro de la campera (derecha)
    .quad 94, 184, 8, 8,   0xFFA0522A      // hombro izquierdo
    .quad 118, 184, 8, 8,  0xFFA0522A      // hombro derecho
    .quad 106, 184, 8, 4,  0xFFFAEBD7      // cuello (central)

    // Campera y Remera
    .quad 98, 192, 8, 20,  0xFFA0522A      // campera parte del torso (izquierda)
    .quad 106, 188, 8, 24, 0xFFFFFFFF      // remera de abajo (blanco)
    .quad 114, 192, 8, 20, 0xFFA0522A      // campera parte del torso (derecha)

    // Brazos y Puños
    .quad 88, 188, 6, 20,  0xFFA0522A      // manga de campera (izquierda)
    .quad 88, 208, 6, 4,   0xFFCD853F      // puño de campera (izquierda)
    .quad 126, 188, 6, 20, 0xFFA0522A      // manga de campera (derecha)
    .quad 126, 208, 6, 4,  0xFFCD853F      // puño de campera (derecha)

    // Manos
    .quad 92, 212, 6, 6,   0xFFFFCCAA      // mano izquierda
    .quad 122, 212, 6, 6,  0xFFFFCCAA      // mano derecha

    // Piernas
    .quad 102, 212, 6, 24, 0xFF203A80      // jean (pierna izquierda)
    .quad 112, 212, 6, 24, 0xFF203A80      // jean (pierna derecha)

    // Pies
    .quad 98, 236, 8, 6,   0xFFFFFFFF      // pie izquierdo (blanco)
    .quad 114, 236, 8, 6,  0xFFFFFFFF      // pie derecho (blanco)


	tabla_will:
	// Cabeza
	.quad 176, 304, 32, 24, 0xFFFFCCAA      // cara
	.quad 180, 300, 24, 4,  0xFFFFCCAA      // mentón
	.quad 188, 296, 8, 4,   0xFFCCA874      // cuello
	.quad 180, 336, 24, 4,  0xFF444444      // 1era parte del pelo
	.quad 176, 328, 32, 8,  0xFF444444      // 2da parte del pelo
	.quad 172, 304, 4, 28,  0xFF444444      // pelo vertical izquierdo
	.quad 208, 304, 4, 28,  0xFF444444      // pelo vertical derecho
	.quad 176, 300, 4, 12,  0xFF444444      // pelo vertical al lado del mentón izquierdo
	.quad 204, 300, 4, 12,  0xFF444444      // pelo vertical al lado del mentón derecho
	.quad 180, 300, 4, 4,   0xFF444444      // pelo al lado del mentón izquierdo
	.quad 200, 300, 4, 4,   0xFF444444      // pelo al lado del mentón derecho
	.quad 176, 320, 8, 8,   0xFF444444      // flequillo izquierdo
	.quad 180, 316, 4, 4,   0xFF444444      // parte del flequillo cae, izquierda
	.quad 184, 324, 12, 4,  0xFF444444      // pelo en la frente
	.quad 204, 320, 4, 8,   0xFF444444      // mechón vertical derecha
	.quad 184, 312, 4, 4,   0xFF000000      // ojo izquierdo (negro)
	.quad 196, 312, 4, 4,   0xFF000000      // ojo derecho (negro)
	.quad 188, 304, 8, 4,   0xFFA0522D      // boca

	// Cuerpo
	.quad 176, 288, 32, 8,  0xFF203A80      // parte superior del torso (azul oscuro)
	.quad 180, 268, 24, 24, 0xFF880033      // campera (marrón)
	.quad 184, 264, 4, 36,  0xFF880033      // hombro alto izq
	.quad 196, 264, 4, 36,  0xFF880033      // hombro alto der
	.quad 188, 268, 8, 28,  0xFFEEEEEE      // remera blanca

	// Brazos
	.quad 172, 268, 4, 24,  0xFF203A80      // mangas remera brazo izquierdo (azul oscuro)
	.quad 208, 268, 4, 24,  0xFF203A80      // mangas remera brazo derecho (azul oscuro)
	.quad 172, 268, 4, 16,  0xFFEEEEEE      // remera blanca manga izquierda (parte visible)
	.quad 208, 268, 4, 16,  0xFFEEEEEE      // remera blanca manga derecha (parte visible)

	// Manos
	.quad 176, 264, 4, 4,   0xFFFFCCAA      // mano izquierda
	.quad 204, 264, 4, 4,   0xFFFFCCAA      // mano derecha

	// Piernas
	.quad 184, 248, 4, 20,  0xFF2F3C75      // pierna izquierda (jeans)
	.quad 196, 248, 4, 20,  0xFF2F3C75      // pierna derecha (jeans)

	// Pies
	.quad 180, 244, 8, 6,   0xFFFFFFFF      // pie izquierdo (blanco)
	.quad 196, 244, 8, 6,   0xFFFFFFFF      // pie derecho (blanco)

tabla_max:
	.quad 252, 152, 40, 20, 0xFFFFCCAA // Cabeza: piel parte alta de la cara
	.quad 264, 140, 16, 4, 0xFFCC3020 // Cabeza: mechon alto del pelo
	.quad 252, 144, 40, 12, 0xFFCC3020 // Cabeza: 1era parte del pelo
	.quad 248, 156, 8, 32, 0xFFCC3020 // Cabeza: parte vertical izquierda del pelo
	.quad 288, 156, 8, 32, 0xFFCC3020 // Cabeza: parte vertical derecha del pelo
	.quad 256, 172, 32, 8, 0xFFFFCCAA // Cabeza: piel parte baja de la cara
	.quad 254, 156, 12, 4, 0xFFCC3020 // Cabeza: parte del flequillo izquierdo
	.quad 276, 156, 12, 4, 0xFFCC3020 // Cabeza: parte del flequillo derecho
	.quad 264, 164, 4, 4, 0xFF000000 // Cabeza: ojo izq
	.quad 276, 164, 4, 4, 0xFF000000 // Cabeza: ojo derecho
	.quad 268, 172, 8, 4, 0xFFA0522D // Cabeza: boca
	.quad 260, 180, 24, 4, 0xFFFFCCAA // Cuello: 1er parte del cuello
	.quad 268, 184, 8, 4, 0xFFFFCCAA // Cuello: 2da parte del cuello
	.quad 256, 188, 32, 8, 0xCC80D0FF // Cuerpo: Hombros - Campera
	.quad 268, 188, 8, 8, 0xFFEEEEEE // Cuerpo: Remera de abajo
	.quad 260, 196, 24, 20, 0xCC80D0FF // Cuerpo: Panza - Campera
	.quad 264, 184, 4, 12, 0xFFFFFF00 // Cuerpo: Bordes del cuello y detalles del cierre - cierre campera
	.quad 276, 184, 4, 12, 0xFFFFFF00 // Cuerpo: Bordes del cuello y detalles del cierre - cierre campera
	.quad 268, 196, 8, 4, 0xFFFFFF00 // Cuerpo: Bordes del cuello y detalles del cierre - cierre campera
	.quad 252, 192, 4, 24, 0xCC80D0FF // Brazo: Campera
	.quad 288, 192, 4, 24, 0xCC80D0FF // Brazo: Campera
	.quad 252, 204, 4, 8, 0xFFFFFF00 // Brazo: detalle campera
	.quad 288, 204, 4, 8, 0xFFFFFF00 // Brazo: detalle campera
	.quad 256, 216, 4, 4, 0xFFFFCCAA // Manos
	.quad 284, 216, 4, 4, 0xFFFFCCAA // Manos
	.quad 264, 216, 4, 20, 0xFF2F3C75 // Piernas: pantalones
	.quad 276, 216, 4, 20, 0xFF2F3C75 // Piernas: pantalones
	.quad 260, 236, 8, 6, 0xFFFFFFFF // Pies
	.quad 276, 236, 8, 6, 0xFFFFFFFF // Pies

tabla_lucas:
	.quad 338, 140, 24, 4, 0xFFA97253 // Cabeza: parte superior de la frente / pelo
	.quad 334, 144, 32, 32, 0xFFA97253 // Cabeza: base de la cabeza / cara
	.quad 330, 148, 4, 20, 0xFFA97253 // Cabeza: lado izquierdo de la cara
	.quad 366, 148, 4, 20, 0xFFA97253 // Cabeza: lado derecho de la cara
	.quad 338, 176, 24, 4, 0xFFA97253 // Cabeza: barbilla / parte inferior de la cara
	.quad 346, 180, 8, 4, 0xFFA97253 // Cuello: parte inferior del cuello
	.quad 346, 170, 8, 4, 0xFFA0522D // Boca
	.quad 342, 180, 4, 4, 0xFFA54F50 // Cuerpo: Borde izquierdo del cuello
	.quad 354, 180, 4, 4, 0xFFA54F50 // Cuerpo: Borde derecho del cuello
	.quad 334, 184, 32, 8, 0xFFA54F50 // Cuerpo: Hombros
	.quad 338, 192, 24, 20, 0xFFA54F50 // Cuerpo: Panza
	.quad 328, 188, 6, 24, 0xFFA54F50 // Brazo izquierdo
	.quad 366, 188, 6, 24, 0xFFA54F50 // Brazo derecho
	.quad 332, 212, 6, 6, 0xFFFFCCAA // Mano izquierda
	.quad 362, 212, 6, 6, 0xFFFFCCAA // Mano derecha
	.quad 342, 212, 6, 24, 0xFF952225 // Pierna izquierda: pantalones
	.quad 352, 212, 6, 24, 0xFF952225 // Pierna derecha: pantalones
	.quad 338, 236, 8, 6, 0xFFFFFFFF // Pie izquierdo
	.quad 354, 236, 8, 6, 0xFFFFFFFF // Pie derecho
	.quad 338, 140, 24, 4, 0xFF411401 // Pelo: parte superior
	.quad 334, 144, 4, 4, 0xFF411401 // Pelo: superior izquierda 1
	.quad 330, 148, 4, 4, 0xFF411401 // Pelo: superior izquierda 2
	.quad 362, 144, 4, 4, 0xFF411401 // Pelo: superior derecha 1
	.quad 366, 148, 4, 4, 0xFF411401 // Pelo: superior derecha 2
	.quad 334, 156, 12, 4, 0xFF411401 // Pelo: flequillo izquierdo
	.quad 334, 160, 4, 4, 0xFF411401 // Pelo: detalle flequillo izquierdo
	.quad 354, 156, 12, 4, 0xFF411401 // Pelo: flequillo derecho
	.quad 362, 160, 4, 4, 0xFF411401 // Pelo: detalle flequillo derecho
	.quad 338, 144, 24, 4, 0xFF93995D // Pelo: Verde Oscuro 1
	.quad 334, 148, 32, 4, 0xFF93995D // Pelo: Verde Oscuro 2
	.quad 334, 152, 8, 4, 0xFF93995D // Pelo: Verde Oscuro 3
	.quad 358, 152, 8, 4, 0xFF93995D // Pelo: Verde Oscuro 4
	.quad 330, 156, 4, 4, 0xFF93995D // Pelo: Verde Oscuro 5
	.quad 366, 156, 4, 4, 0xFF93995D // Pelo: Verde Oscuro 6
	.quad 330, 152, 4, 4, 0xFFE7D887 // Pelo: Verde Claro 1
	.quad 366, 152, 4, 4, 0xFFE7D887 // Pelo: Verde Claro 2
	.quad 350, 144, 4, 4, 0xFFE7D887 // Pelo: Verde Claro 3 (en la parte superior de la cabeza)
	.quad 354, 148, 4, 4, 0xFFE7D887 // Pelo: Verde Claro 4 (en la parte superior de la cabeza)
	.quad 346, 184, 8, 28, 0xFF6AD3FF // Marron piel (superpuesto por Celeste)
	.quad 346, 184, 8, 28, 0xFF6AD3FF // Celeste (esto parece ser el color principal de la ropa de Lucas, superponiendo el "marrón piel" anterior)
	.quad 338, 188, 24, 8, 0xFFC1A991 // Crema (Parece ser una parte de la remera o cuello)
	.quad 338, 164, 4, 4, 0xFF000000 // Ojo izquierdo
	.quad 358, 164, 4, 4, 0xFF000000 // Ojo derecho


	tabla_eleven:
.quad 418, 172, 8, 4, 0xFFA0522D // Cabeza: boca
.quad 418, 140, 24, 4, 0xFFF4A58A // Cabeza: parte superior de la frente / pelo
.quad 414, 144, 32, 32, 0xFFFFCCAA // Cabeza: base de la cabeza / cara
.quad 414, 144, 32, 8, 0xFFF4A58A // Cabeza: parte del pelo (superpuesto a la cara)
.quad 422, 152, 16, 4, 0xFFF4A58A // Cabeza: pelo central
.quad 418, 160, 4, 4, 0xFF000000 // Ojos: ojo izquierdo
.quad 438, 160, 4, 4, 0xFF000000 // Ojos: ojo derecho
.quad 410, 148, 4, 20, 0xFFF4A58A // Cabeza: lado izquierdo del pelo
.quad 410, 168, 4, 4, 0xFFFFCCAA // Cabeza: piel (parte inferior izquierda de la cara)
.quad 446, 148, 4, 20, 0xFFF4A58A // Cabeza: lado derecho del pelo
.quad 446, 168, 4, 4, 0xFFFFCCAA // Cabeza: piel (parte inferior derecha de la cara)
.quad 418, 176, 24, 4, 0xFFFFCCAA // Cabeza: barbilla / parte inferior de la cara
.quad 426, 180, 8, 4, 0xFFFFCCAA // Cuello: parte inferior del cuello
.quad 426, 170, 8, 4, 0xFFA0522D // Boca (repetido, asegúrate de que esto sea intencional si no, podría superponerse)
.quad 422, 180, 4, 4, 0xFF5F3DC4 // Cuerpo: Borde izquierdo del cuello
.quad 434, 180, 4, 4, 0xFF5F3DC4 // Cuerpo: Borde derecho del cuello
.quad 418, 184, 24, 8, 0xFF5F3DC4 // Cuerpo: Hombros
.quad 422, 184, 16, 40, 0xFFD8A6A3 // Cuerpo: Panza (principal de la vestimenta)
.quad 426, 184, 8, 4, 0xFFFFFFFF // Cuerpo: Detalle blanco (puede ser un cuello de camisa o detalle en el pecho)
.quad 422, 184, 4, 20, 0xFF5F3DC4 // Cuerpo: Detalle vertical izquierdo
.quad 434, 184, 4, 20, 0xFF5F3DC4 // Cuerpo: Detalle vertical derecho
.quad 414, 188, 4, 24, 0xFF5F3DC4 // Brazo izquierdo
.quad 442, 188, 4, 24, 0xFF5F3DC4 // Brazo derecho
.quad 418, 212, 4, 4, 0xFFFFCCAA // Mano izquierda
.quad 438, 212, 4, 4, 0xFFFFCCAA // Mano derecha
.quad 422, 224, 4, 12, 0xFFFFCCAA // Pierna izquierda
.quad 434, 224, 4, 12, 0xFFFFCCAA // Pierna derecha
.quad 418, 236, 8, 6, 0xFFFFFFFF // Pie izquierdo
.quad 434, 236, 8, 6, 0xFFFFFFFF // Pie derecho


tabla_mike:
.quad 498, 136, 20, 4, 0xFF1C1C1C // Cabeza: pelo, parte superior central
.quad 490, 140, 32, 4, 0xFF1C1C1C // Cabeza: pelo, parte superior ancha
.quad 494, 144, 32, 32, 0xFFFFCCAA // Cabeza: piel base de la cara
.quad 486, 144, 40, 4, 0xFF1C1C1C // Cabeza: pelo, sobre la frente
.quad 514, 144, 4, 4, 0xFFFFCCAA // Cabeza: piel, parte superior derecha (puede ser oreja o detalle de cara)
.quad 486, 148, 44, 4, 0xFF1C1C1C // Cabeza: pelo, más abajo sobre la frente
.quad 510, 148, 8, 4, 0xFFFFCCAA // Cabeza: piel, parte superior derecha de la cara
.quad 486, 152, 48, 4, 0xFF1C1C1C // Cabeza: pelo, debajo de la frente
.quad 506, 152, 20, 4, 0xFFFFCCAA // Cabeza: piel, centro de la cara (parte superior de los ojos)
.quad 486, 156, 48, 4, 0xFF1C1C1C // Cabeza: pelo, borde inferior
.quad 498, 156, 28, 4, 0xFFFFCCAA // Cabeza: piel, parte media de la cara (debajo de los ojos)
.quad 486, 160, 4, 16, 0xFF1C1C1C // Cabeza: pelo, lateral izquierdo
.quad 530, 160, 4, 12, 0xFF1C1C1C // Cabeza: pelo, lateral derecho
.quad 490, 160, 4, 8, 0xFFFFCCAA // Cabeza: piel, lateral izquierdo de la cara
.quad 526, 160, 4, 8, 0xFFFFCCAA // Cabeza: piel, lateral derecho de la cara
.quad 505, 170, 8, 4, 0xFFA0522D // Boca
.quad 498, 164, 4, 4, 0xFF000000 // Ojo izquierdo
.quad 518, 164, 4, 4, 0xFF000000 // Ojo derecho
.quad 526, 168, 4, 12, 0xFF1C1C1C // Pelo: detalle lateral 
.quad 530, 176, 4, 4, 0xFF1C1C1C // Pelo: detalle lateral 
.quad 558, 168, 4, 12, 0xFF1C1C1C // Pelo: detalle lateral 
.quad 554, 176, 4, 4, 0xFF1C1C1C // Pelo: detalle lateral 
.quad 498, 176, 24, 4, 0xFFFFCCAA // Cabeza: barbilla / parte inferior de la cara
.quad 506, 180, 8, 4, 0xFFFFCCAA // Cuello: parte inferior
.quad 502, 180, 4, 4, 0xFFA5B78D // Cuerpo: borde izquierdo del cuello
.quad 514, 180, 4, 4, 0xFFA5B78D // Cuerpo: borde derecho del cuello
.quad 494, 184, 32, 8, 0xFFA5B78D // Cuerpo: hombros
.quad 498, 192, 24, 20, 0xFFA5B78D // Cuerpo: torso principal
.quad 506, 184, 8, 28, 0xFFFFFFFF // 
.quad 506, 192, 8, 16, 0xFF0D3286 //
.quad 506, 196, 8, 8, 0xFFF7D038 // 
.quad 488, 188, 6, 24, 0xFFA5B78D // Brazo izquierdo
.quad 526, 188, 6, 24, 0xFFA5B78D // Brazo derecho
.quad 492, 212, 6, 6, 0xFFFFCCAA // Mano izquierda
.quad 522, 212, 6, 6, 0xFFFFCCAA // Mano derecha
.quad 502, 212, 6, 24, 0xFF5F3DC4 // Pierna izquierda
.quad 512, 212, 6, 24, 0xFF5F3DC4 // Pierna derecha
.quad 498, 236, 8, 6, 0xFFFFFFFF // Pie izquierdo
.quad 514, 236, 8, 6, 0xFFFFFFFF // Pie derecho
