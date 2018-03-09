from django.contrib.auth.models import Permission, Group
from django.contrib.auth.views import redirect_to_login
from django.db.models.functions import datetime
from django.contrib import messages
from django.db import IntegrityError
from django.contrib.auth import logout, authenticate, login
from datetime import datetime
from django.http import HttpResponseRedirect
from django.shortcuts import get_object_or_404, render
from django.contrib.auth import logout
from .forms import *
from django.core.mail import send_mail
from django.conf import settings

import datetime

def userpage(request):

    if request.user.groups.filter(name__in=["Utente"]).exists():
        current_date = datetime.date.today()
        current_user = request.user
        prenotation = Prenotazioni.objects.all().filter(id_user=current_user)
        lista_attesa = ListaAttesaStanza.objects.all().filter(user_id=current_user)
        return render(request, 'userpage.html', {"prenotazioni": prenotation, "lista_attesa": lista_attesa, 'visible' : False, "current_date": current_date})
    else:
        return render(request, 'userpage.html', {'visible' : True})

def search(request):
        hotels = Hotel.objects.all()
        stanze = Stanza.objects.all()
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
                f_ordinamento = form_search_hotel.cleaned_data['ordinamento']
                print(f_ordinamento)
                # trasformo in stringa la data di checkin e checkout per calcolare il delta
                date_format = "%Y-%m-%d"
                check_in_string = f_check_in.strftime(date_format)
                check_out_string = f_check_out.strftime(date_format)
                delta = f_check_out - f_check_in
                data.append(check_in_string)
                data.append(check_out_string)
                data.append(delta.days)

                Filtered_hotels = Filtered_hotels.filter(citta__icontains=f_citta).all()


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

                for stanza_prenotata in prenotazioni_totali:
                    cin = stanza_prenotata.check_in.strftime(date_format)
                    cout = stanza_prenotata.check_out.strftime(date_format)

                    if (data[0] >= cin and data[0] <= cout) or (data[1] >= cin and data[1] <= cout) or (
                            data[0] <= cin and data[1] >= cout):

                        print("Stanza Nel Periodo: ", stanza_prenotata.id)
                        prenotazioni_filtrate.append(stanza_prenotata.id_stanza_id)


                    else:
                        print("Stanza Fuori Periodo: ", stanza_prenotata.id)



                # tengo solo gli hotel filtrati che possiedono delle stanze:    DA RIVEDERE PER TROVARE QUALCOSA DI MEGLIO
                if total_id_hotel:
                    for h in Filtered_hotels:
                        count = 0
                        for e in total_id_hotel:
                            if h.id == e.id :
                                count = count +1
                        if count == 0:
                            print("Hotel senza camera: ",h.nome)
                            Filtered_hotels = Filtered_hotels.exclude(pk=h.pk)

                if f_ordinamento == 'voto':
                 Filtered_hotels = Filtered_hotels.order_by('media_voto')
                else:
                 risultati_stanze = risultati_stanze.order_by('prezzo')

                return render(request, 'indexsearch.html',
                              {'data': data, 'risultati_hotel': Filtered_hotels, 'form_search': form_search_hotel,
                               'stanze_filtrate': risultati_stanze, "stanze_prenotate": prenotazioni_filtrate,
                               "id_prenotate": p})



        else:

            # se sono in una get faccio vedere il form vuoto
            form_search_hotel = SearchHotelForm()
            return render(request, 'indexsearch.html', {'form_search' : form_search_hotel})




        # print(prenotazioni_filtrate)

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



# filtro da usare nel template per il calcolo del prezzo totale per il soggiorno
# @register.filter(name='moltiplicazione')
# def moltiplicazione(value, arg):
#     print("value: "+" arg: ", value, arg)
#     return value*arg


#Eseguibile solo da chi possiede i permessi Direzione
def creastanza(request):
    if request.user.groups.filter(name__in = ["Direzione"]).exists():
        if request.method == 'POST':

            form_crea_stanza = AddRoomForm(request.POST,user=request.user)
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
                    return render(request, 'successocreazionestanza.html')
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
            form_crea_stanza = AddRoomForm(user=request.user)

        return render(request, 'creastanza.html', {'form_aggiungi_stanza': form_crea_stanza})
    else:
        return render(request, 'accessonegato.html')

