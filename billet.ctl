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
