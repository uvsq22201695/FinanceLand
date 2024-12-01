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
    id_attraction NUMBER,
    heure DATE,
    entree_ou_sortie VARCHAR2(50),
    CONSTRAINT fk_tourniquet_attraction FOREIGN KEY (id_attraction) REFERENCES attraction(id_attraction)
);

-- Création de la table 'billet'
CREATE TABLE billet (
    id_billet NUMBER PRIMARY KEY,
    id_parc NUMBER,
    id_commande NUMBER,
    date_debut_validite DATE,
    date_fin_validite DATE,
    tarif VARCHAR2(100),
    CONSTRAINT chk_billet_dates CHECK (date_fin_validite >= date_debut_validite),
    CONSTRAINT fk_billet_parc FOREIGN KEY (id_parc) REFERENCES parc(id_parc),
    CONSTRAINT fk_billet_commande FOREIGN KEY (id_commande) REFERENCES commande(id_commande),
    CONSTRAINT fk_billet_tarif FOREIGN KEY (tarif) REFERENCES tarif(nom_tarif)
);

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

-- Disneyland Paris
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Hyperspace Mountain', DATE '1995-06-01', 'Vekoma', 76, 2400, NULL, 31, 5, 24, 2, 1000, 'Launched Coaster', 237, 'ouverte', 3);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Big Thunder Mountain', DATE '1992-04-12', 'Vekoma', 65, 2424, NULL, 22, 5, 30, 0, 1205, 'Mine Train', 236, 'ouverte', 3);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Pirates of the Caribbean', DATE '1992-04-01', 'Intamin', 30, 3400, 1.95, 10, 50, 24, 0, 1000, 'Dark Ride', 630, 'ouverte', 3);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Phantom Manor', DATE '1992-04-12', 'Vekoma', 2, 2200, NULL, 5.64, 130, 2, 0, 239, 'Omnimover', 360, 'ouverte', 3);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Indiana Jones et le Temple du Péril', DATE '1993-07-30', 'Intamin', 58, 1440, NULL, 18, 7, 12, 1, 566, 'Mad Mouse', 74, 'ouverte', 3);
INSERT INTO attraction VALUES (sequence_id_attraction.nextval, 'Avengers Assemble', DATE '2002-03-16', 'Vekoma', 91, 1800, 5, 24.40, 5, 24, 3, 1037, 'Dark Ride', 70, 'ouverte', 3);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Casey Jr. - le Petit Train du Cirque', DATE '1994-04-12', 'Vekoma', 45, 1440, NULL, 3, 2, 34, 0, 522, 'Family Coaster', 120, 'ouverte', 3);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Crush''s Coaster', DATE '2007-06-09', 'Maurer Rides', 61, 895, NULL, 15.50, 11, 4, 0, 550, 'Spinning Coaster', 140, 'ouverte', 3);

-- Parc Astérix
INSERT INTO attraction values (sequence_id_attraction.nextval, 'OzIris', DATE'2012-04-07', 'Bolliger & Mabillard', 90, 1600, NULL, 40, 3, 32, 5, 1000, 'Inverted Coaster', 135, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Pégase Express', DATE'2017-06-11', 'Gerstlauer', 52, 1200, NULL, 20, 4, 20, 0, 928, 'Family Coaster', 120, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Tonnerre 2 Zeus', DATE'1997-04-07', 'Custom Coasters International', 90, 1440, NULL, 29.90, 2, 24, 0, 1232.60, 'Wooden Coaster', 125, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Goudurix', DATE'1989-04-30', 'Vekoma', 90, 1100, 4.5, 36.10, 2, 28, 7, 950, 'Steel Coaster', 80, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Trace du Hourra', DATE'2001-03-31', 'Mack Rides', 60, 1500, NULL, 31, 5, 14, 0, 900, 'Bobsleigh', 170, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Menhir Express', DATE'1995-04-07', 'Hopkins Ride', NULL, 1200, 0, 13, 30, 4, 0, 627, 'Log Flume', 300, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Grand Splatch', DATE'1989-04-30', 'Intamin', NULL, 1400, 3.5, 11, 9, 20, 0, 627, 'Log Flume', 360, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Toutatis', DATE'2023-04-08', 'Intamin', 110, 1260, NULL, 51, 3, 20, 3, 1075, 'Launched Coaster', 123, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Le vol d\Icare', DATE'1994-04-07', 'Zierer', 42, 1150, NULL, 10.70, 5, 4, 0, 410, 'Family Coaster', 75, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'SOS Tournevis', DATE'1990-04-30', 'Zierer', 32, 1000, NULL, 6, 1, 30, 0, 199, 'Family Coaster', 90, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Romus et Rapidus', DATE'2004-04-07', 'Hopkins Ride', NULL, 1200, 0, 13, 30, 4, 0, 627, 'Log Flume', 300, 'Ouvert', 4);