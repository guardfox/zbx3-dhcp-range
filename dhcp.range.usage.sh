#!/bin/bash
total=`cat /var/log/zabbix/dhcp-range.cnt | grep $1 | /usr/bin/awk '{ print $2 }'`
used=`cat /var/log/zabbix/dhcp-range.cnt | grep $1 | /usr/bin/awk '{ print $3 }'`


echo $total,$used
