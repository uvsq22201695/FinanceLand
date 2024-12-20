LOAD DATA
INFILE *
APPEND
INTO TABLE client
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(id_client, email, nom, prenom, date_naissance DATE "YYYY-MM-DD", adresse, telephone, ville, pays)
BEGIN DATA
1, 'john.doe@example.com', 'Doe', 'John', '123 Main Street', '555-0101', 'Springfield', 'USA'
2, 'jane.smith@example.com', 'Smith', 'Jane', '456 Elm Street', '555-0202', 'Shelbyville', 'USA'
3, 'emily.johnson@example.com', 'Johnson', 'Emily', '789 Oak Avenue', '555-0303', 'Ogdenville', 'Canada'
4, 'michael.brown@example.com', 'Brown', 'Michael', '321 Pine Lane', '555-0404', 'North Haverbrook', 'USA'
5, 'sarah.davis@example.com', 'Davis', 'Sarah', '654 Maple Boulevard', '555-0505', 'Capital City', 'UK'
6, 'david.wilson@example.com', 'Wilson', 'David', '987 Cedar Road', '555-0606', 'Springfield', 'Australia'
7, 'lisa.taylor@example.com', 'Taylor', 'Lisa', '135 Willow Circle', '555-0707', 'Shelbyville', 'New Zealand'
8, 'paul.martin@example.com', 'Martin', 'Paul', '246 Aspen Court', '555-0808', 'Ogdenville', 'Ireland'
9, 'laura.thomas@example.com', 'Thomas', 'Laura', '357 Birch Way', '555-0909', 'North Haverbrook', 'France'
10, 'james.moore@example.com', 'Moore', 'James', '468 Cherry Street', '555-1010', 'Capital City', 'Germany'
11, 'ana.robin@example.com', 'Robin', 'Ana', '10 Rue Jean Moulin', '0756123487', 'Grenoble', 'France'
12, 'marc.garcia@example.com', 'Garcia', 'Marc', '11 Rue de Provence', '0623456790', 'Dijon', 'France'
13, 'elise.benoit@example.com', 'Benoit', 'Elise', '12 Rue des Carmes', '0645236789', 'Le Havre', 'France'
14, 'nathan.morel@example.com', 'Morel', 'Nathan', '13 Rue du Marché', '0634236789', 'Toulon', 'France'
15, 'ines.bernard@example.com', 'Bernard', 'Ines', '14 Rue Saint-Honoré', '0612234789', 'Saint-Étienne', 'France'
16, 'emilie.martinez@example.com', 'Martinez', 'Emilie', '15 Rue de la République', '0698123456', 'Rennes', 'France'
17, 'mathieu.fabre@example.com', 'Fabre', 'Mathieu', '16 Rue de Metz', '0623456789', 'Aix-en-Provence', 'France'
18, 'lea.clement@example.com', 'Clément', 'Lea', '17 Rue des Peupliers', '0678236789', 'Montpellier', 'France'
19, 'juliette.david@example.com', 'David', 'Juliette', '18 Rue des Acacias', '0654123678', 'Orléans', 'France'
20, 'maxime.renard@example.com', 'Renard', 'Maxime', '19 Avenue de l''Europe', '0687345678', 'Clermont-Ferrand', 'France'
21, 'emilie.dupuis@example.com', 'Dupuis', 'Emilie', '20 Rue des Lilas', '0645123789', 'Nancy', 'France'
22, 'vincent.robert@example.com', 'Robert', 'Vincent', '21 Rue des Tulipes', '0698123478', 'Metz', 'France'
23, 'sophie.lopez@example.com', 'Lopez', 'Sophie', '22 Boulevard Gambetta', '0634234789', 'Tours', 'France'
24, 'lucas.navarro@example.com', 'Navarro', 'Lucas', '23 Rue des Mimosas', '0687345789', 'Angers', 'France'
25, 'melanie.dumont@example.com', 'Dumont', 'Melanie', '24 Avenue Jules Ferry', '0623456897', 'Perpignan', 'France'
26, 'etienne.guillaume@example.com', 'Guillaume', 'Etienne', '25 Rue de Lorraine', '0654123489', 'Limoges', 'France'
27, 'florence.roger@example.com', 'Roger', 'Florence', '26 Rue de l''Abbaye', '0678123467', 'Béziers', 'France'
28, 'quentin.lefevre@example.com', 'Lefevre', 'Quentin', '27 Rue de la Liberté', '0689234789', 'Pau', 'France'
29, 'helene.durieux@example.com', 'Durieux', 'Helene', '28 Rue des Vignes', '0612234689', 'Avignon', 'France'
30, 'thibault.rousseau@example.com', 'Rousseau', 'Thibault', '29 Rue des Marronniers', '0698123467', 'Valence', 'France'

