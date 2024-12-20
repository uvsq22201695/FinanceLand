LOAD DATA
INFILE *
APPEND
INTO TABLE parc
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(id_parc, nom, date_ouverture YYYY-MM-DD, superficie, pays, ville)
BEGINDATA
1, "Phantasialand", 1967-04-30, 28, "Allemagne", "Brülh"
2, "Europa-Park", 1975-07-12, 95, "Allemagne", "Rust"
3, "Disneyland Paris", 1992-04-12, 2230, "France", "Marne-la-Vallée"
4, "Parc Astérix", 1989-04-30, 35, "France", "Plailly"
5, "Futuroscope", 1987-05-31, 60, "France", "Chasseneuil-du-Poitou"
6, "Walibi Rhône-Alpes", 1979-06-04, 35, "France", "Les Avenières"
7, "Walibi Sud-Ouest", 1999-06-04, 30, "France", "Roquefort"
8, "Alton Towers", 1980-04-04, 200, "Royaume-Uni", "Alton"
9, "Thorpe Park", 1979-05-24, 200, "Royaume-Uni", "Chertsey"
10, "PortAventura", 1995-05-01, 119, "Espagne", "Salou"
11, "Disneyland Resort", 1955-07-17, 486, "États-Unis", "Anaheim"
12, "Universal Studios Hollywood", 1964-07-15, 415, "États-Unis", "Los Angeles"
13, "Six Flags Magic Mountain", 1971-05-29, 262, "États-Unis", "Valencia"
14, "Cedar Point", 1870-05-17, 200, "États-Unis", "Sandusky"
15, "Wonderland Adventure", 2020-06-15, 120, "Australie", "Sydney"
16, "Galaxy World", 2019-09-20, 150, "Canada", "Toronto"
17, "Dream Park", 2021-07-01, 80, "Japon", "Tokyo"
18, "Adventure City", 2018-03-10, 95, "Chine", "Shanghai"
19, "Future Fun", 2017-11-05, 110, "Corée du Sud", "Séoul"
20, "Fantasy Land", 2022-04-25, 90, "Mexique", "Mexico"
21, "Oceanic Thrills", 2016-10-12, 130, "Afrique du Sud", "Cape Town"
22, "Extreme Rides", 2015-08-18, 140, "Russie", "Moscou"
23, "Magic Horizons", 2020-02-14, 100, "Brésil", "Rio de Janeiro"
24, "Luna Park", 2014-05-20, 60, "Italie", "Rome"
25, "Skyline Adventures", 2019-11-11, 150, "Nouvelle-Zélande", "Auckland"
26, "Velocity Valley", 2021-09-09, 200, "États-Unis", "Las Vegas"
27, "Gravity Park", 2018-12-25, 85, "Espagne", "Barcelone"
28, "Sunset Thrills", 2016-06-06, 100, "Portugal", "Lisbonne"
29, "Moonlit Adventures", 2023-03-21, 75, "Grèce", "Athènes"
30, "Star Quest", 2017-01-01, 120, "Inde", "Mumbai"

LOAD DATA
INFILE *
APPEND
INTO TABLE tarif
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(nom_tarif, prix, duree_en_jour, date_debut YYYY-MM-DD, date_fin YYYY-MM-DD)
BEGINDATA
"journalier", 50, 1, 2021-01-01, null)
"2 jours", 80, 2,  2021-01-01, null)
"annuel", 500, 365,  2021-01-01, null)
"nocturne", 30, 1,  2021-01-01, null)
"noel", 60, 1,  2020-11-15, 2021-12-31)

