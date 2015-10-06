#!/bin/bash
#
# Converts *.trc files produced by TAU in dynamic instrumentation mode
# into *.slog2 files, that can be read by Jumpshot
#
# If input parameter is present
# it converts only this one file.
# If there are no input parameters, 
# in convetrs all *.trc files in current folder.

# Along with *.trc files there must exist *.edf files (events.N.edf)
# also produced by TAU.

# Copyright (C) 2014 Bryzgalov Peter @ RIKEN AICS

taudir=""
arch="$(uname -m)"
if [ $TAUDIR ] 
	then
	taudir="$TAUDIR/$arch/bin"
fi

function join() {
	local IFS="$1"
	shift
	echo "$*"
}

if [ ! -z $1 ]
	then	
	IFS="\." read -ra arr <<< "$1"
	name=${arr[0]}
	edfile="$name.edf"
	tracefile="$name.trc"
	slog2file="$name.slog2"
	echo "Use $taudir/tau2slog2 to convert $tracefile to $slog2file"
	if [ -f $slog2file ]
		then
		echo $slog2file exists
		exit 0
	fi	
	"$taudir/tau2slog2" $tracefile $edfile -o $slog2file
	exit 0
fi

echo "Use $taudir/tau2slog2"
for f in tautrace.*.trc
do 
	IFS="\." read -ra arr <<< "$f"
	n=${arr[1]}
	edfile="events.$n.edf"
	# echo $edfile
	slog2file="$(join \. "${arr[@]:0:4}").slog2"
	# echo $slog2file
	if [ ! -f $edfile ]
	then
		echo "$edfile not exists"
		continue
	fi

	if [ -f $slog2file ]
	then
		echo $slog2file exists
		continue
	fi
	echo "converting $f to $slog2file"
	"$taudir/tau2slog2" $f $edfile -o $slog2file
done
