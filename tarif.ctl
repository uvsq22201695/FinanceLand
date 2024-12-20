LOAD DATA
INFILE *
APPEND
INTO TABLE tarif
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(nom_tarif, prix, duree_en_jour, date_debut DATE "YYYY-MM-DD", date_fin DATE "YYYY-MM-DD")
BEGINDATA
"journalier", 50, 1, 2021-01-01,
"2 jours", 80, 2, 2021-01-01,
"annuel", 500, 365, 2021-01-01,
"nocturne", 30, 1, 2021-01-01,
"noel", 60, 1, 2020-11-15, 2021-12-31