LOAD DATA
INFILE *
APPEND
INTO TABLE employe
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(numero_de_securite_sociale, id_attraction, nom, prenom, telephone, email, adresse, ville, pays)
100000001, 5, "Dupont", "Jean", "0123456789", "jean.dupont@example.com", "10 Brühl Avenue", "Brühl","Allemagne")
100000002, 12, "Martin", "Sophie", "0234567890", "sophie.martin@example.com", "20 Rust Street", "Rust","Allemagne")
100000003, 8, "Bernard", "Luc", "0345678901", "luc.bernard@example.com", "30 Disneyland Road", "Marne-la-Vallée", "France")
100000004, 15, "Durand", "Emma", "0456789012", "emma.durand@example.com", "40 Asterix Boulevard", "Plailly", "France")
100000005, 20, "Moreau", "Louis", "0567890123", "louis.moreau@example.com", "50 Futuroscope Way", "Chasseneuil-du-Poitou", "France")
100000006, 25, "Roux", "Julie", "0678901234", "julie.roux@example.com", "60 Walibi Lane", "Les Avenières", "France")
100000007, 30, "Petit", "Paul", "0789012345", "paul.petit@example.com", "70 Sud-Ouest Drive", "Roquefort", "France")
100000008, 34, "Richard", "Claire", "0890123456", "claire.richard@example.com", "80 Alton Towers Road", "Alton", "Royaume-Uni")
100000009, 2, "Durand", "Marc", "0901234567", "marc.durand@example.com", "90 Thorpe Park Lane", "Chertsey", "Royaume-Uni")
100000010, 6, "Dubois", "Marie", "0112345678", "marie.dubois@example.com", "100 PortAventura Street", "Salou", "Espagne")
100000011, 14, "Blanc", "Alice", "0123456789", "alice.blanc@example.com", "110 Disney Drive", "Anaheim", "États-Unis")
100000012, 10, "Fabre", "Hugo", "0234567890", "hugo.fabre@example.com", "120 Universal Boulevard", "Los Angeles", "États-Unis")
100000013, 18, "Lemoine", "Sarah", "0345678901", "sarah.lemoine@example.com", "130 Six Flags Road", "Valencia", "États-Unis")
100000014, 22, "Noir", "Lucas", "0456789012", "lucas.noir@example.com", "140 Cedar Avenue", "Sandusky", "États-Unis")
100000015, 9, "Clément", "Chloe", "0567890123", "chloe.clement@example.com", "150 Brühl Avenue", "Brühl", "Allemagne")
100000016, 11, "Perrin", "Thomas", "0678901234", "thomas.perrin@example.com", "160 Rust Street", "Rust", "Allemagne")
100000017, 16, "Leclerc", "Emma", "0789012345", "emma.leclerc@example.com", "170 Disneyland Road", "Marne-la-Vallée", "France")
100000018, 21, "Lemoine", "Victor", "0890123456", "victor.lemoine@example.com", "180 Asterix Boulevard", "Plailly", "France")
100000019, 19, "Simon", "Anais", "0901234567", "anais.simon@example.com", "190 Futuroscope Way", "Chasseneuil-du-Poitou", "France")
100000020, 24, "Michel", "Arthur", "0112345678", "arthur.michel@example.com", "200 Walibi Lane", "Les Avenières", "France")
100000021, 27, "Garcia", "Elisa", "0123456789", "elisa.garcia@example.com", "210 Sud-Ouest Drive", "Roquefort", "France")
100000022, 28, "Fernandez", "Nathan", "0234567890", "nathan.fernandez@example.com", "220 Alton Towers Road", "Alton", "Royaume-Uni")
100000023, 3, "Lopez", "Camille", "0345678901", "camille.lopez@example.com", "230 Thorpe Park Lane", "Chertsey", "Royaume-Uni")
100000024, 7, "Morin", "Julien", "0456789012", "julien.morin@example.com", "240 PortAventura Street", "Salou", "Espagne")
100000025, 13, "Morel", "Celine", "0567890123", "celine.morel@example.com", "250 Disney Drive", "Anaheim", "États-Unis")
100000026, 4, "Guerin", "Leo", "0678901234", "leo.guerin@example.com", "260 Universal Boulevard", "Los Angeles", "États-Unis")
100000027, 23, "Fournier", "Eva", "0789012345", "eva.fournier@example.com", "270 Six Flags Road", "Valencia", "États-Unis")
100000028, 17, "Girard", "Adam", "0890123456", "adam.girard@example.com", "280 Cedar Avenue", "Sandusky", "États-Unis")
100000029, 26, "Andre", "Lola", "0901234567", "lola.andre@example.com", "290 Brühl Avenue", "Brühl", "Allemagne")
100000030, 31, "Mercier", "Noah", "0112345678", "noah.mercier@example.com", "300 Rust Street", "Rust", "Allemagne")
100000031, 32, "Dupuis", "Alice", "0123456789", "alice.dupuis@example.com", "310 Disneyland Road", "Marne-la-Vallée", "France")
100000032, 33, "Lambert", "Louis", "0234567890", "louis.lambert@example.com", "320 Asterix Boulevard", "Plailly", "France")
100000033, 29, "Fontaine", "Sophie", "0345678901", "sophie.fontaine@example.com", "330 Futuroscope Way", "Chasseneuil-du-Poitou", "France")
100000034, 2, "Roche", "Emma", "0456789012", "emma.roche@example.com", "340 Walibi Lane", "Les Avenières", "France")
100000035, 1, "Chevalier", "Hugo", "0567890123", "hugo.chevalier@example.com", "350 Sud-Ouest Drive", "Roquefort", "France")
100000036, 12, "Francois", "Paul", "0678901234", "paul.francois@example.com", "360 Alton Towers Road", "Alton", "Royaume-Uni")
100000037, 18, "Perrot", "Lucas", "0789012345", "lucas.perrot@example.com", "370 Thorpe Park Lane", "Chertsey", "Royaume-Uni")
100000038, 20, "Lemoine", "Sarah", "0890123456", "sarah.lemoine@example.com", "380 PortAventura Street", "Salou", "Espagne")
100000039, 14, "Benoit", "Julien", "0901234567", "julien.benoit@example.com", "390 Disney Drive", "Anaheim", "États-Unis")
100000040, 10, "Antoine", "Eve", "0112345678", "eve.antoine@example.com", "400 Universal Boulevard", "Los Angeles", "États-Unis")
100000041, 30, "Navarro", "Chloe", "0123456789", "chloe.navarro@example.com", "410 Six Flags Road", "Valencia", "États-Unis")
100000042, 21, "Renaud", "Victor", "0234567890", "victor.renaud@example.com", "420 Cedar Avenue", "Sandusky", "États-Unis")
100000043, 9, "Lemoine", "Anais", "0345678901", "anais.lemoine@example.com", "430 Brühl Avenue", "Brühl", "Allemagne")

LOAD DATA
INFILE *
APPEND
INTO TABLE attraction
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(id_attraction, nom, date_ouverture DATE "YYYY-MM-DD", constructeur, vitesse_maximale, capacite_horaire, force_g_maximale, hauteur_maximale, nombre_de_train, personnes_par_train, nombre_inversion, longueur, type, duree, etat, id_parc)
BEGIN DATA
1,Black Mamba,2006-04-01,Bolliger & Mabillard,80,1500,4.5,27,2,32,6,779,Inverted Coaster,3,ouverte,1
2,Taron,2016-06-30,Intamin,117,1200,4.5,30,2,32,0,1349,Launched Coaster,3,ouverte,1
3,Raik,2016-06-30,Gerstlauer,60,1000,3.5,25,2,16,0,682,Family Coaster,2,ouverte,1
4,Chiapas,2014-04-01,Intamin,53,1200,3.5,20,2,20,0,850,Log Flume,3,ouverte,1
5,Colorado Adventure,1996-04-01,Intamin,45,1200,3.5,20,2,20,0,1180,Mine Train,3,ouverte,1
6,Winja's Fear & Force,2006-04-01,Maurer AG,40,1200,3.5,20,2,20,0,1180,Spinning Coaster,3,ouverte,1
7,Maus au Chocolat,2011-04-01,Mack Rides,10,1200,0,0,9,12,0,350,Interactive Dark Ride,9,ouverte,1
8,F.L.Y.,2020-09-17,Vekoma,100,1200,4.5,40,2,16,0,1230,Flying Coaster,3,ouverte,1
9,River Quest,2002-04-01,Intamin,20,1200,0,22,18,9,0,440,River Rapids,6,ouverte,1
10,Blue Fire Megacoaster,2009-04-04,Mack Rides,100,1720,3.8,38,5,20,4,1056,Launched Coaster,140,ouverte,2
11,Silver Star,2002-03-23,Bolliger & Mabillard,127,1750,4,73,3,36,0,1620,Hyper Coaster,360,ouverte,2
12,Wodan Timbur Coaster,2012-03-31,Great Coasters International,100,1250,3.5,40,3,24,0,1050,Wooden Coaster,150,ouverte,2
13,Eurosat - CanCan Coaster,1989-09-12,Mack Rides,60,1280,4,25.5,7,14,0,922,Dark Ride,198,ouverte,2
14,Euro-Mir,1997-06-12,Mack Rides,80,1600,4,28.30,9,16,0,984,Spinning Coaster,273,ouverte,2
15,Voltron Nevera,2024-04-24,Mack Rides,100,1600,4.2,32.50,7,16,7,1385,Launched Coaster,180,ouverte,2
16,Hyperspace Mountain,1995-06-01,Vekoma,76,2400,2.7,31,5,24,2,1000,Launched Coaster,237,ouverte,3
17,Big Thunder Mountain,1992-04-12,Vekoma,65,2424,1.9,22,5,30,0,1205,Mine Train,236,ouverte,3
18,Pirates of the Caribbean,1992-04-01,Intamin,30,3400,1.95,10,50,24,0,1000,Dark Ride,630,ouverte,3
19,Phantom Manor,1992-04-12,Vekoma,2,2200,1,5.64,130,2,0,239,Omnimover,360,ouverte,3
20,Indiana Jones et le Temple du Péril,1993-07-30,Intamin,58,1440,3.2,18,7,12,1,566,Mad Mouse,74,ouverte,3
21,Avengers Assemble,2002-03-16,Vekoma,91,1800,5,24.40,5,24,3,1037,Dark Ride,70,ouverte,3
22,Casey Jr. - le Petit Train du Cirque,1994-04-12,Vekoma,45,1440,1.1,3,2,34,0,522,Family Coaster,120,ouverte,3
23,Crushs Coaster,2007-06-09,Maurer Rides,61,895,1.5,15.50,11,4,0,550,Spinning Coaster,140,ouverte,3
24,OzIris,2012-04-07,Bolliger & Mabillard,90,1600,3.2,40,3,32,5,1000,Inverted Coaster,135,ouverte,4
25,Pégase Express,2017-06-11,Gerstlauer,52,1200,2.1,20,4,20,0,928,Family Coaster,120,ouverte,4
26,Tonnerre 2 Zeus,1997-04-07,Custom Coasters International,90,1440,2.1,29.90,2,24,0,1232.60,Wooden Coaster,125,ouverte,4
27,Goudurix,1989-04-30,Vekoma,90,1100,4.5,36.10,2,28,7,950,Steel Coaster,80,ouverte,4
28,Trace du Hourra,2001-03-31,Mack Rides,60,1500,1.8,31,5,14,0,900,Bobsleigh,170,ouverte,4
29,Menhir Express,1995-04-07,Hopkins Ride,36,1200,0,13,30,4,0,627,Log Flume,300,ouverte,4
30,Grand Splatch,1989-04-30,Intamin,42,1400,3.5,11,9,20,0,627,Log Flume,360,ouverte,4
31,Toutatis,2023-04-08,Intamin,110,1260,1.1,51,3,20,3,1075,Launched Coaster,123,ouverte,4
32,Le vol d'Icare,1994-04-07,Zierer,42,1150,1,10.70,5,4,0,410,Family Coaster,75,ouverte,4
33,SOS Tournevis,1990-04-30,Zierer,32,1000,1.2,6,1,30,0,199,Family Coaster,90,ouverte,4
34,Romus et Rapidus,2004-04-07,Hopkins Ride,22,1200,0,13,30,4,0,627,Log Flume,300,ouverte,4

