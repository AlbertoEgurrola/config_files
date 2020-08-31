#!/bin/bash
output=$(curl "wttr.in/Caborca?format=3")
echo $output | awk '{ print $1 " <fn=5>" $2 "</fn> " $3}'
