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
