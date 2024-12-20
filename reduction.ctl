LOAD DATA
INFILE *
APPEND
INTO TABLE reduction
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(nom_reduction, reduction, date_debut DATE "YYYY-MM-DD", date_fin DATE "YYYY-MM-DD")
BEGIN DATA
"normal", 0, DATE '2021-01-01', NULL
"enfant", 0.5, DATE '2021-01-01', NULL
"étudiant", 0.1, DATE '2021-01-01', NULL
"senior", 0.05, DATE '2021-01-01', NULL