#Eseguibile solo da chi possiede i permessi Direzione
def creahotel(request):
    if request.user.groups.filter(name__in=["Direzione"]).exists():
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
                                         pub_date = datetime.datetime.now(),
                                         direttore = request.user
                                         )
                    return render(request, 'successocrezionehotel.html')
                except IntegrityError as e:
                    messages.info(request, 'Impossibile creare hotel! Hotel gia esistente!')

        else:
            # se sono in una get faccio vedere il form vuoto
            form_crea_hotel = AddHotelForm()
        return render(request, 'creahotel.html', {'form_aggiungi_hotel': form_crea_hotel})
    else:
        return render(request, 'accessonegato.html')



# @login_required
# def login_test(request):
#     return HttpResponseRedirect('/myBookingApp_2/search/')


def logout_view(request):
    logout(request)
    return HttpResponseRedirect('/myBookingApp_2/')

#Eseguibile solo se non loggato
def register_user(request):
    if not request.user.is_authenticated():
        if request.method == 'POST':
            form = RegistrationForm(request.POST)
            if form.is_valid():
                user = User.objects.create_user(
                username =form.cleaned_data['username'],
                first_name = form.cleaned_data['first_name'],
                last_name = form.cleaned_data['last_name'],
                password =form.cleaned_data['pwd1'],
                email =form.cleaned_data['email']
                )
                group = Group.objects.get(name='Utente')
                user.groups.add(group)

                return render(request, 'successocreazioneutente.html')
        else:
            form = RegistrationForm()
        return render(request, 'register.html', {'form': form})
    else:
        return render(request, 'accessonegato.html')

#Eseguibile solo se non loggato
def register_gestore(request):
    if not request.user.is_authenticated():
        if request.method == 'POST':
            form = RegistrationForm(request.POST)
            if form.is_valid():
                user = User.objects.create_user(
                username =form.cleaned_data['username'],
                first_name = form.cleaned_data['first_name'],
                last_name = form.cleaned_data['last_name'],
                password =form.cleaned_data['pwd1'],
                email =form.cleaned_data['email']
                )
                print()
                group = Group.objects.get(name = 'Direzione')
                user.groups.add(group)
                return render(request, 'successocreazionedirettore.html')
        else:
            form = RegistrationForm()
        return render(request, 'register.html', {'form': form})
    else:
        return render(request, 'accessonegato.html')

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
            return HttpResponseRedirect('/myBookingApp_2/',)
        else:
            print("not autenticated")
            return HttpResponseRedirect('/myBookingApp_2/', )
    else:
        loginform = LoginForm()
        return render(request, 'login.html', {'form': loginform})

def login_2(request):
    print("login 2")
    id_hotel = request.session['id_hotel']
    print(id_hotel)
    id_camera = request.session['id']
    data_arrive = request.session['data_arrive']
    hotel = Hotel.objects.all().filter(id=id_hotel)

    data_leave = request.session['data_leave']
    print(id,data_arrive,data_leave)
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
            return render(request, 'riepilogoprenotazione.html', {'id_camera': id_camera,'check_in': data_arrive,'check_out': data_leave, 'nome_stanza' : id_camera, 'nome_hotel':hotel })
        else:
            print("not autenticated")
            return HttpResponseRedirect('/myBookingApp_2/')
    else:
        loginform = LoginForm()
        return render(request, 'login.html', {'form': loginform})

