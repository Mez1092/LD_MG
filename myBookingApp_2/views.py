from django.contrib.auth.models import Permission, Group
from django.db.models.functions import datetime
from django.contrib import messages
from django.db import IntegrityError
from django.template.defaultfilters import *
from django.contrib.auth import logout, authenticate, login
from django.shortcuts import render_to_response
from datetime import datetime
from django.http import HttpResponseRedirect
from django.template import RequestContext
from django.shortcuts import get_object_or_404, render
from django.contrib.auth import logout
from django.contrib.auth.decorators import login_required
from .forms import *
import datetime

def index(request):
    hotels = Hotel.objects.all()
    stanze = Stanza.objects.all()
    return render(request, 'index.html', {'hotels': hotels , "stanze" : stanze})

def userpage(request):
    current_user = request.user
    prenotation = Prenotazioni.objects.all().filter(id_user=current_user)
    preferite = Stanzapreferita.objects.all().filter(user_id=current_user)
    lista_attesa = ListaAttesaStanza.objects.all().filter(user_id=current_user)


    return render(request, 'userpage.html', {"prenotazioni": prenotation, "preferite": preferite, "lista_attesa": lista_attesa})


def search(request):


        hotels = Hotel.objects.all()
        stanze = Stanza.objects.all()
        stanze = stanze.order_by("prezzo")
        prenotazioni = Prenotazioni.objects.all()
        prenotazioni_totali = Prenotazioni.objects.all()
        data = []

        Filtered_hotels = None
        Filtered_rooms = None
        total_id_hotel = None
        giorni_alloggio = 0

        #contiene tutti gli id delle stanze prenotate
        p = [p.id_stanza.id for p in prenotazioni]
        prenotazioni_filtrate = []


        if request.method == 'POST':


            form_search_hotel = SearchHotelForm(request.POST)
            Filtered_hotels = hotels
            Filtered_rooms = stanze

            if form_search_hotel.is_valid():
                # prendo in ingresso tutti i valori inseriti nel form
                f_citta = form_search_hotel.cleaned_data['citta']
                f_check_in = form_search_hotel.cleaned_data['check_in']
                f_check_out= form_search_hotel.cleaned_data['check_out']
                f_piscina = form_search_hotel.cleaned_data['piscina']
                f_wifi = form_search_hotel.cleaned_data['WiFi']
                f_accesso_disabili = form_search_hotel.cleaned_data['accesso_disabili']
                f_ristorante = form_search_hotel.cleaned_data['ristorante']
                f_parcheggio = form_search_hotel.cleaned_data['parcheggio']
                f_palestra = form_search_hotel.cleaned_data['palestra']
                f_bar = form_search_hotel.cleaned_data['bar']
                f_spa = form_search_hotel.cleaned_data['spa']
                f_num_persone = form_search_hotel.cleaned_data['num_persone']
                f_aria_condizionata = form_search_hotel.cleaned_data['aria_condizionata']
                f_camera_fumatori = form_search_hotel.cleaned_data['camera_fumatori']
                f_animali = form_search_hotel.cleaned_data['animali']
                # trasformo in stringa la data di checkin e checkout per calcolare il delta
                date_format = "%Y-%m-%d"
                check_in_string = f_check_in.strftime(date_format)
                check_out_string = f_check_out.strftime(date_format)
                delta = f_check_out - f_check_in
                data.append(check_in_string)
                data.append(check_out_string)
                data.append(delta.days)

                Filtered_hotels = Filtered_hotels.filter(citta__icontains=f_citta).all()
                # Filtered_hotels = Filtered_hotels.filter(citta=f_citta).all()

                # filtro solo gli elementi che hanno le caratteristiche inserite nel form
                if f_piscina:
                    Filtered_hotels = Filtered_hotels.filter(piscina=True)
                if f_wifi:
                    Filtered_hotels = Filtered_hotels.filter(WiFi=True)
                if f_accesso_disabili:
                    Filtered_hotels = Filtered_hotels.filter(accesso_disabili=True)
                if f_ristorante:
                    Filtered_hotels = Filtered_hotels.filter(ristorante=True)
                if f_parcheggio:
                    Filtered_hotels = Filtered_hotels.filter(parcheggio=True)
                if f_palestra:
                    Filtered_hotels = Filtered_hotels.filter(palestra=True)
                if f_bar:
                    Filtered_hotels = Filtered_hotels.filter(bar=True)
                if f_spa:
                    Filtered_hotels = Filtered_hotels.filter(spa=True)
                if (f_num_persone > 0):
                    Filtered_rooms = Filtered_rooms.filter(num_persone__gte=f_num_persone)
                if f_aria_condizionata:
                    Filtered_rooms = Filtered_rooms.filter(aria_condizionata=True)
                if f_camera_fumatori:
                    Filtered_rooms = Filtered_rooms.filter(camera_fumatori=True)
                if f_animali:
                    Filtered_rooms = Filtered_rooms.filter(animali=True)

                total_id_hotel = [h.id_hotel for h in Filtered_rooms]
                risultati_stanze = Filtered_rooms
                f_id_stanze_filtrate = [room.id for room in Filtered_rooms]


        else:

            # se sono in una get faccio vedere il form vuoto
            form_search_hotel = SearchHotelForm()
            return render(request, 'indexsearch.html', {'form_search' : form_search_hotel})


        for stanza_prenotata in prenotazioni_totali:
             cin = stanza_prenotata.check_in.strftime(date_format)
             cout = stanza_prenotata.check_out.strftime(date_format)
             counter = 0

             # if data[0] <= cin and data[1] >= cin or data[0] >= cin and data[1] <= cout or data[0] <= cout and data[1] >= cout or data[0] <= cin and data[1] >= cout:
             if (data[0] >= cin and data[0] <= cout) or (data[1] >= cin and data[1] <= cout) or (data[0] <= cin and data[1] >= cout):

                 print("Stanza Nel Periodo: ", stanza_prenotata.id)
                 prenotazioni_filtrate.append(stanza_prenotata.id_stanza_id)


             else:
                 print("Stanza Fuori Periodo: ", stanza_prenotata.id)
                 # stanza_prenotata.delete()              #mi rimuove la stanza dal db, valutare alternative per rimuovere la stanza dall'elenco prenotazioni totali


        print(prenotazioni_filtrate)

        # print("total id ", Filtered_rooms)

        # tengo solo gli hotel filtrati che possiedono delle stanze:    DA RIVEDERE PER TROVARE QUALCOSA DI MEGLIO
        # if total_id_hotel:
        #     for h in Filtered_hotels:
        #         count = 0
        #         for e in total_id_hotel:
        #             if h.id == e.id :
        #                 count = count +1
        #         if count == 0:
        #             print(h.nome)
        #             Filtered_hotels = Filtered_hotels.exclude(pk=h.pk)
        # print("filtered hotel dopo ", Filtered_hotels)
        #
        #risultati_hotel = Filtered_hotels


        return render(request, 'indexsearch.html', {'data': data, 'risultati_hotel': hotels , 'form_search' : form_search_hotel, 'stanze_filtrate': risultati_stanze, "stanze_prenotate" : prenotazioni_filtrate, "id_prenotate": p })

