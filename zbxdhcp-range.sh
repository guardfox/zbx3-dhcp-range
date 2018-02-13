#!/bin/bash

config="/etc/dhcp/dhcpd.conf"
leases="/var/lib/dhcp/dhcpd.leases"

ranges=( $(cat $config | grep range | sed '/ *#/d; /^ *$/d' | awk '{  print $2,$3 }' |sed 's/;//g'| sed 's/ /-/g'))
ipaddrs=( $(cat $leases | awk '{ if ($1 == "lease") { x=$2 } else { if (($1 == "binding") && ($3 == "active;")) { print x } } }' | sort | uniq ) )


for ((i=0;i<${#ipaddrs[@]};i++));
        do
                for ((j=0;j<${#ranges[@]};j++));
                        do
                            #     echo "IP address: ${ipaddrs[$i]}";
                            #     echo "Range: ${ranges[$j]} ";
                                srchost=`./iptorange.pl ${ipaddrs[$i]} ${ranges[$j]} `
                                let ipcount[$j]="${ipcount[$j]} + $srchost"
                        done
        done


 echo -n > /var/log/zabbix/dhcp-range.zbx
for ((i=0;i<${#ranges[@]};i++));
        do
                maxhosts=`./rangesize.sh ${ranges[$i]}`
                echo ${ranges[$i]}" "$maxhosts" "${ipcount[$i]} >> /var/log/zabbix/dhcp-range.zbx
        done

chown zabbix /var/log/zabbix/dhcp-range.zbx
mv -f /var/log/zabbix/dhcp-range.zbx /var/log/zabbix/dhcp-range.cnt
