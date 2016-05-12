# Ping-and-Traceroute-logging

Ping and traceroute logging bash script
_______________________________________

#How it works:


extremetracert.sh

If the ping has a timeout, a traceroute is running.

extremeping.sh

If one of te ping ip's in iparray has a timeout, Loss and ping times are logged

You can use Cron to run this:
```
*/5 *           * * *   bash /home/extremetracert.sh 8.8.8.8 > /dev/null
*/1 *           * * *   bash /home/extremeping.sh 8.8.8.8 > /dev/null
