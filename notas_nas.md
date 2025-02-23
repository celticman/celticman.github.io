# NAS con Linux (Ubuntu)

## Introducción

### Objetivos

El objetivo es tener un NAS con los siguientes objetivos:

1. **Fácil de mantener**, para lo que ha de cumplir los siguientes requisitos:

    - Cada uno de los discos ha de contener todos los datos.
    
    - Ha de ser fácil de montar los discos en otro ordenador: Por ejemplo en caso de fallo del ordenador o del disco de arranque, ha de poder extraerse cualquiera de los discos de datos e insertarlo en otro ordenador.

2. **Instantáneas  (snapshots)** soportadas por el sistema de archivos, que permita recuperar datos borrados por accidente ó sobreescritos.

3. **Verificación (scrub)** de los datos almacenados..

4. **Cifrado** de todos los discos.

### Descripción del sistema

En el PC que ha de actuar como NAS, el servidor ha de estar formado por los siguientes discos:

- **1 disco duro de arranque**: En este disco se instala el sistema operativo con la partición cifrada.

- **2 ó 3 discos duros de datos**: En cada disco duro se crea una partición BTRFS (cifrada con LUKS):

    - Un disco primario en el que se escriben los datos.
    - Uno o dos discos secundarios.

- **Copia de los datos del disco primario al secundario**: Mediante un comando rsync se copian los datos del disco primario (disco1) a los discos secundarios. Este script se ha de ejecutar de forma periódica.

## Sistema operativo

Se instala KUbuntu LTS en el disco duro de arranque, con cifrado LUKS.

## Paquetes necesarios

Usaremos las siguientes utilidades:

- fdisk: (particionado)
- badblocks: contenido en e2fsprogs (comprobación de escritura)
- smartctl: contenido en smartmontools (Lectura estadísticas SMART)
- lsblk: contenido en util-linux
- cryptsetup: Para usar particiones LUKS
- btrfs-progs: Herramientas gestión BTRFS
- duperemove: Dedupliación

En Ubuntu se instalarían con:

	apt install fdisk e2fsprogs smartmontools util-linux cryptsetup-bin btrfs-progs duperemove
	
## Comprobación de la memoria del PC/NAS

