LOAD DATA
CHARACTERSET UTF8
INFILE *
APPEND
INTO TABLE contrat
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    id_contrat,
    numero_de_securite_sociale,
    date_debut DATE "YYYY-MM-DD",
    date_fin "CASE WHEN :date_fin = 'TMP' THEN SYSDATE + INTERVAL '2' MONTH ELSE TO_DATE(:date_fin, 'YYYY-MM-DD') END",
    metier,
    salaire,
    type
)
BEGINDATA
1,100000001,2022-01-01, "TMP", "Technicien", 2500, "CDI"
2,100000002,2021-05-01,2023-05-01, "Manager", 3500, "CDD"
3,100000003,2020-09-01, "TMP", "Agent d'entretien", 1800, "CDI"
4,100000004,2022-06-15,2023-06-15, "Responsable attraction", 3200, "Stage"
5,100000005,2023-02-01,, "Administrateur", 4000, "Alternance"
6,100000006,2021-09-01,2022-09-01, "Technicien", 2700, "CDD"
7,100000007,2023-03-01,, "Manager", 3600, "CDI"
8,100000008,2020-07-01,2023-07-01, "Agent d'entretien", 1900, "CDD"
9,100000009,2022-05-01,, "Responsable attraction", 3400, "CDI"
10,100000010,2023-01-15,2023-12-31, "Administrateur", 4100, "Stage"
11,100000011,2021-11-01,2022-11-01, "Technicien", 2600, "CDD"
12,100000012,2022-10-01,2024-10-01, "Manager", 3700, "CDI"
13,100000013,2021-06-15,2023-06-15, "Agent d'entretien", 2000, "CDD"
14,100000014,2022-03-01,2022-12-31, "Responsable attraction", 3300, "Stage"
15,100000015,2020-09-01,, "Administrateur", 4200, "Alternance"
16,100000016,2023-02-01,2024-02-01, "Technicien", 2800, "CDI"
17,100000017,2022-01-01,2023-01-01, "Manager", 3800, "CDD"
18,100000018,2021-08-01,, "Agent d'entretien", 2100, "CDI"
19,100000019,2022-11-01,2024-11-01, "Responsable attraction", 3500, "CDD"
20,100000020,2020-04-01,2022-04-01, "Administrateur", 4300, "CDI"
21,100000021,2021-10-01,2022-10-01, "Technicien", 2400, "CDD"
22,100000022,2022-06-01,2024-06-01, "Manager", 3900, "Alternance"
23,100000023,2020-12-01,2023-12-01, "Agent d'entretien", 2200, "CDI"
24,100000024,2021-07-01,2022-07-01, "Responsable attraction", 3100, "Stage"
25,100000025,2022-03-01,, "Administrateur", 4400, "CDI"
26,100000026,2023-01-15,2023-12-15, "Technicien", 2900, "CDD"
27,100000027,2020-09-01,2022-09-01, "Manager", 4000, "CDI"
28,100000028,2021-11-01,2023-11-01, "Agent d'entretien", 2300, "CDD"
29,100000029,2022-02-01,2024-02-01, "Responsable attraction", 3600, "Alternance"
30,100000030,2021-08-01,, "Administrateur", 4500, "CDI"
31,100000031,2022-03-01,2024-03-01, "Technicien", 2500, "CDI"
32,100000032,2023-01-15,, "Responsable attraction", 3200, "Alternance"
33,100000033,2022-06-01,2023-06-01, "Manager", 3500, "CDD"
34,100000034,2021-09-01,2023-09-01, "Agent d'entretien", 2000, "CDD"
35,100000035,2022-11-01,2024-11-01, "Administrateur", 4000, "CDI"
36,100000036,2020-07-01,2022-07-01, "Technicien", 2800, "CDD"
37,100000037,2023-05-01,, "Responsable attraction", 3300, "CDI"
38,100000038,2021-08-15,2023-08-15, "Manager", 3700, "CDD"
39,100000039,2022-12-01,2023-12-01, "Agent d'entretien", 2200, "Alternance"
40,100000040,2020-04-01,, "Administrateur", 4500, "CDI"
41,100000041,2023-02-01,2024-02-01, "Technicien", 2700, "CDD"
42,100000042,2022-09-01,2023-09-01, "Responsable attraction", 3600, "CDD"
43,100000043,2021-03-01,, "Manager", 3900, "CDI"