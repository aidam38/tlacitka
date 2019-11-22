#!/usr/bin/env bash

check_bus(){
	play_sound
}

play_sound(){
	out="$(tr -d '\0' <bus)"
    output="${out%%*( )}"
    button="${output: -1}"
	if [[ "$button" == "0" ]]; then
    	echo "---0---"
    	xdotool key Left
    elif [[ "$button" == "1" ]]; then
    	echo "---1---"
    	xdotool key Right
    fi
}


stty -F /dev/ttyUSB0 9600
cat /dev/ttyUSB0 >> bus &

while true; do
	inotifywait -q "bus" && check_bus
done
