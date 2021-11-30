#!/bin/bash

fhelp=0
fh=0
fn=0
fsize=0
f=0
fdir=0
for opt in "$@"
do
    if [[ $f = 0 && ${opt:0:1} = "-" ]]
    then
	if [[ $opt = "--help" ]]
	then
	    fhelp=1
	elif [[ $opt == -[0-9]* ]]
	then
	    fn=$opt
	elif [[ $opt = "-h" ]]
	then
	    fh=1
	elif [[ $opt = "-s" ]]
	then
	    fsize="-1"
	elif [[ $opt = [0-9]* && $fsize = "-1" ]]
	then
	    fsize=$opt
	elif [[ $opt = "--" ]]
	then
	    f=1
	fi
    elif [[ $fsize = "-1" ]]
    then
	fsize=$opt
    else
	dir=$opt
	fdir=1
    fi
done
if [[ $fhelp = 1 ]]
then
    echo "topsize [--help][-h][-N][-s minsize][--][dir]"
    exit 0
else
    if [[ $fn = 0 ]]
    then
	fn="-10"
    fi
    if [[ $fsize = 0 ]]
    then
	fsize="+1c"
    fi
    if [[ $fdir = 0 ]]
    then
   	dir="."
    fi
    if [[ $fh = 1 ]]
    then
        find $dir -size $fsize -exec ls "{}" -nh \; >ke
	sort -rhk5 ke > ke1
	head $fn ke1 > ke2
	cut -d ' ' -f 5,9 ke2
    else
	find $dir -size $fsize -exec ls "{}" -n \; >ke
	sort -rhk5 ke > ke1
	head $fn ke1 > ke2
	cut -d ' ' -f 5,9 ke2
    fi
fi
