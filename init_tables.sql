-- Suppression des tables avec leurs contraintes
DECLARE
    v_sql VARCHAR2(4000);
BEGIN
    FOR table_name IN (
        SELECT table_name
        FROM user_tables
        WHERE table_name IN (
            'BILLET', 'TOURNIQUET', 'COMMANDE', 'CONTRAT',
            'EMPLOYE', 'TRAVAUX', 'ATTRACTION', 'CLIENT', 'TARIF', 'PARC'
        )
    ) LOOP
        v_sql := 'DROP TABLE ' || '"' || table_name.table_name || '"' || ' CASCADE CONSTRAINTS';
        EXECUTE IMMEDIATE v_sql;
    END LOOP;
END;
/

-- Suppression des séquences
DECLARE
    v_sql VARCHAR2(4000);
BEGIN
    FOR seq_name IN (
        SELECT sequence_name
        FROM user_sequences
        WHERE sequence_name IN ('SEQUENCE_ID_ATTRACTION')
    ) LOOP
        v_sql := 'DROP SEQUENCE ' || seq_name.sequence_name;
        EXECUTE IMMEDIATE v_sql;
    END LOOP;
END;
/

-- Ajout des séquences

CREATE SEQUENCE sequence_id_attraction
START WITH 1
INCREMENT BY 1
NOCACHE;

-- Création de la table 'parc'
CREATE TABLE parc (
    id_parc NUMBER PRIMARY KEY,
    nom VARCHAR2(100) NOT NULL,
    date_ouverture DATE,
    superficie NUMBER,
    pays VARCHAR2(100),
    ville VARCHAR2(100),
    constraint chk_superficie CHECK (superficie > 0)
);

-- Création de la table 'tarif'
CREATE TABLE tarif (
    nom_tarif VARCHAR2(100) PRIMARY KEY,
    prix NUMBER,
    duree_en_jour NUMBER,
    reduction NUMBER,
    date_debut DATE,
    date_fin DATE,
    constraint ch_tarif_prix CHECK (prix > 0),
    constraint chk_tarif_duree CHECK (duree_en_jour > 0),
    constraint chk_date_fin CHECK (date_fin >= date_debut or date_fin is null)
);

-- Création de la table réduction
CREATE TABLE reduction (
    nom_reduction VARCHAR2(100) PRIMARY KEY,
    reduction NUMBER,
    date_debut DATE,
    date_fin DATE,
    constraint chk_reduction CHECK (reduction > 0 and reduction < 1),
    constraint chk_date_fin CHECK (date_fin >= date_debut or date_fin is null),
    constraint fk_reduction_tarif FOREIGN KEY (nom_reduction) REFERENCES billet(reduction)
);

-- Création de la table 'client'
CREATE TABLE client (
    id_client NUMBER PRIMARY KEY,
    email VARCHAR2(150) NOT NULL,
    nom VARCHAR2(100) NOT NULL,
    prenom VARCHAR2(100) NOT NULL,
    adresse VARCHAR2(200),
    telephone VARCHAR2(20),
    ville VARCHAR2(100),
    pays VARCHAR2(100)
);

