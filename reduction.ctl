LOAD DATA
INFILE *
APPEND
INTO TABLE reduction
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    nom_reduction,
    reduction "TO_NUMBER(:reduction, '9999D99', 'NLS_NUMERIC_CHARACTERS=''.,''')",
    date_debut DATE "YYYY-MM-DD",
    date_fin DATE "YYYY-MM-DD"
)
BEGINDATA
"normal", 0, 2021-01-01,
"enfant", 0.5, 2021-01-01,
"étudiant", 0.1, 2021-01-01,
"senior", 0.05, 2021-01-01,