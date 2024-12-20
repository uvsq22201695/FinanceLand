LOAD DATA
INFILE *
APPEND
INTO TABLE parc
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(id_parc, nom, date_ouverture DATE "YYYY-MM-DD", superficie, pays, ville)
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