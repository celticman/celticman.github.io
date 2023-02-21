# NAS con Linux (Ubuntu)

## Paquetes necesarios

Usaremos las siguientes utilidades:

- fdisk: (particionado)
- badblocks: contenido en e2fsprogs (comprobación de escritura)
- smartctl: contenido en smartmontools (Lectura estadísticas SMART)
- lsblk: contenido en util-linux
- utilidades ZFS: zfsutils-linux
- cryptsetup: PAra usar particiones LUKS

En Ubuntu se instalarían con:

	apt install fdisk e2fsprogs smartmontools util-linux zfsutils-linux cryptsetup-bin


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

	Según del artículo: https://www.backblaze.com/blog/hard-drive-smart-stats/

	Ejecutar el siguiente comando para comparar los dos resultados:
	
		cat sdX_smart*.txt | grep 'Reallocated\|Reported\|Command_Ti\|Current\|Offline_Un'
	
	Por orden de importantancia:
	
		- Reallocated Sectors Count
		- Reported Uncorrectable Errors
		- Command Timeout
		- Current Pending Sector Count
		- Uncorrectable Sector Count
		
	Según el disco hay fallo ó no ejecutando:
	
		smartctl -H /dev/sdX
		
## Creación mirror de 3 discos BTRFS (Raid 1C3) con cifrado luks

1. Crear las particiones en los discos:

	fdisk /dev/sdX

		Comando1:	n (nueva particion)
		Comando2:	p (partición primaria)
		Comando3:	(valor predeterminado)
		Comando4:	(valor predeterminado)
		Comando5:	w	(escribir la nueva partición y salir)
		
3. Crear fichero con clave cifrado

	sudo touch /etc/btrfs_clave_cifrado
	sudo chmod 600 /etc/btrfs_clave_cifrado
	
4. Escribir la clave en el fichero

	sudo vim /etc/btrfs_clave_cifrado

5. Cifrado de las particiones a utilizar, para todas las particiones creadas (p.ej.: /dev/sdb1 /dev/sdc1 /dev/sdd1).

	cryptsetup luksFormat --type luks2 /dev/sdX1 /etc/btrfs_clave_cifrado

6. Extraer los UUID de las particiones cifradas con LUKS:

	sudo cryptsetup luksDump /dev/sdX | grep UUID


	

## Creación mirror de 3 discos con ZFS con cifrado nativo

Basado en (https://bhoey.com/blog/3-way-disk-mirrors-with-zfsonlinux/) y (https://ubuntu.com/tutorials/setup-zfs-storage-pool#1-overview).

1. Verificar los discos sobre los que se quiere crear la partición

	- Listado del disco:
	
		lsblk -o NAME,MAJ:MIN,RM,SIZE,RO,TYPE,MOUNTPOINTS,UUID,PARTUUID
	
	- Listado particiones:
	
		sudo fdisk -l
		
2. Creación de las particiones en los discos a usar:

    - Se usaran /dev/sdb /deb/sdc /deb/sdd
	
	- Crear agrupacion de ZFS (Pool):
	
		sudo zpool create -m /srv/espejo espejo mirror /dev/sdb /dev/sdc /dev/sdd
		
	- Habilitar el cifrado en la agrupación de ZFS (Pool):
	
		sudo zpool set feature@encryption=enabled espejo
		
	- Activar el cifrado del conjunto de datos:
	
		zfs create -o encryption=on -o keylocation=prompt -o keyformat=passphrase espejo/compartir
		
		zfs create -o encryption=on -o keylocation=file:///etc/zfs_clave_cifrado -o keyformat=passphrase espejo/compartir
		
	El disco está montado en /srv/espejo
	
3. Comprobación estado online 

	sudo zpool status
	
4. Ejecutar una verificación del conjunto ZFS (Pool):

	sud zpool scrub espejo