LOAD DATA
INFILE *
APPEND
INTO TABLE travaux
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(id_travaux, id_attraction, date_debut DATE "YYYY-MM-DD", date_fin DATE "YYYY-MM-DD", description, cout, etat, reparateur)
BEGIN DATA
1, 1, DATE '2021-01-01', DATE '2021-01-15', 'Maintenance annuelle', 10000, 'terminé', 'Reparator 3000'
2, 2, DATE '2021-01-01', DATE '2021-01-15', 'Maintenance annuelle', 10000, 'terminé', 'Attraction Comme Neuves INC'
3, 3, DATE '2021-01-01', DATE '2021-01-15', 'Rethématisation', 10000, 'terminé', 'DecoraMax'
4, 4, DATE '2021-01-01', DATE '2021-01-15', 'Maintenance annuelle', 10000, 'terminé', 'Reparator 3000'
5, 5, DATE '2021-01-01', DATE '2021-01-15', 'Maintenance annuelle', 10000, 'terminé', 'Attraction Comme Neuves INC'
6, 6, DATE '2021-01-01', DATE '2021-01-15', 'Rethématisation', 10000, 'terminé', 'DecoraMax'
7, 7, DATE '2021-01-01', DATE '2021-01-15', 'Maintenance annuelle', 10000, 'terminé', 'Reparator 3000'
8, 1, DATE '2021-02-01', DATE '2021-02-10', 'Révision matérielle', 12000, 'terminé', 'FixIt Fast'
9, 2, DATE '2021-03-01', DATE '2021-03-15', 'Maintenance annuelle', 8000, 'terminé', 'Reparator 3000'
10, 3, DATE '2021-04-05', DATE '2021-04-20', 'Test de sécurité', 15000, 'terminé', 'SafeCheck Pro'
11, 4, DATE '2021-05-01', DATE '2021-05-10', 'Réparation urgente', 20000, 'terminé', 'RepairHub'
12, 5, DATE '2021-06-01', DATE '2021-06-12', 'Amélioration technique', 18000, 'terminé', 'TechnoPatch'
13, 6, DATE '2021-07-10', DATE '2021-07-25', 'Maintenance annuelle', 10000, 'prévu', 'FixIt Fast'
14, 7, DATE '2021-08-01', DATE '2021-08-20', 'Test de sécurité', 16000, 'terminé', 'SafeCheck Pro'
15, 8, DATE '2021-09-01', DATE '2021-09-15', 'Révision matérielle', 14000, 'terminé', 'Reparator 3000'
16, 9, DATE '2021-10-01', DATE '2021-10-20', 'Réparation urgente', 22000, 'terminé', 'RepairHub'
17, 10, DATE '2021-11-01', DATE '2021-11-15', 'Amélioration technique', 17000, 'terminé', 'TechnoPatch'
18, 11, DATE '2021-12-01', DATE '2021-12-10', 'Maintenance annuelle', 12000, 'terminé', 'FixIt Fast'
19, 12, DATE '2021-02-15', DATE '2021-03-01', 'Réparation urgente', 25000, 'terminé', 'RepairHub'
20, 13, DATE '2021-03-10', DATE '2021-03-25', 'Test de sécurité', 20000, 'terminé', 'SafeCheck Pro'
21, 14, DATE '2021-04-15', DATE '2021-05-05', 'Amélioration technique', 30000, 'prévu', 'TechnoPatch'
22, 15, DATE '2021-05-10', DATE '2021-05-25', 'Maintenance annuelle', 9000, 'terminé', 'Reparator 3000'
23, 16, DATE '2021-06-15', DATE '2021-07-01', 'Réparation urgente', 24000, 'terminé', 'FixIt Fast'
24, 17, DATE '2021-07-20', DATE '2021-08-10', 'Révision matérielle', 15000, 'terminé', 'RepairHub'
25, 18, DATE '2021-08-25', DATE '2021-09-10', 'Test de sécurité', 12000, 'terminé', 'SafeCheck Pro'
26, 19, DATE '2021-10-01', DATE '2021-10-15', 'Amélioration technique', 21000, 'terminé', 'TechnoPatch'
27, 20, DATE '2021-11-10', DATE '2021-11-25', 'Maintenance annuelle', 10000, 'prévu', 'Reparator 3000'
28, 21, DATE '2021-01-10', DATE '2021-01-20', 'Test de sécurité', 13000, 'terminé', 'SafeCheck Pro'
29, 22, DATE '2021-02-05', DATE '2021-02-15', 'Révision matérielle', 17000, 'terminé', 'Reparator 3000'
30, 23, DATE '2021-03-05', DATE '2021-03-18', 'Maintenance annuelle', 12000, 'terminé', 'FixIt Fast'
31, 24, DATE '2021-04-05', DATE '2021-04-15', 'Réparation urgente', 25000, 'prévu', 'RepairHub'
32, 25, DATE '2021-05-10', DATE '2021-05-20', 'Amélioration technique', 30000, 'terminé', 'TechnoPatch'
33, 26, DATE '2021-06-15', DATE '2021-06-25', 'Test de sécurité', 22000, 'terminé', 'SafeCheck Pro'
34, 27, DATE '2021-07-01', DATE '2021-07-10', 'Maintenance annuelle', 15000, 'terminé', 'Reparator 3000'
35, 28, DATE '2021-08-05', DATE '2021-08-15', 'Révision matérielle', 16000, 'terminé', 'FixIt Fast'
36, 29, DATE '2021-09-10', DATE '2021-09-20', 'Maintenance annuelle', 18000, 'terminé', 'RepairHub'
37, 30, DATE '2021-10-05', DATE '2021-10-15', 'Test de sécurité', 25000, 'terminé', 'SafeCheck Pro'
38, 31, DATE '2021-11-15', DATE '2021-11-25', 'Réparation urgente', 26000, 'prévu', 'RepairHub'
39, 32, DATE '2021-12-01', DATE '2021-12-12', 'Maintenance annuelle', 14000, 'terminé', 'TechnoPatch'
40, 33, DATE '2021-01-05', DATE '2021-01-15', 'Révision matérielle', 16000, 'terminé', 'FixIt Fast'
41, 34, DATE '2021-02-10', DATE '2021-02-20', 'Test de sécurité', 18000, 'terminé', 'SafeCheck Pro'
42, 1, DATE '2023-01-10', DATE '2023-01-20', 'Inspection de sécurité', 12000, 'terminé', 'SafeCheck Pro'
43, 1, DATE '2024-05-15', DATE '2025-06-01', 'Réparation majeure', 35000, 'en cours', 'RepairHub'
44, 2, DATE '2023-03-01', DATE '2023-03-15', 'Amélioration technique', 20000, 'terminé', 'TechnoPatch'
45, 2, DATE '2024-07-10', DATE '2024-07-25', 'Maintenance annuelle', 15000, 'prévu', 'FixIt Fast'
46, 3, DATE '2024-02-20', DATE '2024-03-05', 'Révision matérielle', 14000, 'terminé', 'Reparator 3000'
47, 3, DATE '2023-11-01', DATE '2023-11-20', 'Test de sécurité', 16000, 'terminé', 'SafeCheck Pro'
48, 4, DATE '2023-06-01', DATE '2023-06-15', 'Réparation urgente', 25000, 'terminé', 'RepairHub'
49, 4, DATE '2024-09-01', DATE '2025-09-15', 'Amélioration technique', 28000, 'en cours', 'TechnoPatch'
50, 5, DATE '2023-08-01', DATE '2023-08-10', 'Maintenance annuelle', 10000, 'terminé', 'Reparator 3000'
51, 5, DATE '2024-10-15', DATE '2024-10-30', 'Inspection de sécurité', 12000, 'prévu', 'SafeCheck Pro'
52, 6, DATE '2023-05-01', DATE '2023-05-10', 'Révision matérielle', 11000, 'terminé', 'FixIt Fast'
53, 6, DATE '2024-11-01', DATE '2025-11-10', 'Réparation urgente', 18000, 'en cours', 'RepairHub'
54, 7, DATE '2023-04-15', DATE '2023-04-30', 'Test de sécurité', 15000, 'terminé', 'SafeCheck Pro'
55, 7, DATE '2024-12-01', DATE '2024-12-15', 'Amélioration technique', 22000, 'prévu', 'TechnoPatch'
56, 8, DATE '2023-09-01', DATE '2023-09-10', 'Maintenance annuelle', 9000, 'terminé', 'Reparator 3000'
57, 8, DATE '2024-03-01', DATE '2024-03-15', 'Révision matérielle', 14000, 'terminé', 'FixIt Fast'
58, 9, DATE '2023-02-01', DATE '2023-02-10', 'Réparation urgente', 30000, 'terminé', 'RepairHub'
59, 9, DATE '2024-04-10', DATE '2024-04-20', 'Test de sécurité', 16000, 'terminé', 'SafeCheck Pro'
60, 10, DATE '2023-12-01', DATE '2023-12-10', 'Amélioration technique', 25000, 'prévu', 'TechnoPatch'
61, 10, DATE '2024-06-10', DATE '2024-06-20', 'Maintenance annuelle', 12000, 'terminé', 'Reparator 3000'
62, 1, TRUNC(SYSDATE, 'YEAR') - INTERVAL '10' MONTH, TRUNC(SYSDATE, 'YEAR') - INTERVAL '9' MONTH, 'Révision annuelle', 15000, 'terminé', 'FixIt Fast'
63, 1, TRUNC(SYSDATE, 'YEAR') - INTERVAL '6' MONTH, TRUNC(SYSDATE, 'YEAR') - INTERVAL '5' MONTH, 'Test de sécurité', 12000, 'terminé', 'SafeCheck Pro'
64, 5, TRUNC(SYSDATE, 'YEAR') - INTERVAL '11' MONTH, TRUNC(SYSDATE, 'YEAR') - INTERVAL '10' MONTH, 'Maintenance préventive', 18000, 'terminé', 'RepairHub'
65, 5, TRUNC(SYSDATE, 'YEAR') - INTERVAL '3' MONTH, TRUNC(SYSDATE, 'YEAR') - INTERVAL '2' MONTH, 'Amélioration technique', 20000, 'terminé', 'TechnoPatch'

