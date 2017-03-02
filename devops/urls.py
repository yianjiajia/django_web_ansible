from django.conf.urls import patterns, include, url
from django.views.generic import TemplateView
from django.conf import settings as conf
import apps.ansible.urls
import apps.account.urls

from django.contrib import admin


admin.autodiscover()

handler404 = 'devops.views.serve_404_error'
handler500 = 'devops.views.serve_500_error'
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
                        #     url(r'^$', 'devops.views.home', name='home'),
                        url(r'^ansible$', TemplateView.as_view(template_name='ansible.html'), name="home"),
                        url(r'^accounts/login/$', 'devops.auth.views.dt_login'),
                        url(r'^accounts/logout/$', 'devops.auth.views.dt_logout',
                            {'next_page': '/accounts/login/'}),
                        url(r'^logs$', 'devops.views.log_view'),
                        url(r'^settings$', 'devops.views.settings'),
                        #    (r'^test$','devops.views.test'),

                        # Uncomment the admin/doc line below to enable admin documentation:
                        #    url(r'^admin/doc/', include('django.contrib.admindocs.urls')),
                        # Uncomment the next line to enable the admin:
                        #    url(r'^i18n/',include('django.conf.urls.i18n')),
                        url(r'^i18n/setlang/', 'devops.views.set_language'),
                        url(r'^ansible/projects/', include(apps.ansible.urls)),
                        url(r'^account/', include(apps.account.urls)),

                        )

if conf.DEBUG is False:
    urlpatterns += patterns('',
                            url(r'^static/(?P<path>.*)$', 'django.views.static.serve',
                                {'document_root': conf.STATIC_ROOT,
                                 }),
                            )