-- Création de la table 'attraction'
CREATE TABLE attraction (
    id_attraction NUMBER PRIMARY KEY,
    nom VARCHAR2(100) NOT NULL,
    date_ouverture DATE,
    constructeur VARCHAR2(100),
    vitesse_maximale NUMBER,
    capacite_horaire NUMBER,
    force_g_maximale NUMBER,
    hauteur_maximale NUMBER,
    nombre_de_train NUMBER,
    personnes_par_train NUMBER,
    nombre_inversion NUMBER,
    longueur NUMBER,
    type VARCHAR2(100),
    duree NUMBER,
    etat VARCHAR2(50),
    id_parc NUMBER,
    CONSTRAINT chk_attraction_etat_valide CHECK (etat IN ('ouverte', 'fermée', 'en travaux')),
    CONSTRAINT chk_attraction_capacite_non_nulle CHECK (capacite_horaire > 0 or capacite_horaire is null),
    CONSTRAINT chk_attraction_nombre_train_minimum CHECK (nombre_de_train >= 1 or nombre_de_train is null),
    CONSTRAINT chk_attraction_personnes_par_train_minimum CHECK (personnes_par_train >= 1 or personnes_par_train is null),
    CONSTRAINT chk_attraction_nombre_inversion_non_negatif CHECK (nombre_inversion >= 0 or nombre_inversion is null),
    CONSTRAINT chk_attraction_longueur_non_negatif CHECK (longueur >= 0 or longueur is null),
    CONSTRAINT chk_attraction_duree_non_negatif CHECK (duree >= 0 or duree is null),
    CONSTRAINT chk_attraction_vitesse_non_negatif CHECK (vitesse_maximale >= 0 or vitesse_maximale is null),
    CONSTRAINT fk_attraction_parc FOREIGN KEY (id_parc) REFERENCES parc(id_parc)
);

-- Création de la table 'travaux'
CREATE TABLE travaux (
    id_travaux NUMBER PRIMARY KEY,
    id_attraction NUMBER,
    date_debut DATE,
    date_fin DATE,
    description VARCHAR2(500),
    cout NUMBER,
    etat VARCHAR2(50),
    reparateur VARCHAR2(100),
    CONSTRAINT chk_travaux_dates CHECK (date_fin IS NULL OR date_fin >= date_debut),
    CONSTRAINT chk_travaux_cout_non_negatif CHECK (cout >= 0 or cout is null),
    CONSTRAINT chk_travaux_etat_valide CHECK (etat IN ('prévu', 'en cours', 'terminé')),
    CONSTRAINT fk_travaux_attraction FOREIGN KEY (id_attraction) REFERENCES attraction(id_attraction)
);

-- Création de la table 'employe'
CREATE TABLE employe (
    numero_de_securite_sociale NUMBER PRIMARY KEY,
    id_parc NUMBER,
    id_attraction NUMBER,
    nom VARCHAR2(100) NOT NULL,
    prenom VARCHAR2(100) NOT NULL,
    telephone VARCHAR2(20),
    email VARCHAR2(150),
    adresse VARCHAR2(200),
    ville VARCHAR2(100),
    pays VARCHAR2(100),
    CONSTRAINT fk_employe_parc FOREIGN KEY (id_parc) REFERENCES parc(id_parc),
    CONSTRAINT fk_employe_attraction FOREIGN KEY (id_attraction) REFERENCES attraction(id_attraction)
);

-- Création de la table 'contrat'
CREATE TABLE contrat (
    id_contrat NUMBER PRIMARY KEY,
    numero_de_securite_sociale NUMBER,
    date_debut DATE,
    date_fin DATE,
    metier VARCHAR2(100),
    salaire NUMBER,
    type VARCHAR2(50),
    CONSTRAINT chk_contrat_salaire_non_negatif CHECK (salaire > 0),
    CONSTRAINT chk_contrat_type_valide CHECK (type IN ('CDI', 'CDD', 'stage', 'alternance', 'interim')),
    CONSTRAINT chk_contrat_dates CHECK (date_fin IS NULL OR date_fin >= date_debut),
    CONSTRAINT fk_contrat_employe FOREIGN KEY (numero_de_securite_sociale) REFERENCES employe(numero_de_securite_sociale)
);

-- Création de la table 'commande'
CREATE TABLE commande (
    id_commande NUMBER PRIMARY KEY,
    id_client NUMBER,
    date_commande DATE,
    CONSTRAINT fk_commande_client FOREIGN KEY (id_client) REFERENCES client(id_client)
);

-- Création de la table 'tourniquet'
CREATE TABLE tourniquet (
    id_attraction NUMBER NOT NULL,
    heure DATE NOT NULL,
    entree_ou_sortie VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_tourniquet_attraction FOREIGN KEY (id_attraction) REFERENCES attraction(id_attraction),
    CONSTRAINT chk_entree_ou_sortie CHECK (entree_ou_sortie IN ('entrée', 'sortie'))
);

