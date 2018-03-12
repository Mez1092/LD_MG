from sqlite3 import IntegrityError

from django.core.checks import messages
from django.shortcuts import get_object_or_404
from django.test import TestCase
from django.contrib.auth.models import  User, Group


from myBookingApp_2.models import Stanza, Hotel

class Tests(TestCase):
    def creazione_utente(self):
        user = User.objects.create_user(username='marco',
        first_name='Filippo', last_name='Inzaghi',
        password='pippomio', email='pippo9@gmail.com')
        group = Group.objects.get(name='Utente')
        user.groups.add(group)


    def creazione_stanza(self):
        try:
            Stanza.objects.create(id_hotel=5, num_camera=4, prezzo=300,
                                  prezzo_festivita=450,
                                  num_persone=3, aria_condizionata=True,
                                  camera_fumatori=False, animali=False)
        except IntegrityError as e:
            messages.info('Impossibile creare stanza! Stanza gia esistente per hotel selezionato')

