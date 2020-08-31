#!/bin/bash
#echo "Setting default sink to: $1";
total_sinks=$(pacmd list-sinks short list | grep 'index:' | wc -l)
#sinks=()
#IFS=$'\n' read -r -d '' -a sinks < <((pacmd list-sinks short list | grep 'index:' | awk '{ print $NF }') && printf '\0')
sinks=($(pacmd list-sinks short list | grep 'index:' | awk '{ print $NF }'))
current_sink=$(pacmd list-sinks short list | grep '* index:' | awk '{ print $3 }')
next_sink=$((current_sink+1))

ready_for_next_sink=false
echo ${sinks[*]}
for sink in "${sinks[@]}"
do
    echo "ready: $ready_for_next_sink, checking sink: $sink"
    if [ $ready_for_next_sink == true ]
    then
        echo "step1"
        next_sink=$sink
        break
    elif [ $current_sink == ${sinks[-1]} ]
    then
        echo "step2"
        next_sink=${sinks[0]}
        break
    elif [ $sink == $current_sink ]
    then
        echo "step3"
        ready_for_next_sink=true
    fi
done

echo "total sinks: $total_sinks"
echo "current sink: $current_sink"
echo "next sink: $next_sink"

pacmd set-default-sink $next_sink
pacmd list-sink-inputs | grep index | while read line
do
    input=$(echo $line | cut -f2 -d' ')
    #echo "Moving input: $input to sink: $next_sink";
    pacmd move-sink-input $input $next_sink
done

#restart the volume sys try applet
killall pnmixer
pnmixer