-- Création de la table 'billet'
CREATE TABLE billet (
    id_billet NUMBER PRIMARY KEY,
    id_parc NUMBER,
    id_commande NUMBER,
    date_debut_validite DATE,
    date_fin_validite DATE,
    tarif VARCHAR2(100),
    reduction VARCHAR2(100),
    scanne NUMBER(1, 0) DEFAULT 0,
    CONSTRAINT chk_billet_dates CHECK (date_fin_validite >= date_debut_validite),
    constraint chk_scanne_type CHECK (scanne IN (0, 1)),
    CONSTRAINT fk_billet_parc FOREIGN KEY (id_parc) REFERENCES parc(id_parc),
    CONSTRAINT fk_billet_commande FOREIGN KEY (id_commande) REFERENCES commande(id_commande),
    CONSTRAINT fk_billet_tarif FOREIGN KEY (tarif) REFERENCES tarif(nom_tarif),
    CONSTRAINT fk_billet_reduction FOREIGN KEY (reduction) REFERENCES reduction(nom_reduction)
);


-- Triggers

/* Trigger pour empêcher la modification d'un billet scanné dont la date de fin de validité est dépassée
ou dont la date de début de validité n'est pas encore passée */
CREATE OR REPLACE TRIGGER trigger_billet_scanne BEFORE UPDATE OF scanne ON billet FOR EACH ROW
BEGIN
    IF :OLD.scanne = 0 AND :NEW.scanne = 1 THEN
        IF SYSDATE > :OLD.date_fin_validite THEN
            RAISE_APPLICATION_ERROR(-20001, 'Impossible de modifier un billet scanné dont la date de fin de validité est dépassée');
        END IF;

        IF :OLD.date_debut_validite > SYSDATE THEN
            RAISE_APPLICATION_ERROR(-20002, 'Impossible de modifier un billet scanné dont la date de début de validité n''est pas encore passée');
        END IF;
    END IF;
END;

-- Trigger pour empecher la suppression de contrat finit il y a moins de 5 ans

CREATE OR REPLACE TRIGGER trg_contrat_delete
BEFORE DELETE ON contrat
FOR EACH ROW
BEGIN
    IF :OLD.date_fin >= SYSDATE - INTERVAL '5' YEAR THEN
        RAISE_APPLICATION_ERROR(-20001, 'Impossible de supprimer un contrat fini il y a moins de 5 ans');
    END IF;
END;

-- Insertions

-- Insertions parc

INSERT INTO parc VALUES (1, 'Phantasialand', DATE '1967-04-30', 28, 'Allemagne', 'Brülh');
INSERT INTO parc VALUES (2, 'Europa-Park', DATE '1975-07-12', 95, 'Allemagne', 'Rust');
INSERT INTO parc VALUES (3, 'Disneyland Paris', DATE '1992-04-12', 2230, 'France', 'Marne-la-Vallée');
INSERT INTO parc VALUES (4, 'Parc Astérix', DATE '1989-04-30', 35, 'France', 'Plailly');
INSERT INTO parc VALUES (5, 'Futuroscope', DATE '1987-05-31', 60, 'France', 'Chasseneuil-du-Poitou'); -- Correction 31 novembre impossible
INSERT INTO parc VALUES (6, 'Walibi Rhône-Alpes', DATE '1979-06-04', 35, 'France', 'Les Avenières');
INSERT INTO parc VALUES (7, 'Walibi Sud-Ouest', DATE '1999-06-04', 30, 'France', 'Roquefort');
INSERT INTO parc VALUES (8, 'Alton Towers', DATE '1980-04-04', 200, 'Royaume-Uni', 'Alton');
INSERT INTO parc VALUES (9, 'Thorpe Park', DATE '1979-05-24', 200, 'Royaume-Uni', 'Chertsey');
INSERT INTO parc VALUES (10, 'PortAventura', DATE '1995-05-01', 119, 'Espagne', 'Salou');
INSERT INTO parc VALUES (11, 'Disneyland Resort', DATE '1955-07-17', 486, 'États-Unis', 'Anaheim');
INSERT INTO parc VALUES (12, 'Universal Studios Hollywood', DATE '1964-07-15', 415, 'États-Unis', 'Los Angeles');
INSERT INTO parc VALUES (13, 'Six Flags Magic Mountain', DATE '1971-05-29', 262, 'États-Unis', 'Valencia');
INSERT INTO parc VALUES (14, 'Cedar Point', DATE '1870-05-17', 200, 'États-Unis', 'Sandusky');

