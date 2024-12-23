LOAD DATA
CHARACTERSET UTF8
INFILE *
APPEND
INTO TABLE travaux
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(
  id_travaux,
  id_attraction,
  date_debut "CASE WHEN :date_debut = 'DYN' THEN TRUNC(SYSDATE, 'YEAR') - INTERVAL '5' MONTH ELSE TO_DATE(:date_debut, 'YYYY-MM-DD') END",
  date_fin "CASE WHEN :date_fin = 'DYN' THEN TRUNC(SYSDATE, 'YEAR') - INTERVAL '3' MONTH ELSE TO_DATE(:date_fin, 'YYYY-MM-DD') END",
  description,
  cout,
  etat,
  reparateur
)
BEGINDATA
1, 1, 2021-01-01, 2021-01-15, "Maintenance annuelle", 10000, "terminé", "Reparator 3000"
2, 2, 2021-01-01, 2021-01-15, "Maintenance annuelle", 10000, "terminé", "Attraction Comme Neuves INC"
3, 3, 2021-01-01, 2021-01-15, "Rethématisation", 10000, "terminé", "DecoraMax"
4, 4, 2021-01-01, 2021-01-15, "Maintenance annuelle", 10000, "terminé", "Reparator 3000"
5, 5, 2021-01-01, 2021-01-15, "Maintenance annuelle", 10000, "terminé", "Attraction Comme Neuves INC"
6, 6, 2021-01-01, 2021-01-15, "Rethématisation", 10000, "terminé", "DecoraMax"
7, 7, 2021-01-01, 2021-01-15, "Maintenance annuelle", 10000, "terminé", "Reparator 3000"
8, 1, 2021-02-01, 2021-02-10, "Révision matérielle", 12000, "terminé", "FixIt Fast"
9, 2, 2021-03-01, 2021-03-15, "Maintenance annuelle", 8000, "terminé", "Reparator 3000"
10, 3, 2021-04-05, 2021-04-20, "Test de sécurité", 15000, "terminé", "SafeCheck Pro"
11, 4, 2021-05-01, 2021-05-10, "Réparation urgente", 20000, "terminé", "RepairHub"
12, 5, 2021-06-01, 2021-06-12, "Amélioration technique", 18000, "terminé", "TechnoPatch"
13, 6, 2021-07-10, 2021-07-25, "Maintenance annuelle", 10000, "prévu", "FixIt Fast"
14, 7, 2021-08-01, 2021-08-20, "Test de sécurité", 16000, "terminé", "SafeCheck Pro"
15, 8, 2021-09-01, 2021-09-15, "Révision matérielle", 14000, "terminé", "Reparator 3000"
16, 9, 2021-10-01, 2021-10-20, "Réparation urgente", 22000, "terminé", "RepairHub"
17, 10, 2021-11-01, 2021-11-15, "Amélioration technique", 17000, "terminé", "TechnoPatch"
18, 11, 2021-12-01, 2021-12-10, "Maintenance annuelle", 12000, "terminé", "FixIt Fast"
19, 12, 2021-02-15, 2021-03-01, "Réparation urgente", 25000, "terminé", "RepairHub"
20, 13, 2021-03-10, 2021-03-25, "Test de sécurité", 20000, "terminé", "SafeCheck Pro"
21, 14, 2021-04-15, 2021-05-05, "Amélioration technique", 30000, "prévu", "TechnoPatch"
22, 15, 2021-05-10, 2021-05-25, "Maintenance annuelle", 9000, "terminé", "Reparator 3000"
23, 16, 2021-06-15, 2021-07-01, "Réparation urgente", 24000, "terminé", "FixIt Fast"
24, 17, 2021-07-20, 2021-08-10, "Révision matérielle", 15000, "terminé", "RepairHub"
25, 18, 2021-08-25, 2021-09-10, "Test de sécurité", 12000, "terminé", "SafeCheck Pro"
26, 19, 2021-10-01, 2021-10-15, "Amélioration technique", 21000, "terminé", "TechnoPatch"
27, 20, 2021-11-10, 2021-11-25, "Maintenance annuelle", 10000, "prévu", "Reparator 3000"
28, 21, 2021-01-10, 2021-01-20, "Test de sécurité", 13000, "terminé", "SafeCheck Pro"
29, 22, 2021-02-05, 2021-02-15, "Révision matérielle", 17000, "terminé", "Reparator 3000"
30, 23, 2021-03-05, 2021-03-18, "Maintenance annuelle", 12000, "terminé", "FixIt Fast"
31, 24, 2021-04-05, 2021-04-15, "Réparation urgente", 25000, "prévu", "RepairHub"
32, 25, 2021-05-10, 2021-05-20, "Amélioration technique", 30000, "terminé", "TechnoPatch"
33, 26, 2021-06-15, 2021-06-25, "Test de sécurité", 22000, "terminé", "SafeCheck Pro"
34, 27, 2021-07-01, 2021-07-10, "Maintenance annuelle", 15000, "terminé", "Reparator 3000"
35, 28, 2021-08-05, 2021-08-15, "Révision matérielle", 16000, "terminé", "FixIt Fast"
36, 29, 2021-09-10, 2021-09-20, "Maintenance annuelle", 18000, "terminé", "RepairHub"
37, 30, 2021-10-05, 2021-10-15, "Test de sécurité", 25000, "terminé", "SafeCheck Pro"
38, 31, 2021-11-15, 2021-11-25, "Réparation urgente", 26000, "prévu", "RepairHub"
39, 32, 2021-12-01, 2021-12-12, "Maintenance annuelle", 14000, "terminé", "TechnoPatch"
40, 33, 2021-01-05, 2021-01-15, "Révision matérielle", 16000, "terminé", "FixIt Fast"
41, 34, 2021-02-10, 2021-02-20, "Test de sécurité", 18000, "terminé", "SafeCheck Pro"
42, 1, 2023-01-10, 2023-01-20, "Inspection de sécurité", 12000, "terminé", "SafeCheck Pro"
43, 1, 2024-05-15, 2025-06-01, "Réparation majeure", 35000, "en cours", "RepairHub"
44, 2, 2023-03-01, 2023-03-15, "Amélioration technique", 20000, "terminé", "TechnoPatch"
45, 2, 2024-07-10, 2024-07-25, "Maintenance annuelle", 15000, "prévu", "FixIt Fast"
46, 3, 2024-02-20, 2024-03-05, "Révision matérielle", 14000, "terminé", "Reparator 3000"
47, 3, 2023-11-01, 2023-11-20, "Test de sécurité", 16000, "terminé", "SafeCheck Pro"
48, 4, 2023-06-01, 2023-06-15, "Réparation urgente", 25000, "terminé", "RepairHub"
49, 4, 2024-09-01, 2025-09-15, "Amélioration technique", 28000, "en cours", "TechnoPatch"
50, 5, 2023-08-01, 2023-08-10, "Maintenance annuelle", 10000, "terminé", "Reparator 3000"
51, 5, 2024-10-15, 2024-10-30, "Inspection de sécurité", 12000, "prévu", "SafeCheck Pro"
52, 6, 2023-05-01, 2023-05-10, "Révision matérielle", 11000, "terminé", "FixIt Fast"
53, 6, 2024-11-01, 2025-11-10, "Réparation urgente", 18000, "en cours", "RepairHub"
54, 7, 2023-04-15, 2023-04-30, "Test de sécurité", 15000, "terminé", "SafeCheck Pro"
55, 7, 2024-12-01, 2024-12-15, "Amélioration technique", 22000, "prévu", "TechnoPatch"
56, 8, 2023-09-01, 2023-09-10, "Maintenance annuelle", 9000, "terminé", "Reparator 3000"
57, 8, 2024-03-01, 2024-03-15, "Révision matérielle", 14000, "terminé", "FixIt Fast"
58, 9, 2023-02-01, 2023-02-10, "Réparation urgente", 30000, "terminé", "RepairHub"
59, 9, 2024-04-10, 2024-04-20, "Test de sécurité", 16000, "terminé", "SafeCheck Pro"
60, 10, 2023-12-01, 2023-12-10, "Amélioration technique", 25000, "prévu", "TechnoPatch"
61, 10, 2024-06-10, 2024-06-20, "Maintenance annuelle", 12000, "terminé", "Reparator 3000"
62, 1, DYN, DYN, "Révision annuelle", 15000, "terminé", "FixIt Fast"
63, 1, DYN, DYN, "Test de sécurité", 12000, "terminé", "SafeCheck Pro"
64, 5, DYN, DYN, "Maintenance préventive", 18000, "terminé", "RepairHub"
65, 5, DYN, DYN, "Amélioration technique", 20000, "terminé", "TechnoPatch"