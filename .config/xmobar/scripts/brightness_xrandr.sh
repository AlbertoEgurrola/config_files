#!/bin/bash

display_name="LVDS-0"
brightness=$(xrandr --verbose | grep -A 20 $display_name | grep 'Backlight:' | awk '{ print $2 }')
brightness=$(echo $brightness | tr -d '\n')
echo "<fn=4></fn> $brightness%"

