#!/bin/bash
. $HOME/.config/sway/scripts.d/vars.conf

case $* in
	dropdown)
		if [[ "$(ps aux | grep -v grep | grep -o dropterminal | head -n 1)" != "dropterminal" ]]; then
			echo 1
			$dropterm -T dropterminal &
			sleep 0.15
			swaymsg scratchpad show 
		else
			echo 2
			swaymsg scratchpad show
		fi
	;;
	default)
		$terminal
	;;
esac
