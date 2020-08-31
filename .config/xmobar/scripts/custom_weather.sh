#!/bin/sh
ansiweather -l Caborca,MX -s true | awk {'print $4 ": " $6 $7 "  " $8'}
