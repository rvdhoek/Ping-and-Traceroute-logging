#!/bin/sh
PING="/bin/ping"
logfile="/var/log/extreme_ping.log"
sleep 1
## declare an ip array variable
declare -a iparray=(192.168.1.1 8.8.4.4 8.8.8.8)

# get length of an array
iparraylength=${#iparray[@]}

# use for loop to read all values and indexes
for (( i=1; i<${iparraylength}+1; i++ ));
do
        DATA=`$PING -c3 -s500 ${iparray[$i-1]} -q `
#echo $DATA
        iploss[i-1]=`echo $DATA | awk '{print $18 }' | tr -d %`
        ipmintime[i-1]=`echo $DATA | tail -1| awk '{print $26}' | cut -d '/' -f 1`
        ipavgtime[i-1]=`echo $DATA | tail -1| awk '{print $26}' | cut -d '/' -f 2`
        ipmaxtime[i-1]=`echo $DATA | tail -1| awk '{print $26}' | cut -d '/' -f 3`
#echo -n ${iploss[i-1]}
#echo -n ${ipmintime[i-1]}
#echo -n ${ipavgtime[i-1]}
#echo -n ${ipmaxtime[i-1]}

done
# Test if error
if [[ ${iploss[*]} =~ 100 ]]
then
{
        String=$(echo "Error: ")
        String+=$(date +%Y-%m-%d:%H:%M:%S)
        for (( i=1; i<${iparraylength}+1; i++ ));
        do
                 String+=" ip:"
                 String+=$(echo -n ${iparray[i-1]})
                 String+=" Loss%:"
                 String+=$(echo -n ${iploss[i-1]})
                 if [[ ! ${iploss[i-1]} == 100 ]]
                 then
                        String+=" min/max/avg (msec):"
                        String+=$(echo -n ${ipmintime[i-1]})
                        String+="/"
                        String+=$(echo -n ${ipavgtime[i-1]})
                        String+="/"
                        String+=$(echo -n ${ipmaxtime[i-1]})
                        String+="  "
                else
                        String+=" No time"
                fi
        done
echo "$String" >> $logfile

}
fi