# Visualizzabile solo dagli User in quanto sono gli unici che possono prenotare
def RiepilogoPrenotazione(request):

        print("riepilogoprenotazione")
        if not request.user.is_authenticated():
            print("non autenticato")
            if request.method == "POST":

                request.session['id_hotel'] = int(request.POST['id_hotel'])
                request.session['id'] = int(request.POST['id'])
                request.session['data_arrive'] = request.POST['data_arrive']
                request.session['data_leave'] = request.POST['data_leave']
                return HttpResponseRedirect('/myBookingApp_2/login_2/')
        else:
            if request.user.groups.filter(name__in=["Utente"]).exists():
                if request.method == "POST":
                    # checkin = request.session['data_arrive']
                    # checkout = request.session['data_leave']
                    # new_idStanzaPrenotation = request.session['id']
                    print("sono autenticato e sono nella riepilogo")
                    id_hotel = request.POST['id_hotel']
                    id_camera = request.POST['id']
                    data_arrive = request.POST['data_arrive']
                    data_leave = request.POST['data_leave']
                    hotel = Hotel.objects.all().filter(id =id_hotel)
                    print(id, data_arrive, data_leave)
                    return render(request, 'riepilogoprenotazione.html',{'id_camera': id_camera, 'check_in': data_arrive, 'check_out': data_leave,'nome_stanza': id_camera, 'nome_hotel': hotel})
            # DO STUFF
                else:
                    print("else")
            else:
                return render(request, 'accessonegato.html')


#Eseguibile solo da chi possiede i permessi User
def AggiungiPrenotazione(request):
    if request.user.groups.filter(name__in=["Utente"]).exists():
        room = Stanza.objects.all()
        new_idStanzaPrenotation = int(request.POST['id'])
        new_userPrenotation = request.user.id
        date_arrive = request.POST['data_arrive']
        date_leave = request.POST['data_leave']
        obj = Prenotazioni.objects.get_or_create(id_stanza=get_object_or_404(Stanza,pk=new_idStanzaPrenotation), id_user=get_object_or_404(User,pk=new_userPrenotation), check_in=date_arrive, check_out=date_leave)
        return render(request, 'successoprenotazione.html')
    else:
        return render(request, 'accessonegato.html')



# def AggiungiAiPreferiti(request):
#     preferite = Stanzapreferita.objects.all()
#     room = Stanza.objects.all()
#     new_idStanzaPreferita = int(request.POST['id'])
#     new_userPreferita = request.user.id
#
#     preferite = preferite.filter(user_id = new_userPreferita)
#     if new_idStanzaPreferita not in preferite:
#             obj = Stanzapreferita.objects.get_or_create(stanza_preferita=get_object_or_404(Stanza,pk=new_idStanzaPreferita), user_id=get_object_or_404(User,pk=new_userPreferita))
#             form_search_hotel = SearchHotelForm()
#             return HttpResponseRedirect('/myBookingApp_2/search', {'form_search': form_search_hotel})
#     else :
#             form_search_hotel = SearchHotelForm()
#             return HttpResponseRedirect('/myBookingApp_2/search', {'form_search': form_search_hotel})


def AggiungiAWishlist(request):
    whishlist = ListaAttesaStanza.objects.all()

    room = Stanza.objects.all()
    new_idStanzaWishlist = int(request.POST['id'])
    new_userWishlist = request.user.id
    date_arrive = request.POST['data_arrive']
    date_leave = request.POST['data_leave']
    print(date_arrive)

    obj = ListaAttesaStanza.objects.get_or_create(lista_attesa=get_object_or_404(Stanza, pk=new_idStanzaWishlist), user_id = get_object_or_404(User, pk = new_userWishlist), check_in_lista_attesa = date_arrive, check_out_lista_attesa = date_leave)
    form_search_hotel = SearchHotelForm()

    return HttpResponseRedirect('/myBookingApp_2/search', {'form_search': form_search_hotel})


def CancellaPrenotazione(request):
    PrenotationDelete = int(request.POST['IdPrenotazione'])
    # print("ID Prenotazione: ", PrenotationDelete)
    
    for p in Prenotazioni.objects.all():
        if p.id == PrenotationDelete:
            stanzaPrenotata = p.id_stanza_id
            # print("La stanza prenotata : ", stanzaPrenotata)

    wishListFiltered = ListaAttesaStanza.objects.filter(lista_attesa_id = stanzaPrenotata)
    prenotazioniFiltered = Prenotazioni.objects.all().filter(id_stanza_id = stanzaPrenotata)

    print("Elimino la Prenotazione")
    Prenotazioni.objects.filter(id=PrenotationDelete).delete()

    
    for w in wishListFiltered:
        win = w.check_in_lista_attesa
        wout = w.check_out_lista_attesa
        stanzaOccupata = 0
        for p in prenotazioniFiltered:
            pin = p.check_in
            pout = p.check_out

            if (win >= pin and win <= pout) or (wout >= pin and wout <= pout) or (
                            win <= pin and wout >= pout):

                print("Stanza Nel Periodo: ", p.id_stanza_id)
                stanzaOccupata = 1


            else:
                print("Stanza Fuori Periodo: ", p.id_stanza_id)

        if stanzaOccupata == 0:
            print("L'utente puo prenotare")
            print("Sto Mandando la Mail")
            subject = 'Booking staff'
            message = 'Hi user, we inform you that you can book the room you have placed in the waiting list'
            from_email = settings.EMAIL_HOST_USER
            send_mail(subject, message, from_email, [w.user_id.email], fail_silently=False)
            print("Email Inviata")
        else:
            print("L'utente non puo prenotare")



    return HttpResponseRedirect('/myBookingApp_2/userpage')


