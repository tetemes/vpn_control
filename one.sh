#!/bin/sh

. `dirname $0`/config.sh

# one.sh -- Singleton command execution for Linux/BSD
#
# Makes sure only one instance of the same process is running at once. This
# script does nothing if it was previously used to launch the same command
# and that instance is still running.
#
# /tmp/one-<md5sum of the arguments>.pid is used as the lock file. This file
# is removed if the process it refers to isn't actually running.
#
# Usage:   ./one.sh <command> <arguments>
# Example: ./one.sh wget --mirror http://mysite.com
#
# See http://patrickmylund.com/projects/one/ for more information.
 
# Switch out LFILE for something static to avoid running md5sum and cut, e.g.
# LFILE=/tmp/one.pid
LFILE=/tmp/onepid.pid
SPFILE=/tmp/onesubpid.pid
if [ -e ${LFILE} ] && sudo kill -0 `cat ${LFILE}`; then
	echo Lock found at `date`
	exit
fi
 
trap ctrl_c INT TERM EXIT
ctrl_c() {
	EC=$?
	if [ -e ${SPFILE} ] && sudo kill -0 `cat ${SPFILE}`
	then
		sudo kill -15 `cat ${SPFILE}` && rm -f ${SPFILE}
	fi
	rm -f ${LFILE}
	exit $EC
}

echo $$ > ${LFILE}

"$@" &
SUBPID=$!

echo $SUBPID > ${SPFILE}

wait $SUBPID
#while [ -e /proc/$SUBPID ]
#do
#	sleep 2
#done


rm -f ${LFILE}
rm -f ${SPFILE}
