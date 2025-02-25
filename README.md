# celticman.github.io

## Informatica para niños

- [¿Cómo crear una página web de un niño?](./ninos_github_pages.html).

## Guías

- [Particionamiento disco cifrado con LUKS en Linux](./notas_luks_particion_cifrada.html) 

- [NAS simple con BTRFS](./notas_nas.html) 

- [Uso de vagrant](./notas_vagrant.html)

- [Go - Golang](./notas_golang.html)

- [QEMU y Virt Manager- Golang](./notas_qemu.html)

## Utilidades

### Utilidades Línea de órdenes

- [fzf - fuzzy finder - Busqueda por nombre de fichero o directorio](https://github.com/junegunn/fzf) 

    - Instalar en ubuntu: "sudo apt install fzf".
    - Uso:

        - Ctrl + T: Búsqueda de ficheros
        - Alt + C: Busqueda directorios

- [ag - The silver searcher - Busqueda por contedido de ficheros](https://github.com/ggreer/the_silver_searcher)

    - Instalar en ubuntu: "sudo apt install silversearcher-ag"
    - Uso:

        - Teclear: ag TERMINIO-BUSQUEDA.
        - Para que solo aparezca el listado de ficheros, añadir la opcion "-l".
        - Para que busque la cadena indicada (sin utilizar una expresión regular), añadir "--literal".
        - Para buscar en directorios ocultos, añadir la opción "--hidden".

- [httpie - Línea de ordenes para interaccionar con API HTTP](https://httpie.org/)

    - Instalar en ubuntu: "sudo apt install httpie"
    - Uso:


            http https://ifconfig.me/all.json -p HBhb
            http https://api.weather.gov/points/40,-116 -p HBhb
            http http://worldtimeapi.org/api/ip -p HBhb

        
- [visidata - Visor y editor de hojas de calculo en línea de ordenes](https://www.visidata.org)

    - Instalar en Ubuntu: 

            sudo apt install visidata

    - Uso:
        - Ver un fichero CSV con separador ";": 

            vd input.csv

        - Ver un fichero CSV con separador "ð": 

            vd input.csv --csv-delimiter ð

        
- [ocrmypdf - Genera un pdf con reconocimiento de textos y que se puede buscar](https://ocrmypdf.readthedocs.io/en/latest/index.html)

	- Instalar en Ubuntu: 

            sudo apt install ocrmypdf tesseract-ocr tesseract-ocr-spa jbig2dec


	- Uso:	

            ocrmypdf origen.pdf -l spa destino.pdf 

	
- [espeak-ng - Sintetizador de voz a partir de un texto](https://github.com/espeak-ng/espeak-ng)

	- Instalar en Ubuntu: 

            sudo apt install espeak-ng

	- Uso para que lea la voz de forma directa en Español: 

            espeak-ng -f fichero.txt -v es -s 145 -p 50

	- Uso para que genere un fichero wav en Español: 

            espeak-ng -f fichero.txt -v es -s 145 -p 50 -w fichero-salida.wav

	- Convertir el fichero anterior a mp3: 

            ffmpeg -i fichero-salida.wav -acodec mp3 fichero-salida.mp3


- [fdupes - Buscar y borrar ficheros duplicados](https://github.com/adrianlopezroche/fdupes)

	- Instalar en Ubuntu:

            sudo apt install fdupes"

	- Buscar ficheros duplicados en el directorio actual (y sus subdirectorios con la opción -r): 

            fdupes -r ./

	- Buscar y eliminar los ficheros duplicados en el directorio actual: 
    
            fdupes -r ./ --delete
    
	- Buscar y eliminar los ficheros duplicados en el directorio actual de forma automática (no pregunta y conserva aquel que tiene la fecha de modificación más antigua)
    
            fdupes -r ./ -d -N
            
            -d = borrar (delete)
            -N = No preguntar (no prompt)
	
- [lpadmin - Añadir y quitar impresoras desde línea de ordenes (para impresoras que soporten IPP](https://www.cups.org/doc/man-lpadmin.html)

    - Instalar en Ubuntu: 

            sudo apt install cups

    - Añadir impresora:

            sudo lpadmin -p NOMBRE_IMPRESORA -E -v ipp://DIRECCION_IP/ipp/print -m everywhere

    - Quitar impresora:

            sudo lpadmin -x NOMBRE_IMPRESORA

    - Listar impresoras disponibles:

            sudo lpinfo -lv
        
- [zstd - Compresión de alta velocidad](https://github.com/facebook/zstd)

    - Descripcion: Compresion mas eficiente en tiempo que Gzip y tamaño final igual a gzip y cercano a 7-zip. Los tiempos siguientes son el resultado de comprimir un mismo directorio con muchos ficheros de texto de pequeño tamaño.

        | Algoritmo  | Tiempo (mm:ss) | Tamaño final |
        | ------------- | ------------- | ------------- |
        | Gzip  | 02:56  | 1.4 GB  |
        | 7-zip  | 02:43  | 1.1 GB  |
        | LZ4  | 00:22  | 2.2 GB  |
        | ZSTD  | 00:24  | 1.4 GB  |

    - Instalar en Ubuntu: 

            sudo apt install zstd

    - Comprimir un fichero: 
        
            zstd fichero-entrada -o fichero-comprimido.zst

    - Comprimir con tar un directorio entero:
        
            tar --zstd -cf dat.tar.zst ./dat

    - Descomprimir: 

            tar -I zstd -xvf dat.tar.zst

    - Descomprimir en un directorio diferente:    

            tar -I zstd -xvf dat.tar.zst -C ./otro-directorio
            
- [ncdu - NCurses Disk Usage - Herramienta análisis uso de disco](https://github.com/facebook/zstd)

    - Descripción: Esta herramienta permite un análisis **MUY RÁPIDO** del tamaño ocupado por cada directorio y acceder a cada directorio para ver el tamaño ocupado por los subdirectorios y archivos.
            
    - Instalar en Ubuntu: 

            sudo apt install ncdu
            
- [zxcvbn - Cálculo complejidad contraseñas](https://github.com/zxcvbn-ts/zxcvbn)

    - Descripción: Esta herramienta permite hacer un cálculo de la complejidad de la contraseña.
    
    - Instalar en Ubuntu:

            sudo apt install python3-zxcvbn
        
    - Uso (ya pide el la contraseña):
    
            zxcvbn
        
- [masscan - Escaneo de puertos abiertos](https://github.com/robertdavidgraham/masscan)

    - Descripción: Masscan permite la busqueda de puertos abiertos en un equipo ó red. Es muy rápido y de uso sencillo.
    
    - Instalar en Ubuntu:
    
            sudo apt install masscan
        
    - Uso para buscar puertos abiertos en un equipo (p.ej. 192.168.0.50):
    
- [shred - Eliminación segura de datos de archivos ó discos](https://www.gnu.org/software/coreutils/manual/html_node/shred-invocation.html)

    - Descripción: Shred elimina de forma segura los datos contenidos en los archivos ó discos. Por defecto sobreecribe los datos en tres pasadas con datos aleatorios:
    
    - Instalar: Debe estar siempre instalado, ya que pertenece al paquete coreutils.
    
    - Eliminación de datos ficheros:
    
            shred nombre-fichero

    - Eliminación de datos ficheros y borrado del fichero
    
            shred -u nombre-fichero

    - Eliminación de datos de un disco duro completo
        
            sudo shred -v /dev/XXX
            
- [hey - Herramienta carga servidor web](https://github.com/rakyll/hey)

    - Descripción: Es una herramienta que envía carga a un servidor web.
    
    - Instalación:

        apt install hey
        
    - Uso:
    
        hey http://localhost:8000
        
- [mtr - My traceroute - gráfico](https://www.bitwizard.nl/mtr/)

    - Descrición: Herramienta para sustituir a ping y traceroute. En Ubuntu por defecto se instala mtr-tiny (en modo texto).
    
    - Instalación de la versión completa:
    
        apt install mtr
        
    - Uso:
    
        mtr 8.8.8.8
        
- [SmokePing - Vigilador de latencia con visualizacion gráfica (basada en CGI ejecutado por Apache), requiere instalar Apache](https://oss.oetiker.ch/smokeping/)
        
- [yt-dlp - Descarga de videos y audios de videos de Youtube](https://github.com/yt-dlp/yt-dlp)

    - Descripción: Herramienta para descargar videos de youtube
    
    - Instalación:
    
        apt install yt-dlp
        
    - Uso:

        - Descargar un video

            yt-dlp https://www.youtube.com/watch?v=zZzZzZzZzZz

        - Descargar un video en formato mp3

            yt-dlp https://www.youtube.com/watch?v=zZzZzZzZzZz -x --audio-format mp3

        - Descargar una lista de reproducción a mp3

            yt-dlp https://www.youtube.com/@ZzzzzZzzzzZzzzz/videos -x --audio-format mp3

        - Descargar una lista de reproducción a mp3 con una antiguedad máxima

            yt-dlp https://www.youtube.com/@ZzzzzZzzzzZzzzz/videos -x --audio-format mp3 --dateafter YYYYMMDD

        - Opciones útiles

            --restrict-filenames  --windows-filenames


        
    

### Utilidades web

- [OBS.Ninja - Videoconferencia](https://obs.ninja/)

- [Talky.io - Videoconferencia](https://talky.io)

- [Wormhole - Envío de ficheros - alternativa a firefox Send](https://wormhole.app/): Hay que compartir un enlace, pero la transferencia puede ser offline.

- [Vercel - Blaze - Compartir ficheros](https://blaze.vercel.app/): Funciona incluso en una red local (los equipos se conectan automáticamente sin tener que compartir un enlace).

- [ntfy - Envío notificaciones PUSH a móvil](https://ntfy.sh/)

    - Descripción: Servicio para que el envío de notificaciones PUSH a un teléfono móvil sea muy sencillo
    
    - Paso 1: Instalar en el teléfono móvil (iOS ó Android) la aplicación **ntfy**.
    
    - Paso 2: Crear un "asunto" ó "topic" con una cadena (si se desea que sea privada, debe ser larga y/o aleatoria). P.ej. MIS-NOTIFICACIONES
    
    - Paso 3: Enviar mediante línea de órdenes la notificación del siguiente modo:
    
        curl -d "mensaje de la notificacion" ntfy.sh/MIS-NOTIFICACIONES

### Utilidades escritorio

- [DBeaver - Administración bases de datos](https://dbeaver.io/)

