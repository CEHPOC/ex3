#!/bin/bash

fhelp=0
fh=0
fn=0
fsize=0
f=0
for opt in "$@"
do
    if [[ f = 0 && ${opt:0:1} = "-" ]]
    then
	if [[ $opt = "--help" ]]
	then
	    fhelp=1
	elif [[ $opt == -[0-9]* ]]
	then
	    fn="${opt#-}"
	elif [[ $opt = "-h" ]]
	then
	    fh=1
	elif [[ $opt = "-s" ]]
	then
	    fsize="-1"
	elif [[ $opt = "--" ]]
	then
	    
