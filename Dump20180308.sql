CREATE DATABASE  IF NOT EXISTS `bookingdb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `bookingdb`;
-- MySQL dump 10.16  Distrib 10.1.29-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: bookingdb
-- ------------------------------------------------------
-- Server version	10.1.29-MariaDB-6

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'Direzione'),(2,'Utente');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (4,1,19),(5,1,20),(6,1,21),(7,1,22),(8,1,23),(9,1,24),(10,1,25),(11,1,26),(12,1,27),(13,1,28),(14,1,29),(15,1,30),(16,1,31),(17,1,32),(18,1,33),(21,2,22),(22,2,23),(23,2,24),(24,2,28),(25,2,29),(26,2,30),(27,2,31),(19,2,32),(20,2,33);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add hotel',7,'add_hotel'),(20,'Can change hotel',7,'change_hotel'),(21,'Can delete hotel',7,'delete_hotel'),(22,'Can add prenotazioni',8,'add_prenotazioni'),(23,'Can change prenotazioni',8,'change_prenotazioni'),(24,'Can delete prenotazioni',8,'delete_prenotazioni'),(25,'Can add stanza',9,'add_stanza'),(26,'Can change stanza',9,'change_stanza'),(27,'Can delete stanza',9,'delete_stanza'),(28,'Can add vote',10,'add_vote'),(29,'Can change vote',10,'change_vote'),(30,'Can delete vote',10,'delete_vote'),(31,'Can add voto',10,'add_voto'),(32,'Can change voto',10,'change_voto'),(33,'Can delete voto',10,'delete_voto'),(34,'Can add stanzapreferita',11,'add_stanzapreferita'),(35,'Can change stanzapreferita',11,'change_stanzapreferita'),(36,'Can delete stanzapreferita',11,'delete_stanzapreferita'),(37,'Can add lista attesa stanza',12,'add_listaattesastanza'),(38,'Can change lista attesa stanza',12,'change_listaattesastanza'),(39,'Can delete lista attesa stanza',12,'delete_listaattesastanza');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$36000$LcI22nYp4JVS$m85jGswE6BcGYORAw6zED7utlXCZGaThvn9shngmXlk=','2018-03-07 23:16:09.709135',1,'admin','','','ma.mezzetti@gmail.com',1,1,'2018-01-22 11:52:38.289406'),(2,'pbkdf2_sha256$36000$QYpubgeLDmOF$nHY3RwtaAljyTGrs+ywj5QDsDcnORHFSPYxhkMq7/BY=','2018-03-06 08:33:09.411701',0,'marco','Marco','Mezzetti','ma.mezzetti@gmail.com',1,1,'2018-02-04 14:26:56.000000'),(3,'pbkdf2_sha256$36000$GGLnOmi1qGyP$Owdl/rJoIqeZHlZtcfsfsVQqDQwG0vw9SymXwXjDuDY=','2018-03-07 23:16:45.885866',0,'Direttore','Giacomo','Bonaventura','giacomo.bonaventura@gmail.com',1,1,'2018-02-09 07:25:50.000000'),(4,'pbkdf2_sha256$36000$etB9fx9MNnvP$EsxgVDW+AFp9ah9B6V3qCnBtVyBnHj+h9xnt75mykEc=',NULL,0,'Mez','','','ma.mezzetti@gmail.com',0,1,'2018-03-03 15:45:18.898846'),(5,'pbkdf2_sha256$36000$lL7BXMBgsDur$1itI+ozC7KkgE1/m36BqChjN7YEB3GWgMD/rK6CBgo4=',NULL,0,'test','','','test@gmail.com',0,1,'2018-03-05 19:45:21.469361');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (3,2,2),(1,3,1),(2,4,2),(4,5,2);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2018-01-22 11:55:07.524033','1','Hotel object',1,'[{\"added\": {}}]',7,1),(2,'2018-01-22 12:01:50.125526','2','Hotel object',1,'[{\"added\": {}}]',7,1),(3,'2018-01-22 12:04:42.670441','3','Hotel object',1,'[{\"added\": {}}]',7,1),(4,'2018-01-22 12:05:34.333523','1','Stanza object',1,'[{\"added\": {}}]',9,1),(5,'2018-01-22 12:05:52.992232','2','Stanza object',1,'[{\"added\": {}}]',9,1),(6,'2018-01-22 12:06:09.755308','3','Stanza object',1,'[{\"added\": {}}]',9,1),(7,'2018-01-22 12:09:39.143978','4','Stanza object',1,'[{\"added\": {}}]',9,1),(8,'2018-01-22 12:09:55.416340','5','Stanza object',1,'[{\"added\": {}}]',9,1),(9,'2018-01-22 12:10:16.699340','6','Stanza object',1,'[{\"added\": {}}]',9,1),(10,'2018-01-22 12:10:40.556818','7','Stanza object',1,'[{\"added\": {}}]',9,1),(11,'2018-01-22 12:10:59.562327','8','Stanza object',1,'[{\"added\": {}}]',9,1),(12,'2018-02-04 14:26:56.111239','2','marco',1,'[{\"added\": {}}]',4,1),(13,'2018-02-04 14:27:39.645943','2','marco',2,'[{\"changed\": {\"fields\": [\"first_name\", \"last_name\", \"email\", \"is_staff\"]}}]',4,1),(14,'2018-02-04 16:29:05.703646','1','Prenotazioni object',1,'[{\"added\": {}}]',8,1),(15,'2018-02-04 16:35:18.184727','2','Prenotazioni object',1,'[{\"added\": {}}]',8,1),(16,'2018-02-05 21:47:35.478104','1','Voto object',1,'[{\"added\": {}}]',10,1),(17,'2018-02-05 22:33:40.192975','2','Voto object',1,'[{\"added\": {}}]',10,1),(18,'2018-02-05 22:54:22.687124','3','Prenotazioni object',1,'[{\"added\": {}}]',8,1),(19,'2018-02-05 22:54:43.646420','1','Luxury Hotel',2,'[{\"changed\": {\"fields\": [\"voto\"]}}]',10,1),(20,'2018-02-09 07:17:00.663313','1','Direzione',1,'[{\"added\": {}}]',3,1),(21,'2018-02-09 07:17:48.245181','2','Utente',1,'[{\"added\": {}}]',3,1),(22,'2018-02-09 07:21:04.599142','2','Utente',2,'[{\"changed\": {\"fields\": [\"permissions\"]}}]',3,1),(23,'2018-02-09 07:25:50.909241','3','Direttore',1,'[{\"added\": {}}]',4,1),(24,'2018-02-09 07:26:46.882500','3','Direttore',2,'[{\"changed\": {\"fields\": [\"first_name\", \"last_name\", \"email\", \"is_staff\", \"groups\"]}}]',4,1),(25,'2018-02-12 20:15:10.059964','1','Luxury Hotelcamera num: 1',1,'[{\"added\": {}}]',11,1),(26,'2018-02-12 20:15:14.860141','2','Mondialcamera num: 1',1,'[{\"added\": {}}]',11,1),(27,'2018-02-12 20:15:20.848669','3','Hotel Gloriescamera num: 2',1,'[{\"added\": {}}]',11,1),(28,'2018-02-12 20:15:33.516693','4','Luxury Hotelcamera num: 3',1,'[{\"added\": {}}]',11,1),(29,'2018-02-12 20:39:42.338944','2','Mondialcamera num: 3',1,'[{\"added\": {}}]',12,1),(30,'2018-02-12 21:32:54.916353','1','Direzione',2,'[{\"changed\": {\"fields\": [\"permissions\"]}}]',3,1),(31,'2018-02-18 14:39:52.377873','14','Prenotazioni object',1,'[{\"added\": {}}]',8,1),(32,'2018-02-18 16:57:23.273029','3','Hotel Gloriescamera num: 1',1,'[{\"added\": {}}]',12,1),(33,'2018-02-18 16:59:13.583638','4','Mondialcamera num: 1',1,'[{\"added\": {}}]',12,1),(34,'2018-02-18 17:00:59.913191','5','Mondialcamera num: 3',1,'[{\"added\": {}}]',12,1),(35,'2018-02-18 17:20:08.728975','6','Luxury Hotelcamera num: 3',1,'[{\"added\": {}}]',12,1),(36,'2018-02-18 17:20:20.426206','7','Luxury Hotelcamera num: 2',1,'[{\"added\": {}}]',12,1),(37,'2018-03-03 15:44:12.590796','2','marco',2,'[{\"changed\": {\"fields\": [\"is_staff\"]}}]',4,1),(38,'2018-03-03 15:46:23.048125','2','marco',2,'[{\"changed\": {\"fields\": [\"groups\"]}}]',4,1),(39,'2018-03-03 15:46:33.617998','2','marco',2,'[{\"changed\": {\"fields\": [\"is_staff\"]}}]',4,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'myBookingApp_2','hotel'),(12,'myBookingApp_2','listaattesastanza'),(8,'myBookingApp_2','prenotazioni'),(9,'myBookingApp_2','stanza'),(11,'myBookingApp_2','stanzapreferita'),(10,'myBookingApp_2','voto'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2018-01-21 20:30:31.752825'),(2,'auth','0001_initial','2018-01-21 20:30:32.141680'),(3,'admin','0001_initial','2018-01-21 20:30:32.256168'),(4,'admin','0002_logentry_remove_auto_add','2018-01-21 20:30:32.281034'),(5,'contenttypes','0002_remove_content_type_name','2018-01-21 20:30:32.364624'),(6,'auth','0002_alter_permission_name_max_length','2018-01-21 20:30:32.408879'),(7,'auth','0003_alter_user_email_max_length','2018-01-21 20:30:32.458889'),(8,'auth','0004_alter_user_username_opts','2018-01-21 20:30:32.478392'),(9,'auth','0005_alter_user_last_login_null','2018-01-21 20:30:32.512617'),(10,'auth','0006_require_contenttypes_0002','2018-01-21 20:30:32.517694'),(11,'auth','0007_alter_validators_add_error_messages','2018-01-21 20:30:32.536407'),(12,'auth','0008_alter_user_username_max_length','2018-01-21 20:30:32.633134'),(13,'auth','0009_alter_user_last_name_max_length','2018-01-21 20:30:32.687313'),(14,'auth','0010_auto_20180118_2120','2018-01-21 20:30:32.746384'),(15,'myBookingApp_2','0001_initial','2018-01-21 20:30:32.783726'),(16,'sessions','0001_initial','2018-01-21 20:30:32.821321'),(17,'myBookingApp_2','0002_auto_20180121_2040','2018-01-21 20:40:37.980341'),(18,'myBookingApp_2','0002_auto_20180204_1633','2018-02-04 16:33:39.240581'),(19,'myBookingApp_2','0003_vote','2018-02-05 21:01:20.355243'),(20,'myBookingApp_2','0004_auto_20180205_2131','2018-02-05 21:31:26.368225'),(21,'myBookingApp_2','0005_auto_20180205_2136','2018-02-05 21:36:16.400053'),(22,'myBookingApp_2','0006_auto_20180205_2143','2018-02-05 21:43:47.610915'),(23,'myBookingApp_2','0007_auto_20180205_2229','2018-02-05 22:29:47.896466'),(24,'myBookingApp_2','0008_auto_20180206_1448','2018-02-06 14:48:46.022745'),(25,'myBookingApp_2','0009_stanzapreferita','2018-02-12 20:09:55.988920'),(26,'myBookingApp_2','0010_listaattesastanza','2018-02-12 20:35:13.892341');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('1i5gnwrdkcpro0gld8dw0sogr5im7cr8','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-02-25 17:57:58.088880'),('2hmtp2zdpz3z4jvyoc6hkfd21bvvux71','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-02-26 20:40:34.767410'),('2o3rf3qk6mwed7j4jeghniffu1cugnxk','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-03-04 15:50:49.808265'),('3wd0juy52jmaig48i82qztc4f2m8y4ag','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-02-20 10:48:01.138675'),('43vgroth2f208fmuhuygc7x2uj5dhiqi','MWY0MThlNzU0MTlmZTllNTllY2YzMDkyMDY2YTMwN2Y1MDNiYmM1Nzp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxYmM5M2VjNTI1MTY4NDEyMjM1OWI1YjJlNDJmMjUwYTdmZDM3Nzk4In0=','2018-02-18 14:28:31.541305'),('6fj16rdu7qu7ifa10t5ap24epsq21j1h','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-03-13 13:54:36.574197'),('80ptd1qm0dmgq42y30j4gpch17qejsjm','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-02-19 18:12:07.601677'),('8s9z700eqd2hp70kmvdayysl8tiszyxa','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-03-07 18:10:11.363403'),('99jxz0t5o5o9fk0dk3wor69381fj6lrg','Y2JiOWE1MzQzYzJkMjVkYWI5NGZjN2NjZDk5ZTk2ZDY0NWQ0YmNlZTp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzOTdlZWZkYzJiNDg0ODBmZTg4MTBhNDNlNzczNjM4YzE5YWZlNWJmIn0=','2018-03-21 23:16:45.890133'),('9udi9svmv5u69uuzo2ppun6h5d7lbze7','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-03-12 18:48:19.231047'),('af1g8zxhu7oq4r2civxk2g17m4zuaida','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-03-04 10:21:11.296420'),('ai17j5miquwafnmfhl4skcunzy2o5s9m','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-02-19 18:54:22.769673'),('azaac8mxmag4n4xlmydb96r89yursbu9','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-03-04 16:21:24.245903'),('bsaijh4ncjzt6nplk4s73nalzd9huy1i','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-02-26 20:35:25.375530'),('bzytaggqt9tkkrnvvvajngznzp69iss7','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-02-26 20:37:10.556147'),('geppmbfyj7c67aghxpfi3lb37wy0137x','MTQ0MTAwMWUwZGYwZWNkOWE1NWEzMmMxZTlmNzQ3NzgwMDM3YTUwMjp7ImlkX2hvdGVsIjoxLCJpZCI6MywiZGF0YV9hcnJpdmUiOiIyMDE4LTAzLTAzIiwiZGF0YV9sZWF2ZSI6IjIwMTgtMDMtMDQifQ==','2018-03-17 12:03:43.657448'),('gq2aqco75sg52wd3z0f6898haoqihh4i','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-02-18 16:34:38.479338'),('hhkkod4st2jixib8d6gt5eewybf6hljg','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-02-19 21:02:14.955382'),('izrov7slcw8v0qqevf9acsqhe5mt4ydw','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-03-03 09:24:51.271176'),('jidxdnvs2xmyqohindo22idtihdr5ko3','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-02-26 20:13:43.489121'),('le3ch7yedub0nvdtn18rggejm86eolqe','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-03-03 10:03:03.650165'),('mswql4q9blu5dodklg5wr803lwn0ace2','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-03-12 19:26:53.168640'),('n02ewg5himurag8uihncqo8ncxp8sqda','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-02-24 11:46:30.443571'),('o3ei8co85vg5cu2ujemm9bn5xwzpyywr','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-02-26 20:43:48.722816'),('qy7tqbruve8afailjssi6gvofm5gej7t','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-03-01 09:43:32.308158'),('r2tjn4zbdg7sqjfa2atbif4foyp7tkue','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-02-20 11:00:25.678215'),('t9mujd6r77f4nzzco9d3iw5uc7v72w87','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-03-13 11:58:58.642542'),('tk3owup6d6a4kg1yqxjno9ajmizoa0jn','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-02-26 21:14:21.456405'),('u6lun01lu08cw8kzhmi3delos0k20ego','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-02-19 22:53:48.069941'),('zttj60xtq2sp1j1h8qtg4a9yxixvk7y7','MzZlOWI3M2U5NjczMmNmOTZjODhiZmUzMjg4ZTQ5ZWMxNTc1YzM5Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjODliZjU3ZmZiMTc5NjFlNzA4ZDUzZWRmOTQyM2NjMThmNzJkNGQzIn0=','2018-02-19 22:30:12.227790');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mybookingapp_2_hotel`
--

