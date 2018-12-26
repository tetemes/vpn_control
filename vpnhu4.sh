#!/bin/bash
. `dirname $0`/config.sh
SPFILE=/tmp/onesubpid.pid
SPPID=`cat ${SPFILE}`
if [ -e ${SPFILE} ] && sudo kill -0 $SPPID 2> /dev/null
then
	echo subprocess exists, killing
	sudo kill -15 $SPPID && rm -f ${SPFILE}
	echo waiting for process $SPPID to exit
	while [ -e /proc/$SPPID ]
	do
		sleep .5
	done
else
	echo subprocess does not exist
fi
(cd ~/ipvanish_vpn_files/ && one.sh sudo /usr/sbin/openvpn ipvanish-HU-Budapest-bud-c04.ovpn) & disown
