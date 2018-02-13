#!/bin/bash
echo '{"data":[' ;
cat /var/log/zabbix/dhcp-range.cnt | /usr/bin/awk '{print "{\"{#RANGE}\":\"" $1 "\"},"}' | /bin/sed '$s,\,,,g'
echo ']}'