LOAD DATA
INFILE *
APPEND
INTO TABLE employe
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(numero_de_securite_sociale, id_attraction, nom, prenom, telephone, email, adresse, ville, pays)
BEGIN DATA
100000001, 5, 'Dupont', 'Jean', '0123456789', 'jean.dupont@example.com', '10 Brühl Avenue', 'Brühl','Allemagne'
100000002, 12, 'Martin', 'Sophie', '0234567890', 'sophie.martin@example.com', '20 Rust Street', 'Rust','Allemagne'
100000003, 8, 'Bernard', 'Luc', '0345678901', 'luc.bernard@example.com', '30 Disneyland Road', 'Marne-la-Vallée', 'France'
100000004, 15, 'Durand', 'Emma', '0456789012', 'emma.durand@example.com', '40 Asterix Boulevard', 'Plailly', 'France'
100000005, 20, 'Moreau', 'Louis', '0567890123', 'louis.moreau@example.com', '50 Futuroscope Way', 'Chasseneuil-du-Poitou', 'France'
100000006, 25, 'Roux', 'Julie', '0678901234', 'julie.roux@example.com', '60 Walibi Lane', 'Les Avenières', 'France'
100000007, 30, 'Petit', 'Paul', '0789012345', 'paul.petit@example.com', '70 Sud-Ouest Drive', 'Roquefort', 'France'
100000008, 34, 'Richard', 'Claire', '0890123456', 'claire.richard@example.com', '80 Alton Towers Road', 'Alton', 'Royaume-Uni'
100000009, 2, 'Durand', 'Marc', '0901234567', 'marc.durand@example.com', '90 Thorpe Park Lane', 'Chertsey', 'Royaume-Uni'
100000010, 6, 'Dubois', 'Marie', '0112345678', 'marie.dubois@example.com', '100 PortAventura Street', 'Salou', 'Espagne'
100000011, 14, 'Blanc', 'Alice', '0123456789', 'alice.blanc@example.com', '110 Disney Drive', 'Anaheim', 'États-Unis'
100000012, 10, 'Fabre', 'Hugo', '0234567890', 'hugo.fabre@example.com', '120 Universal Boulevard', 'Los Angeles', 'États-Unis'
100000013, 18, 'Lemoine', 'Sarah', '0345678901', 'sarah.lemoine@example.com', '130 Six Flags Road', 'Valencia', 'États-Unis'
100000014, 22, 'Noir', 'Lucas', '0456789012', 'lucas.noir@example.com', '140 Cedar Avenue', 'Sandusky', 'États-Unis'
100000015, 9, 'Clément', 'Chloe', '0567890123', 'chloe.clement@example.com', '150 Brühl Avenue', 'Brühl', 'Allemagne'
100000016, 11, 'Perrin', 'Thomas', '0678901234', 'thomas.perrin@example.com', '160 Rust Street', 'Rust', 'Allemagne'
100000017, 16, 'Leclerc', 'Emma', '0789012345', 'emma.leclerc@example.com', '170 Disneyland Road', 'Marne-la-Vallée', 'France'
100000018, 21, 'Lemoine', 'Victor', '0890123456', 'victor.lemoine@example.com', '180 Asterix Boulevard', 'Plailly', 'France'
100000019, 19, 'Simon', 'Anais', '0901234567', 'anais.simon@example.com', '190 Futuroscope Way', 'Chasseneuil-du-Poitou', 'France'
100000020, 24, 'Michel', 'Arthur', '0112345678', 'arthur.michel@example.com', '200 Walibi Lane', 'Les Avenières', 'France'
100000021, 27, 'Garcia', 'Elisa', '0123456789', 'elisa.garcia@example.com', '210 Sud-Ouest Drive', 'Roquefort', 'France'
100000022, 28, 'Fernandez', 'Nathan', '0234567890', 'nathan.fernandez@example.com', '220 Alton Towers Road', 'Alton', 'Royaume-Uni'
100000023, 3, 'Lopez', 'Camille', '0345678901', 'camille.lopez@example.com', '230 Thorpe Park Lane', 'Chertsey', 'Royaume-Uni'
100000024, 7, 'Morin', 'Julien', '0456789012', 'julien.morin@example.com', '240 PortAventura Street', 'Salou', 'Espagne'
100000025, 13, 'Morel', 'Celine', '0567890123', 'celine.morel@example.com', '250 Disney Drive', 'Anaheim', 'États-Unis'
100000026, 4, 'Guerin', 'Leo', '0678901234', 'leo.guerin@example.com', '260 Universal Boulevard', 'Los Angeles', 'États-Unis'
100000027, 23, 'Fournier', 'Eva', '0789012345', 'eva.fournier@example.com', '270 Six Flags Road', 'Valencia', 'États-Unis'
100000028, 17, 'Girard', 'Adam', '0890123456', 'adam.girard@example.com', '280 Cedar Avenue', 'Sandusky', 'États-Unis'
100000029, 26, 'Andre', 'Lola', '0901234567', 'lola.andre@example.com', '290 Brühl Avenue', 'Brühl', 'Allemagne'
100000030, 31, 'Mercier', 'Noah', '0112345678', 'noah.mercier@example.com', '300 Rust Street', 'Rust', 'Allemagne'
100000031, 32, 'Dupuis', 'Alice', '0123456789', 'alice.dupuis@example.com', '310 Disneyland Road', 'Marne-la-Vallée', 'France'
100000032, 33, 'Lambert', 'Louis', '0234567890', 'louis.lambert@example.com', '320 Asterix Boulevard', 'Plailly', 'France'
100000033, 29, 'Fontaine', 'Sophie', '0345678901', 'sophie.fontaine@example.com', '330 Futuroscope Way', 'Chasseneuil-du-Poitou', 'France'
100000034, 2, 'Roche', 'Emma', '0456789012', 'emma.roche@example.com', '340 Walibi Lane', 'Les Avenières', 'France'
100000035, 1, 'Chevalier', 'Hugo', '0567890123', 'hugo.chevalier@example.com', '350 Sud-Ouest Drive', 'Roquefort', 'France'
100000036, 12, 'Francois', 'Paul', '0678901234', 'paul.francois@example.com', '360 Alton Towers Road', 'Alton', 'Royaume-Uni'
100000037, 18, 'Perrot', 'Lucas', '0789012345', 'lucas.perrot@example.com', '370 Thorpe Park Lane', 'Chertsey', 'Royaume-Uni'
100000038, 20, 'Lemoine', 'Sarah', '0890123456', 'sarah.lemoine@example.com', '380 PortAventura Street', 'Salou', 'Espagne'
100000039, 14, 'Benoit', 'Julien', '0901234567', 'julien.benoit@example.com', '390 Disney Drive', 'Anaheim', 'États-Unis'
100000040, 10, 'Antoine', 'Eve', '0112345678', 'eve.antoine@example.com', '400 Universal Boulevard', 'Los Angeles', 'États-Unis'
100000041, 30, 'Navarro', 'Chloe', '0123456789', 'chloe.navarro@example.com', '410 Six Flags Road', 'Valencia', 'États-Unis'
100000043, 9, 'Lemoine', 'Anais', '0345678901', 'anais.lemoine@example.com', '430 Brühl Avenue', 'Brühl', 'Allemagne'

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

