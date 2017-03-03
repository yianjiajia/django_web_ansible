# -*- coding: utf-8 -*-
from django.db import models


# Create your models here.
class User(models.Model):
    username = models.CharField('用户名', max_length=20)
    password = models.CharField('密码', max_length=20)
    realname = models.CharField('真实姓名', max_length=255)
    sex = models.CharField('性别', max_length=10)
    email = models.EmailField('电子邮箱', blank=True)

    def __unicode__(self):
        return self.username


class FileServer(models.Model):
    disk_useage = models.CharField('磁盘使用率', max_length=10)
    smb_status = models.CharField('Samba状态', max_length=50)
    raid_status = models.CharField('Raid状态', max_length=50)

    def __unicode__(self):
        return self.disk_useage

    def toJSON(self):
        fields = []
        for field in self._meta.fields:
            fields.append(field.name)
        d = {}
        for attr in fields:
            d[attr] = getattr(self, attr)
        import json
        return json.dumps(d)


class Feature(models.Model):
    textarea = models.TextField('需求')
    who = models.CharField('用户名', max_length=20)


class NamePassword(models.Model):
    IP = models.CharField('IP地址', max_length=20)
    username = models.CharField('账户名', max_length=20)
    password = models.CharField('密码', max_length=20)


class LinuxServer(models.Model):
    serverip = models.CharField('IP地址', max_length=20)
    mingcheng = models.CharField('名称', max_length=20)
    leixing = models.CharField('类型', max_length=20)
    version = models.CharField('版本', max_length=20)


class Resource(models.Model):
    leixin = models.CharField('类型', max_length=100)
    banben = models.CharField('版本', max_length=100)
    ip = models.CharField('ip地址', max_length=255)
    username = models.CharField('用户名', max_length=100)
    password = models.CharField('密码', max_length=100)
    beizhu = models.CharField('备注', max_length=255)
    tester = models.CharField('测试人', max_length=100)
    rd = models.CharField('开发人', max_length=100)


class ServerIp(models.Model):
    ip = models.CharField('IP地址', max_length=20)
    useornot = models.CharField('是否使用', max_length=10)
    beizhu = models.CharField('备注', max_length=40)
