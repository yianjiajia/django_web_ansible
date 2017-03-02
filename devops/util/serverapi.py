# coding=utf-8
__author__ = 'yanjiajia'
from devops.conf import ser_config
import paramiko
from Crypto.Hash import MD5


def t5():
    '''Crypto MD5'''

    h = MD5.new()
    h.update(b'Hello')
    print h.hexdigest()


def sshapi(cmd):
    hostname = ser_config.hostname
    port = ser_config.port
    user = ser_config.user
    passwd = ser_config.passwd

    paramiko.util.log_to_file('paramiko.log')
    s = paramiko.SSHClient()
    s.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    s.connect(hostname=hostname, port=port, username=user, password=passwd, timeout=10)
    # stdin,stdout,stderr=s.exec_command('pwd')
    stdin, stdout, stderr = s.exec_command(cmd)
    # print stdout.read()
    lines = stdout.readlines()
    for i in lines:
        return splitline(i)


def splitline(ss):
    ret = ''
    for i in ss:
        ret += i
    out = ret.encode("utf8")
    return out