LOAD DATA
INFILE *
APPEND
INTO TABLE commande
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(id_commande, id_client, date_commande DATE "YYYY-MM-DD", montant_total, nb_billets)
BEGIN DATA
1, 12, DATE '2023-11-01', 0, 0
2, 7, DATE '2023-11-02', 0, 0
3, 23, DATE '2023-11-03', 0, 0
4, 5, DATE '2023-11-04', 0, 0
5, 19, DATE '2023-11-05', 0, 0
6, 15, DATE '2023-11-06', 0, 0
7, 8, DATE '2023-11-07', 0, 0
8, 27, DATE '2022-11-08', 0, 0
9, 1, DATE '2023-11-09', 0, 0
10, 29, DATE '2023-11-10', 0, 0
11, 6, DATE '2023-11-11', 0, 0
12, 18, DATE '2023-11-12', 0, 0
13, 14, DATE '2023-11-13', 0, 0
14, 21, DATE '2023-11-14', 0, 0
15, 9, DATE '2023-11-15', 0, 0
16, 3, DATE '2023-11-16', 0, 0
17, 10, DATE '2023-11-17', 0, 0
18, 22, DATE '2023-11-18', 0, 0
19, 26, DATE '2023-11-19', 0, 0
20, 4, DATE '2023-11-20', 0, 0
21, 25, DATE '2023-11-21', 0, 0
22, 2, DATE '2023-11-22', 0, 0
23, 17, DATE '2023-11-23', 0, 0
24, 13, DATE '2023-11-24', 0, 0
25, 19, DATE '2023-11-25', 0, 0
26, 11, DATE '2023-11-26', 0, 0
27, 29, DATE '2023-11-27', 0, 0
28, 16, DATE '2023-11-28', 0, 0
29, 8, DATE '2023-11-29', 0, 0
30, 20, DATE '2023-11-30', 0, 0
31, 5, DATE '2023-12-01', 0, 0
32, 24, DATE '2023-12-02', 0, 0
33, 12, DATE '2023-12-03', 0, 0
34, 28, DATE '2023-12-04', 0, 0
35, 7, DATE '2023-12-05', 0, 0
36, 2, DATE '2023-12-06', 0, 0
37, 9, DATE '2023-12-07', 0, 0
38, 15, DATE '2023-12-08', 0, 0
39, 1, DATE '2023-12-09', 0, 0
40, 19, DATE '2023-12-10', 0, 0
41, 14, DATE '2023-12-11', 0, 0
42, 22, DATE '2023-12-12', 0, 0
43, 3, DATE '2023-12-13', 0, 0
44, 10, DATE '2023-12-14', 0, 0
45, 18, DATE '2023-12-15', 0, 0
46, 21, DATE '2023-12-16', 0, 0
47, 27, DATE '2023-12-17', 0, 0
48, 6, DATE '2023-12-18', 0, 0
49, 11, DATE '2023-12-19', 0, 0
50, 29, DATE '2023-12-20', 0, 0

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

LOAD DATA
INFILE *
APPEND
INTO TABLE reduction
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(nom_reduction, reduction, date_debut DATE "YYYY-MM-DD", date_fin DATE "YYYY-MM-DD")
BEGIN DATA
'normal', 0, DATE '2021-01-01', NULL
'enfant', 0.5, DATE '2021-01-01', NULL
'étudiant', 0.1, DATE '2021-01-01', NULL
'senior', 0.05, DATE '2021-01-01', NULL

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