Verificar que la memoria del PC es correcta, para evitar que errores en la memoria provoquen fallos en los datos almacenados. Se puede utiliza [Memtest86+](https://memtest.org/)


## Comprobar los discos duros a utilizar

1. Comprobar que disco duro se quiere probar

	lsblk -o NAME,MAJ:MIN,RM,SIZE,RO,TYPE,MOUNTPOINT,MODEL,SERIAL
	
2. Leer los datos SMART antes de ejecutar badblocks:

	2.1. Imprime los test disponibles en el disco:
	
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
		
7. Spinrite
		
## Preparación de los discos

### Identificación de los discos

Los discos identificados antes, se identifican utilizando lsblk con el siguiente comando:

	lsblk -o NAME,MAJ,MIN,RM,SIZE,RO,TYPE,MOUNTPOINTS,FSTYPE,MODEL,SERIAL
	
Al figurar el número de serie, podemos identificar el disco duro que se va a preparar.

### Particionamiento con KDE Partition Manager

1. Arrancamos KDE Partition Manager

2. Seleccionamos el disco a particionar (comprobando el número de serie que aparece en la pestaña de datos SMART). 

3. Creamos una nueva tabla de particiones GPT.

4. Creamos una nueva particion con los siguientes datos:

    - Tipo: Primario
    - Sistema de archivos: BTRFS
    - Cifrar con LUKS: Sí (Usado la misma contraseña que el disco de arranque)
    - Etiqueta: Por ejemplo DATOS_MODELO_NUM-SERIE (p.ej. DATOS_ST4000-Y4PC)
    
5. Identificamos la el UUID de la particion cifrada.

6. Modificamos el fichero /etc/crypttab añadiendo una nueva línea con el siguiente formato:

		NUMERO-SERIE_crypt UUID="UUID DE LA PARTICIÓN CIFRADA" none luks, discard
	
	Por ejemplo sería:
	
		qazwsx_crypt UUID="e4d76f43-e510-4b5d-a422-e92d1075d93c" none luks, discard
	
    Nota: No es necesario introducir la contraseña utilizando crypttab si se utiliza la misma contraseña que para el disco de arranque.

	
7. Creamos los directorios de almacenamiento de los discos 1 y 2:

	mkdir /srv/datos1
	mkdir /srv/datos2
	
	
8. Montamos la partición automaticamente usando /etc/fstab. Se añade una nueva línea:

	/dev/mapper/qazwsx_crypt /srv/datos1 defaults   0 0
	mágenes

9. Repetir los pasos 2 a 8 para el segundo disco. Cambiando:

    - /srv/datos1 -> /srv/datos2
    - "qazwsx" por los 6 últimos caracteres del número de serie del segundo disco.
    

## Gestión de instantáneas (snapshots)

Basado en [Snapshots con Btrfs de inlab.fib.upc.edu](https://inlab.fib.upc.edu/es/blog/snapshots-con-btrfs).

Para la gestión de imágenes se utilizará Snapper que es una herramienta creda por openSUSE para la gestión de instantáneas del sistema de archivos BTRFS.

1. Instalación Snapper

	sudo apt install snapper
	
2. Crear la configuración de Snapper para los dos discos

	sudo snapper -c datos1 create-config /srv/datos1
	sudo snapper -c datos2 create-config /srv/datos2
		
3. Arrancar el servicio de Snapper:

	sudo systemctl enable --now snapper-timeline.timer snapper-cleanup.timer
	
4. Crear un subvolumen

    Ejecutar los siguientes comandos:

		cd /srv/datos1
		sudo btrfs subvolume create datos1-compartir
		
	Debe aparecer un nuevo directorio /srv/datos1/datos1-compartir
	
5.	Crear la configuración de Snapper

	Se ejecuta:
		
		snapper -c datos1 create-config /srv/datos1
		snapper -c datos2 create-config /srv/datos2
		
	Se confirma que se han creado la configuración ejecutando:
	
		snapper list-configs
		
6. Realizar una instantánea:

	Se ejecuta:
	
		snapper -c datos1 create
		
	Se listan las instantáneas:
	
		snapper -c datos1 list
		
7. Creación automática de instantáneas

	Por defecto Snapper debe realizar imágenes automáticamente de los directorios configurados. La configuración de retención de las instantáneas debe ser (que aparece en /etc/snapper/configs/datos1 ) son:

	- TIMELINE_LIMIT_HOURLY="36"
	- TIMELINE_LIMIT_DAILY="10"
	- TIMELINE_LIMIT_WEEKLY="6"
	- TIMELINE_LIMIT_MONTHLY="14"
	- TIMELINE_LIMIT_YEARLY="10"
	
8. Acceso a las instantáneas:


    Se puede acceder a las instantánea en la siguiente ruta:
	
    	/srv/datos1/.snapshots
	
    Dentro del directorio anterior aparecerán las instantáneas por su número (en el subdirectorio snapchot).
    

				
9. Borrar instantáneas

				snapper -c datos1 delete NUMERO-INSTANTANEA


	
## Copia de datos del disco1 al disco2

Crear un el fichero **/srv/scripts/sincronizar_datos1-datos2.sh**, que contiene los siguientes comandos:

	echo "sincronizar_datos1_datos2.sh inicio $dato --rfc-3339=seconds)"  >> /srv/scripts/sincronizar.log

	ruta1="/srv/datos1"
	if mountpoint -q "$ruta1"; then
			echo "Montado"
	else
			echo "    $ruta1 NO montado" >> /srv/scripts/sincronizar.log
			exit 1
	fi

	ruta2="/srv/datos2"
	if mountpoint -q "$ruta2"; then
			echo "Montado"
	else
			echo "    $ruta2 NO montado" >> /srv/scripts/sincronizar.log
			exit 1
	fi
	
	rsync -avh --exclude .snapshots --delete-after /srv/datos1/ /srv/datos2
	
	echo "    fin $(date --rfc-3339=seconds)" >> /srv/scripts/sincronizar.log 
	
Debe ser propiedad de root:

	sudo chown root:root /etc/cron.daily/sincronizar_datos1-datos2.sh
	
Debe tener permiso de ejecución:

	sudo chmod 0700 /etc/cron.daily/sincronizar_datos1-datos2.sh
	
La ejecución del script anterior se hace utilizando crontab, se crea un fichero **/srv/scripts/sincronizar_datos1-datos2.crontab** con el siguiente contenido (lo ejecuta todos los días a las 23:50):

	50 23 * * * /srv/scripts/sincronizar_datos1-datos2.sh
	
Se añade a la ejecución de crontab con la siguiente orden:

	sudo crontab /srv/scripts/sincronizar_datos1-datos2.crontab
	
Comprobamos que se ha añadido con:

	sudo crontab -l
	
Se puede eliminar con:

	sudo crontab -r

## Verificación de los datos almacenados en los discos (Scrub)

La verificación de los datos almacenados se realiza del siguiente modo:

	btrfs scrub start /srv/datos1
	
Se puede consultar el resultado de la verificación con el siguiente comando:

	btrfs scrub status /srv/datos1
	
## Recuperar datos

Se puede recuperar los datos desde una determinada instantánea (snapshot).

Listado de instantáneas:

	snapper -c datos2 list
	
De la lista anterior extraemos el número de instantánea

Se puede navegar por las diferentes instantáneas en la siguiente ruta

	/srv/datos1/.snapshots

De la lista anterior extraemos el número de instantánea y podemos recuperar un fichero con el siguiente comando.

	snapper -c datos2 -v undochange NUMERO-INSTANTANEA..0 FICHERO
	
Si se quiere restaurar todo el sistema de archivos bastaría con:

	snapper -c datos2 -v undochange NUMERO-INSTANTANEA..0
	
## Deduplicación

Para realizar la Deduplicación se puede utilizar la siguiente herramienta:

duperemove -r -d /srv/datos1/compartido

## Asignar una dirección IP fija

Una vez conectado el cable de red, podemos identificar la tarjeta de red con el comando:

	ip link

Editar el fichero **/etc/netplan/01-netcfg.yaml** :

	network:
		version: 2
		renderer: networkd
		ethernets:
			NOMBRE-TARJETA-RED:
				dhcp4: no
				addresses:
					- 192.168.0.2/24
				gateway4: 192.168.0.1
				nameservers:
					addresses: [8.8.8.8, 1.1.1.1]
		
Aplicar con el comando:

	sudo netplan apply
	
## Arrancar servidor SSH

Instalar servidor SSH:

	sudo apt install ssh
	
Comprobar que se está ejecutando:

	sudo systemctl status ssh
	
## FUNCIONES PENDIENTES 

1. Ejecución Automática de Scrub automático (p.ej. cada mes), con notificación.

2. Notificación copia de disco1 a disco2.

3. Ejecución Automática de Deduplicación de datos, con notificación.

4. Compartir los ficheros snapshot

5. Acceso a ficheros vía web:

	- [sftpgo - Fully featured and highly configurable SFTP server](https://github.com/drakkan/sftpgo)
    - [filebrowser - Crear tu cloud, accediendo a los ficheros con una interfaz web](https://filebrowser.org/)
    - [Seafile - Reliable and Performant File Sync and Share Solution](https://www.seafile.com/en/home/): Puede almacenar los ficheros cifrados (encriptados antes de subirlos al servidor).
    - [Pydio - Document Sharing At Scale, Cells V4 now provides secure, cloud-native, scalable, self-hosted, open-core document sharing and collaboration](https://pydio.com)

7. Acceso remoto con VPN (Wireguard)

8. Sincronización ficheros con syncthing

9. Sincronización de contactos y calendario:

	- Radicale
	
10. Backup de servidor:

	- A discos externos
	
	- A otro NAS Simple
	
	- A un servicio en la nube

## Anexo 1 (Enlaces)

- [Encrypted Btrfs Array with LUKS - Kenneth Jørgensen](https://kennethjorgensen.com/blog/2022/encrypted-btrfs-array-with-luks/).

- [Comprobación de discos usando badblocks - Hard Drive Validation or Destructive Wipe with Badblocks - Calomel](https://calomel.org/badblocks_wipe.html)

## Anexo 2 (no usado)

Las siguientes secciones se deja como referencia, pero no se usan por que como se explica anteriormente se prefiere un sistema formado por un disco maestro y un disco esclavo, pero indendientes.

### Creación mirror de 3 discos BTRFS (Raid 1C3) con cifrado luks

**SE DEJA COMO REFERENCIA PERO NO SE USA**

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


	

### Creación mirror de 3 discos con ZFS con cifrado nativo

**SE DEJA COMO REFERENCIA PERO NO SE USA**

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