-- Insertions tarif
INSERT INTO tarif VALUES ('journalier', 50, 1, 0, DATE '2021-01-01', null);
INSERT INTO tarif VALUES ('2 jours', 80, 2, 0, DATE '2021-01-01', null);
INSERT INTO tarif VALUES ('annuel', 150, 365, 0, DATE '2021-01-01', null);
INSERT INTO tarif VALUES ('nocturne', 30, 1, 0, DATE '2021-01-01', null);
INSERT INTO tarif VALUES ('noel', 60, 1, 0, DATE '2024-11-15', DATE '2021-12-31');

-- Insertions clients

-- Insertions attractions

-- Phantasialand
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Black Mamba', DATE '2006-04-01', 'Bolliger & Mabillard', 80, 1500, 4.5, 27, 2, 32, 6, 779, 'Inverted Coaster', 3, 'ouverte', 1);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Taron', DATE '2016-06-30', 'Intamin', 117, 1200, 4.5, 30, 2, 32, 0, 1349, 'Launched Coaster', 3, 'ouverte', 1);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Raik', DATE '2016-06-30', 'Gerstlauer', 60, 1000, 3.5, 25, 2, 16, 0, 682, 'Family Coaster', 2, 'ouverte', 1);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Chiapas', DATE '2014-04-01', 'Intamin', 53, 1200, 3.5, 20, 2, 20, 0, 850, 'Log Flume', 3, 'ouverte', 1);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Colorado Adventure', DATE '1996-04-01', 'Intamin', 45, 1200, 3.5, 20, 2, 20, 0, 1180, 'Mine Train', 3, 'ouverte', 1);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Winja''s Fear & Force', DATE '2006-04-01', 'Maurer AG', 40, 1200, 3.5, 20, 2, 20, 0, 1180, 'Spinning Coaster', 3, 'ouverte', 1);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Maus au Chocolat', DATE '2011-04-01', 'Mack Rides', 10, 1200, 0, 0, 9, 12, 0, 350, 'Interactive Dark Ride', 9, 'ouverte', 1);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'F.L.Y.', DATE '2020-09-17', 'Vekoma', 100, 1200, 4.5, 40, 2, 16, 0, 1230, 'Flying Coaster', 3, 'ouverte', 1);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'River Quest', DATE '2002-04-01', 'Intamin', 20, 1200, 0, 22, 18, 9, 0, 440, 'River Rapids', 6, 'ouverte', 1);

-- Europa-Park
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Blue Fire Megacoaster', DATE '2009-04-04', 'Mack Rides', 100, 1720, 3.80, 38, 5, 20, 4, 1056, 'Launched Coaster', 140, 'ouverte', 2);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Silver Star', DATE '2002-03-23', 'Bolliger & Mabillard', 127, 1750, 4, 73, 3, 36, 0, 1620, 'Hyper Coaster', 360, 'ouverte', 2);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Wodan Timbur Coaster', DATE '2012-03-31', 'Great Coasters International', 100, 1250, 3.5, 40, 3, 24, 0, 1050, 'Wooden Coaster', 150, 'ouverte', 2);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Eurosat - CanCan Coaster', DATE '1989-09-12', 'Mack Rides', 60, 1280, 4, 25.5, 7, 14, 0, 922, 'Dark Ride', 198, 'ouverte', 2);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Euro-Mir', DATE '1997-06-12', 'Mack Rides', 80, 1600, 4, 28.30, 9, 16, 0, 984, 'Spinning Coaster', 273, 'ouverte', 2);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Voltron Nevera', DATE '2024-04-24', 'Mack Rides', 100, 1600, 4.2, 32.50, 7, 16, 7, 1385, 'Launched Coaster', 180, 'ouverte', 2);

