#!/bin/bash

rocnik=26
user=***REMOVED***
server=fykos.cz
path=/network/data/www/fykos/rocnik${rocnik}

if [ "x$1" = "x" ] ; then
	echo "Usage: $(basename $0) [FILEs] ..."
	exit 1
fi

# table for transforming problem names
table[1]=1
table[2]=2
table[3]=3
table[4]=4
table[5]=8
table[6]=5
table[7]=6
table[8]=7

for file in "$@" ; do
	case $file in
		reseni?-?.pdf)
			sfile="reseni/$(echo -n ${file:0:-5}${table[${file:8:1}]}.pdf)"
		;;
		serie?.pdf)
			sfile="$file"
		;;
		serial?.pdf)
			sfile="serial/$file"
		;;
	esac
	scp $file $user@$server:$path/$sfile
	ssh $user@$server chown $user:fykos $path/$sfile
	ssh $user@$server chmod 664 $path/$sfile
done;
