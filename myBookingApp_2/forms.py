# coding=utf-8
from django import forms
from .models import *
import datetime


class SearchHotelForm(forms.Form):
    # citta = forms.CharField(widget=forms.TextInput(attrs=dict(required=False, id='testcitta')),required=False,)
    citta = forms.CharField(widget=forms.TextInput(), required=False)
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
    CHOICES = [('prezzo', 'Prezzo'),
               ('voto', 'Voto')]

    ordinamento = forms.ChoiceField(choices=CHOICES, widget=forms.RadioSelect())



class EditPrenotazione(forms.Form):
    check_in = forms.DateField(widget=forms.widgets.SelectDateWidget, initial=datetime.date.today())
    check_out = forms.DateField(widget=forms.widgets.SelectDateWidget,initial=datetime.date.today() + datetime.timedelta(days=1))

    # def clean_check_out(self):
    #     if 'check_out' in self.cleaned_data and 'check_in' in self.cleaned_data:
    #         if self.cleaned_data['check_out'] < self.cleaned_data['check_in']:
    #             raise forms.ValidationError("La data di checkout deve essere maggiore di quella di checkin")
    #     return self.cleaned_data


class AddRoomForm(forms.ModelForm):
    class Meta:
        model = Stanza
        fields = ('id_hotel', 'num_camera','prezzo','num_persone','prezzo_festivita','aria_condizionata','camera_fumatori','animali')

    def __init__(self, *args, **kwargs):
        user = kwargs.pop('user')
        super(AddRoomForm, self).__init__(*args, **kwargs)
        self.fields['id_hotel'].queryset = Hotel.objects.filter(direttore=user)


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
    username = forms.RegexField(regex=r'\w+$', widget=forms.TextInput(attrs=dict(required=True, max_length=30)), label=("Username"), error_messages={ 'invalid': ("Il campo può contenere solo lettere,numeri e underscore") })
    first_name = forms.CharField(widget=forms.TextInput(attrs=dict(required=True, max_length=30)), label=("Nome"))
    last_name = forms.CharField(widget=forms.TextInput(attrs=dict(required=True, max_length=30)), label=("Cognome"))
    email = forms.EmailField(widget=forms.TextInput(attrs=dict(required=True, max_length=30)), label=("Indirizzo Email"))
    pwd1 = forms.CharField(widget=forms.PasswordInput(attrs=dict(required=True, max_length=30, render_value=False)), label=("Password"))
    pwd2 = forms.CharField(widget=forms.PasswordInput(attrs=dict(required=True, max_length=30, render_value=False)), label=("Ripetere Password"))

    def clean_username(self):
        try:
            user = User.objects.get(username__iexact=self.cleaned_data['username'])
        except User.DoesNotExist:
            return self.cleaned_data['username']
        raise forms.ValidationError("Username già esistente")



    def clean(self):
        if 'pwd1' in self.cleaned_data and 'pwd2' in self.cleaned_data:
            if self.cleaned_data['pwd1'] != self.cleaned_data['pwd2']:
                raise forms.ValidationError("Le due password non corrispondono")
        return self.cleaned_data

class LoginForm(forms.Form):
    Username = forms.CharField(max_length=30, required=True)
    Password = forms.CharField(max_length=30, required=True)

    class Meta:
        model = User
        fields = ('username', 'password' )
