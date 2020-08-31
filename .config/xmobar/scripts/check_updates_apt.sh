#!/bin/bash
sudo apt update | tail -n1 | awk {'{if( $0 ~ /([[:digit:]]+) packages can be upgraded/) print $1 " updates"; else print "Up-to-date"}'} | tail -n1
