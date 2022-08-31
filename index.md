# [Página web de **celticman**](https://celticman.github.io/.html)

## Informatica para niños

- [¿Cómo crear una página web de un niño?](./ninos_github_pages.html).

## Guías

- [Particionamiento disco cifrado con LUKS en Linux](./crear_particion_cifrada_luks.html) 

- [¿Cómo verificar la velocidad de descarga desde la línea de ordenes?](./utilidades_velocidad_speedtest.html).

- [Uso de vagrant](./uso_vagrant.html)

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

        - http https://ifconfig.me/all.json -p HBhb
        - http https://api.weather.gov/points/40,-116 -p HBhb
        - http http://worldtimeapi.org/api/ip -p HBhb
        
- [visidata - Visor y editor de hojas de calculo en línea de ordenes](https://www.visidata.org)

    - Instalar en Ubuntu: "sudo apt install visidata"
    - Uso:
        - Ver un fichero CSV con separador ";": vd input.csv
        - Ver un fichero CSV con separador "ð": vd input.csv --csv-delimiter ð
        
- [ocrmypdf - Genera un pdf con reconocimiento de textos y que se puede buscar](https://ocrmypdf.readthedocs.io/en/latest/index.html)

	- Instalar en Ubuntu: "sudo apt install ocrmypdf"
	- Instalar idioma de Tesseract "sudo apt install tesseract-ocr tesseract-ocr-spa"
	- Uso:	ocrmypdf origen.pdf -l spa destino.pdf 
	
- [espeak-ng - Sintetizador de voz a partir de un texto](https://github.com/espeak-ng/espeak-ng)

	- Instalar en Ubuntu: "sudo apt install espeak-ng"
	- Uso para que lea la voz de forma directa en Español: espeak-ng -f fichero.txt -v es -s 145 -p 50
	- Uso para que genere un fichero wav en Español: espeak-ng -f fichero.txt -v es -s 145 -p 50 -w fichero-salida.wav
	- Convertir el fichero anterior a mp3: ffmpeg -i fichero-salida.wav -acodec mp3 fichero-salida.mp3

### Utilidades web

- [OBS.Ninja - Videoconferencia](https://obs.ninja/)

- [Talky.io - Videoconferencia](https://talky.io)

- [Wormhole - Envío de ficheros - alternativa a firefox Send](https://wormhole.app/)

### Utilidades escritorio

- [DBeaver - Administración bases de datos](https://dbeaver.io/)

