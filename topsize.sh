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
    if [[ $fsize = 0 ]]
    then
	fsize="+1c"
    fi
    if [[ $fdir = 0 ]]
    then
   	dir="."
    fi
    if ! [ -d $dir ]
    then
	echo "Нет директории" >&2
	exit 2
    fi
    if [[ $fh = 1 && $fn = 0 ]]
    then
        find $dir -size $fsize -exec ls "{}" -nh \; | sort -rhk5 | cut -d ' ' -f 5,9-
    elif [[ $fh = 1 ]]
    then
	find $dir -size $fsize -exec ls "{}" -nh \; | sort -rhk5 | head $fn | cut -d ' ' -f 5,9-
    elif [[ $fh = 0 && $fn = 0 ]]
    then
	find $dir -size $fsize -exec ls "{}" -n \; | sort -rhk5 | cut -d ' ' -f 5,9-
    else
	find $dir -size $fsize -exec ls "{}" -n \; | sort -rhk5 | head $fn | cut -d ' ' -f 5,9-
    fi
fi
