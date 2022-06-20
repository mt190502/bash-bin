#!/bin/bash
. $HOME/.config/sway/scripts.d/vars.conf
_date=$(date +%d%m%Y_%H%M%S)

[[ "$(ps aux | grep -v grep | grep -io swappy)" == "swappy" ]] && kill -9 $(ps aux | grep -v grep | grep -i swappy | awk '{print $2}')

fullcopy() {
	grim -g "0,0 $screenres" - | wl-copy && notify-send "The photo has been saved to the clipboard" || notify-send "The photo could not be saved"
	[[ "$showeditor" == "yes" ]] && grim -g "0,0 $screenres" - | swappy -f -
}

fullsave() {
	grim -g "0,0 $screenres" $HOME/Pictures/grim/IMG_$_date.jpg && notify-send "The photo was saved to $HOME/Pictures/grim/ with the name IMG_$_date.jpg" || notify-send "The photo could not be saved"
	[[ "$showeditor" == "yes" ]] && swappy -f $HOME/Pictures/grim/IMG_$_date.jpg
}

fulltimecopy() {
	timeout="$(zenity --title Screenshot \
	--text '               Full Screenshot' \
	--scale --value 3 --max-value 50)"
	sleep $timeout
	[[ -z "$timeout" ]] && exit
	grim -g "0,0 $screenres" - | wl-copy && notify-send "The photo has been saved to the clipboard" || notify-send "The photo could not be saved"
	[[ "$showeditor" == "yes" ]] && grim -g "0,0 $screenres" - | swappy -f -
}

fulltimesave() {
	timeout="$(zenity --title Screenshot \
	--text '               Full Screenshot' \
	--scale --value 3 --max-value 50)"
	sleep $timeout
	[[ -z "$timeout" ]] && exit
	grim -g "0,0 $screenres" $HOME/Pictures/grim/IMG_$_date.jpg && notify-send "The photo was saved to $HOME/Pictures/grim/ with the name IMG_$_date.jpg" || notify-send "The photo could not be saved"
	[[ "$showeditor" == "yes" ]] && swappy -f $HOME/Pictures/grim/IMG_$_date.jpg
}


reccopy() {
	grim -g "0,0 $screenres" /tmp/screenshot.png
	feh -F /tmp/screenshot.png &
	slurpout=$(slurp)
	[[ -z $slurpout ]] && notify-send "The photo could not be saved" && killall feh && exit
	grim -g "$slurpout" - | wl-copy && notify-send "The photo has been saved to the clipboard" || notify-send "The photo could not be saved"
	killall feh
	[[ "$showeditor" == "yes" ]] && grim -g "$slurpout" - | swappy -f -
	rm /tmp/screenshot.png
}

recsave() {
	grim -g "0,0 $screenres" /tmp/screenshot.png
	feh -F /tmp/screenshot.png &
	slurpout=$(slurp)
	[[ -z $slurpout ]] && notify-send "The photo could not be saved" && killall feh && exit
	grim -g "$slurpout" $HOME/Pictures/grim/IMG_$_date.jpg && notify-send "The photo was saved to $HOME/Pictures/grim/ with the name IMG_$_date.jpg" || notify-send "The photo could not be saved"
	killall feh
	[[ "$showeditor" == "yes" ]] && grim -g "$slurpout" - | swappy -f -
	rm /tmp/screenshot.png
}

rectimecopy() {
	timeout="$(zenity --title Screenshot \
	--text '               Rectangular Screenshot' \
	--scale --value 3 --max-value 50)"
	sleep $timeout
	[[ -z "$timeout" ]] && exit
	grim -g "0,0 $screenres" /tmp/screenshot.png
	feh -F /tmp/screenshot.png &
	slurpout=$(slurp)
	[[ -z $slurpout ]] && notify-send "The photo could not be saved" && killall feh && exit
	grim -g "$slurpout" - | wl-copy && notify-send "The photo has been saved to the clipboard" || notify-send "The photo could not be saved"
	killall feh
	[[ "$showeditor" == "yes" ]] && grim -g "$slurpout" - | swappy -f -
	rm /tmp/screenshot.png
}

rectimesave() {
	timeout="$(zenity --title Screenshot \
	--text '               Rectangular Screenshot' \
	--scale --value 3 --max-value 50)"
	sleep $timeout
	[[ -z "$timeout" ]] && exit
	grim -g "0,0 $screenres" /tmp/screenshot.png
	feh -F /tmp/screenshot.png &
	slurpout=$(slurp)
	[[ -z $slurpout ]] && notify-send "The photo could not be saved" && killall feh && exit
	grim -g "$slurpout" $HOME/Pictures/grim/IMG_$_date.jpg && notify-send "The photo was saved to $HOME/Pictures/grim/ with the name IMG_$_date.jpg" || notify-send "The photo could not be saved"
	killall feh
	[[ "$showeditor" == "yes" ]] && grim -g "$slurpout" - | swappy -f -
	rm /tmp/screenshot.png	
}


rectangular() {
ENTRY2="$(zenity --warning \
	--title Screenshot \
	--text 'Rectangular Screenshot' \
	--width 300 \
       	--extra-button "Timeout&Save" \
	--extra-button "Timeout&Copy" \
	--extra-button "Save" \
       	--extra-button "Copy" \
	--ok-label 'Cancel')"

[[ "$ENTRY2" == "Timeout&Save" ]] && rectimesave
[[ "$ENTRY2" == "Timeout&Copy" ]] && rectimecopy
[[ "$ENTRY2" == "Save" ]] && recsave
[[ "$ENTRY2" == "Copy" ]] && reccopy
}


full() {
ENTRY2="$(zenity --warning \
	--title Screenshot \
	--text 'Full Screenshot' \
	--width 300 \
       	--extra-button "Timeout&Save" \
	--extra-button "Timeout&Copy" \
	--extra-button "Save" \
       	--extra-button "Copy" \
	--ok-label 'Cancel')"

[[ "$ENTRY2" == "Timeout&Save" ]] && fulltimesave
[[ "$ENTRY2" == "Timeout&Copy" ]] && fulltimecopy
[[ "$ENTRY2" == "Save" ]] && fullsave
[[ "$ENTRY2" == "Copy" ]] && fullcopy
}


case $1 in
	rec)
		reccopy
	;;
	full)
		fullcopy
	;;
	*)
		ENTRY1="$(zenity --warning \
		       	--title Screenshot \
			--text 'Screenshot' \
			--width 300 \
		       	--extra-button Rectangular \
			--extra-button Full \
		       	--ok-label 'Cancel')"
		[[ "$ENTRY1" == "Rectangular" ]] && rectangular
		[[ "$ENTRY1" == "Full" ]] && full
	;;
esac
