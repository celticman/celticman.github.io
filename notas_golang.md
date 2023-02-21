# Programa ejemplo utilización paquetes en Go

## Pasos:

### 1. Crear el fichero go.mod 

Se crea el fichero go.mod, usando el comando go mod. El nombre que se le da no tiene que ver con el directorio en el que está ubicado el projecto. Se ha de ejecutar en el directorio raiz del proyecto:

	go mod init "celticman/mis-ejercicios/uso-paquetes"

Esto crea un fichero go.mod, con el siguiente contenido:

	module celticman/mis-ejercicios/uso-paquetes

	go 1.16

### 2. Crear el fichero "main.go" en el directorio raiz

En el programa principal "main.go" llamamos a la librería ( de cálculos matemáticos usando la siguiente línea. Las librerías en términos de GO se llaman paquetes.

	import "celticman/mis-ejercicios/uso-paquetes/matematicas"

La ruta consiste en añadir la ruta del paquete al nombre del proyeto. El nombre del paquete es su ruta dentro del proyecto, es básicamente un directorio.

### 3. Creamos el paquete de matemáticas

Creamos un directorio "matematicas" y en el fichero GO que no tiene por que tener el mismo nombre. Por ejemplo "mates.go". La cabecera del fichero sería solo:

	package matematicas

El paquete ó librería puede contener un único fichero **.go** ó varios. En este caso podríamos tener un fichero **estadistica.go** y otro **matrices.go**.

### 4. Compilamos el proyecto

En el directorio principal compilamos del siguiente modo:

	go build uso-paquetes.go
	
## Comentarios 

### Primera letra de las funciones

Si la primera letra de las funciones es Mayúscula, esa función se exporta y se puede usar donde se importa ese paquete.

Se exportaría la siguiente:

	func Media(numeros []float64) float64 {

No se exportaría la siguiente:

	func media(numeros []float64) float64 {

### Instalar versión 1.16 de GO

La gestión de paquetes se actualizó en las versiones anteriores a la versión 1.16. Para actualizar a esta versión es necesario seguir los pasos indicados en el siguiente enlace:

[Descarga e Instalación de la última versión de GO](https://golang.org/doc/install)

### El nombre del paquete no puede incluir un "-"

No se puede incluir un guión medio como nombre del paquete, p.ej. no es válido "calculos-matematicos". En su lugar puede usarse un "_" (p.ej. calculos_matematicos) ó que la primera letra de las segunda palabra sea mayúscula (p.ej. calculosMatematicos).

### Al llamar la función hay que poner en primer lugar el nombre del paquete.

Si el paquete a llamar se llama "calculos_matematicos" y se utiliza una funcion pública (p.ej. Media), la llamada a la función debe ser del siguiente modo:

	calculos_matematicos.Media( numeros )
	
Si se llama solo a la función el resultado es el siguiente:

	./uso-paquetes.go:4:8: imported and not used: "aprendiendo-go/ejercicios/trabajar-con-paquetes/calculos_matematicos"
	./uso-paquetes.go:8:12: undefined: Media

El primer fallo se debe a que en el segundo fallo no encuentra la función Media y por tanto no se está utilizando ninguna función del paquete "calculos_matematicos".

### Para que las librerías externas se integren en el proyecto (Vendoring)

Para asegurar que en todas las compilaciones de un proyecto se utiliza la misma librería y no puede desaparecer, se recomienda utilizar la función **vendor**. Consiste en que pasamos a tener un directorio **vendor** dentro del proyecto que contiene todas las dependencias externas del proyecto (librerías).

Se define el proyecto a utilizar en el enabezado del fichero go en el que se vaya a utilizar (por ejemplo main.go):

	import "github.com/tidwall/gjson"
	
Para crear el directorio **vendor** ejecutamos:

	go mod vendor
	
Esto crea el directorio **vendor** en el que se almacena el paquete anterior y todas sus dependencias. Si eliminamos la librería de nuestro proyecto y volvemos a ejecutar el comando anterior, se elimina la librería del directorio vendor.

Si el comando vendor dió un error de que no se encuentra la librería, Para que no nos de error el comando vendor, primero tenemos que descargar la librería:

	go get "github.com/tidwall/gjson"
	
