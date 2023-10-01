#! /bin/bash

# primero matamos todo

pkill dunst
pkill flashfocus
pkill picom
pkill pa-applet
pkill polybar
pkill xfce4-power-manager
pkill nm-applet
pkill udiskie
# esperamos un segundo

sleep 1

#ahora lo volvemos a abrir

if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$m polybar --reload example &
	done
else
	polybar --reload example &
fi

udiskie --appindicator &
wal -R &
flashfocus &
picom -b &
pa-applet &
xfce4-power-manager &
nm-applet &
xinput set-prop 'ELAN0001:00 04F3:3140 Touchpad' 'libinput Tapping Enabled' 1 &
$HOME/.scripts/misc/java.sh &
dunst &
sh /home/an/.screenlayout/pantallas.sh
dunstify --urgency=low 'bspwm' 'Environment was reloaded'
