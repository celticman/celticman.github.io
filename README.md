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

    ```
            http https://ifconfig.me/all.json -p HBhb
            http https://api.weather.gov/points/40,-116 -p HBhb
            http http://worldtimeapi.org/api/ip -p HBhb
    ```
        
- [visidata - Visor y editor de hojas de calculo en línea de ordenes](https://www.visidata.org)

    - Instalar en Ubuntu: 
    ```
            sudo apt install visidata
    ```
    - Uso:
        - Ver un fichero CSV con separador ";": 
    ```
            vd input.csv
    ```
        - Ver un fichero CSV con separador "ð": 
    ```
            vd input.csv --csv-delimiter ð
    ```
        
- [ocrmypdf - Genera un pdf con reconocimiento de textos y que se puede buscar](https://ocrmypdf.readthedocs.io/en/latest/index.html)

	- Instalar en Ubuntu: 
    ```
            sudo apt install ocrmypdf tesseract-ocr tesseract-ocr-spa jbig2dec
    ```

	- Uso:	
    ```
            ocrmypdf origen.pdf -l spa destino.pdf 
    ```
	
- [espeak-ng - Sintetizador de voz a partir de un texto](https://github.com/espeak-ng/espeak-ng)

	- Instalar en Ubuntu: 
    ```
            sudo apt install espeak-ng
    ```
	- Uso para que lea la voz de forma directa en Español: 
    ```
            espeak-ng -f fichero.txt -v es -s 145 -p 50
    ```
	- Uso para que genere un fichero wav en Español: 
    ```
            espeak-ng -f fichero.txt -v es -s 145 -p 50 -w fichero-salida.wav
    ```
	- Convertir el fichero anterior a mp3: 
    ```
            ffmpeg -i fichero-salida.wav -acodec mp3 fichero-salida.mp3
    ```

- [fdupes - Buscar y borrar ficheros duplicados](https://github.com/adrianlopezroche/fdupes)

	- Instalar en Ubuntu:
    ```
            sudo apt install fdupes"
    ```
	- Buscar ficheros duplicados en el directorio actual: 
    ```
            fdupes -r ./
    ```
	- Buscar y eliminar los ficheros duplicados en el directorio actual: 
    ```
            fdupes -r ./ --delete
    ```
	
- [lpadmin - Añadir y quitar impresoras desde línea de ordenes (para impresoras que soporten IPP](https://www.cups.org/doc/man-lpadmin.html)

    - Instalar en Ubuntu: 
    ```
            sudo apt install cups
    ```
    - Añadir impresora:
    ```
            sudo lpadmin -p NOMBRE_IMPRESORA -E -v ipp://DIRECCION_IP/ipp/print -m everywhere
    ```
    - Quitar impresora:
    ```
            sudo lpadmin -x NOMBRE_IMPRESORA
    ```
    - Listar impresoras disponibles:
    ```
            sudo lpinfo -lv
    ```
        
- [zstd - Compresión de alta velocidad](https://github.com/facebook/zstd)

Compresion mas eficiente en tiempo que Gzip

| Algoritmo  | Tiempo (mm:ss) | Tamaño final |
| ------------- | ------------- | ------------- |
| Gzip  | 02:56  | 1.4 GB  |
| 7-zip  | 02:43  | 1.1 GB  |
| LZ4  | 00:22  | 2.2 GB  |
| ZSTD  | 00:24  | 1.4 GB  |

Uso:

    - Instalar en Ubuntu: 

    ```
            sudo apt install zstd
    ```

    - Comprimir: 

    ```
            tar --zstd -cf dat.tar.zst ./dat
    ```

    - Descomprimir: 

    ```
            tar -I zstd -xvf dat.tar.zst
    ```

    - Descomprimir en un directorio diferente:    

    ```
            tar -I zstd -xvf dat.tar.zst -C ./otro-directorio
    ```

### Utilidades web

- [OBS.Ninja - Videoconferencia](https://obs.ninja/)

- [Talky.io - Videoconferencia](https://talky.io)

- [Wormhole - Envío de ficheros - alternativa a firefox Send](https://wormhole.app/)

### Utilidades escritorio

- [DBeaver - Administración bases de datos](https://dbeaver.io/)

