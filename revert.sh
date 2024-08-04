 #!/usr/bin/bash

TARGET="${HOME}/.config/"
CACHE="cache/"

#declaration of directories path relative to ${HOME}/.config/ and associated commands
#note: do not specify final directory forward slash
declare -a DIR_NAMES=("nvim" "ranger" "alacritty" "polybar" "i3" "fish")
declare -a COMMANDS=("eval nvim --headless +PlugInstall +PlugClean! +qall!; cp -r ${CACHE}nvim/plugged/nvim-treesitter/parser/ ${TARGET}nvim/plugged/nvim-treesitter/" "" "" "chmod +x ${TARGET}polybar/launch.sh" "i3-msg restart" "source ~/.config/fish/**/*.fish")

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