LOAD DATA
INFILE *
APPEND
INTO TABLE client
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(id_client, email, nom, prenom, date_naissance DATE "YYYY-MM-DD", adresse, telephone, ville, pays)
BEGIN DATA
1, 'john.doe@example.com', 'Doe', 'John', '123 Main Street', '555-0101', 'Springfield', 'USA'
2, 'jane.smith@example.com', 'Smith', 'Jane', '456 Elm Street', '555-0202', 'Shelbyville', 'USA'
3, 'emily.johnson@example.com', 'Johnson', 'Emily', '789 Oak Avenue', '555-0303', 'Ogdenville', 'Canada'
4, 'michael.brown@example.com', 'Brown', 'Michael', '321 Pine Lane', '555-0404', 'North Haverbrook', 'USA'
5, 'sarah.davis@example.com', 'Davis', 'Sarah', '654 Maple Boulevard', '555-0505', 'Capital City', 'UK'
6, 'david.wilson@example.com', 'Wilson', 'David', '987 Cedar Road', '555-0606', 'Springfield', 'Australia'
7, 'lisa.taylor@example.com', 'Taylor', 'Lisa', '135 Willow Circle', '555-0707', 'Shelbyville', 'New Zealand'
8, 'paul.martin@example.com', 'Martin', 'Paul', '246 Aspen Court', '555-0808', 'Ogdenville', 'Ireland'
9, 'laura.thomas@example.com', 'Thomas', 'Laura', '357 Birch Way', '555-0909', 'North Haverbrook', 'France'
10, 'james.moore@example.com', 'Moore', 'James', '468 Cherry Street', '555-1010', 'Capital City', 'Germany'
11, 'ana.robin@example.com', 'Robin', 'Ana', '10 Rue Jean Moulin', '0756123487', 'Grenoble', 'France'
12, 'marc.garcia@example.com', 'Garcia', 'Marc', '11 Rue de Provence', '0623456790', 'Dijon', 'France'
13, 'elise.benoit@example.com', 'Benoit', 'Elise', '12 Rue des Carmes', '0645236789', 'Le Havre', 'France'
14, 'nathan.morel@example.com', 'Morel', 'Nathan', '13 Rue du Marché', '0634236789', 'Toulon', 'France'
15, 'ines.bernard@example.com', 'Bernard', 'Ines', '14 Rue Saint-Honoré', '0612234789', 'Saint-Étienne', 'France'
16, 'emilie.martinez@example.com', 'Martinez', 'Emilie', '15 Rue de la République', '0698123456', 'Rennes', 'France'
17, 'mathieu.fabre@example.com', 'Fabre', 'Mathieu', '16 Rue de Metz', '0623456789', 'Aix-en-Provence', 'France'
18, 'lea.clement@example.com', 'Clément', 'Lea', '17 Rue des Peupliers', '0678236789', 'Montpellier', 'France'
19, 'juliette.david@example.com', 'David', 'Juliette', '18 Rue des Acacias', '0654123678', 'Orléans', 'France'
20, 'maxime.renard@example.com', 'Renard', 'Maxime', '19 Avenue de l''Europe', '0687345678', 'Clermont-Ferrand', 'France'
21, 'emilie.dupuis@example.com', 'Dupuis', 'Emilie', '20 Rue des Lilas', '0645123789', 'Nancy', 'France'
22, 'vincent.robert@example.com', 'Robert', 'Vincent', '21 Rue des Tulipes', '0698123478', 'Metz', 'France'
23, 'sophie.lopez@example.com', 'Lopez', 'Sophie', '22 Boulevard Gambetta', '0634234789', 'Tours', 'France'
24, 'lucas.navarro@example.com', 'Navarro', 'Lucas', '23 Rue des Mimosas', '0687345789', 'Angers', 'France'
25, 'melanie.dumont@example.com', 'Dumont', 'Melanie', '24 Avenue Jules Ferry', '0623456897', 'Perpignan', 'France'
26, 'etienne.guillaume@example.com', 'Guillaume', 'Etienne', '25 Rue de Lorraine', '0654123489', 'Limoges', 'France'
27, 'florence.roger@example.com', 'Roger', 'Florence', '26 Rue de l''Abbaye', '0678123467', 'Béziers', 'France'
28, 'quentin.lefevre@example.com', 'Lefevre', 'Quentin', '27 Rue de la Liberté', '0689234789', 'Pau', 'France'
29, 'helene.durieux@example.com', 'Durieux', 'Helene', '28 Rue des Vignes', '0612234689', 'Avignon', 'France'
30, 'thibault.rousseau@example.com', 'Rousseau', 'Thibault', '29 Rue des Marronniers', '0698123467', 'Valence', 'France'