def CancellaWishlist(request):
    WishlistDelete = int(request.POST['IdWishlist'])
    ListaAttesaStanza.objects.filter(id=WishlistDelete).delete()
    return HttpResponseRedirect('/myBookingApp_2/userpage')


def Votazione(request):
    hotels = Hotel.objects.all()
    voto = request.POST['stelle']
    hotel_id = int(request.POST['HotelID'])

    try:
        obj = Voto.objects.get_or_create(hotel_id_id=hotel_id, user_id_id=request.user.id, voto=voto)

        VotiHotel = {}

        for hId in Hotel.objects.all():
            votoTOT = 0
            counter = 0
            for record in Voto.objects.all():
                if hId.id == record.hotel_id_id:
                    counter += 1
                    votoTOT += record.voto

            if counter != 0:
                VotiHotel[hId.id] = votoTOT / counter

        for key, value in VotiHotel.items():
            for h in Hotel.objects.all():
                print(key,h.id)
                if key == h.id:
                    print("Aggiorno il voto ")
                    Hotel.objects.filter(id = key).update(media_voto = value)
        return HttpResponseRedirect('/myBookingApp_2/userpage')

    except IntegrityError as e:
        messages.info(request, 'Voto gia espresso per questa struttura!')
        return HttpResponseRedirect('/myBookingApp_2/userpage')


def ModificaPrenotazione(request):
    PrenotationEdit = int(request.POST['IdPrenotazione'])
    data_checkin = request.POST['data_checkin']
    data_checkout = request.POST['data_checkout']
    prenotazioni = Prenotazioni.objects.all()


    for p in prenotazioni:
        if p.id == PrenotationEdit:
            data_checkin = p.check_in
            data_checkout = p.check_out
            id_stanza_modifica = p.id_stanza_id


    # if request.method == 'GET':
    #     print("Sono in GET")
    #     form_editprenotazione = EditPrenotazione(initial={'check_in': data_checkin, 'check_out': data_checkout})
    #     return render(request, "editprenotation.html", {'form_editprenotazione' : form_editprenotazione, 'prenotazione_modificata': PrenotationEdit})
    if request.method == 'POST':
        print("sono in POST")
        form_editprenotazione = EditPrenotazione(initial={'check_in': data_checkin, 'check_out': data_checkout})
        return render(request, "editprenotation.html", {'form_editprenotazione' : form_editprenotazione, 'prenotazione_modificata': PrenotationEdit})
    else:
        print("sono in GET")

        form_editprenotazione = EditPrenotazione()
        return render(request, "editprenotation.html",
                      {'form_editprenotazione': form_editprenotazione, 'prenotazione_modificata': PrenotationEdit})


