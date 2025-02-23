## Uso de particiones cifradas en Linux

### Instrucciones creación de volumen CIFRADO

0.0) Identifica la partición ó disco a utilizar

	lsblk

0.1) Verificar si existen particiones en el disco duro externo

	fdisk -l /dev/sdb

0.2) Si no existen hay que crearla con:

	fdisk /dev/sdb

		Comando1:	n (nueva particion)
		Comando2:	p (partición primaria)
		Comando3:	(valor predeterminado)
		Comando4:	(valor predeterminado)
		Comando5:	w	(escribir la nueva partición y salir)

1) Crear unidad cifrada

	cryptsetup luksFormat /dev/sdb1 --type luks2 --verify-passphrase 

2) Descifrar volumen

	cryptsetup luksOpen /dev/sdb1 HD1

3) Formatear volumen con etiqueta "ETIQUETA"

	mkfs.ext4 /dev/mapper/HD1 -L ETIQUETA

4) Montar volumen

	mount /dev/mapper/HD1 /mnt/HD1


### Para MONTAR:

Para montar es necesario ejecutar lo siguiente:

	#!/bin/sh
	cryptsetup luksOpen /dev/sdb1 HD1
	mount /dev/mapper/HD1 /mnt/HD1


### Para DESMONTAR:

Para montar es necesario ejecutar lo siguiente:

	#!/bin/sh
	umount /dev/mapper/HD1
	cryptsetup luksClose HD1

### Destrucción de datos en discos duros

#### DBAN - Herramienta destrucción de datos en discos duros

[DBAN - Darik's Boot and Nuke](https://sourceforge.net/projects/dban/) - Es una utilidad que se puede arrancar desde un CD ó USB y que borra los datos de todos los discos insertados en un PC, es posibe eleir entre el procedimiento de 7 escrituras ó el corto de 3 escrituras (que para los sistemas actuales de almacenamiento debe ser suficiente).

#### Borrado de datos con shred

Este comando borra un disco con 3 pasadas de datos aleatorios

		sudo shred -v /dev/sdX

		
#### Otras alternativas con la línea de ordenes de linux:

**El siguiente texto es un resumen de https://askubuntu.com/questions/1344289/how-to-securely-delete-wipe-out-a-hard-disk-so-its-hard-to-recover-data**:

#### Eliminación de datos de SSD (y HDD) conectados vía SATA o NVME

En los discos duros HDD y los de estado sólido es muy recomendable que el borrado se realice con las funciones SMART. El propio SSD debe borrar la clave de descifrado y poner todos los bloques a cero, así como marcarlos como que no tienen datos.

1. Bloquee la unidad con hdparm y la opción --security-set-pass

2. Borre la unidad con hdparm y la opción --security-erase

3. Desbloquee la unidad con hdparm y la opción --security-unlock

**Importante: hdparm solo se debe usar en discos conectados día SATA ó NVMe**.

