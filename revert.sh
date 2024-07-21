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

for i in ${!DIR_NAMES[@]}
do
	echo "REVERTING ${DIR_NAMES[i]} CONFIG..."
	mkdir -p "${TARGET}${DIR_NAMES[i]}/" 
	rm -rf "${TARGET}${DIR_NAMES[i]}/"
	echo "${TARGET}${DIR_NAMES[i]}/ DELETED"
	cp -r "${CACHE}${DIR_NAMES[i]}/" "${TARGET}"
	echo "${CACHE}${DIR_NAMES[i]}/ COPIED TO ${TARGET}"
	echo "EXECUTING ${COMMANDS[i]}"
	${COMMANDS[i]}
	echo ""
	echo "EXECUTED (${COMMANDS[i]})"
	echo "CONFIG REVERTED (${DIR_NAMES[i]})"
	echo ""
done

#home config
for i in ${!HOME_CONFIGS[@]}
do
	echo "REVERTING ${HOME_CONFIGS[i]} CONFIG..."
	mkdir -p "${CACHE}${HOME_CONFIGS[i]}/"
	cp "${CACHE}${HOME_FILES[i]}" "${HOME}/" 
	echo "${CACHE}${HOME_FILES[i]} COPIED TO ${HOME}/"
	echo "EXECUTING ${HOME_COMMANDS[i]}"
	${HOME_COMMANDS[i]}
	echo ""
	echo "EXECUTED (${HOME_COMMANDS[i]})"
	echo "CONFIG REVERTED (${HOME_CONFIGS[i]})"
done

