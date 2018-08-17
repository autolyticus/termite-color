#!/usr/bin/env bash

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

detectColorDir() {
	if [ -d "$MYDIR/colors" ]; then
		echo "$MYDIR/colors"
	else if [ -d "$HOME/.config/termite/colors" ]; then
			echo "$HOME/.config/termite/colors"
		else
			echo "Unable to detect colors directory. Termite-color is now exiting"
			exit 1
		fi
	fi
}

COLORDIR="$(detectColorDir)"

CONFIGDIR="$HOME/.config/termite"
CONFIGFILE="$CONFIGDIR/config"

BEGDELIM='###BEGINNING###termite-color###'
ENDDELIM='###END###termite-color###'
COLORTAG='\[colors\]'

insertColor() {
	colorFile="$@"
	colorName="$(basename $colorFile)"
	colorName="$(echo "$colorName" | cut -f1 -d.)"
	echo "Setting color $colorName"
	{
		echo "$BEGDELIM"
		echo
		echo "###COLOR###$colorName###"
		cat "$COLORDIR/$colorFile"
		echo
		echo "$ENDDELIM"
	} >> "$CONFIGFILE"
}

getCurrentTheme() {
	grep 'COLOR' "$CONFIGFILE" | cut -d'#' -f7
}


if [ -z "$@" ]; then
	echo -n 'Current Theme: '
	getCurrentTheme
	exit 0
fi

UserColor=$((cd "$COLORDIR" || exit; find -type f -name '*.config')  | fzf --prompt='Choose theme: ')
if [ -z "$UserColor" ]; then
    echo "Please enter valid color"
    exit 1
fi


# while getopts "c:d:" opt; do
# 	case "${opt}" in
# 		c)
# 			echo "Colour = $OPTARG"
# 			UserColor="$OPTARG"
# 			;;
# 		:)
# 			echo "Option -$OPTARG requires an argument"
# 			;;
# 		\?)	echo "Usage incorrect"
# 			exit 1
# 			;;
# 	esac
# done


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
	if ! touch "$CONFIGFILE"; then
		echo "Seems like termite config file isn't writable"
		exit 1
	fi
	read -p "Should I create it?" -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo "Making default config"
		cp "$MYDIR/sensible.config" "$CONFIGFILE"
	fi
fi

# Find the line number where beg and end delimiters are present
lineNoBeg="$(grep -n "$BEGDELIM" "$CONFIGFILE" | cut -f1 -d ':')"
lineNoEnd="$(grep -n "$ENDDELIM" "$CONFIGFILE" | cut -f1 -d ':')"

cp "$CONFIGFILE" "$CONFIGFILE.bak"

# If such delimiters do exist then remove the section
if [ -n "$lineNoBeg" ] && [ -n "$lineNoEnd" ]; then
	sed -i "$lineNoBeg,$lineNoEnd"d "$CONFIGFILE"
fi

# Remove any uncommented colors section tags if present to ensure there's no error
sed -i "/$COLORTAG/d" "$CONFIGFILE"

insertColor "$UserColor"