LOAD DATA
INFILE *
APPEND
INTO TABLE travaux
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(id_travaux, id_attraction, date_debut DATE "YYYY-MM-DD", date_fin DATE "YYYY-MM-DD", description, cout, etat, reparateur)
BEGIN DATA
1, 1, DATE '2021-01-01', DATE '2021-01-15', 'Maintenance annuelle', 10000, 'terminé', 'Reparator 3000'
2, 2, DATE '2021-01-01', DATE '2021-01-15', 'Maintenance annuelle', 10000, 'terminé', 'Attraction Comme Neuves INC'
3, 3, DATE '2021-01-01', DATE '2021-01-15', 'Rethématisation', 10000, 'terminé', 'DecoraMax'
4, 4, DATE '2021-01-01', DATE '2021-01-15', 'Maintenance annuelle', 10000, 'terminé', 'Reparator 3000'
5, 5, DATE '2021-01-01', DATE '2021-01-15', 'Maintenance annuelle', 10000, 'terminé', 'Attraction Comme Neuves INC'
6, 6, DATE '2021-01-01', DATE '2021-01-15', 'Rethématisation', 10000, 'terminé', 'DecoraMax'
7, 7, DATE '2021-01-01', DATE '2021-01-15', 'Maintenance annuelle', 10000, 'terminé', 'Reparator 3000'
8, 1, DATE '2021-02-01', DATE '2021-02-10', 'Révision matérielle', 12000, 'terminé', 'FixIt Fast'
9, 2, DATE '2021-03-01', DATE '2021-03-15', 'Maintenance annuelle', 8000, 'terminé', 'Reparator 3000'
10, 3, DATE '2021-04-05', DATE '2021-04-20', 'Test de sécurité', 15000, 'terminé', 'SafeCheck Pro'
11, 4, DATE '2021-05-01', DATE '2021-05-10', 'Réparation urgente', 20000, 'terminé', 'RepairHub'
12, 5, DATE '2021-06-01', DATE '2021-06-12', 'Amélioration technique', 18000, 'terminé', 'TechnoPatch'
13, 6, DATE '2021-07-10', DATE '2021-07-25', 'Maintenance annuelle', 10000, 'prévu', 'FixIt Fast'
14, 7, DATE '2021-08-01', DATE '2021-08-20', 'Test de sécurité', 16000, 'terminé', 'SafeCheck Pro'
15, 8, DATE '2021-09-01', DATE '2021-09-15', 'Révision matérielle', 14000, 'terminé', 'Reparator 3000'
16, 9, DATE '2021-10-01', DATE '2021-10-20', 'Réparation urgente', 22000, 'terminé', 'RepairHub'
17, 10, DATE '2021-11-01', DATE '2021-11-15', 'Amélioration technique', 17000, 'terminé', 'TechnoPatch'
18, 11, DATE '2021-12-01', DATE '2021-12-10', 'Maintenance annuelle', 12000, 'terminé', 'FixIt Fast'
19, 12, DATE '2021-02-15', DATE '2021-03-01', 'Réparation urgente', 25000, 'terminé', 'RepairHub'
20, 13, DATE '2021-03-10', DATE '2021-03-25', 'Test de sécurité', 20000, 'terminé', 'SafeCheck Pro'
21, 14, DATE '2021-04-15', DATE '2021-05-05', 'Amélioration technique', 30000, 'prévu', 'TechnoPatch'
22, 15, DATE '2021-05-10', DATE '2021-05-25', 'Maintenance annuelle', 9000, 'terminé', 'Reparator 3000'
23, 16, DATE '2021-06-15', DATE '2021-07-01', 'Réparation urgente', 24000, 'terminé', 'FixIt Fast'
24, 17, DATE '2021-07-20', DATE '2021-08-10', 'Révision matérielle', 15000, 'terminé', 'RepairHub'
25, 18, DATE '2021-08-25', DATE '2021-09-10', 'Test de sécurité', 12000, 'terminé', 'SafeCheck Pro'
26, 19, DATE '2021-10-01', DATE '2021-10-15', 'Amélioration technique', 21000, 'terminé', 'TechnoPatch'
27, 20, DATE '2021-11-10', DATE '2021-11-25', 'Maintenance annuelle', 10000, 'prévu', 'Reparator 3000'
28, 21, DATE '2021-01-10', DATE '2021-01-20', 'Test de sécurité', 13000, 'terminé', 'SafeCheck Pro'
29, 22, DATE '2021-02-05', DATE '2021-02-15', 'Révision matérielle', 17000, 'terminé', 'Reparator 3000'
30, 23, DATE '2021-03-05', DATE '2021-03-18', 'Maintenance annuelle', 12000, 'terminé', 'FixIt Fast'
31, 24, DATE '2021-04-05', DATE '2021-04-15', 'Réparation urgente', 25000, 'prévu', 'RepairHub'
32, 25, DATE '2021-05-10', DATE '2021-05-20', 'Amélioration technique', 30000, 'terminé', 'TechnoPatch'
33, 26, DATE '2021-06-15', DATE '2021-06-25', 'Test de sécurité', 22000, 'terminé', 'SafeCheck Pro'
34, 27, DATE '2021-07-01', DATE '2021-07-10', 'Maintenance annuelle', 15000, 'terminé', 'Reparator 3000'
35, 28, DATE '2021-08-05', DATE '2021-08-15', 'Révision matérielle', 16000, 'terminé', 'FixIt Fast'
36, 29, DATE '2021-09-10', DATE '2021-09-20', 'Maintenance annuelle', 18000, 'terminé', 'RepairHub'
37, 30, DATE '2021-10-05', DATE '2021-10-15', 'Test de sécurité', 25000, 'terminé', 'SafeCheck Pro'
38, 31, DATE '2021-11-15', DATE '2021-11-25', 'Réparation urgente', 26000, 'prévu', 'RepairHub'
39, 32, DATE '2021-12-01', DATE '2021-12-12', 'Maintenance annuelle', 14000, 'terminé', 'TechnoPatch'
40, 33, DATE '2021-01-05', DATE '2021-01-15', 'Révision matérielle', 16000, 'terminé', 'FixIt Fast'
41, 34, DATE '2021-02-10', DATE '2021-02-20', 'Test de sécurité', 18000, 'terminé', 'SafeCheck Pro'
42, 1, DATE '2023-01-10', DATE '2023-01-20', 'Inspection de sécurité', 12000, 'terminé', 'SafeCheck Pro'
43, 1, DATE '2024-05-15', DATE '2025-06-01', 'Réparation majeure', 35000, 'en cours', 'RepairHub'
44, 2, DATE '2023-03-01', DATE '2023-03-15', 'Amélioration technique', 20000, 'terminé', 'TechnoPatch'
45, 2, DATE '2024-07-10', DATE '2024-07-25', 'Maintenance annuelle', 15000, 'prévu', 'FixIt Fast'
46, 3, DATE '2024-02-20', DATE '2024-03-05', 'Révision matérielle', 14000, 'terminé', 'Reparator 3000'
47, 3, DATE '2023-11-01', DATE '2023-11-20', 'Test de sécurité', 16000, 'terminé', 'SafeCheck Pro'
48, 4, DATE '2023-06-01', DATE '2023-06-15', 'Réparation urgente', 25000, 'terminé', 'RepairHub'
49, 4, DATE '2024-09-01', DATE '2025-09-15', 'Amélioration technique', 28000, 'en cours', 'TechnoPatch'
50, 5, DATE '2023-08-01', DATE '2023-08-10', 'Maintenance annuelle', 10000, 'terminé', 'Reparator 3000'
51, 5, DATE '2024-10-15', DATE '2024-10-30', 'Inspection de sécurité', 12000, 'prévu', 'SafeCheck Pro'
52, 6, DATE '2023-05-01', DATE '2023-05-10', 'Révision matérielle', 11000, 'terminé', 'FixIt Fast'
53, 6, DATE '2024-11-01', DATE '2025-11-10', 'Réparation urgente', 18000, 'en cours', 'RepairHub'
54, 7, DATE '2023-04-15', DATE '2023-04-30', 'Test de sécurité', 15000, 'terminé', 'SafeCheck Pro'
55, 7, DATE '2024-12-01', DATE '2024-12-15', 'Amélioration technique', 22000, 'prévu', 'TechnoPatch'
56, 8, DATE '2023-09-01', DATE '2023-09-10', 'Maintenance annuelle', 9000, 'terminé', 'Reparator 3000'
57, 8, DATE '2024-03-01', DATE '2024-03-15', 'Révision matérielle', 14000, 'terminé', 'FixIt Fast'
58, 9, DATE '2023-02-01', DATE '2023-02-10', 'Réparation urgente', 30000, 'terminé', 'RepairHub'
59, 9, DATE '2024-04-10', DATE '2024-04-20', 'Test de sécurité', 16000, 'terminé', 'SafeCheck Pro'
60, 10, DATE '2023-12-01', DATE '2023-12-10', 'Amélioration technique', 25000, 'prévu', 'TechnoPatch'
61, 10, DATE '2024-06-10', DATE '2024-06-20', 'Maintenance annuelle', 12000, 'terminé', 'Reparator 3000'
62, 1, TRUNC(SYSDATE, 'YEAR') - INTERVAL '10' MONTH, TRUNC(SYSDATE, 'YEAR') - INTERVAL '9' MONTH, 'Révision annuelle', 15000, 'terminé', 'FixIt Fast'
63, 1, TRUNC(SYSDATE, 'YEAR') - INTERVAL '6' MONTH, TRUNC(SYSDATE, 'YEAR') - INTERVAL '5' MONTH, 'Test de sécurité', 12000, 'terminé', 'SafeCheck Pro'
64, 5, TRUNC(SYSDATE, 'YEAR') - INTERVAL '11' MONTH, TRUNC(SYSDATE, 'YEAR') - INTERVAL '10' MONTH, 'Maintenance préventive', 18000, 'terminé', 'RepairHub'
65, 5, TRUNC(SYSDATE, 'YEAR') - INTERVAL '3' MONTH, TRUNC(SYSDATE, 'YEAR') - INTERVAL '2' MONTH, 'Amélioration technique', 20000, 'terminé', 'TechnoPatch'

