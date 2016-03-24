#!/bin/sh
PING="/bin/ping"
logfile="/var/log/extreme_tracert.log"

#check if symlink exists
if [ $1 = "" ]; then
echo "Error: No ip input"
exit 1
fi

DATA=`$PING -c3 -s500 $1 -q `
LOSS=`echo $DATA | awk '{print $18 }' | tr -d %`
#echo $LOSS

if [ $LOSS = 100 ]; then
{
        HOSTNAME=$(hostname)
        TODAY=$(date +%Y-%m-%d:%H:%M:%S)
        echo ">"
        echo "Date: $TODAY My host:$HOSTNAME IP:$1 " >> $logfile
        echo "__________________" >> $logfile
        echo
        traceroute $1 -m 13 >> $logfile
}
fi
