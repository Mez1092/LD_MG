from django.contrib.auth.models import User
from django.core.validators import RegexValidator, MinValueValidator, MaxValueValidator
from django.db import models



class Hotel(models.Model):
    nome = models.CharField(max_length=200)
    indirizzo = models.CharField(max_length=300)
    citta = models.CharField(max_length=200)
    stato = models.CharField(max_length=200)
    telefono_regex = RegexValidator(regex=r'^\+?1?\d{9,15}$',message="Phone number must be entered in the format: '+999999999'. Up to 15 digits allowed.")
    num_telefono = models.CharField(validators=[telefono_regex], max_length=15, blank=True)
    piscina = models.BooleanField(default=False)
    WiFi = models.BooleanField(default=False)
    accesso_disabili= models.BooleanField(default=False)
    ristorante = models.BooleanField(default=False)
    parcheggio = models.BooleanField(default=False)
    palestra = models.BooleanField(default=False)
    bar = models.BooleanField(default=False)
    spa = models.BooleanField(default=False)
    descrizione = models.CharField(max_length=1000)
    sito = models.CharField(max_length=600)
    pub_date = models.DateTimeField('date published')

    def __str__(self):
        return self.nome


class Stanza(models.Model):
    id_hotel = models.ForeignKey(Hotel)
    num_camera = models.PositiveIntegerField()
    prezzo = models.FloatField(validators=[MinValueValidator(1)])
    prezzo_festivita = models.FloatField(validators=[MinValueValidator(1)])
    num_persone = models.PositiveIntegerField(validators=[MinValueValidator(1)])
    aria_condizionata = models.BooleanField(default=False)
    camera_fumatori = models.BooleanField(default=False)
    animali = models.BooleanField(default=False)

    class Meta:
        unique_together = (("id_hotel", "num_camera"),)

    def __str__(self):
        return self.id_hotel.nome + " - Camera Numero: " + str(self.num_camera)


class Prenotazioni(models.Model):
    id_stanza = models.ForeignKey(Stanza)
    id_user = models.ForeignKey(User)
    check_in = models.DateField('check_in')
    check_out = models.DateField('check_out')


class Voto(models.Model):
    hotel_id = models.ForeignKey(Hotel)
    user_id = models.ForeignKey(User)
    voto = models.FloatField(validators=[MinValueValidator(0), MaxValueValidator(5)])

    def __str__(self):
        return self.hotel_id.nome
