#!/bin/bash
VOLUME=$(pacmd list-sinks|grep -A 15 '* index:'| awk '{ if ($0 ~ /muted: yes/){ print ":M"}else if($0 ~ /volume: front/){ print $5 }}' | tr '\n' ':' | sed 's/[%|,]//g' | awk -F: '{ print ($0 ~ /M/ ? "-1" : $1) }')
#SOUND_PATH="$HOME/.config/dunst/to-the-point.ogg"
SOUND_PATH="/usr/share/sounds/freedesktop/stereo/message.oga"

COMMAND="ffplay -nodisp -autoexit -volume "
if [[ $VOLUME -le 40 ]]; then
  $COMMAND 80 $SOUND_PATH
elif [[ $VOLUME -le 50 ]]; then
  $COMMAND 70 $SOUND_PATH
elif [[ $VOLUME -le 60 ]]; then
  $COMMAND 60 $SOUND_PATH
elif [[ $VOLUME -le 70 ]]; then
  $COMMAND 50 $SOUND_PATH
elif [[ $VOLUME -le 80 ]]; then
  $COMMAND 40 $SOUND_PATH
else
  $COMMAND 30 $SOUND_PATH
fi
