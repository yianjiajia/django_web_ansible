#coding=utf-8
__author__ = 'yanjiajia'
#文件服务器
hostname = '192.168.0.174'
port = 22
user = 'root'
passwd = '123456'
DISK_STATUS = "df -h |grep md127|awk '{ print $5}'"
RAID_STATUS = 'mdadm -D /dev/md127|grep State|head -1'
SMB_STATUS = 'service smb status'
DBNAME = 'apexit'
DBUSER = 'root'
DBPASSWORD =  '111111'
HOSTIP = '192.168.0.35'
HOSTPORT = 3306
TABBLENAME = 'gaga_fileserver'