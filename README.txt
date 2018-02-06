########################### CONFIGURAZIONE DATABASE MYSQL ###########################

-------- ENTRO IN MYSQL --------
$ mysql --user=root -p
poi inserisci la password di root di MySQL

-------- CREO IL DB --------
create database BookingDB_2 character set utf8;

-------- CREO LO USER --------
create user 'bookingUser_2'@'localhost' identified by 'password';

-------- RILASCIO I PRIVILEGI --------
grant all privileges on BookingDB_2.* to 'bookingUser_2'@'localhost' with grant option;

-------- CARICO IL DATABASE --------
mysql -u bookingUser_2 -p bookingDB_2 < BookingDB_2.sql

########################### DJANGO ########################### 

-------- Apro Terminale in PyCharm --------
python manage.py makemigrations

python manage.py migrate

python manage.py runserver


########################### CREDENTIALS ###########################



User: Admin
Password: 123stella




