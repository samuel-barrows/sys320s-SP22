#!/bin/bash
#Parse apache access log into a csv file

file=$1
out=$2

awk -F ' ' 'BEGIN {print "IP,DATE,METHOD,URI,User Agent"}; 
{OFS="\","} 
{sub(/^\"/,"",$6)}
{sub(/[\[\]]/,"",$4)}
{split($4, a, ":")}
#{print a[1]}
{print "\""$1,
	    "\""a[1],
	    "\""$6,
	    "\""$7,
	    "\""$NF"\n"}' $file > $out

