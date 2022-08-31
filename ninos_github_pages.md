# [Página web de Celticman](https://celticman.github.io/).

## ¿Cómo crear una página estática gratuita utilizando Github Pages? Versión para niños

Esta guía ha sido realizado utilizando como guía [Hospedar tu sitio web en Github - Khan Academy](https://es.khanacademy.org/computing/computer-programming/html-css/web-development-tools/a/hosting-your-website-on-github).

## Pasos

- Visitar [GitHub](https://github.com).

- Crear una cuenta, como nombre de usuario hay que inventar un nombre. El nombre es importante, ya que la página tendrá este nombre. **Dado que se trata de un niño y deseamos que tenga la máxima privacidad, este nombre no debe ser usado en ninguna otra cuenta ni corresponderse con el nombre real**.

- Crear un repositorio dentro de la cuenta de GitHub, con el siguiente nombre: NOMBRE-USUARIO.github.io (sustituyendo NOMBRE-USUARIO por el nombre real utilizado).

- En el PC hay que instalar Git. Si es un sitema operativo Linux Ubuntu: La instalación se hace con el siguiente comando:
	
	```
	sudo apt install git
	```

- Una vez instalado vamos al directorio que va a tener la pagina web y ejecutamos los siguientes comandos:

	```
	git init
	git config user.name  "NOMBRE-USUARIO"
	git config user.email "NOMBRE-USUARIO@NOMBRE-USUARIO.COM"
	git commit -m "Primer Cambio"
	```
	
- Generar un token de acceso (Desde Agosto de 2021 Github requiere que la conexión a través de la línea de ordenes tenga asociado un Token ó :

	- En el menú Settings -> Developer Settings -> Personal access tokens, seguir los siguientes pasos:
	
		- Pulsar "Generate new token".
		
		- En **Note** dar un nombre al Token, p.ej. "Token linea ordenes".
	
		- En **Expiration** indicar la fecha de caducidad del token, p.ej. 1 año menos un día ó No expiracion
		
		- En **Select scopes** seleccionar **repo**.
		
		- Pulsar el boton verde **Generate token**.
		
	- Si ya se había creado el remote hay que borrarlo:
	
		- Se listan los repositorios remotos con:
		
		```
		git remote 
		```
		- Si se llama "origin", se borra con:
		
		```
		git remote remove origin
		```
			
		
	- Añadir el origen
		
		```
		git remote add origin https://<TOKEN>@github.com/NOMBRE-USUARIO/NOMBRE-USUARIO.github.io.git

		```
		git push -u origin master
		```
	


- Ahora ya puedes crear la página web en tu PC. Recuerda que debe existir un fichero "index.html", que sería la página principal.

- Cuando quieras enviar los cambios a GitHub tendrías que ejecutar los siguientes comandos:

	```
	git add . --all
	git commit -m "DESCRIPCION-DEL-CAMBIO"
	git push
	```

## ¿Cómo eliminar el registro de cambios de github?

Si el niño publica información que no debe estar en internet, además de cambiar la informacion tenemos que eliminar la historia de los cambios.

### Pasos

- Crear una nueva rama

	```
	git checkout --orphan nueva_rama
	```

- Añadir todos los ficheros

	```
	git add -A
	```

- Registrar los cambios

	```
	git commit -am "Cambio historia"
	```

- Borrar la rama master

	```
	git branch -D master
	```

- Cambiar el nombre de la rama actual "nueva_rama" a master

	```
	git branch -m master
	```

- Enviar al repositorio (github)

	```
	git push -f origin master
	```
