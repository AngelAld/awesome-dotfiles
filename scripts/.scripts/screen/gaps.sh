GAPS=$(bspc config window_gap)

if [ $GAPS -eq 10 ]; then
	NEW_GAPS=30
else
	NEW_GAPS=10
fi

bspc config window_gap $NEW_GAPS
