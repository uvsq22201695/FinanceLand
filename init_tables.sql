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
        v_sql := 'DROP TABLE ' || table_name.table_name || ' CASCADE CONSTRAINTS';
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
    ville VARCHAR2(100)
);

-- Création de la table 'tarif'
CREATE TABLE tarif (
    nom_tarif VARCHAR2(100) PRIMARY KEY,
    prix NUMBER,
    duree_en_jour NUMBER,
    reduction NUMBER,
    date_debut DATE,
    date_fin DATE
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
    CONSTRAINT fk_billet_parc FOREIGN KEY (id_parc) REFERENCES parc(id_parc),
    CONSTRAINT fk_billet_commande FOREIGN KEY (id_commande) REFERENCES commande(id_commande),
    CONSTRAINT fk_billet_tarif FOREIGN KEY (tarif) REFERENCES tarif(nom_tarif)
);

-- Insertions

-- Insertions parc

INSERT INTO parc values (1, 'Phantasialand', 1967-04-30, 28, 'Allemagne', 'Brülh');
INSERT INTO parc values (2, 'Europa-Park', 1975-07-12, 95, 'Allemagne', 'Rust');
INSERT INTO parc values (3, 'Disneyland Paris', 1992-04-12, 2230, 'France', 'Marne-la-Vallée');
INSERT INTO parc values (4, 'Parc Astérix', 1989-04-30, 35, 'France', 'Plailly');
INSERT INTO parc values (5, 'Futuroscope', 1987-11-31, 60, 'France', 'Chasseneuil-du-Poitou');
INSERT INTO parc values (6, 'Walibi Rhône-Alpes', 1979-06-04, 35, 'France', 'Les Avenières');
INSERT INTO parc values (7, 'Walibi Sud-Ouest', 1999-06-04, 30, 'France', 'Roquefort');
INSERT INTO parc values (8, 'Alton Towers', 1980-04-04, 200, 'Royaume-Uni', 'Alton');
INSERT INTO parc values (9, 'Thorpe Park', 1979-05-24, 200, 'Royaume-Uni', 'Chertsey');
INSERT INTO parc values (10, 'PortAventura', 1995-05-01, 119, 'Espagne', 'Salou');
INSERT INTO parc values (11, 'Disneyland Resort', 1955-07-17, 486, 'États-Unis', 'Anaheim');
INSERT INTO parc values (12, 'Universal Studios Hollywood', 1964-07-15, 415, 'États-Unis', 'Los Angeles');
INSERT INTO parc values (13, 'Six Flags Magic Mountain', 1971-05-29, 262, 'États-Unis', 'Valencia');
INSERT INTO parc values (14, 'Cedar Point', 1870-05-17, 200, 'États-Unis', 'Sandusky');

-- Insertions attractions

-- Phantasialand
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Black Mamba', 2006-05-24, 'Bolliger & Mabillard', 80, 1500, 4.5, 26, 2, 32, 4, 768, 'Inverted Coaster', 60, 'Ouvert', 1);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Taron', 2016-06-30, 'Intamin', 117, 1200, 1.8, 30, 4, 16, 0, 1320, 'Launched Coaster', 100, 'Ouvert', 1);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Raik', 2016-06-30, 'Vekoma', 62, 720, NULL, 25, 1, 20, 0, 210, 'Boomerang coaster', 90, 'Ouvert', 1);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Chiapas', 2014-05-01, 'Intamin', 76, 1740, NULL, 15, 29, 6, 0, 620, 'Log Flume', 360, 'Ouvert', 1);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Colorado Adventure', 1996-05-11, 'Vekoma', 50, 2300, NULL, 26, 5, 32, 0, 1280, 'Mine Train', 175, 'Ouvert', 1);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Winjas Fear & Force', 2002-03-30, 'Maurer Rides', 66, 1440, NULL, 17.40, 14, 4, 0, 465, 'Spinning Coaster', 3, 'Ouvert', 1);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Maus au Chocolat', 2011-06-09, 'ETF Rides', NULL, 960, NULL, 0, 9, 12, 0, 350, 'Interactive Dark Ride', 420, 'Ouvert', 1);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'F.L.Y.', 2020-09-17, 'Vekoma', 78, 1400, 4.5, NULL, 4, 20, 2, 1236, 'Flying Launched Coaster', 107, 'Ouvert', 1);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'River Quest', 2002-07-27, 'HAFEMA', NULL, 960, NULL, 22, 18, 9, 0, 440, 'River Rapids', 360, 'Ouvert', 1);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Geister Rikscha', 1981-06-05, 'Schwarzkopf', NULL, 3600, NULL, NULL, 100, 3, 0, 250, 'Omnimover', 480, 'Ouvert', 1);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Würmling Express', 2010-06-01, 'Preston & Barbieri', 8, 330, NULL, 8, 12, 2, 0, 200, 'Family Coaster', 360, 'Ouvert', 1);

