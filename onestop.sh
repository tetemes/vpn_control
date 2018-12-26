#!/bin/bash
. `dirname $0`/config.sh
SPFILE=/tmp/onesubpid.pid
if [ -e ${SPFILE} ]
then
	SPPID=`cat ${SPFILE}`
else
	exit
fi
if [ -e ${SPFILE} ] && sudo kill -0 $SPPID 2> /dev/null
then
	echo subprocess exists, killing
	sudo kill -15 $SPPID && rm -f ${SPFILE}
	echo waiting for process $SPPID to exit
	while [ -e /proc/$SPPID ]
	do
		sleep .5
	done

fi
