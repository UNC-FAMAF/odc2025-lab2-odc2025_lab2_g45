Nombre y apellido 
Integrante 1: Emma Micaela Barraud
Integrante 2: Aquiles Ayax Ulises Fraenza
Integrante 3: Luca Gonzalez
Integrante 4: Lautaro Julián Ríos


Descripción ejercicio 1: La imagen muestra a los personajes de Stranger Things, de pie frente a un bosque azul oscuro. Del lado de abajo vemos a "Will", que está en el "upside down" y debajo de "Eleven" vemos al demogorgon. "ODC 2025" está escrito entre las ramas (al medio).



Descripción ejercicio 2: Volvimos a usar la imagen del ejercicio 1, animando a Eleven, que levanta el brazo y sangra de la nariz mientras "saca" a Will del Upside Down. Luego la pantalla se "come" el dibujo, y al final sale la Intro de Stranger things, solo que dice "Odc 2025". Esto se repite infinitamente.


Justificación instrucciones ARMv8:


Uso de instrucciones ARMv8:Usamos algunas que no están en LEGv8 porque nos permitian trabajar de forma más eficiente con los datos. Lo que usamos fue:

  .quad: para definir tablas de objetos donde cada entrada tiene varios valores. Si hubiéramos tenido que usar .word, habría sido mucho más engorroso manejaresos datos.

  ldr x1, [x19], #8: Esta instrucción nos permite recorrer las tablas de 64 bits avanzando automáticamente. Si hubiéramos tenido que hacerlo con registros de 32 bits, el código sería más largo.

  ldr xN, =label: simplifica cargar direcciones de tablas. Si hubiéramos tenido que usar adrp y add todo el tiempo, el código habría sido más difícil de leer y mantener.

