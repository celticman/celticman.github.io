# NAS con Linux (Ubuntu)

## Paquetes necesarios

Usaremos las siguientes utilidades:

- fdisk: (particionado)
- badblocks: contenido en e2fsprogs (comprobación de escritura)
- smartctl: contenido en smartmontools (Lectura estadísticas SMART)
- lsblk: contenido en util-linux

En Ubuntu se instalarían con:

	apt install fdisk e2fsprogs smartmontools util-linux


## Comprobar los discos duros a utilizar

1. Comprobar que disco duro se quiere probar

	lsblk -o NAME,MAJ:MIN,RM,SIZE,RO,TYPE,MOUNTPOINT,MODEL,SERIAL
	
2. Leer los datos SMART antes de ejecutar badblocks:

	2.1. Imprime los test disponibles en el disco>
	
		sudo smartctl -c /dev/sdX
		
	2.2. Imprime la información del disco:

		sudo smartctl -i /dev/sdX > sdX_smart_informacion.txt
		
	2.3. Ejecutamos un test corto ó el largo:
	
		sudo smartctl -t short -C /dev/sdX
		
		sudo smartctl -t long -C /dev/sdX
		
	2.4. Visualizamos los resultados del test anterior:
	
		sudo smartctl -a /dev/sdX > sdX_smart_inicial.txt

3. Extraer los datos de tamaño de bloque del disco:

	sudo -n blockdev --getbsz /dev/sdX
	
4. Ejecutar el programa badblocks con lectura y escritura

	** Atención los siguientes test son destructivos **

	4.1. Ejecutar un test completo (con varios tramas de datos):

		sudo badblocks -wsv /dev/sdx

	4.2. Ejecutar un test rápido (con una sola trama de datos):

		sudo badblocks -wsv -t 0xAA /dev/sdx

5. Comprobar el efecto de la escritura y lectura de todos los bloques:

	5.1. Volver a ejecutar el test SMART (corto o largo):

		sudo smartctl -t short -C /dev/sdX
		
		sudo smartctl -t long -C /dev/sdX

	5.2. Generar los resultados:
	
		sudo smartctl -a /dev/sdX > sdX_smart_final.txt
		
6. Comparar los dados iniciales (sdX_smart_inicial.txt) y finales (sdX_smart_final.txt):

	6.1. Abrir los dos ficheros
	
		
		
	6.2. Comparar
	
