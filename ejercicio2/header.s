.equ SCREEN_WIDTH, 		640
	.equ SCREEN_HEIGH, 		480
	.equ BITS_PER_PIXEL,  	32

	.equ GPIO_BASE,      0x3f200000
	.equ GPIO_GPFSEL0,   0x00
	.equ GPIO_GPLEV0,    0x34
    
	// Colores
.equ BLACK,          0xFF000000
.equ WHITE,          0xFFFFFFFF
.equ YELLOW,         0xFFFFFF00
.equ CYAN,           0xFF00FFFF
.equ MAGENTA,        0xFFFF00FF
.equ RED,            0xFFFF0000
.equ GREEN,          0xFF00FF00
.equ BLUE,           0xFF0000FF
// Colores (asegúrate de que RED esté aquí)
.equ STAR_ORIGINAL_COLOR, 0xFF2E91B9// Amarillo/Blanco para estrellas (ajústalo al color original que uses)
// ... otros colores que ya tengas
