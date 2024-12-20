
LOAD DATA
INFILE *
APPEND
INTO TABLE tourniquet
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(id_attraction, heure, entree_ou_sortie)
BEGIN DATA
1, TO_DATE('2023-12-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
1, TO_DATE('2023-12-01 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie'
1, TO_DATE('2023-12-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
1, TO_DATE('2023-12-01 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie'
2, TO_DATE('2023-12-01 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
4, TO_DATE('2023-12-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
4, TO_DATE('2023-12-01 12:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie'
5, TO_DATE('2023-12-01 09:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
5, TO_DATE('2023-12-01 09:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie'
5, TO_DATE('2023-12-01 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
5, TO_DATE('2023-12-01 10:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie'
5, TO_DATE('2023-12-01 11:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
7, TO_DATE('2023-12-01 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
7, TO_DATE('2023-12-01 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie'
8, TO_DATE('2023-12-01 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie'
9, TO_DATE('2023-12-01 09:05:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
9, TO_DATE('2023-12-01 09:35:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
9, TO_DATE('2023-12-01 10:05:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
9, TO_DATE('2023-12-01 10:35:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
10, TO_DATE('2023-12-01 09:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
10, TO_DATE('2023-12-01 09:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie'
11, TO_DATE('2023-12-01 10:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
12, TO_DATE('2023-12-01 10:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
12, TO_DATE('2023-12-01 11:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie'
13, TO_DATE('2023-12-01 11:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
14, TO_DATE('2023-12-01 12:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
15, TO_DATE('2023-12-01 12:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
16, TO_DATE('2023-12-01 13:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
17, TO_DATE('2023-12-01 13:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
18, TO_DATE('2023-12-01 14:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
19, TO_DATE('2023-12-01 14:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
20, TO_DATE('2023-12-01 15:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
21, TO_DATE('2023-12-01 15:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
22, TO_DATE('2023-12-01 16:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
23, TO_DATE('2023-12-01 16:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
24, TO_DATE('2023-12-01 17:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
25, TO_DATE('2023-12-01 17:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
26, TO_DATE('2023-12-01 18:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
27, TO_DATE('2023-12-01 18:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
28, TO_DATE('2023-12-01 19:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
29, TO_DATE('2023-12-01 19:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'
30, TO_DATE('2023-12-01 20:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée'