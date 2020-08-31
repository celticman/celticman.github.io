## Uso de particiones cifradas en Linux

### Instrucciones creación de volumen CIFRADO

0.0) Verificar si existen particiones en el disco duro externo

	fdisk -l /dev/sdb

0.1) Si no existen hay que crearla con:

	fdisk /dev/sdb

		Comando1:	n (nueva particion)
		Comando2:	p (partición primaria)
		Comando3:	(valor predeterminado)
		Comando4:	(valor predeterminado)
		Comando5:	w	(escribir la nueva partición y salir)

1) Crear unidad cifrada

	cryptsetup --verbose --cipher "aes-cbc-essiv:sha256" --key-size 256 --verify-passphrase luksFormat /dev/sdb1

2) Descifrar volumen

	cryptsetup luksOpen /dev/sdb1 HD1

3) Formatear volumen

	mkfs.ext4 /dev/mapper/HD1

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
