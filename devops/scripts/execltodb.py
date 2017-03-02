# -*- coding: utf8 -*-
import xlrd
import ser_config
import sys
import MySQLdb

reload(sys)
sys.setdefaultencoding('utf-8')


class execltodb(object):
    def __init__(self, fname, sheet):
        self.fname = fname
        self.sheet = sheet

    def get_execl(self):
        bk = xlrd.open_workbook(self.fname)
        shxrange = range(bk.nsheets)
        try:
            sh = bk.sheet_by_name(self.sheet)
            # 获取行数
            nrows = sh.nrows
            # 获取列数
            ncols = sh.ncols
            cell_value = sh.cell_value(1, 1)
            # 获取第一行第一列数据
            # print cell_value
            row_list = []
            # 获取各行数据
            for i in range(1, nrows):
                row_data = sh.row_values(i)
                row_list.append(row_data)
            return row_list
        except:
            print "no sheet in %s named Sheet1" % fname

    def todb(self):
        # 创建数据库连接
        conn = MySQLdb.Connect(host=ser_config.HOSTIP,
                               user=ser_config.DBUSER,
                               passwd=ser_config.DBPASSWORD,
                               db=ser_config.DBNAME, charset="utf8")
        # 创建游标、插入数据
        cur = conn.cursor()
        data = self.get_execl()
        for i in data:
            sql = "insert into gaga_serverip(ip, useornot, beizhu) values(%s,%s,%s)"
            para = tuple(i)
            cur.execute(sql, para)
        conn.commit()
        cur.close()
        conn.close()


if __name__ == '__main__':
    try:
        execl = execltodb(r'c:\ip2.xls', 'Sheet1')
        execl.todb()
    except MySQLdb.Error, e:
        print "Mysql Error %d: %s" % (e.args[0], e.args[1])
