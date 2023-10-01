#!/bin/bash

output=$(playerctl metadata 2>/dev/null)
if [[ $output ]]; then
	artista=$(playerctl metadata artist)
	titulo=$(playerctl metadata title)
	player=$(playerctl metadata mpris:trackid)
	if echo "$player" | grep -q "spotify"; then
		icon="阮"
	else
		icon=" "
	fi
	echo "$icon $artista - ${titulo:0:30}"
fi
