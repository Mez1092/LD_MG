from django.contrib import admin
from .models import *

# Register your models here.
class HotelAdmin(admin.ModelAdmin):
    fieldsets = [('Info',{'fields':['nome','descrizione', 'sito', 'pub_date']}),
                ('Indirizzo',{'fields':['indirizzo', 'citta', 'stato', 'num_telefono']}),
                ('Servizi',{'fields':['piscina', 'WiFi', 'accesso_disabili', 'ristorante', 'parcheggio', 'palestra', 'bar', 'spa']}),
              ]
    list_display = ('nome', 'pub_date')
    list_filter = ['pub_date']
    search_fields = ['nome']
    def __str__(self):
        return 'Policy: ' + self.nome


class StanzaAdmin(admin.ModelAdmin):
    fieldsets = [('Info',{'fields':['num_persone','id_hotel', 'num_camera', 'prezzo', 'prezzo_festivita']}),
                ('Servizi',{'fields':[ 'aria_condizionata', 'camera_fumatori', 'animali']}),]

    list_display = ('id_hotel', 'num_camera')
    def __str__(self):
        return '- Camera Numero: ' + self.num_camera


class PrenotazioniAdmin(admin.ModelAdmin):
    fields = ['id_stanza', 'id_user', 'check_in', 'check_out']
    list_display = ('id_stanza', 'id_user' ,'check_in', 'check_out' )


class VotoAdmin(admin.ModelAdmin):
    fields = ['hotel_id', 'user_id', 'voto']
    list_display = ('hotel_id', 'user_id', 'voto')


class ListaAttesaAdmin(admin.ModelAdmin):
    fields = ['lista_attesa','user_id','check_in_lista_attesa','check_out_lista_attesa']
    list_display = ('lista_attesa','user_id')

admin.site.register(Hotel, HotelAdmin)
admin.site.register(Stanza, StanzaAdmin)
admin.site.register(Prenotazioni,PrenotazioniAdmin)
admin.site.register(Voto,VotoAdmin)
admin.site.register(ListaAttesaStanza,ListaAttesaAdmin)
