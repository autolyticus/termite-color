#!/usr/bin/env bash

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
COLORDIR="$MYDIR/colors"

CONFIGDIR="$HOME/.config/termite"
CONFIGFILE="$CONFIGDIR/config"


BEGDELIM="###BEGINNING###termite-color###"
ENDDELIM="###END###termite-color###"
insertColor() {
	colorName="$@"
	{
		echo "$BEGDELIM"
		echo "###COLOR###$colorName###"
		cat "$MYDIR/colors/$colorName"
		echo "$ENDDELIM"
	} >> "$CONFIGFILE"
}

if [ ! -d "$CONFIGDIR" ]; then
	echo "Termite config folder doesn't exist"
	read -p "Should I create it?" -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		# Exit if CONFIGDIR isn't editable
		mkdir "$CONFIGDIR" || exit 1
	fi
fi

if [ ! -e "$CONFIGFILE" ]; then
	echo "Termite configuration doesn't exist"
	if [ ! -w "$CONFIGFILE" ]; then
		echo "Seems like termite config file isn't writable"
		exit 1
	fi
	read -p "Should I create it?" -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo "Making default config"
		cp "$MYDIR/sensible.config" "$CONFIGFILE"
		echo "Please run $0 again with your desired theme"
	fi
fi

lineNoBeg="$(grep -n "$BEGDELIM")"
lineNoEnd="$(grep -n "$ENDDELIM")"
