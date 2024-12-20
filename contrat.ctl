LOAD DATA
INFILE *
APPEND
INTO TABLE contrat
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(id_contrat, numero_de_securite_sociale, date_debut DATE, date_fin DATE, metier, salaire, type)
BEGIN DATA
1, 100000001, DATE '2022-01-01', SYSDATE + INTERVAL '2' MONTH, 'Technicien', 2500, 'CDI'
2, 100000002, DATE '2021-05-01', DATE '2023-05-01', 'Manager', 3500, 'CDD'
3, 100000003, DATE '2020-09-01', SYSDATE + INTERVAL '1' MONTH, 'Agent d''entretien', 1800, 'CDI'
4, 100000004, DATE '2022-06-15', DATE '2023-06-15', 'Responsable attraction', 3200, 'Stage'
5, 100000005, DATE '2023-02-01', NULL, 'Administrateur', 4000, 'Alternance'
6, 100000006, DATE '2021-09-01', DATE '2022-09-01', 'Technicien', 2700, 'CDD'
7, 100000007, DATE '2023-03-01', NULL, 'Manager', 3600, 'CDI'
8, 100000008, DATE '2020-07-01', DATE '2023-07-01', 'Agent d''entretien', 1900, 'CDD'
9, 100000009, DATE '2022-05-01', NULL, 'Responsable attraction', 3400, 'CDI'
10, 100000010, DATE '2023-01-15', DATE '2023-12-31', 'Administrateur', 4100, 'Stage'
11, 100000011, DATE '2021-11-01', DATE '2022-11-01', 'Technicien', 2600, 'CDD'
12, 100000012, DATE '2022-10-01', DATE '2024-10-01', 'Manager', 3700, 'CDI'
13, 100000013, DATE '2021-06-15', DATE '2023-06-15', 'Agent d''entretien', 2000, 'CDD'
14, 100000014, DATE '2022-03-01', DATE '2022-12-31', 'Responsable attraction', 3300, 'Stage'
15, 100000015, DATE '2020-09-01', NULL, 'Administrateur', 4200, 'Alternance'
16, 100000016, DATE '2023-02-01', DATE '2024-02-01', 'Technicien', 2800, 'CDI'
17, 100000017, DATE '2022-01-01', DATE '2023-01-01', 'Manager', 3800, 'CDD'
18, 100000018, DATE '2021-08-01', NULL, 'Agent d''entretien', 2100, 'CDI'
19, 100000019, DATE '2022-11-01', DATE '2024-11-01', 'Responsable attraction', 3500, 'CDD'
20, 100000020, DATE '2020-04-01', DATE '2022-04-01', 'Administrateur', 4300, 'CDI'
21, 100000021, DATE '2021-10-01', DATE '2022-10-01', 'Technicien', 2400, 'CDD'
22, 100000022, DATE '2022-06-01', DATE '2024-06-01', 'Manager', 3900, 'Alternance'
23, 100000023, DATE '2020-12-01', DATE '2023-12-01', 'Agent d''entretien', 2200, 'CDI'
24, 100000024, DATE '2021-07-01', DATE '2022-07-01', 'Responsable attraction', 3100, 'Stage'
25, 100000025, DATE '2022-03-01', NULL, 'Administrateur', 4400, 'CDI'
26, 100000026, DATE '2023-01-15', DATE '2023-12-15', 'Technicien', 2900, 'CDD'
27, 100000027, DATE '2020-09-01', DATE '2022-09-01', 'Manager', 4000, 'CDI'
28, 100000028, DATE '2021-11-01', DATE '2023-11-01', 'Agent d''entretien', 2300, 'CDD'
29, 100000029, DATE '2022-02-01', DATE '2024-02-01', 'Responsable attraction', 3600, 'Alternance'
30, 100000030, DATE '2021-08-01', NULL, 'Administrateur', 4500, 'CDI'
31, 100000031, DATE '2022-03-01', DATE '2024-03-01', 'Technicien', 2500, 'CDI'
32, 100000032, DATE '2023-01-15', NULL, 'Responsable attraction', 3200, 'Alternance'
33, 100000033, DATE '2022-06-01', DATE '2023-06-01', 'Manager', 3500, 'CDD'
34, 100000034, DATE '2021-09-01', DATE '2023-09-01', 'Agent d''entretien', 2000, 'CDD'
35, 100000035, DATE '2022-11-01', DATE '2024-11-01', 'Administrateur', 4000, 'CDI'
36, 100000036, DATE '2020-07-01', DATE '2022-07-01', 'Technicien', 2800, 'CDD'
37, 100000037, DATE '2023-05-01', NULL, 'Responsable attraction', 3300, 'CDI'
38, 100000038, DATE '2021-08-15', DATE '2023-08-15', 'Manager', 3700, 'CDD'
39, 100000039, DATE '2022-12-01', DATE '2023-12-01', 'Agent d''entretien', 2200, 'Alternance'
40, 100000040, DATE '2020-04-01', NULL, 'Administrateur', 4500, 'CDI'
41, 100000041, DATE '2023-02-01', DATE '2024-02-01', 'Technicien', 2700, 'CDD'
42, 100000042, DATE '2022-09-01', DATE '2023-09-01', 'Responsable attraction', 3600, 'CDD'
43, 100000043, DATE '2021-03-01', NULL, 'Manager', 3900, 'CDI'