LOAD DATA
INFILE *
APPEND
INTO TABLE employe
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(numero_de_securite_sociale, id_attraction, nom, prenom, telephone, email, adresse, ville, pays)
BEGIN DATA
100000001, 5, 'Dupont', 'Jean', '0123456789', 'jean.dupont@example.com', '10 Brühl Avenue', 'Brühl','Allemagne'
100000002, 12, 'Martin', 'Sophie', '0234567890', 'sophie.martin@example.com', '20 Rust Street', 'Rust','Allemagne'
100000003, 8, 'Bernard', 'Luc', '0345678901', 'luc.bernard@example.com', '30 Disneyland Road', 'Marne-la-Vallée', 'France'
100000004, 15, 'Durand', 'Emma', '0456789012', 'emma.durand@example.com', '40 Asterix Boulevard', 'Plailly', 'France'
100000005, 20, 'Moreau', 'Louis', '0567890123', 'louis.moreau@example.com', '50 Futuroscope Way', 'Chasseneuil-du-Poitou', 'France'
100000006, 25, 'Roux', 'Julie', '0678901234', 'julie.roux@example.com', '60 Walibi Lane', 'Les Avenières', 'France'
100000007, 30, 'Petit', 'Paul', '0789012345', 'paul.petit@example.com', '70 Sud-Ouest Drive', 'Roquefort', 'France'
100000008, 34, 'Richard', 'Claire', '0890123456', 'claire.richard@example.com', '80 Alton Towers Road', 'Alton', 'Royaume-Uni'
100000009, 2, 'Durand', 'Marc', '0901234567', 'marc.durand@example.com', '90 Thorpe Park Lane', 'Chertsey', 'Royaume-Uni'
100000010, 6, 'Dubois', 'Marie', '0112345678', 'marie.dubois@example.com', '100 PortAventura Street', 'Salou', 'Espagne'
100000011, 14, 'Blanc', 'Alice', '0123456789', 'alice.blanc@example.com', '110 Disney Drive', 'Anaheim', 'États-Unis'
100000012, 10, 'Fabre', 'Hugo', '0234567890', 'hugo.fabre@example.com', '120 Universal Boulevard', 'Los Angeles', 'États-Unis'
100000013, 18, 'Lemoine', 'Sarah', '0345678901', 'sarah.lemoine@example.com', '130 Six Flags Road', 'Valencia', 'États-Unis'
100000014, 22, 'Noir', 'Lucas', '0456789012', 'lucas.noir@example.com', '140 Cedar Avenue', 'Sandusky', 'États-Unis'
100000015, 9, 'Clément', 'Chloe', '0567890123', 'chloe.clement@example.com', '150 Brühl Avenue', 'Brühl', 'Allemagne'
100000016, 11, 'Perrin', 'Thomas', '0678901234', 'thomas.perrin@example.com', '160 Rust Street', 'Rust', 'Allemagne'
100000017, 16, 'Leclerc', 'Emma', '0789012345', 'emma.leclerc@example.com', '170 Disneyland Road', 'Marne-la-Vallée', 'France'
100000018, 21, 'Lemoine', 'Victor', '0890123456', 'victor.lemoine@example.com', '180 Asterix Boulevard', 'Plailly', 'France'
100000019, 19, 'Simon', 'Anais', '0901234567', 'anais.simon@example.com', '190 Futuroscope Way', 'Chasseneuil-du-Poitou', 'France'
100000020, 24, 'Michel', 'Arthur', '0112345678', 'arthur.michel@example.com', '200 Walibi Lane', 'Les Avenières', 'France'
100000021, 27, 'Garcia', 'Elisa', '0123456789', 'elisa.garcia@example.com', '210 Sud-Ouest Drive', 'Roquefort', 'France'
100000022, 28, 'Fernandez', 'Nathan', '0234567890', 'nathan.fernandez@example.com', '220 Alton Towers Road', 'Alton', 'Royaume-Uni'
100000023, 3, 'Lopez', 'Camille', '0345678901', 'camille.lopez@example.com', '230 Thorpe Park Lane', 'Chertsey', 'Royaume-Uni'
100000024, 7, 'Morin', 'Julien', '0456789012', 'julien.morin@example.com', '240 PortAventura Street', 'Salou', 'Espagne'
100000025, 13, 'Morel', 'Celine', '0567890123', 'celine.morel@example.com', '250 Disney Drive', 'Anaheim', 'États-Unis'
100000026, 4, 'Guerin', 'Leo', '0678901234', 'leo.guerin@example.com', '260 Universal Boulevard', 'Los Angeles', 'États-Unis'
100000027, 23, 'Fournier', 'Eva', '0789012345', 'eva.fournier@example.com', '270 Six Flags Road', 'Valencia', 'États-Unis'
100000028, 17, 'Girard', 'Adam', '0890123456', 'adam.girard@example.com', '280 Cedar Avenue', 'Sandusky', 'États-Unis'
100000029, 26, 'Andre', 'Lola', '0901234567', 'lola.andre@example.com', '290 Brühl Avenue', 'Brühl', 'Allemagne'
100000030, 31, 'Mercier', 'Noah', '0112345678', 'noah.mercier@example.com', '300 Rust Street', 'Rust', 'Allemagne'
100000031, 32, 'Dupuis', 'Alice', '0123456789', 'alice.dupuis@example.com', '310 Disneyland Road', 'Marne-la-Vallée', 'France'
100000032, 33, 'Lambert', 'Louis', '0234567890', 'louis.lambert@example.com', '320 Asterix Boulevard', 'Plailly', 'France'
100000033, 29, 'Fontaine', 'Sophie', '0345678901', 'sophie.fontaine@example.com', '330 Futuroscope Way', 'Chasseneuil-du-Poitou', 'France'
100000034, 2, 'Roche', 'Emma', '0456789012', 'emma.roche@example.com', '340 Walibi Lane', 'Les Avenières', 'France'
100000035, 1, 'Chevalier', 'Hugo', '0567890123', 'hugo.chevalier@example.com', '350 Sud-Ouest Drive', 'Roquefort', 'France'
100000036, 12, 'Francois', 'Paul', '0678901234', 'paul.francois@example.com', '360 Alton Towers Road', 'Alton', 'Royaume-Uni'
100000037, 18, 'Perrot', 'Lucas', '0789012345', 'lucas.perrot@example.com', '370 Thorpe Park Lane', 'Chertsey', 'Royaume-Uni'
100000038, 20, 'Lemoine', 'Sarah', '0890123456', 'sarah.lemoine@example.com', '380 PortAventura Street', 'Salou', 'Espagne'
100000039, 14, 'Benoit', 'Julien', '0901234567', 'julien.benoit@example.com', '390 Disney Drive', 'Anaheim', 'États-Unis'
100000040, 10, 'Antoine', 'Eve', '0112345678', 'eve.antoine@example.com', '400 Universal Boulevard', 'Los Angeles', 'États-Unis'
100000041, 30, 'Navarro', 'Chloe', '0123456789', 'chloe.navarro@example.com', '410 Six Flags Road', 'Valencia', 'États-Unis'
100000043, 9, 'Lemoine', 'Anais', '0345678901', 'anais.lemoine@example.com', '430 Brühl Avenue', 'Brühl', 'Allemagne'