DROP TABLE IF EXISTS `mybookingapp_2_hotel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mybookingapp_2_hotel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `indirizzo` varchar(300) NOT NULL,
  `citta` varchar(200) NOT NULL,
  `stato` varchar(200) NOT NULL,
  `piscina` tinyint(1) NOT NULL,
  `WiFi` tinyint(1) NOT NULL,
  `accesso_disabili` tinyint(1) NOT NULL,
  `ristorante` tinyint(1) NOT NULL,
  `parcheggio` tinyint(1) NOT NULL,
  `palestra` tinyint(1) NOT NULL,
  `bar` tinyint(1) NOT NULL,
  `spa` tinyint(1) NOT NULL,
  `descrizione` varchar(1000) NOT NULL,
  `sito` varchar(600) NOT NULL,
  `pub_date` datetime(6) NOT NULL,
  `num_telefono` varchar(15) NOT NULL,
  `media_voto` float NOT NULL DEFAULT '0',
  `direttore` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mybookingapp_2_hotel`
--

LOCK TABLES `mybookingapp_2_hotel` WRITE;
/*!40000 ALTER TABLE `mybookingapp_2_hotel` DISABLE KEYS */;
INSERT INTO `mybookingapp_2_hotel` VALUES (1,'Luxury Hotel','Via fasulla 123','Montreal','Canada',1,1,0,1,1,0,1,1,'Hotel molto bello','www.luxuryhotel.com','2018-01-09 11:54:26.000000','3754896254',0,''),(2,'Mondial','Via Duca della Vittoria, 129/131','MArina di Pietrasanta','Italia',1,1,1,1,1,1,1,1,'Hotel di lusso','http://www.mondialresort.it/','2018-01-10 11:58:22.000000','+390584745911',3,''),(3,'Hotel Glories','C/PADILLA, 173 - 08013 BARCELONA','Barcellona','Spagna',0,1,1,1,0,0,1,0,'molto bello','http://www.hotelglories.com','2018-01-09 12:03:37.000000','+39932650808',1,''),(4,'test','test','test','test',0,1,0,0,0,1,1,0,'True','True','2018-03-07 00:00:00.000000','3343761602',0,'Direttore');
/*!40000 ALTER TABLE `mybookingapp_2_hotel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mybookingapp_2_listaattesastanza`
--

DROP TABLE IF EXISTS `mybookingapp_2_listaattesastanza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mybookingapp_2_listaattesastanza` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `check_in_lista_attesa` datetime(6) NOT NULL,
  `check_out_lista_attesa` datetime(6) NOT NULL,
  `lista_attesa_id` int(11) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myBookingApp_2_lista_lista_attesa_id_f20eab72_fk_myBooking` (`lista_attesa_id`),
  KEY `myBookingApp_2_lista_user_id_id_a4e6db4d_fk_auth_user` (`user_id_id`),
  CONSTRAINT `myBookingApp_2_lista_lista_attesa_id_f20eab72_fk_myBooking` FOREIGN KEY (`lista_attesa_id`) REFERENCES `mybookingapp_2_stanza` (`id`),
  CONSTRAINT `myBookingApp_2_lista_user_id_id_a4e6db4d_fk_auth_user` FOREIGN KEY (`user_id_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mybookingapp_2_listaattesastanza`
--

LOCK TABLES `mybookingapp_2_listaattesastanza` WRITE;
/*!40000 ALTER TABLE `mybookingapp_2_listaattesastanza` DISABLE KEYS */;
INSERT INTO `mybookingapp_2_listaattesastanza` VALUES (16,'2018-03-24 00:00:00.000000','2018-03-26 00:00:00.000000',1,2);
/*!40000 ALTER TABLE `mybookingapp_2_listaattesastanza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mybookingapp_2_prenotazioni`
--

DROP TABLE IF EXISTS `mybookingapp_2_prenotazioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mybookingapp_2_prenotazioni` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `check_in` datetime(6) NOT NULL,
  `check_out` datetime(6) NOT NULL,
  `id_stanza_id` int(11) NOT NULL,
  `id_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myBookingApp_2_preno_id_stanza_id_1fa98c6e_fk_myBooking` (`id_stanza_id`),
  KEY `myBookingApp_2_prenotazioni_id_user_id_6d0dffd9_fk_auth_user_id` (`id_user_id`),
  CONSTRAINT `myBookingApp_2_preno_id_stanza_id_1fa98c6e_fk_myBooking` FOREIGN KEY (`id_stanza_id`) REFERENCES `mybookingapp_2_stanza` (`id`),
  CONSTRAINT `myBookingApp_2_prenotazioni_id_user_id_6d0dffd9_fk_auth_user_id` FOREIGN KEY (`id_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mybookingapp_2_prenotazioni`
--

LOCK TABLES `mybookingapp_2_prenotazioni` WRITE;
/*!40000 ALTER TABLE `mybookingapp_2_prenotazioni` DISABLE KEYS */;
INSERT INTO `mybookingapp_2_prenotazioni` VALUES (8,'2018-05-05 00:00:00.000000','2018-05-06 00:00:00.000000',1,2),(9,'2018-03-05 00:00:00.000000','2018-03-06 00:00:00.000000',8,2),(11,'2018-03-06 00:00:00.000000','2018-03-07 00:00:00.000000',1,2),(12,'2018-04-14 00:00:00.000000','2018-04-29 00:00:00.000000',1,2),(13,'2018-02-07 00:00:00.000000','2018-02-20 00:00:00.000000',2,2),(14,'2018-03-04 00:00:00.000000','2018-03-06 00:00:00.000000',5,2),(15,'2018-01-07 00:00:00.000000','2018-01-08 00:00:00.000000',7,2);
/*!40000 ALTER TABLE `mybookingapp_2_prenotazioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mybookingapp_2_stanza`
--

DROP TABLE IF EXISTS `mybookingapp_2_stanza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mybookingapp_2_stanza` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num_camera` int(10) unsigned NOT NULL,
  `prezzo` double NOT NULL,
  `prezzo_festivita` double NOT NULL,
  `num_persone` int(10) unsigned NOT NULL,
  `aria_condizionata` tinyint(1) NOT NULL,
  `camera_fumatori` tinyint(1) NOT NULL,
  `animali` tinyint(1) NOT NULL,
  `id_hotel_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `myBookingApp_2_stanza_id_hotel_id_num_camera_69643015_uniq` (`id_hotel_id`,`num_camera`),
  CONSTRAINT `myBookingApp_2_stanz_id_hotel_id_3eb172a3_fk_myBooking` FOREIGN KEY (`id_hotel_id`) REFERENCES `mybookingapp_2_hotel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mybookingapp_2_stanza`
--

LOCK TABLES `mybookingapp_2_stanza` WRITE;
/*!40000 ALTER TABLE `mybookingapp_2_stanza` DISABLE KEYS */;
INSERT INTO `mybookingapp_2_stanza` VALUES (1,1,95,120,3,1,0,1,1),(2,2,65,80,1,0,1,0,1),(3,3,150,200,2,1,1,1,1),(4,1,25,32,1,0,0,0,2),(5,2,50,60,2,0,0,0,2),(6,3,75,90,3,1,0,0,2),(7,1,100,115,4,1,0,1,3),(8,2,39,50,1,1,0,0,3);
/*!40000 ALTER TABLE `mybookingapp_2_stanza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mybookingapp_2_stanzapreferita`
--

DROP TABLE IF EXISTS `mybookingapp_2_stanzapreferita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mybookingapp_2_stanzapreferita` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stanza_preferita_id` int(11) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myBookingApp_2_stanz_stanza_preferita_id_d2955aee_fk_myBooking` (`stanza_preferita_id`),
  KEY `myBookingApp_2_stanz_user_id_id_1bd976c2_fk_auth_user` (`user_id_id`),
  CONSTRAINT `myBookingApp_2_stanz_stanza_preferita_id_d2955aee_fk_myBooking` FOREIGN KEY (`stanza_preferita_id`) REFERENCES `mybookingapp_2_stanza` (`id`),
  CONSTRAINT `myBookingApp_2_stanz_user_id_id_1bd976c2_fk_auth_user` FOREIGN KEY (`user_id_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mybookingapp_2_stanzapreferita`
--

LOCK TABLES `mybookingapp_2_stanzapreferita` WRITE;
/*!40000 ALTER TABLE `mybookingapp_2_stanzapreferita` DISABLE KEYS */;
INSERT INTO `mybookingapp_2_stanzapreferita` VALUES (1,1,2),(2,4,3),(3,8,1),(4,3,2);
/*!40000 ALTER TABLE `mybookingapp_2_stanzapreferita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mybookingapp_2_voto`
--

DROP TABLE IF EXISTS `mybookingapp_2_voto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mybookingapp_2_voto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `voto` double NOT NULL,
  `hotel_id_id` int(11) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`hotel_id_id`,`user_id_id`),
  KEY `myBookingApp_2_voto_hotel_id_id_62a7e18d_fk_myBooking` (`hotel_id_id`),
  KEY `myBookingApp_2_voto_user_id_id_18b82e18_fk_auth_user_id` (`user_id_id`),
  CONSTRAINT `myBookingApp_2_voto_hotel_id_id_62a7e18d_fk_myBooking` FOREIGN KEY (`hotel_id_id`) REFERENCES `mybookingapp_2_hotel` (`id`),
  CONSTRAINT `myBookingApp_2_voto_user_id_id_18b82e18_fk_auth_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mybookingapp_2_voto`
--

LOCK TABLES `mybookingapp_2_voto` WRITE;
/*!40000 ALTER TABLE `mybookingapp_2_voto` DISABLE KEYS */;
INSERT INTO `mybookingapp_2_voto` VALUES (26,3,2,2),(27,1,3,2);
/*!40000 ALTER TABLE `mybookingapp_2_voto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'bookingdb'
--

--
-- Dumping routines for database 'bookingdb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-08 12:43:36
