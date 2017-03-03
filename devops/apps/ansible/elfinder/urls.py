from django.conf.urls import url
from django.contrib.admin.views.decorators import staff_member_required
from views import ElfinderConnectorView

urlpatterns = [
    url(r'^yawd-connector/(?P<optionset>.+)/(?P<start_path>.+)/$',
        staff_member_required(ElfinderConnectorView.as_view()),
        name='yawdElfinderConnectorView'
        )]