-- Disneyland Paris
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Hyperspace Mountain', DATE '1995-06-01', 'Vekoma', 76, 2400, 2.7, 31, 5, 24, 2, 1000, 'Launched Coaster', 237, 'ouverte', 3);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Big Thunder Mountain', DATE '1992-04-12', 'Vekoma', 65, 2424, 1.9, 22, 5, 30, 0, 1205, 'Mine Train', 236, 'ouverte', 3);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Pirates of the Caribbean', DATE '1992-04-01', 'Intamin', 30, 3400, 1.95, 10, 50, 24, 0, 1000, 'Dark Ride', 630, 'ouverte', 3);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Phantom Manor', DATE '1992-04-12', 'Vekoma', 2, 2200, 1, 5.64, 130, 2, 0, 239, 'Omnimover', 360, 'ouverte', 3);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Indiana Jones et le Temple du Péril', DATE '1993-07-30', 'Intamin', 58, 1440, 3.2, 18, 7, 12, 1, 566, 'Mad Mouse', 74, 'ouverte', 3);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Avengers Assemble', DATE '2002-03-16', 'Vekoma', 91, 1800, 5, 24.40, 5, 24, 3, 1037, 'Dark Ride', 70, 'ouverte', 3);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Casey Jr. - le Petit Train du Cirque', DATE '1994-04-12', 'Vekoma', 45, 1440, 1.1, 3, 2, 34, 0, 522, 'Family Coaster', 120, 'ouverte', 3);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Crushs Coaster', DATE '2007-06-09', 'Maurer Rides', 61, 895, 1.5, 15.50, 11, 4, 0, 550, 'Spinning Coaster', 140, 'ouverte', 3);

-- Parc Astérix
INSERT INTO attraction values (sequence_id_attraction.nextval, 'OzIris', DATE'2012-04-07', 'Bolliger & Mabillard', 90, 1600, 3.2, 40, 3, 32, 5, 1000, 'Inverted Coaster', 135, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Pégase Express', DATE'2017-06-11', 'Gerstlauer', 52, 1200, 2.1, 20, 4, 20, 0, 928, 'Family Coaster', 120, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Tonnerre 2 Zeus', DATE'1997-04-07', 'Custom Coasters International', 90, 1440, 2.1, 29.90, 2, 24, 0, 1232.60, 'Wooden Coaster', 125, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Goudurix', DATE'1989-04-30', 'Vekoma', 90, 1100, 4.5, 36.10, 2, 28, 7, 950, 'Steel Coaster', 80, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Trace du Hourra', DATE'2001-03-31', 'Mack Rides', 60, 1500, 1.8, 31, 5, 14, 0, 900, 'Bobsleigh', 170, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Menhir Express', DATE'1995-04-07', 'Hopkins Ride', 36, 1200, 0, 13, 30, 4, 0, 627, 'Log Flume', 300, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Grand Splatch', DATE'1989-04-30', 'Intamin', 42, 1400, 3.5, 11, 9, 20, 0, 627, 'Log Flume', 360, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Toutatis', DATE'2023-04-08', 'Intamin', 110, 1260, 1.1, 51, 3, 20, 3, 1075, 'Launched Coaster', 123, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Le vol d\Icare', DATE'1994-04-07', 'Zierer', 42, 1150, 1, 10.70, 5, 4, 0, 410, 'Family Coaster', 75, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'SOS Tournevis', DATE'1990-04-30', 'Zierer', 32, 1000, 1.2, 6, 1, 30, 0, 199, 'Family Coaster', 90, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Romus et Rapidus', DATE'2004-04-07', 'Hopkins Ride', 22, 1200, 0, 13, 30, 4, 0, 627, 'Log Flume', 300, 'Ouvert', 4);

-- Insertions travaux

-- Insertions employés

-- Insertions contrats

-- Insertions commandes

-- Insertions tourniquets
DECLARE
    i INTEGER := 0;
BEGIN
    WHILE i < 1000 LOOP
        INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie)
        VALUES (
            MOD(DBMS_RANDOM.VALUE(1, 100), 100) + 1, -- id_attraction entre 1 et 100
            TO_DATE(
                TO_CHAR(TRUNC(SYSDATE - DBMS_RANDOM.VALUE(0, 365)), 'YYYY-MM-DD') || ' ' ||
                TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(9, 20)), '00') || ':' ||
                TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(0, 60)), '00') || ':' ||
                TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(0, 60)), '00'),
                'YYYY-MM-DD HH24:MI:SS'
            ), -- Heure entre 09:00:00 et 19:59:59
            CASE
                WHEN DBMS_RANDOM.VALUE(0, 1) < 0.6 THEN 'entrée'
                ELSE 'sortie'
            END
        );
        i := i + 1;
    END LOOP;
    COMMIT;
