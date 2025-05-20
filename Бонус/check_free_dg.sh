#!/usr/bin/bash
porog=80
key_free=0
maillist='backup_admins@any.com'
/usr/bin/su - oracle -c /home/oracle/check_dg.sh > /tmp/check_dg.txt
sleep +5
echo "Group  Total_MB  Free_MB  Free_%" > /tmp/out_dg.txt
for i in $(cat /tmp/check_dg.txt|grep "MOUNTED"|awk '{print $14}')
 do 
	#echo $i
	v_total=$(cat /tmp/check_dg.txt|grep "$i"|awk '{print $8}')
	v_free=$(cat /tmp/check_dg.txt|grep "$i"|awk '{print $9}')
	v_proc=$(bc<<<"scale=0;($v_free*100/$v_total)")
	echo "$i  $v_total     $v_free    $v_proc%" >> /tmp/out_dg.txt
		if [ $v_proc -lt $porog ]; then
		key_free=$(($key_free + 1))
		fi
 done
if [ $key_free -gt 0 ]; then
D=$(cat /tmp/out_dg.txt)
cat /tmp/out_dg.txt
#echo $D
log_name="/tmp/out_dg.txt"
#zip - $log_name|uuencode attach.zip|mailx -m -s "Send $log_name from $(hostname)" $maillist
echo "$D"|mailx -s "Free disk-group space on $(uname -n)" $maillist
fi
