# coding=utf-8
from django import forms
from .models import *
import datetime


class SearchHotelForm(forms.Form):
    citta = forms.CharField(widget=forms.TextInput,required=False)
    check_in = forms.DateField(widget=forms.widgets.SelectDateWidget, initial=datetime.date.today())
    check_out = forms.DateField(widget=forms.widgets.SelectDateWidget,initial=datetime.date.today() + datetime.timedelta(days=1))
    piscina = forms.BooleanField(initial=False, required=False)
    WiFi = forms.BooleanField(initial=False, required=False)
    accesso_disabili = forms.BooleanField(initial=False, required=False)
    ristorante = forms.BooleanField(initial=False, required=False)
    parcheggio = forms.BooleanField(initial=False, required=False)
    palestra = forms.BooleanField(initial=False, required=False)
    bar = forms.BooleanField(initial=False, required=False)
    spa = forms.BooleanField(initial=False, required=False)
    num_persone = forms.IntegerField(initial=1, min_value=1)
    aria_condizionata = forms.BooleanField(initial=False, required=False)
    camera_fumatori = forms.BooleanField(initial=False, required=False)
    animali = forms.BooleanField(initial=False, required=False)

class AddRoomForm(forms.ModelForm):
    class Meta:
        model = Stanza
        fields = ('id_hotel', 'num_camera','prezzo','num_persone','prezzo_festivita', 'aria_condizionata','camera_fumatori','animali')

    # nome = forms.IntegerField(widget=forms.Select(choices=[(hotel.nome) for hotel in Hotel.objects.all()]),required=True)
    # num_camera = forms.IntegerField(required=True,)
    # prezzo = forms.FloatField(required=True)
    # prezzo_festivita = forms.FloatField(required=True)
    # num_persone = forms.IntegerField(min_value=1,required=True)
    # aria_condizionata = forms.BooleanField(initial=False, required=False)
    # camera_fumatori = forms.BooleanField(initial=False, required=False)
    # animali = forms.BooleanField(initial=False, required=False)

class AddHotelForm(forms.ModelForm):
    class Meta:
        model = Hotel
        fields = ('nome', 'indirizzo','citta','stato', 'num_telefono','sito','descrizione','piscina', 'WiFi','accesso_disabili', 'ristorante','parcheggio', 'palestra','bar', 'spa')
    # nome = forms.CharField(max_length=200)
    # indirizzo = forms.CharField(max_length=300)
    # citta = forms.CharField(max_length=200)
    # stato = forms.CharField(max_length=200)
    # num_telefono = forms.CharField( max_length=15)
    # piscina = forms.BooleanField(initial=False, required=False)
    # WiFi = forms.BooleanField(initial=False, required=False)
    # accesso_disabili = forms.BooleanField(initial=False, required=False)
    # ristorante = forms.BooleanField(initial=False, required=False)
    # parcheggio = forms.BooleanField(initial=False, required=False)
    # palestra = forms.BooleanField(initial=False, required=False)
    # bar = forms.BooleanField(initial=False, required=False)
    # spa = forms.BooleanField(initial=False, required=False)

class AddVoto(forms.ModelForm):
    hotel_id = forms.IntegerField(widget=forms.Select(choices=[(hotel.nome) for hotel in Hotel.objects.all()]),required=True)
    user_vote = forms.IntegerField(widget=forms.Select(choices=[(User.username) for User in User.objects.all()]),required=True)
    voto_value = forms.FloatField()



# class AddStanzaPreferita(forms.ModelForm):
#     stanza_preferita = forms.IntegerField(widget=forms.Select(choices=[(stanza.num_camera) for stanza in Stanza.objects.all()]),required=True)
#     user_id = forms.IntegerField(widget=forms.Select(choices=[(User.username) for User in User.objects.all()]),required=True)


class AddToListaAttesa(forms.ModelForm):
    lista_attesa = forms.IntegerField(widget=forms.Select(choices=[(stanza.num_camera) for stanza in Stanza.objects.all()]),required=True)
    user_id = forms.IntegerField(widget=forms.Select(choices=[(User.username) for User in User.objects.all()]),required=True)
    # user_prenotazione = forms.IntegerField(widget=forms.Select(choices=[(prenotazioni.id_user) for prenotazioni in Prenotazioni.objects.all()]),required=True)
    check_in = forms.DateField(widget=forms.widgets.SelectDateWidget, initial=datetime.date.today())
    check_out = forms.DateField(widget=forms.widgets.SelectDateWidget, initial=datetime.date.today() + datetime.timedelta(days=1))


class RegistrationForm(forms.Form):
    username = forms.RegexField(regex=r'^\w+$', widget=forms.TextInput(attrs=dict(required=True, max_length=30)), label=("Username"), error_messages={ 'invalid': ("This value must contain only letters, numbers and underscores.") })
    email = forms.EmailField(widget=forms.TextInput(attrs=dict(required=True, max_length=30)), label=("Email address"))
    password1 = forms.CharField(widget=forms.PasswordInput(attrs=dict(required=True, max_length=30, render_value=False)), label=("Password"))
    password2 = forms.CharField(widget=forms.PasswordInput(attrs=dict(required=True, max_length=30, render_value=False)), label=("Password (again)"))

    def clean_username(self):
        try:
            user = User.objects.get(username__iexact=self.cleaned_data['username'])
        except User.DoesNotExist:
            return self.cleaned_data['username']
        raise forms.ValidationError("The username already exists. Please try another one.")

    def clean(self):
        if 'password1' in self.cleaned_data and 'password2' in self.cleaned_data:
            if self.cleaned_data['password1'] != self.cleaned_data['password2']:
                raise forms.ValidationError("The two password fields did not match.")
        return self.cleaned_data

class LoginForm(forms.Form):
    Username = forms.CharField(max_length=30, required=True)
    Password = forms.CharField(max_length=30, required=True)

    class Meta:
        model = User
        fields = ('username', 'password' )
