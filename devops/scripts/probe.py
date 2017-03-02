__author__ = 'yanjiajia'
# coding=utf8
# !/usr/bin/env python
import time
import ser_config
import sys
import MySQLdb
from serverapi import sshapi

reload(sys)
sys.setdefaultencoding('utf-8')


def probe():
    # 创建数据库连接
    conn = MySQLdb.Connect(host=ser_config.HOSTIP,
                           user=ser_config.DBUSER,
                           passwd=ser_config.DBPASSWORD,
                           db=ser_config.DBNAME, charset="utf8")
    # 创建游标
    cursor = conn.cursor()
    # 查询
    sql1 = 'select * from %s' % ser_config.TABBLENAME
    cursor.execute(sql1)
    DISK_STATUS = sshapi(ser_config.DISK_STATUS)
    RAID_STATUS = sshapi(ser_config.RAID_STATUS)
    SMB_STATUS = sshapi(ser_config.SMB_STATUS)
    try:
        # 查询所有结果，返回二元元组a，a[-1][2]定位到最后表的smb_status域并将返回的Unicode字符串转换为utf8编码与采集到的SMB_STATUS比较
        a = cursor.fetchall()
        if SMB_STATUS <> a[-1][2].encode('utf8'):
            sql2 = 'update gaga_fileserver set disk_useage=%s, smb_status=%s, raid_status=%s'
            param = (DISK_STATUS, SMB_STATUS, RAID_STATUS)
            cursor.execute(sql2, param)
            conn.commit()
            cursor.close()
            conn.close()
    except BaseException, e:
        print e


# if  Fileserver.objects.get(disk_useage__exact=DISK_STATUS) is None:
#        p1 = Fileserver(useage = DISK_STATUS )
#        p1.save()
#    if  Fileserver.objects.get(smb_status__exact=DISK_STATUS) is None:
#        p2 = Fileserver(useage = DISK_STATUS )
#        p2.save()
#    if  Fileserver.objects.get(disk_status__exact=DISK_STATUS) is None:
#        p3 = Fileserver(useage = DISK_STATUS )
#        p3.save()
if __name__ == '__main__':
    while True:
        print u"########开始采集并更新表数据########"
        probe()
        time.sleep(10)
