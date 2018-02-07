from django.conf.global_settings import LOGOUT_REDIRECT_URL
from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'^search/', views.search,name= 'search'),
    url(r'^creastanza/', views.creastanza,name= 'creastanza'),
    url(r'^creahotel/', views.creahotel,name= 'creahotel'),
    url(r'^creazioneavvenuta/', views.successocreazione, name='creazioneavvenuta'),
    url(r'^logout/$', views.logout_view, name='logout'),
    url(r'^login/',views.login_test,name='login'),
    url(r'^userpage/',views.userpage,name='user'),
	url(r'^registrazioneutente/',views.register_user,name='registrazioneutente'),
    url(r'^registrazionegestore/',views.register_gestore,name='registrazionegestore')
]