# filtro da usare nel template per il calcolo del prezzo totale per il soggiorno
# @register.filter(name='moltiplicazione')
# def moltiplicazione(value, arg):
#     print("value: "+" arg: ", value, arg)
#     return value*arg

def creastanza(request):
    if request.method == 'POST':
        form_crea_stanza = AddRoomForm(request.POST)
        if form_crea_stanza.is_valid():
            f_id_hotel = request.POST['id_hotel']
            f_num_camera = request.POST['num_camera']
            f_prezzo = request.POST['prezzo']
            f_prezzo_festivita = request.POST['prezzo_festivita']
            f_num_persone = request.POST['num_persone']
            f_aria_condizionata = 'aria_condizionata' in request.POST.keys()
            f_camera_fumatori = 'camera_fumatori' in request.POST.keys()
            f_animali = 'animali' in request.POST.keys()
            h = get_object_or_404(Hotel,pk=f_id_hotel)
            try:
                Stanza.objects.create(id_hotel=h, num_camera=int(f_num_camera), prezzo=float(f_prezzo), prezzo_festivita=float(f_prezzo_festivita), num_persone=int(f_num_persone),
                    aria_condizionata=f_aria_condizionata, camera_fumatori=f_camera_fumatori, animali=f_animali)
                return HttpResponseRedirect('/myBookingApp/creazioneavvenuta')
            except IntegrityError as e:
                messages.info(request, 'Impossibile creare stanza! Stanza gia esistente per hotel selezionato')
        # Verifica custom se nuova stanza ha numero camera gia esistente
        # for l in Hotel.objects.all():
        #     if (l.id == int(f_id_hotel)):
        #         stanze_id = Stanza.objects.filter(id_hotel=l.id)
        #         for r in stanze_id:
        #             if (r.num_camera == int(f_num_camera)):
        #                 print("numero camera gia esistente")
    else:
        # se sono in una get faccio vedere il form vuoto
        form_crea_stanza = AddRoomForm()
    return render(request, 'creastanza.html', {'form_aggiungi_stanza': form_crea_stanza})

