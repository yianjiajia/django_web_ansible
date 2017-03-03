from django.conf.urls import url
from devops.apps.gaga.views import *

urlpatterns = [
    url(r'^$', login),
    url(r'^regist/$', regist),
    url(r'^index/$', index),
    url(r'^logout/$', logout),
    url(r'index/samba$', samba)
]
