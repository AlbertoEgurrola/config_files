#!/bin/bash

VOLUME=$(pacmd list-sinks|grep -A 15 '* index:'| awk '{ if ($0 ~ /muted: yes/){ print ":M"}else if($0 ~ /volume: front/){ print $5 }}' | tr '\n' ':' | sed 's/[%|,]//g' | awk -F: '{ print ($0 ~ /M/ ? "-1" : $1) }')
DEVICE=$(pacmd list-sinks|grep -A 15 '* index: ' | awk '{ if ($0 ~ /name: .+\.hdmi-stereo/){print "HDMI"}else if($0 ~ /name: .+\.usb-Kingston/){print "Headphones"}else if($0 ~ /name: .+\.pci.+\.analog-stereo/){print "Built-in"}}')
ICON=$(pacmd list-sinks|grep -A 15 '* index: ' | awk '{ if ($0 ~ /name: .+\.hdmi-stereo/){print "\uf108"}else if($0 ~ /name: .+\.usb-Kingston/){print "\uf025"}else if($0 ~ /name: .+\.pci.+\.analog-stereo/){print "\uf109"}}')
COLOR="#FFFFFF"

if (( $VOLUME == 0 ))
then
    COLOR="#F01D21"
elif (( $VOLUME < 1 ))
then
    COLOR="#F01D21"
elif (( $VOLUME <= 20 ))
then
    COLOR="#01A751"
elif (( $VOLUME <= 40 ))
then
    COLOR="#8DC73D"
elif (( $VOLUME <= 60 ))
then
    COLOR="#FFF10B"
elif (( $VOLUME <= 80 ))
then
    COLOR="#F49315"
else
    COLOR="#F01D21"
fi

if [ $VOLUME -lt 0 ]
then
    VOLUME='Mute'
    VOLUME_ICON="\uf6a9"
elif [ $VOLUME -lt 1 ]
then
    VOLUME="$VOLUME%"
    VOLUME_ICON="\uf026"
elif [ $VOLUME -lt 40 ]
then
    VOLUME="$VOLUME%"
    VOLUME_ICON="\uf027"
elif [ $VOLUME -lt 70 ]
then
    VOLUME="$VOLUME%"
    VOLUME_ICON="\uf027"
else
    VOLUME="$VOLUME%"
    VOLUME_ICON="\uf028"
fi

if [ $DEVICE = "Built-in" ]
then
    DEVICE=$(pacmd list-sinks|grep -A 63 '* index: ' | awk '{ if ($0 ~ /active port: <analog-output-headphones>/){print "Logitech"}else if($0 ~ /active port: <analog-output-speaker>/){print "Asus"}}')
    ICON=$(pacmd list-sinks|grep -A 63 '* index: ' | awk '{ if ($0 ~ /active port: <analog-output-headphones>/){print "\uf8e0"}else if($0 ~ /active port: <analog-output-speaker>/){print "\uf109"}}')
fi


echo -e "<fn=4>$ICON</fn> $DEVICE:  <fc=$COLOR><fn=4>$VOLUME_ICON</fn> $VOLUME</fc>"