-- Europa-Park
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Blue Fire Megacoaster', 2009-04-01, 'Mack Rides', 100, 1200, 4, 38, 2, 20, 0, 1050, 'Launched Coaster', 3, 'Ouvert', 2);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Silver Star', 2002-04-01, 'Bolliger & Mabillard', 130, 1200, 4, 73, 3, 36, 0, 1620, 'Hyper Coaster', 3, 'Ouvert', 2);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Wodan Timbur Coaster', 2012-04-01, 'Great Coasters International', 100, 1200, 4, 40, 2, 24, 0, 1050, 'Wooden Coaster', 3, 'Ouvert', 2);

-- Disneyland Paris
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Hyperspace Mountain', 2005-04-01, 'Vekoma', 70, 1200, 3.5, 32, 2, 24, 2, 2000, 'Launched Coaster', 3, 'Ouvert', 3);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Big Thunder Mountain', 1992-04-01, 'Vekoma', 60, 1200, 3.5, 30, 2, 30, 0, 2000, 'Mine Train', 3, 'Ouvert', 3);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Pirates of the Caribbean', 1992-04-01, 'Intamin', 30, 3400, 1.95, 10, 50, 24, 0, 1000, 'Dark Ride', 10, 'Ouvert', 3);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Phantom Manor', 1992-04-01, 'Vekoma', 0, 1200, 0, 0, 0, 0, 0, 0, 'Dark Ride', 15, 'Ouvert', 3);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Indiana Jones et le Temple du Péril', 1993-04-01, 'Intamin', 60, 1200, 3.5, 25, 2, 20, 0, 1200, 'Mine Train', 3, 'Ouvert', 3);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Avengers Assemble', 2021-06-17, 'Vekoma', 0, 1200, 0, 0, 0, 0, 0, 0, 'Dark Ride', 9, 'Ouvert', 3);

-- Parc Astérix
INSERT INTO attraction values (sequence_id_attraction.nextval, 'OzIris', 2012-04-07, 'Bolliger & Mabillard', 90, 1600, NULL, 40, 3, 32, 5, 1000, 'Inverted Coaster', 135, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Pégase Express', 2017-06-11, 'Gerstlauer', 52, 1200, NULL, 20, 4, 20, 0, 928, 'Family Coaster', 120, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Tonnerre 2 Zeus', 1997-04-07, 'Custom Coasters International', 90, 1440, NULL, 29.90, 2, 24, 0, 1232.60, 'Wooden Coaster', 125, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Goudurix', 1989-04-30, 'Vekoma', 90, 1100, 4.5, 36.10, 2, 28, 7, 950, 'Steel Coaster', 80, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Trace du Hourra', 2001-03-31, 'Mack Rides', 60, 1500, NULL, 31, 5, 14, 0, 900, 'Bobsleigh', 170, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Menhir Express', 1995-04-07, 'Hopkins Ride', NULL, 1200, 0, 13, 30, 4, 0, 627, 'Log Flume', 300, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Grand Splatch', 1989-04-30, 'Intamin', NULL, 1400, 3.5, 11, 9, 20, 0, 627, 'Log Flume', 360, 'Ouvert', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Toutatis', 2023-04-08, 'Intamin', 110, 1260, NULL, 51, 3, 20, 3, 1075, 'Launched Coaster', 123, 'Ouvert', 4);

