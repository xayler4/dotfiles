#!/usr/bin/bash

TARGET="${HOME}/.config/"
CACHE="cache/"

#declaration of directories path relative to ${HOME}/.config/ and associated commands
#note: do not specify final directory forward slash
declare -a DIR_NAMES=("nvim" "i3")
declare -a COMMANDS=("nvim --headless +PlugInstall +PlugClean! +qall" "i3-msg restart")

#declaration of directories path relative to ${HOME}/ and associated files and commands
#note: do not specify final directory forward slash
declare -a HOME_CONFIGS=("urxvt")
declare -a HOME_FILES=(".Xresources")
declare -a HOME_COMMANDS=("xrdb ${HOME}/.Xresources")

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
	echo "EXECUTING ${COMMANDS[i]}"
	${COMMANDS[i]}
	echo ""
	echo "EXECUTED (${COMMANDS[i]})"
	echo "CONFIG APPLIED (${DIR_NAMES[i]})"
	echo ""
done

#home config
for i in ${!HOME_CONFIGS[@]}
do
	echo "APPLYING ${HOME_CONFIGS[i]} CONFIG..."
	mkdir -p "${CACHE}${HOME_CONFIGS[i]}/"
	cp "${HOME}/${HOME_FILES[i]}" "${CACHE}${HOME_CONFIGS[i]}/"
	echo "${HOME}/${HOME_FILES[i]} COPIED TO ${CACHE}${HOME_CONFIGS[i]}/"
	cp "${HOME_CONFIGS[i]}/${HOME_FILES[i]}" "${HOME}/"
	echo "${HOME_CONFIGS[i]}/${HOME_FILES[i]} COPIED TO ${HOME}/"
	echo "EXECUTING ${HOME_COMMANDS[i]}"
	${HOME_COMMANDS[i]}
	echo ""
	echo "EXECUTED (${HOME_COMMANDS[i]})"
	echo "CONFIG APPLIED (${HOME_CONFIGS[i]})"
done
