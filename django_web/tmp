

url编码操作
    import urllib,sys

    s = '杭州'
    print(urllib.quote(s)) # url 转码,打印如: %E6%9D%AD%E5%B7%9E
    print(urllib.unquote('%E6%9D%AD%E5%B7%9E')) # url 解码,打印如: 杭州
    print(urllib.unquote('%BA%BC%D6%DD')) # 输入的是gbk编码,解码方式不变,打印如: 杭州

    # 按所用的编码来转码
    print(urllib.quote(s.decode(sys.stdin.encoding).encode('utf8'))) # 打印如: %E6%9D%AD%E5%B7%9E
    print(urllib.quote(s.decode(sys.stdin.encoding).encode('gbk')))  # 打印如: %BA%BC%D6%DD
    print(urllib.quote(s.decode('gbk').encode('utf8'))) # 指定编码来转码
    print(urllib.quote(u'中国'.encode('utf8'))) # unicode编码的，需encode一下；否则中文会报异常
    # decode就是把其他编码转换为unicode，等同于unicode函数；encode就是把unicode编码的字符串转换为特定编码。

    # 一些不希望被编码的url
    print urllib.quote("http://localhost/index.html?id=1") # 打印: http%3A//localhost/index.html%3Fid%3D1
    print urllib.quote("http://localhost/index.html?id=1",":?=/") # 打印: http://localhost/index.html?id=1

    # 查看
    print(u'中国'.__class__) # 打印: <type 'unicode'>
    print('中国'.__class__)  # 打印: <type 'str'>


    # 格式化整个dict
    print(urllib.urlencode({"act": 1, 'b':'杭州'})) # 打印：act=1&b=%E6%9D%AD%E5%B7%9E


python 2.x 时,注意参数
    使用 urllib.quote 和 urllib.unquote 函数时,一定要注意,传给它的参数必须是 str 类型,而不能是 unicode 类型
    传入 unicode 类型时,编码或者解码出来的结果,会是乱码。由于转码时需要判断字符串长度, unicode 的长度跟 str 的不一样, 导致解码出错

    # 范例
    import urllib, logging
    print urllib.unquote('PPTV%E7%BD%91%E7%BB%9C%E7%94%B5%E8%A7%86') # 正常显示:PPTV网络电视
    logging.error(urllib.unquote(u'PPTV%E7%BD%91%E7%BB%9C%E7%94%B5%E8%A7%86')) # 输出是乱码
    print urllib.unquote(u'PPTV%E7%BD%91%E7%BB%9C%E7%94%B5%E8%A7%86') # 用 logging 输出是乱码,直接打印会报异常

    print urllib.quote('PPTV网络电视') # 正常显示:PPTV%E7%BD%91%E7%BB%9C%E7%94%B5%E8%A7%86
    print urllib.quote(u'PPTV网络电视') # 会报异常
    print(urllib.quote(u'中国'.encode('utf8'))) # unicode编码的，需encode一下；否则中文会报异常