def creahotel(request):
    if request.method == 'POST':
        form_crea_hotel = AddHotelForm(request.POST)
        if form_crea_hotel.is_valid():
            f_nome = request.POST['nome']
            f_indirizzo = request.POST['indirizzo']
            f_citta = request.POST['citta']
            f_stato = request.POST['stato']
            f_num_telefono = request.POST['num_telefono']
            f_piscina = 'piscina' in request.POST.keys()
            f_WiFi = 'WiFi' in request.POST.keys()
            f_accesso_disabili = 'accesso_disabili' in request.POST.keys()
            f_ristorante = 'ristorante' in request.POST.keys()
            f_parcheggio = 'parcheggio' in request.POST.keys()
            f_palestra = 'palestra' in request.POST.keys()
            f_bar = 'bar' in request.POST.keys()
            f_spa = 'spa' in request.POST.keys()
            f_descrizione = 'descrizione' in request.POST.keys()
            f_sito = 'sito' in request.POST.keys()
            try:
                Hotel.objects.create(nome=f_nome, indirizzo=f_indirizzo, citta=f_citta,
                                     stato=f_stato, num_telefono=f_num_telefono,
                                     piscina=f_piscina, WiFi=f_WiFi,
                                     accesso_disabili=f_accesso_disabili,
                                     ristorante=f_ristorante, parcheggio=f_parcheggio,
                                     palestra=f_palestra,bar=f_bar,
                                     spa=f_spa, descrizione=f_descrizione,
                                     sito=f_sito,
                                     pub_date = datetime.datetime.now()
                                     )
                return HttpResponseRedirect('/myBookingApp/creazioneavvenuta')
            except IntegrityError as e:
                messages.info(request, 'Impossibile creare hotel! Hotel gia esistente!')

    else:
        # se sono in una get faccio vedere il form vuoto
        form_crea_hotel = AddHotelForm()
    return render(request, 'creahotel.html', {'form_aggiungi_hotel': form_crea_hotel})

def successocreazione(request):
    return render_to_response('esitopositivocreazione.html')

# @login_required
# def login_test(request):
#     return HttpResponseRedirect('/myBookingApp_2/search/')


def logout_view(request):
    logout(request)
    return HttpResponseRedirect('/myBookingApp_2/search/')


def register_user(request):
    if request.method == 'POST':
        form = RegistrationForm(request.POST)
        if form.is_valid():
            user = User.objects.create_user(
            username =form.cleaned_data['username'],
            password =form.cleaned_data['password1'],
            email =form.cleaned_data['email']
            )
            group = Group.objects.get(name='Utente')
            user.groups.add(group)

            return HttpResponseRedirect('esitopositivocreazione.html')
    else:
        form = RegistrationForm()
    return render(request, 'register.html', {'form': form})

def register_gestore(request):

    if request.method == 'POST':
        form = RegistrationForm(request.POST)
        if form.is_valid():
            user = User.objects.create_user(
            username =form.cleaned_data['username'],
            password =form.cleaned_data['password1'],
            email =form.cleaned_data['email']
            )
            group = Group.objects.get(name = 'Direzione')
            user.groups.add(group)
            return HttpResponseRedirect('registrazione_avvenuta.html')
    else:
        form = RegistrationForm()
    return render(request, 'register.html', {'form': form})

def login_test(request):
    if request.method == 'POST':
        loginform = LoginForm(request.POST)
        if loginform.is_valid():
            username = loginform.cleaned_data['Username']
            password = loginform.cleaned_data['Password']
            user = authenticate(request, username=username, password=password)
            print(user)
        if user is not None:
            print("autenticated")
            login(request,user)
            return HttpResponseRedirect('/myBookingApp_2/search/',)
        else:
            print("not autenticated")
            return HttpResponseRedirect('/myBookingApp_2/search/', )
    else:
        loginform = LoginForm()
        return render(request, 'login.html', {'form': loginform})


@login_required
def AggiungiPrenotazione(request):
    print("sono qua")
    room = Stanza.objects.all()
    # hotel = Hotel.objects.all()
    # prenotation = Prenotazioni.objects.all()
    new_idStanzaPrenotation = int(request.POST['id'])
    new_userPrenotation = request.user.id
    date_arrive = request.POST['data_arrive']
    date_leave = request.POST['data_leave']



    # for u in User.objects.all():
    #     if u.id == new_userPrenotation:
    #         c = get_object_or_404(User, pk=u.id)
    #
    # for r in room:
    #     if r.pk == new_idStanzaPrenotation:
    obj = Prenotazioni.objects.get_or_create(id_stanza=get_object_or_404(Stanza,pk=new_idStanzaPrenotation), id_user=get_object_or_404(User,pk=new_userPrenotation), check_in=date_arrive, check_out=date_leave)

    # return render(request, 'indexsearch.html', {'hotel': hotel, 'stanza': room, 'prenotation': prenotation})
    form_search_hotel = SearchHotelForm()
    return HttpResponseRedirect('/myBookingApp_2/search', {'form_search': form_search_hotel})

