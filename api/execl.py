#-*- coding: utf8 -*-
import xlrd
def get_execl(fname, sheet):
    bk = xlrd.open_workbook(fname)
    shxrange = range(bk.nsheets)
    try:
        sh = bk.sheet_by_name(sheet)
        #获取行数
        nrows = sh.nrows
        #获取列数
        ncols = sh.ncols
        cell_value = sh.cell_value(1,1)
        #获取第一行第一列数据
#print cell_value
        row_list = []
#获取各行数据
        for i in range(1, nrows):
            row_data = sh.row_values(i)
            row_list.append(row_data)
        return row_list
    except:
        print "no sheet in %s named Sheet1" % fname
#