#!/bin/sh
maillist='backup_admins@any.com'
#--------------- check free space -----------------------------------------------------------------------------------
for i in `df|grep "%"|grep -v "Filesystem"|awk -F "%" '{print $2}'|awk '{print $1}'`
do
v1=`df $i|wc -l`
v2=`df $i|grep -v ":"|wc -l`
        if [ $v1 -eq $v2 ]; then
                if [ $v1 -ge 3 ]; then
                proc=`df $i|grep "%"|grep -v "Filesystem"|awk -F "%" '{print $1}'|awk '{print $4}'`
                else
                proc=`df $i|grep "%"|grep -v "Filesystem"|awk -F "%" '{print $1}'|awk '{print $5}'`
                fi
#        echo "$i $proc"
                                if [ $proc -ge 80 ] ; then
                                D=`df -h`
                                df -h
#                                D=$D"                                               Run command: find <conc_log_dir> -mtime +2 -exec rm {} \\;"
                                echo "$D"|mailx -s "Free disk space on $(uname -n)" $maillist
                                exit
                                fi
        fi
done
#--------------- check inodes ---------------------------------------------------------------------------------------
for i in `df -i|grep "%"|grep -v "Filesystem"|awk -F "%" '{print $2}'|awk '{print $1}'`
do
v1=`df -i $i|wc -l`
v2=`df -i $i|grep -v ":"|wc -l`
        if [ $v1 -eq $v2 ]; then
                if [ $v1 -ge 3 ]; then
                proc=`df -i $i|grep "%"|grep -v "Filesystem"|awk -F "%" '{print $1}'|awk '{print $4}'`
                else
                proc=`df -i $i|grep "%"|grep -v "Filesystem"|awk -F "%" '{print $1}'|awk '{print $5}'`
                fi
#        echo "$i $proc"
                                if [ $proc -ge 80 ] ; then
                                D=`df -ih`
#                                df -i
#                               D=$D"                                               Run command: find <conc_log_dir> -mtime +2 -exec rm {} \\;"
                                echo "$D"|mailx -s "Deficit inodes into file-system on $(uname -n)" $maillist
                                exit
                                fi
        fi
done
