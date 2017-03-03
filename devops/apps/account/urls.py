'''
urls for ansible app
'''
from django.conf.urls import url
from devops.lib.django_util import get_name_re_rule
from devops.apps.account import views

name_re = get_name_re_rule()

urlpatterns = [url(r'^$', views.list_users),
               url(r'^users$', views.list_users),
               url(r'^users/profile/(?P<username>%s)$' % (name_re,),
                   views.profile, name='profile'),
               url(r'^users/credential/(?P<username>%s)$' % (name_re,),
                   views.credential, name='credential'),
               url(r'^users/delete/(?P<username>%s)$' % (name_re,),
                   views.delete_user, name='delete_user'),
               url(r'^users/add_ldap_users$', views.add_ldap_users, name='add_ldap_users'),
               url(r'^users/sync_ldap_users_groups$',
                   views.sync_ldap_users_groups, name='sync_ldap_users_groups')
               ]
