from django.conf.urls import patterns, url
from devops.gaga.views import *

urlpatterns = patterns('',
                       url(r'^$', login),
                       url(r'^regist/$', regist),
                       url(r'^index/$', index),
                       url(r'^logout/$', logout),
                       url(r'index/samba$', samba),
                       )