LOAD DATA
INFILE *
APPEND
INTO TABLE commande
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(id_commande, id_client, date_commande DATE "YYYY-MM-DD", montant_total, nb_billets)
BEGIN DATA
1, 12, DATE '2023-11-01', 0, 0
2, 7, DATE '2023-11-02', 0, 0
3, 23, DATE '2023-11-03', 0, 0
4, 5, DATE '2023-11-04', 0, 0
5, 19, DATE '2023-11-05', 0, 0
6, 15, DATE '2023-11-06', 0, 0
7, 8, DATE '2023-11-07', 0, 0
8, 27, DATE '2022-11-08', 0, 0
9, 1, DATE '2023-11-09', 0, 0
10, 29, DATE '2023-11-10', 0, 0
11, 6, DATE '2023-11-11', 0, 0
12, 18, DATE '2023-11-12', 0, 0
13, 14, DATE '2023-11-13', 0, 0
14, 21, DATE '2023-11-14', 0, 0
15, 9, DATE '2023-11-15', 0, 0
16, 3, DATE '2023-11-16', 0, 0
17, 10, DATE '2023-11-17', 0, 0
18, 22, DATE '2023-11-18', 0, 0
19, 26, DATE '2023-11-19', 0, 0
20, 4, DATE '2023-11-20', 0, 0
21, 25, DATE '2023-11-21', 0, 0
22, 2, DATE '2023-11-22', 0, 0
23, 17, DATE '2023-11-23', 0, 0
24, 13, DATE '2023-11-24', 0, 0
25, 19, DATE '2023-11-25', 0, 0
26, 11, DATE '2023-11-26', 0, 0
27, 29, DATE '2023-11-27', 0, 0
28, 16, DATE '2023-11-28', 0, 0
29, 8, DATE '2023-11-29', 0, 0
30, 20, DATE '2023-11-30', 0, 0
31, 5, DATE '2023-12-01', 0, 0
32, 24, DATE '2023-12-02', 0, 0
33, 12, DATE '2023-12-03', 0, 0
34, 28, DATE '2023-12-04', 0, 0
35, 7, DATE '2023-12-05', 0, 0
36, 2, DATE '2023-12-06', 0, 0
37, 9, DATE '2023-12-07', 0, 0
38, 15, DATE '2023-12-08', 0, 0
39, 1, DATE '2023-12-09', 0, 0
40, 19, DATE '2023-12-10', 0, 0
41, 14, DATE '2023-12-11', 0, 0
42, 22, DATE '2023-12-12', 0, 0
43, 3, DATE '2023-12-13', 0, 0
44, 10, DATE '2023-12-14', 0, 0
45, 18, DATE '2023-12-15', 0, 0
46, 21, DATE '2023-12-16', 0, 0
47, 27, DATE '2023-12-17', 0, 0
48, 6, DATE '2023-12-18', 0, 0
49, 11, DATE '2023-12-19', 0, 0
50, 29, DATE '2023-12-20', 0, 0

