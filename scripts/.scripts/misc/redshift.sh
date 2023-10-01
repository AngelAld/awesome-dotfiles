#!/bin/bash

# Definimos la función que cambia el valor de la variable
cambiar_valor() {
	if [ $1 -eq 0 ]; then
		echo "1"
	else
		echo "0"
	fi
}

# Obtenemos el valor actual de la variable
valor=$(cat $HOME/.scripts/valor.txt)

# Comprobamos el valor actual de la variable
if [ $valor -eq 0 ]; then
	# Ejecutamos la primera orden
	redshift -x
	# Cambiamos el valor de la variable y lo escribimos en el archivo
	nuevo_valor=$(cambiar_valor $valor)
	echo $nuevo_valor >$HOME/.scripts/valor.txt
else
	# Ejecutamos la segunda orden
	redshift -O 4000
	# Cambiamos el valor de la variable y lo escribimos en el archivo
	nuevo_valor=$(cambiar_valor $valor)
	echo $nuevo_valor >$HOME/.scripts/valor.txt
fi
