#!/bin/bash

VOLUME=$(pacmd list-sinks|grep -A 15 '* index:'| awk '{ if ($0 ~ /muted: yes/){ print ":M"}else if($0 ~ /volume: front/){ print $5 }}' | tr '\n' ':' | sed 's/[%|,]//g' | awk -F: '{ print ($0 ~ /M/ ? "-1" : $1) }')
DEVICE=$(pacmd list-sinks|grep -A 15 '* index: ' | awk '{ if ($0 ~ /name: .+\.hdmi-stereo/){print "HDMI"}else if($0 ~ /name: .+\.usb-Kingston/){print "Headphones"}else if($0 ~ /name: .+\.pci.+\.analog-stereo/){print "Built-in"}}')
ICON=$(pacmd list-sinks|grep -A 15 '* index: ' | awk '{ if ($0 ~ /name: .+\.hdmi-stereo/){print "\uf108"}else if($0 ~ /name: .+\.usb-Kingston/){print "\uf025"}else if($0 ~ /name: .+\.pci.+\.analog-stereo/){print "\uf109"}}')

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
else
    VOLUME="$VOLUME%"
    VOLUME_ICON="\uf028"
fi

echo -e "<fn=4>$ICON</fn> $DEVICE:  <fn=4>$VOLUME_ICON</fn> $VOLUME"
