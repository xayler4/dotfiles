#!/usr/bin/bash

TARGET="${HOME}/.config/"
CACHE="cache/"

#declaration of directories path relative to ${HOME}/.config/ and associated commands
#note: do not specify final directory forward slash
declare -a DIR_NAMES=("picom" "nvim" "ranger" "alacritty" "polybar" "i3" "fish" "gtk-3.0")
declare -a COMMANDS=("" "eval nvim --headless +PlugInstall +PlugClean! +qall!; cp -r ${CACHE}nvim/plugged/nvim-treesitter/parser/ ${TARGET}nvim/plugged/nvim-treesitter/" "" "" "chmod +x ${TARGET}polybar/launch.sh" "i3-msg restart" "source ~/.config/fish/**/*.fish" "" )

#setup target and cache dirs if not already existing
mkdir -p "${TARGET}"
mkdir -p "${CACHE}"

#empty cache
rm -rf "${CACHE}*"
echo "${CACHE} EMPTIED"

for i in ${!DIR_NAMES[@]}
do
	echo "APPLYING ${DIR_NAMES[i]} CONFIG..."
	mkdir -p "${TARGET}${DIR_NAMES[i]}/" 
	cp -r "${TARGET}${DIR_NAMES[i]}/" "${CACHE}"
	echo "${TARGET}${DIR_NAMES[i]}/ COPIED TO ${CACHE}"
	rm -rf "${TARGET}${DIR_NAMES[i]}/"
	echo "${TARGET}${DIR_NAMES[i]}/ DELETED"
	cp -r "${DIR_NAMES[i]}/" "${TARGET}"
	echo "${DIR_NAMES[i]}/ COPIED TO ${TARGET}"
	if [ "${COMMANDS[i]}" != "" ]; then
		echo "EXECUTING ${COMMANDS[i]}"
		${COMMANDS[i]}
		echo ""
		echo "EXECUTED (${COMMANDS[i]})"
	fi
	echo "CONFIG APPLIED (${DIR_NAMES[i]})"
	echo ""
done

GTK2=".gtkrc-2.0"
echo "APPLYING ${GTK2} CONFIG..."
cp "${HOME}/${GTK2}" "${CACHE}"
echo "${HOME}/${GTK2} COPIED TO ${CACHE}"
cp ${GTK2} ${HOME}/
echo "${GTK2} COPIED TO ${HOME}"
echo "CONFIG APPLIED (${GTK2})"
