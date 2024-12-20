LOAD DATA
INFILE *
APPEND
INTO TABLE attraction
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    id_attraction,
    nom,
    date_ouverture DATE "YYYY-MM-DD",
    constructeur,
    vitesse_maximale,
    capacite_horaire,
    force_g_maximale "TO_NUMBER(:force_g_maximale, '9999D99', 'NLS_NUMERIC_CHARACTERS=''.,''')",
    hauteur_maximale "TO_NUMBER(:hauteur_maximale, '9999D99', 'NLS_NUMERIC_CHARACTERS=''.,''')",
    nombre_de_train,
    personnes_par_train,
    nombre_inversion,
    longueur "TO_NUMBER(:longueur, '9999D99', 'NLS_NUMERIC_CHARACTERS=''.,''')",
    type,
    duree,
    etat,
    id_parc
)
BEGINDATA
1,"Black Mamba","2006-04-01","Bolliger & Mabillard",80,1500,4.5,27,2,32,6,779,"Inverted Coaster",3,"ouverte",1
2,"Taron","2016-06-30","Intamin",117,1200,4.5,30,2,32,0,1349,"Launched Coaster",3,"ouverte",1
3,"Raik","2016-06-30","Gerstlauer",60,1000,3.5,25,2,16,0,682,"Family Coaster",2,"ouverte",1
4,"Chiapas","2014-04-01","Intamin",53,1200,3.5,20,2,20,0,850,"Log Flume",3,"ouverte",1
5,"Colorado Adventure","1996-04-01","Intamin",45,1200,3.5,20,2,20,0,1180,"Mine Train",3,"ouverte",1
6,"Winja's Fear & Force","2006-04-01","Maurer AG",40,1200,3.5,20,2,20,0,1180,"Spinning Coaster",3,"ouverte",1
7,"Maus au Chocolat","2011-04-01","Mack Rides",10,1200,0,0,9,12,0,350,"Interactive Dark Ride",9,"ouverte",1
8,"F.L.Y.","2020-09-17","Vekoma",100,1200,4.5,40,2,16,0,1230,"Flying Coaster",3,"ouverte",1
9,"River Quest","2002-04-01","Intamin",20,1200,0,22,18,9,0,440,"River Rapids",6,"ouverte",1
10,"Blue Fire Megacoaster","2009-04-04","Mack Rides",100,1720,3.8,38,5,20,4,1056,"Launched Coaster",140,"ouverte",2
11,"Silver Star","2002-03-23","Bolliger & Mabillard",127,1750,4,73,3,36,0,1620,"Hyper Coaster",360,"ouverte",2
12,"Wodan Timbur Coaster","2012-03-31","Great Coasters International",100,1250,3.5,40,3,24,0,1050,"Wooden Coaster",150,"ouverte",2
13,"Eurosat - CanCan Coaster","1989-09-12","Mack Rides",60,1280,4,25.5,7,14,0,922,"Dark Ride",198,"ouverte",2
14,"Euro-Mir","1997-06-12","Mack Rides",80,1600,4,28.30,9,16,0,984,"Spinning Coaster",273,"ouverte",2
15,"Voltron Nevera","2024-04-24","Mack Rides",100,1600,4.2,32.50,7,16,7,1385,"Launched Coaster",180,"ouverte",2
16,"Hyperspace Mountain","1995-06-01","Vekoma",76,2400,2.7,31,5,24,2,1000,"Launched Coaster",237,"ouverte",3
17,"Big Thunder Mountain","1992-04-12","Vekoma",65,2424,1.9,22,5,30,0,1205,"Mine Train",236,"ouverte",3
18,"Pirates of the Caribbean","1992-04-01","Intamin",30,3400,1.95,10,50,24,0,1000,"Dark Ride",630,"ouverte",3
19,"Phantom Manor","1992-04-12","Vekoma",2,2200,1,5.64,130,2,0,239,"Omnimover",360,"ouverte",3
20,"Indiana Jones et le Temple du Péril","1993-07-30","Intamin",58,1440,3.2,18,7,12,1,566,"Mad Mouse",74,"ouverte",3
21,"Avengers Assemble","2002-03-16","Vekoma",91,1800,5,24.40,5,24,3,1037,"Dark Ride",70,"ouverte",3
22,"Casey Jr. - le Petit Train du Cirque","1994-04-12","Vekoma",45,1440,1.1,3,2,34,0,522,"Family Coaster",120,"ouverte",3
23,"Crushs Coaster","2007-06-09","Maurer Rides",61,895,1.5,15.50,11,4,0,550,"Spinning Coaster",140,"ouverte",3
24,"OzIris","2012-04-07","Bolliger & Mabillard",90,1600,3.2,40,3,32,5,1000,"Inverted Coaster",135,"ouverte",4
25,"Pégase Express","2017-06-11","Gerstlauer",52,1200,2.1,20,4,20,0,928,"Family Coaster",120,"ouverte",4
26,"Tonnerre 2 Zeus","1997-04-07","Custom Coasters International",90,1440,2.1,29.90,2,24,0,1232.60,"Wooden Coaster",125,"ouverte",4
27,"Goudurix","1989-04-30","Vekoma",90,1100,4.5,36.10,2,28,7,950,"Steel Coaster",80,"ouverte",4
28,"Trace du Hourra","2001-03-31","Mack Rides",60,1500,1.8,31,5,14,0,900,"Bobsleigh",170,"ouverte",4
29,"Menhir Express","1995-04-07","Hopkins Ride",36,1200,0,13,30,4,0,627,"Log Flume",300,"ouverte",4
30,"Grand Splatch","1989-04-30","Intamin",42,1400,3.5,11,9,20,0,627,"Log Flume",360,"ouverte",4
31,"Toutatis","2023-04-08","Intamin",110,1260,1.1,51,3,20,3,1075,"Launched Coaster",123,"ouverte",4
32,"Le vol d'Icare","1994-04-07","Zierer",42,1150,1,10.70,5,4,0,410,"Family Coaster",75,"ouverte",4
33,"SOS Tournevis","1990-04-30","Zierer",32,1000,1.2,6,1,30,0,199,"Family Coaster",90,"ouverte",4
34,"Romus et Rapidus","2004-04-07","Hopkins Ride",22,1200,0,13,30,4,0,627,"Log Flume",300,"ouverte",4