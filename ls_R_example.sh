#!/bin/bash -x
#
# Just shows how to recursive on directories, for example with ls -lR implemented using ls -l.

function lsCurrentDir() {
	echo DIR "$1"
	for filename in *
	do
		if test -d "$filename" ; then
			( cd "$filename" && lsCurrentDir "$filename" )
		else
			ls -l "$filename"
		fi
	done
}

# main
lsCurrentDir .
