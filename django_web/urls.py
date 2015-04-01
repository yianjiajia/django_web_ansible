from django.conf.urls import patterns, include, url
from django.views.generic import TemplateView
from django.conf import settings
import apps.ansible.urls
import apps.account.urls
from django_web.views import *
from django.contrib import admin
admin.autodiscover()
from django_web import settings 
handler404 = 'django_web.views.serve_404_error'
handler500 = 'django_web.views.serve_500_error'
urlpatterns = patterns('',
	url(r'^users/', 'service.main.ssh'),
	url(r'^admin/', include(admin.site.urls)),
    url(r'^regist/$', 'gaga.views.regist'),
    url(r'^$', 'gaga.views.index'), 
    url(r'^logout/$', 'gaga.views.logout'),
	url(r'^testresource/$', 'gaga.views.testresource'),
	url(r'^testresource/(?P<tab>\d)/$', 'gaga.views.changetab'),
)
urlpatterns += patterns('gaga.views', 
	url(r'^samba/$', 'samba'),
    url(r'^json/$', 'json_data'),
    url(r'^wiki/$', 'wiki'),
    url(r'^upload/$', 'upload'),
    url(r'error/$', 'noreal'),
    url(r'webSSH/$', 'term'),
    url(r'webcontrol/$', 'webcontrol'),
    )
urlpatterns += patterns('',
#     url(r'^$', 'django_web.views.home', name='home'),
	url(r'^ansible$', TemplateView.as_view(template_name='ansible.html'), name="home"),
	url(r'^accounts/login/$', 'django_web.auth.views.dt_login'),
    url(r'^accounts/logout/$', 'django_web.auth.views.dt_logout', {'next_page': '/accounts/login/'}),
	url(r'^logs$','django_web.views.log_view'),
    url(r'^settings$','django_web.views.settings'),
#    (r'^test$','django_web.views.test'),

    # Uncomment the admin/doc line below to enable admin documentation:
#    url(r'^admin/doc/', include('django.contrib.admindocs.urls')),
    # Uncomment the next line to enable the admin:
#    url(r'^i18n/',include('django.conf.urls.i18n')),
    url(r'^i18n/setlang/','django_web.views.set_language'),
    url(r'^ansible/projects/', include(apps.ansible.urls)),
    url(r'^account/', include(apps.account.urls)),


)

if settings.DEBUG is False:
    urlpatterns += patterns('',
        url(r'^static/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.STATIC_ROOT,
        }),
)