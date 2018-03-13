from django.test import TestCase, Client
from django.contrib.auth.models import  User, Group, Permission


class Tests(TestCase):
    def setUp(self):
        self.group = Group.objects.create(name = "Utente")
        add_voto = Permission.objects.get(codename = 'add_voto')
        self.group.permissions.add(add_voto)
        self.user = User.objects.create_user(username='pippo',
        first_name='Filippo', last_name='Inzaghi',
        password='pippomio', email='pippo9@gmail.com')
        self.group.user_set.add(self.user)
        self.c = Client()


    def test_creazione_utente(self):
        self.assertTrue(isinstance(self.user, User))
        self.assertEqual(self.user.username, 'pippo')

    def test_utente_login(self):
        response_login = self.c.login(username = 'pippo', password = 'pippomio')
        self.assertEqual(response_login.__bool__(), True)