END;
/

-- Insertions dans la table billets

-- Requêtes

-- 1 Quels sont les parcs ouverts depuis plus de 10 ans ?
SELECT nom, date_ouverture
FROM parc
WHERE date_ouverture < SYSDATE - INTERVAL '10' YEAR;

-- 2 Combien d'employés travaillent dans chaque parc ?
SELECT p.nom, COUNT(distinct (e.numero_de_securite_sociale)) AS nb_employes
FROM parc p
LEFT JOIN employe e ON p.id_parc = e.id_parc
GROUP BY p.nom;

-- 3 Quelle est la date du dernier travail effectuée sur chaque attraction ?
SELECT a.nom, MAX(t.date_fin) AS date_dernier_travail
FROM attraction a
LEFT JOIN travaux t ON a.id_attraction = t.id_attraction
GROUP BY a.nom;

-- 4 Quels sont le nombre moyen d'attractions/superficie pour chaque parc ?
SELECT p.nom, COUNT(a.id_attraction) / p.superficie AS nb_attractions_par_superficie
FROM parc p
LEFT JOIN attraction a ON p.id_parc = a.id_parc
GROUP BY p.nom, p.superficie;

-- 5 Quels sont les types d'attractions les plus courants dans tous les parcs ?
SELECT type, COUNT(id_attraction) AS nb_attractions
FROM attraction
GROUP BY type
ORDER BY nb_attractions DESC;

-- 6 Quel parc a le plus d’attractions du constructeur “Vekoma” ?
SELECT p.nom, COUNT(a.id_attraction) AS nb_attractions_vekoma
FROM parc p
JOIN attraction a ON p.id_parc = a.id_parc
WHERE a.constructeur = 'Vekoma'
GROUP BY p.nom
ORDER BY nb_attractions_vekoma DESC
FETCH FIRST ROW ONLY;

-- 7 Combien de travaux ont eu lieu pour chaque attraction au cours des 5 dernières années ?
SELECT a.nom, COUNT(t.id_travaux) AS nb_travaux
FROM attraction a
JOIN travaux t ON a.id_attraction = t.id_attraction
WHERE t.date_debut >= SYSDATE - INTERVAL '5' YEAR
GROUP BY a.nom;

-- 8 Quel est le salaire moyen des employés ?
SELECT AVG(c.salaire) AS salaire_moyen
FROM contrat c;

-- 9 Quelle est la proportion de billets “journalier” vendue ?
SELECT COUNT(b.id_billet) / (SELECT COUNT(id_billet) FROM billet) AS proportion_journalier
FROM billet b
JOIN tarif t ON b.tarif = t.nom_tarif
WHERE t.nom_tarif = 'journalier';

-- 10 Quels employés ont un contrat en cours mais dont le contrat se termine dans les 3 prochains mois ?
SELECT e.nom, e.prenom
FROM employe e
JOIN contrat c ON e.numero_de_securite_sociale = c.numero_de_securite_sociale
WHERE c.date_fin >= SYSDATE AND c.date_fin <= SYSDATE + INTERVAL '3' MONTH;

