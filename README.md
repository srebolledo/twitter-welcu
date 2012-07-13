twitter-welcu
=============

Esta es la herramienta de ejemplo que se pidió desde welcu para llenar el puesto de desarrollador.
La aplicacion tiene las siguientes características
Dependencias
Gems : mysql, sinatra, htmlentities, net/http, json
Ruby version: ruby 1.8.7 (2011-12-28 patchlevel 357) [universal-darwin11.0]

Para este ejemplo se pidio lo siguiente:

La idea es muy simple, queremos  que desarrolles una pequeña aplicación/script y que dado un término de búsqueda se conecte a twitter, descargue los twitts que hacen match y los muestre en pantalla.

Para este primer punto se tienen varias formas de entrada
La primera es a través de la consola. En la carpeta que contiene la aplicacion ejecutamos

	$ ruby twitter.rb termino de busqueda

La segunda es a través de la aplicación web que ejecuta la dependencia "sinatra" (una gem que está en los repositorios)
para ejecutarla, hacemos primero
	$ ruby rest_api.rb 

Veremos que se ejecuta WEBRick y está corriendo en la siguiente dirección

	http://localhost:4567/search/add_search

Con el formulario podemos agregar nuevos terminos de busqueda, los cuales serán traídos despues a través del cron.
Cabe nombrar que dentro de esta aplicación hay algunas rutas importantes.
	http://localhost:4567/show/queries Muestra los términos de búsqueda que buscará el script
	http://localhost:4567/show/queries_stats Muestra los términos de búsqueda y la cantidad de tweets traídos desde twitter
	http://localhost:4567/show/criterio_busqueda Muestra los tweets que hacen match con el criterio "criterio_busqueda"

La tercera forma de agregar criterios es a través de la dirección
	http://localhost:4567/search/criterio_busqueda

Donde "criterio_busqueda" será agregado como criterio a la lista de criterios.


Toda el app está escrita en Ruby.

Los tweets se guardan con respecto a su identificador. También para cada una de las consultas se guarda el identificador más grande de twitter, cosa de que cuando busquemos nuevos tweets, buscamos desde el último que ya tenemos guardado.
Se generó una especie de interfaz web con "sinatra" así mismo como un api rest, la cual no está completa porque faltan los métodos de edición y borrado.
El código completo está en github, lo más actualizado hasta ahora.

Lamentablemente para cumplir la última asignación, que es subirlo a un servidor y ejecutarlo con un cron, no lo pude lograr ya que no tengo ningún hosting con todas las herramientas de ruby que usé para completar el ejercicio.
Eso sí, la linea del cron es la siguiente:

	0 0 * * * /usr/bin/ruby /path/to/app/that/has/name/twitter-welcu/twitter_cron.rb