def UpdateModificaPrenotazione(request):
    if request.method == 'POST':
        data = []
        form_editprenotazione = EditPrenotazione(request.POST)
        PrenotationEdit = int(request.POST['IdPrenotazione'])
        print(PrenotationEdit)


        # Salvo la prenotazione da modificare
        for p in Prenotazioni.objects.all():
            if p.id == PrenotationEdit:
                prenotazione_stanza = p

        # Filtro le prenotazioni per stanza prenotata e escludo la prenotazione che voglio modificare
        prenotazioniListFiltered = Prenotazioni.objects.filter(id_stanza_id = prenotazione_stanza.id_stanza_id)
        print("------------------------------------")
        print(prenotazioniListFiltered)
        print("------------------------------------")

        prenotazioniListFiltered = prenotazioniListFiltered.exclude(id = PrenotationEdit)
        print(prenotazioniListFiltered)

        print("------------------------------------")



        # Raccolgo i dati dal form se valido
        if form_editprenotazione.is_valid():
            print("IL FORM E VALIDO")
            f_check_in = form_editprenotazione.cleaned_data['check_in']
            f_check_out = form_editprenotazione.cleaned_data['check_out']
            date_format = "%Y-%m-%d"
            check_in_string = f_check_in.strftime(date_format)
            check_out_string = f_check_out.strftime(date_format)
            delta = f_check_out - f_check_in
            data.append(check_in_string)
            data.append(check_out_string)
            data.append(delta.days)
            counterPeriodoOccupato = 0

            # Controllo che la stanza non sia occupata nelle nuove date
            for stanza_prenotata in prenotazioniListFiltered:
                print("sono dentro al for delle filtrate")
                print(prenotazioniListFiltered)

                cin = stanza_prenotata.check_in.strftime(date_format)
                cout = stanza_prenotata.check_out.strftime(date_format)

                if (data[0] >= cin and data[0] <= cout) or (data[1] >= cin and data[1] <= cout) or (
                                data[0] <= cin and data[1] >= cout):

                    print("Stanza Impegnata: ", stanza_prenotata.id_stanza_id)
                    counterPeriodoOccupato = 1

            # Se la stanza e libera effettuo la modifica della prenotazione
            if counterPeriodoOccupato == 0:
                obj = Prenotazioni.objects.get_or_create(
                    id_stanza=get_object_or_404(Stanza, pk=p.id_stanza_id),
                    id_user=get_object_or_404(User, pk=p.id_user_id), check_in=data[0], check_out=data[1])


                #Controllo in wishlist se la stanza e libera nei periodi desiderati
                for p in Prenotazioni.objects.all():
                    if p.id == PrenotationEdit:
                        stanzaPrenotata = p.id_stanza_id
                        # print("La stanza prenotata : ", stanzaPrenotata)
                Prenotazioni.objects.filter(id=PrenotationEdit).delete()

                wishListFiltered = ListaAttesaStanza.objects.filter(lista_attesa_id=stanzaPrenotata)
                prenotazioniFiltered = Prenotazioni.objects.filter(id_stanza_id=stanzaPrenotata)


                for w in wishListFiltered:
                    win = w.check_in_lista_attesa
                    wout = w.check_out_lista_attesa
                    stanzaOccupata = 0
                    for p in prenotazioniFiltered:
                        pin = p.check_in
                        pout = p.check_out

                        if (win >= pin and win <= pout) or (wout >= pin and wout <= pout) or (
                                        win <= pin and wout >= pout):

                            print("Stanza Nel Periodo: ", p.id_stanza_id)
                            stanzaOccupata = 1


                        else:
                            print("Stanza Fuori Periodo: ", p.id_stanza_id)


                    # Se la stanza e libera nel periodo desiderato mando una mail all'utente'
                    if stanzaOccupata == 0:
                        print("L'utente puo prenotare")
                        print("Sto Mandando la Mail")
                        subject = 'Booking staff'
                        message = 'Hi ' + w.user_id.first_name + ', we inform you that you can book the room you added in the waiting list'
                        from_email = settings.EMAIL_HOST_USER
                        send_mail(subject, message, from_email, [w.user_id.email], fail_silently=False)
                        print("Email Inviata")
                    else:
                        print("L'utente non puo prenotare")

                return HttpResponseRedirect('/myBookingApp_2/userpage')



            else:
                return render(request, 'modificaprenotazioneNONavvenuta.html')
        else:
            return HttpResponseRedirect('/myBookingApp_2/userpage')


    # date_checkin = request.POST['check_in_day']
    # data_checkin_month = request.POST['check_in_month']
    # data_checkin_year = request.POST['check_in_year']

    # print("Check In: ", date_checkin)

    # return HttpResponseRedirect('/myBookingApp_2/userpage')