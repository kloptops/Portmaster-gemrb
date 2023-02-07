#!/bin/bash

if [ -d "/opt/system/Tools/PortMaster/" ]; then
  controlfolder="/opt/system/Tools/PortMaster"
elif [ -d "/opt/tools/PortMaster/" ]; then
  controlfolder="/opt/tools/PortMaster"
else
  controlfolder="/roms/ports/PortMaster"
fi

source $controlfolder/control.txt
if [ -z ${TASKSET+x} ]; then
  source $controlfolder/tasksetter
fi

get_controls

## TODO: Change to PortMaster/tty when Johnnyonflame merges the changes in,
CUR_TTY=/dev/tty0

PORTDIR="/$directory/ports"
GAMEDIR="$PORTDIR/gemrb"
cd $GAMEDIR

width=55
height=15

$ESUDO chmod 666 $CUR_TTY
$ESUDO touch log.txt
$ESUDO chmod 666 log.txt
export TERM=linux
printf "\033c" > $CUR_TTY

# if [ -z ${GAME+x} ]; then

#   printf "\e[?25h" > $CUR_TTY
#   dialog --clear > $CUR_TTY


#   $GPTOKEYB "dialog" -c "${GAMEDIR}/gemrb-menu.gptk" &

#   GAMEEXES=( $(find games/ -maxdepth 2 -iname 'gameexe.ini' | sort) );
#   if [ "${#GAMEEXES[@]}" -eq 0 ]; then
#     dialog \
#     --backtitle "Real Live VM" \
#     --title "[ Error ]" \
#     --clear \
#     --msgbox "No Games Found!" $height $width > $CUR_TTY

#     printf "\033c" > $CUR_TTY
#     $ESUDO kill -9 $(pidof gptokeyb)
#     $ESUDO systemctl restart oga_events &
#     exit 1;
#   fi

#   VN_CHOICES=()
#   VN_DIRS=()

#   OFFSET=0
#   if [ -f "${GAMEDIR}/save/last_game" ]; then
#     LAST_GAME=$(cat "${GAMEDIR}/save/last_game")
#     VN_CHOICES+=(0 "$LAST_GAME")
#     VN_DIRS+=("$LAST_GAME")
#     echo "0 -> **${LAST_GAME}**" 2>&1 | tee -a ./log.txt
#     OFFSET=1
#   else
#     LAST_GAME=""
#   fi

#   for i in "${!GAMEEXES[@]}"; do
#     VN_PATH=$(dirname "${GAMEEXES[$i]}")
#     VN_DIR=${VN_PATH##*/}

#     if [ "$VN_DIR" = "$LAST_GAME" ]; then
#       OFFSET=$(($OFFSET-1))
#     else
#       i=$(($i+$OFFSET))
#       echo "$i -> ${VN_DIR}" 2>&1 | tee -a ./log.txt
#       VN_SHORTCUT="$PORTDIR/${VN_DIR}.sh"
#       VN_DIRS+=("${VN_DIR}")
#       if [ -f "$PORTDIR/${VN_DIR}.sh" ]; then
#         VN_CHOICES+=($i "${VN_DIR} - Installed")
#       else
#         VN_CHOICES+=($i "${VN_DIR}")
#       fi
#     fi
#   done

#   IN_CHOICES=( "${VN_CHOICES[@]}" )

#   VN_CHOICES+=("" "")
#   VN_CHOICES+=("i" "Install Game Shortcut")

#   if [ "${#VN_DIRS[@]}" -eq 1 ]; then
#     GAME="${VN_DIRS[0]}"
#   else
#     GAME_SELECT=(dialog \
#       --backtitle "Real Live VM" \
#       --title "[ Select Game ]" \
#       --clear \
#       --menu "Choose Your Game" $height $width 15)


#     VN_CHOICE=$("${GAME_SELECT[@]}" "${VN_CHOICES[@]}" 2>&1 > $CUR_TTY)
#     if [ $? != 0 ]; then
#       $ESUDO kill -9 $(pidof gptokeyb)
#       $ESUDO systemctl restart oga_events &
#       echo "QUIT: ${VN_CHOICE}" 2>&1 | $ESUDO tee -a ./log.txt
#       printf "\033c" > $CUR_TTY
#       exit 1;
#     fi

#     if [ $VN_CHOICE = "i" ]; then
#       IN_SELECT=(dialog \
#         --backtitle "Real Live VM" \
#         --title "[ Install Game Shortcut ]" \
#         --clear \
#         --menu "Choose Your Game" $height $width 15)

#       IN_CHOICE=$("${IN_SELECT[@]}" "${IN_CHOICES[@]}" 2>&1 > $CUR_TTY)
#       if [ $? != 0 ]; then
#         $ESUDO kill -9 $(pidof gptokeyb)
#         $ESUDO systemctl restart oga_events &
#         echo "QUIT: ${IN_CHOICE}" 2>&1 | tee -a ./log.txt
#         printf "\033c" > $CUR_TTY
#         exit 1;
#       fi

#       IN_GAME="${VN_DIRS[$IN_CHOICE]}"

#       printf "#!/usr/bin/bash\nGAME=$IN_GAME $PORTDIR/Rlvm.sh\n" | $ESUDO tee "$PORTDIR/$IN_GAME.sh"

#       dialog \
#         --backtitle "Real Live VM" \
#         --title "[ Success ]" \
#         --clear \
#         --msgbox "Installed shortcut for $IN_GAME\n\nRestart Emulation Station to find the game under ports." $height $width > $CUR_TTY

#       $ESUDO kill -9 $(pidof gptokeyb)
#       $ESUDO systemctl restart oga_events &
#       printf "\033c" > $CUR_TTY
#       exit 0;
#     fi

#     echo "C ${VN_CHOICE} -> ${VN_DIRS[$VN_CHOICE]}" 2>&1 | tee -a ./log.txt

#     $ESUDO kill -9 $(pidof gptokeyb)

#     GAME="${VN_DIRS[$VN_CHOICE]}"
#   fi

#   if [ ! -d "${GAMEDIR}/save" ]; then
#     $ESUDO mkdir "${GAMEDIR}/save"
#   fi
#   # Save the selected game as the last game
#   printf "$GAME" | $ESUDO tee "${GAMEDIR}/save/last_game"
# fi

if [ ! -d "$GAMEDIR/engine" ]; then
  # Extract the engine from the build zip.
  unzip "$GAMEDIR/engine.zip"
  mv -fv "$GAMEDIR/engine/gemrb" "$GAMEDIR/gemrb"
fi

printf "\033c" > $CUR_TTY
## RUN SCRIPT HERE

export SDL_GAMECONTROLLERCONFIG="$sdl_controllerconfig"

export PYTHONHOME="$GAMEDIR"

GAME="demo"

$GPTOKEYB "gemrb" -c "${GAMEDIR}/gemrb.gptk" &
$TASKSET ./gemrb $MSGOTHIC "${GAMEDIR}/games/${GAME}/" 2>&1 | $ESUDO tee -a ./log.txt

$ESUDO kill -9 $(pidof gptokeyb)
unset LD_LIBRARY_PATH
unset SDL_GAMECONTROLLERCONFIG
$ESUDO systemctl restart oga_events &

# Disable console
printf "\033c" > $CUR_TTY
