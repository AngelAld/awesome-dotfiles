pkill dunst

dunstify --urgency=low 'test 1' 'urgency low'
sleep 1
dunstify --urgency=normal 'test 2' 'urgency normal'
sleep 1
dunstify --urgency=critical 'test 3' 'urgency critical'
