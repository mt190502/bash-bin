#!/bin/bash
. $HOME/.config/sway/scripts.d/vars.conf
if test -d /sys/class/backlight/$backlightdev/; then
	case $1 in
	get ) 
		echo """  $(brightnessctl | grep Current | awk -F ")" '{print $1}' |  awk -F "(" '{print $2}')"""
	;;
	up )
		brightnessctl set +5%
	;;
	down )
		if [ "$(brightnessctl | grep Current | sed 's/[\(,\),\%]//g' | cut -d\  -f4)" -le "10" ]; then
				echo ""
			else
				brightnessctl set 5%-
		fi
	;;
	esac
else
	echo ""
fi