-- 11 S’il n’y avait pas de tarif étudiant, combien chaque parc aurait-il gagné en plus ?

-- 12 Quel parc a le plus grand nombre d'attractions avec des inversions ?
SELECT p.nom, COUNT(a.id_attraction) AS nb_attractions_inversions
FROM parc p
JOIN attraction a ON p.id_parc = a.id_parc
WHERE a.nombre_inversion > 0
GROUP BY p.nom
ORDER BY nb_attractions_inversions DESC;

-- 13 Quelles attractions ont été fermées pour des travaux au moins deux fois l'année dernière ?
SELECT a.nom, COUNT(t.id_travaux) AS nb_travaux
FROM attraction a
JOIN travaux t ON a.id_attraction = t.id_attraction
WHERE t.date_debut >= TRUNC(SYSDATE, 'YEAR') - INTERVAL '1' YEAR
AND t.date_debut < TRUNC(SYSDATE, 'YEAR')
AND t.etat = 'terminé'
GROUP BY a.nom
HAVING COUNT(t.id_travaux) >= 2;

-- 14 Quels employés ont des contrats dont le salaire est supérieur à la moyenne des salaires de tous les employés exerçant le même métier ?
SELECT e.nom, e.prenom, c.salaire
FROM employe e
JOIN contrat c ON e.numero_de_securite_sociale = c.numero_de_securite_sociale
WHERE c.salaire > (
    SELECT AVG(c2.salaire)
    FROM contrat c2
    WHERE c2.metier = c.metier
);

-- 15 Quels sont pour chaque parc les 3 attractions qui ont coûté le plus en termes de maintenance ?
SELECT p.nom, a.nom, t.cout
FROM parc p
JOIN attraction a ON p.id_parc = a.id_parc
JOIN travaux t ON a.id_attraction = t.id_attraction
ORDER BY t.cout DESC
FETCH FIRST 3 ROWS ONLY;

-- 16 Pour chaque parc, quelle attraction a eu le plus de travaux?
SELECT p.nom, a.nom, COUNT(t.id_travaux) AS nb_travaux
FROM parc p
JOIN attraction a ON p.id_parc = a.id_parc
JOIN travaux t ON a.id_attraction = t.id_attraction
GROUP BY p.nom, a.nom
ORDER BY nb_travaux DESC
FETCH FIRST ROW ONLY;

-- 17 Pour chaque parc, quelle est la proportion de billets non utilisés ?

SELECT p.nom, COUNT(b.id_billet) / (SELECT COUNT(id_billet) FROM billet) AS proportion_billets_non_utilises
FROM parc p
JOIN billet b ON p.id_parc = b.id_parc
WHERE b.date_fin_validite < SYSDATE
GROUP BY p.nom;

-- 18 Quelle est la capacité horaire pour chaque parc ?
SELECT p.nom, SUM(a.capacite_horaire) AS capacite_horaire_totale
FROM parc p
JOIN attraction a ON p.id_parc = a.id_parc
GROUP BY p.nom;

-- 19 Quelles sont les attractions les plus populaires de tous les parcs (laquelle a le plus d’entrée) ?
SELECT a.nom, COUNT(t.id_attraction) AS nb_entrees
FROM attraction a
JOIN tourniquet t ON a.id_attraction = t.id_attraction
WHERE t.entree_ou_sortie = 'entrée'
GROUP BY a.nom
ORDER BY nb_entrees DESC
FETCH FIRST ROW ONLY;

-- 20 Pour chaque parc, quel est le visiteur le plus fidèle ?
SELECT p.nom, c.nom, c.prenom, COUNT(b.id_billet) AS nb_billets
FROM parc p
JOIN billet b ON p.id_parc = b.id_parc
JOIN commande co ON b.id_commande = co.id_commande
JOIN client c ON co.id_client = c.id_client
GROUP BY p.nom, c.nom, c.prenom
ORDER BY nb_billets DESC
FETCH FIRST ROW ONLY;
