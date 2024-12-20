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