LOAD DATA
INFILE *
APPEND
INTO TABLE tourniquet
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(id_attraction, heure, entree_ou_sortie)
BEGIN DATA
1, TO_DATE('2023-12-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
1, TO_DATE('2023-12-01 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie'
1, TO_DATE('2023-12-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
1, TO_DATE('2023-12-01 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie'
2, TO_DATE('2023-12-01 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
4, TO_DATE('2023-12-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
4, TO_DATE('2023-12-01 12:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie'
5, TO_DATE('2023-12-01 09:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
5, TO_DATE('2023-12-01 09:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie'
5, TO_DATE('2023-12-01 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
5, TO_DATE('2023-12-01 10:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie'
5, TO_DATE('2023-12-01 11:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
7, TO_DATE('2023-12-01 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
7, TO_DATE('2023-12-01 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie'
8, TO_DATE('2023-12-01 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie'
9, TO_DATE('2023-12-01 09:05:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
9, TO_DATE('2023-12-01 09:35:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
9, TO_DATE('2023-12-01 10:05:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
9, TO_DATE('2023-12-01 10:35:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
10, TO_DATE('2023-12-01 09:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
10, TO_DATE('2023-12-01 09:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie'
11, TO_DATE('2023-12-01 10:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
12, TO_DATE('2023-12-01 10:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
12, TO_DATE('2023-12-01 11:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie'
13, TO_DATE('2023-12-01 11:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
14, TO_DATE('2023-12-01 12:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
15, TO_DATE('2023-12-01 12:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
16, TO_DATE('2023-12-01 13:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
17, TO_DATE('2023-12-01 13:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
18, TO_DATE('2023-12-01 14:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
19, TO_DATE('2023-12-01 14:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
20, TO_DATE('2023-12-01 15:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
21, TO_DATE('2023-12-01 15:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
22, TO_DATE('2023-12-01 16:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
23, TO_DATE('2023-12-01 16:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
24, TO_DATE('2023-12-01 17:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
25, TO_DATE('2023-12-01 17:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
26, TO_DATE('2023-12-01 18:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
27, TO_DATE('2023-12-01 18:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
28, TO_DATE('2023-12-01 19:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
29, TO_DATE('2023-12-01 19:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
30, TO_DATE('2023-12-01 20:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'

LOAD DATA
INFILE *
APPEND
INTO TABLE reduction
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(nom_reduction, reduction, date_debut DATE "YYYY-MM-DD", date_fin DATE "YYYY-MM-DD")
BEGIN DATA
'normal', 0, DATE '2021-01-01', NULL
'enfant', 0.5, DATE '2021-01-01', NULL
'étudiant', 0.1, DATE '2021-01-01', NULL
'senior', 0.05, DATE '2021-01-01', NULL

LOAD DATA
INFILE *
APPEND
INTO TABLE billet
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(id_billet, id_parc, id_commande, date_debut_validite DATE "YYYY-MM-DD", date_fin_validite DATE "YYYY-MM-DD", tarif, reduction, scanne)
BEGIN DATA
1, 1, 12, DATE '2023-12-01', DATE '2023-12-01', 'journalier', 'normal', 0
2, 2, 17, DATE '2023-12-05', DATE '2023-12-06', '2 jours', 'étudiant', 0
3, 3, 21, DATE '2023-12-10', DATE '2023-12-10', 'noel', 'normal', 0
4, 4, 4, DATE '2023-12-03', DATE '2023-12-03', 'journalier', 'senior', 1
71, 1, 30, DATE '2023-12-15', DATE '2023-12-15', 'nocturne', 'normal', 0
5, 1, 30, DATE '2023-12-15', DATE '2023-12-15', 'nocturne', 'enfant', 0
6, 2, 43, DATE '2023-12-25', DATE '2023-12-26', 'annuel', 'étudiant', 0
7, 3, 8, DATE '2023-12-01', DATE '2023-12-01', 'journalier', 'normal', 0
78, 3, 8, DATE '2022-12-01', DATE '2022-12-01', 'journalier', 'normal', 1
8, 4, 10, DATE '2023-12-04', DATE '2023-12-05', '2 jours', 'normal', 1
9, 1, 14, DATE '2023-12-10', DATE '2023-12-10', 'noel', 'senior', 0
10, 2, 20, DATE '2023-12-03', DATE '2023-12-03', 'journalier', 'normal', 0
11, 3, 29, DATE '2023-12-20', DATE '2023-12-20', 'nocturne', 'normal', 0
12, 4, 1, DATE '2023-12-18', DATE '2023-12-19', 'annuel', 'étudiant', 1
13, 1, 7, DATE '2023-12-11', DATE '2023-12-11', 'journalier', 'senior', 0
14, 2, 13, DATE '2023-12-22', DATE '2023-12-23', '2 jours', 'normal', 1
15, 3, 28, DATE '2023-12-25', DATE '2023-12-25', 'noel', 'normal', 0
72, 4, 42, DATE '2023-12-30', DATE '2023-12-30', 'journalier', 'étudiant', 0
16, 4, 42, DATE '2023-12-30', DATE '2023-12-30', 'journalier', 'enfant', 0
17, 1, 35, DATE '2023-12-15', DATE '2023-12-15', 'nocturne', 'étudiant', 1
18, 2, 6, DATE '2023-12-12', DATE '2023-12-13', 'annuel', 'normal', 0
19, 3, 19, DATE '2023-12-01', DATE '2023-12-01', 'journalier', 'normal', 0
20, 4, 15, DATE '2023-12-05', DATE '2023-12-05', '2 jours', 'normal', 0
79, 1, 25, DATE '2023-12-07', DATE '2023-12-07', 'noel', 'normal', 0
21, 1, 25, DATE '2023-12-07', DATE '2023-12-07', 'noel', 'enfant', 0
22, 2, 33, DATE '2023-12-20', DATE '2023-12-20', 'journalier', 'étudiant', 0
23, 3, 3, DATE '2023-12-23', DATE '2023-12-23', 'nocturne', 'normal', 1
24, 4, 22, DATE '2023-12-29', DATE '2023-12-30', 'annuel', 'normal', 0
25, 1, 38, DATE '2023-12-06', DATE '2023-12-06', 'journalier', 'senior', 0
26, 2, 10, DATE '2023-12-12', DATE '2023-12-13', '2 jours', 'normal', 0
27, 3, 47, DATE '2023-12-18', DATE '2023-12-18', 'noel', 'étudiant', 1
73, 4, 32, DATE '2023-12-22', DATE '2023-12-22', 'journalier', 'étudiant', 0
28, 4, 32, DATE '2023-12-22', DATE '2023-12-22', 'journalier', 'enfant', 0
29, 1, 2, DATE '2023-12-27', DATE '2023-12-27', 'nocturne', 'normal', 0
30, 2, 40, DATE '2023-12-29', DATE '2023-12-30', 'annuel', 'normal', 1
31, 3, 48, DATE '2023-12-01', DATE '2023-12-01', 'journalier', 'normal', 0
32, 4, 5, DATE '2023-12-07', DATE '2023-12-07', '2 jours', 'normal', 0
33, 1, 13, DATE '2023-12-15', DATE '2023-12-15', 'noel', 'senior', 1
34, 2, 37, DATE '2023-12-22', DATE '2023-12-22', 'journalier', 'normal', 0
35, 3, 9, DATE '2023-12-30', DATE '2023-12-30', 'nocturne', 'normal', 0
74, 4, 16, DATE '2023-12-03', DATE '2023-12-03', 'journalier', 'normal', 0
36, 4, 16, DATE '2023-12-03', DATE '2023-12-03', 'annuel', 'enfant', 1
37, 1, 20, DATE '2023-12-10', DATE '2023-12-11', '2 jours', 'étudiant', 0
38, 2, 24, DATE '2023-12-18', DATE '2023-12-18', 'noel', 'normal', 0
39, 3, 11, DATE '2023-12-28', DATE '2023-12-28', 'journalier', 'normal', 0
40, 4, 41, DATE '2023-12-04', DATE '2023-12-04', 'nocturne', 'normal', 1
41, 1, 18, DATE '2023-12-07', DATE '2023-12-07', 'annuel', 'senior', 0
42, 2, 28, DATE '2023-12-14', DATE '2023-12-14', 'journalier', 'normal', 0
43, 3, 19, DATE '2023-12-01', DATE '2023-12-02', '2 jours', 'normal', 1
44, 4, 8, DATE '2023-12-09', DATE '2023-12-10', 'noel', 'étudiant', 0
45, 1, 26, DATE '2023-12-13', DATE '2023-12-13', 'journalier', 'senior', 0
80, 2, 44, DATE '2023-12-20', DATE '2023-12-20', 'nocturne', 'normal', 0
46, 3, 44, DATE '2023-12-20', DATE '2023-12-20', 'nocturne', 'enfant', 0
47, 4, 15, DATE '2023-12-26', DATE '2023-12-27', 'annuel', 'normal', 1
48, 1, 2, DATE '2023-12-06', DATE '2023-12-07', '2 jours', 'normal', 0
49, 2, 12, DATE '2023-12-15', DATE '2023-12-15', 'journalier', 'senior', 0
50, 3, 39, DATE '2023-12-29', DATE '2023-12-29', 'noel', 'étudiant', 1
51, 4, 31, DATE '2023-12-22', DATE '2023-12-22', 'journalier', 'normal', 0
75, 1, 23, DATE '2023-12-01', DATE '2023-12-02', '2 jours', 'étudiant', 0
52, 1, 23, DATE '2023-12-01', DATE '2023-12-02', '2 jours', 'enfant', 0
53, 2, 48, DATE '2023-12-10', DATE '2023-12-10', 'noel', 'normal', 1
54, 3, 33, DATE '2023-12-20', DATE '2023-12-20', 'journalier', 'senior', 0
55, 4, 6, DATE '2023-12-30', DATE '2023-12-30', 'nocturne', 'normal', 0
56, 1, 5, DATE '2023-12-18', DATE '2023-12-18', 'annuel', 'normal', 1
57, 2, 14, DATE '2023-12-02', DATE '2023-12-03', '2 jours', 'normal', 0
58, 3, 27, DATE '2023-12-07', DATE '2023-12-07', 'journalier', 'senior', 0
59, 4, 45, DATE '2023-12-14', DATE '2023-12-14', 'noel', 'normal', 0
60, 1, 35, DATE '2023-12-29', DATE '2023-12-29', 'journalier', 'normal', 0
61, 2, 25, DATE '2023-12-01', DATE '2023-12-02', '2 jours', 'étudiant', 0
76, 3, 30, DATE '2023-12-10', DATE '2023-12-11', 'nocturne', 'normal', 0
62, 3, 30, DATE '2023-12-10', DATE '2023-12-11', 'nocturne', 'enfant', 0
63, 4, 40, DATE '2023-12-18', DATE '2023-12-18', 'annuel', 'senior', 1
64, 1, 9, DATE '2023-12-07', DATE '2023-12-07', 'journalier', 'normal', 0
65, 2, 37, DATE '2023-12-25', DATE '2023-12-25', 'noel', 'normal', 0
66, 3, 41, DATE '2023-12-22', DATE '2023-12-23', '2 jours', 'normal', 0
67, 4, 46, DATE '2023-12-04', DATE '2023-12-04', 'journalier', 'senior', 1
68, 1, 3, DATE '2023-12-15', DATE '2023-12-15', 'nocturne', 'normal', 0
69, 2, 10, DATE '2023-12-19', DATE '2023-12-19', 'annuel', 'étudiant', 0
77, 3, 20, DATE '2023-12-30', DATE '2023-12-30', 'journalier', 'normal', 0
70, 3, 20, DATE '2023-12-30', DATE '2023-12-30', 'journalier', 'enfant', 0
81, 4, 34, DATE '2023-12-01', DATE '2023-12-02', '2 jours', 'normal', 1
82, 4, 36, DATE '2023-12-01', DATE '2023-12-02', '2 jours', 'étudiant', 1
83, 4, 49, DATE '2023-12-01', DATE '2023-12-02', '2 jours', 'senior', 1
84, 4, 50, DATE '2023-12-01', DATE '2023-12-02', 'journalier', 'étudiant', 1
85, 4, 50, DATE '2023-12-01', DATE '2023-12-02', 'journalier', 'enfant', 1
86, 4, 50, DATE '2023-12-01', DATE '2023-12-02', 'journalier', 'senior', 1
87, 4, 50, DATE '2023-12-01', DATE '2023-12-02', 'journalier', 'normal', 1
88, 4, 50, DATE '2023-12-01', DATE '2023-12-02', 'journalier', 'normal', 1
89, 4, 50, DATE '2023-12-01', DATE '2023-12-02', 'journalier', 'normal', 1
90, 4, 50, DATE '2023-12-01', DATE '2023-12-02', 'journalier', 'normal', 1
91, 4, 50, DATE '2023-12-01', DATE '2023-12-02', 'journalier', 'normal', 1

