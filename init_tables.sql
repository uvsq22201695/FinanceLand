-- Suppression des tables avec leurs contraintes
DECLARE
    v_sql VARCHAR2(4000);
BEGIN
    FOR table_name IN (
        SELECT table_name
        FROM user_tables
        WHERE table_name IN (
            'BILLET', 'TOURNIQUET', 'COMMANDE', 'CONTRAT', 'REDUCTION',
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
        WHERE sequence_name IN ('SEQUENCE_ID_ATTRACTION', 'SEQUENCE_ID_TRAVAUX','SEQUENCE_ID_CLIENT')
    ) LOOP
        v_sql := 'DROP SEQUENCE ' || seq_name.sequence_name;
        EXECUTE IMMEDIATE v_sql;
    END LOOP;
END;
/

-- Suppression des rôles existants
DECLARE
    v_sql VARCHAR2(4000);
BEGIN
    FOR role_name IN (
        SELECT granted_role AS role
        FROM user_role_privs
        WHERE granted_role IN (
            'C##DIRIGEANTS',
            'C##SERVICE_CLIENT',
            'C##DIRECTEUR_PARC',
            'C##RESPONSABLE_ATTRACTIONS',
            'C##GESTIONNAIRE_RH',
            'C##CLIENTS'
        )
    ) LOOP
        v_sql := 'DROP ROLE ' || role_name.role;
        EXECUTE IMMEDIATE v_sql;
    END LOOP;
END;
/

-- Ajout des séquences

CREATE SEQUENCE sequence_id_attraction
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE sequence_id_travaux
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE sequence_id_client
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
    date_debut DATE,
    date_fin DATE,
    constraint ch_tarif_prix CHECK (prix > 0),
    constraint chk_tarif_duree CHECK (duree_en_jour > 0),
    constraint chk_date_fin CHECK (date_fin >= date_debut or date_fin is null),
    constraint chk_prix check (nom_tarif = 'journalier' and prix = 50 or nom_tarif = '2 jours' and prix = 80 or nom_tarif = 'annuel' and prix = 500 or nom_tarif = 'nocturne' and prix = 30 or nom_tarif = 'noel' and prix = 60)
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
    CONSTRAINT fk_attraction_parc FOREIGN KEY (id_parc) REFERENCES parc(id_parc) ON DELETE CASCADE
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
    CONSTRAINT fk_travaux_attraction FOREIGN KEY (id_attraction) REFERENCES attraction(id_attraction) ON DELETE CASCADE
);

-- Création de la table 'employe'
CREATE TABLE employe (
    numero_de_securite_sociale NUMBER PRIMARY KEY,
    id_attraction NUMBER,
    nom VARCHAR2(100) NOT NULL,
    prenom VARCHAR2(100) NOT NULL,
    telephone VARCHAR2(20),
    email VARCHAR2(150),
    adresse VARCHAR2(200),
    ville VARCHAR2(100),
    pays VARCHAR2(100),
    CONSTRAINT fk_employe_attraction FOREIGN KEY (id_attraction) REFERENCES attraction(id_attraction) ON DELETE SET NULL
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
    CONSTRAINT chk_contrat_type_valide CHECK (type IN ('CDI', 'CDD', 'Stage', 'Alternance', 'Interim')),
    CONSTRAINT chk_contrat_dates CHECK (date_fin IS NULL OR date_fin >= date_debut),
    CONSTRAINT fk_contrat_employe FOREIGN KEY (numero_de_securite_sociale) REFERENCES employe(numero_de_securite_sociale) ON DELETE CASCADE
);

-- Création de la table 'commande'
CREATE TABLE commande (
    id_commande NUMBER PRIMARY KEY,
    id_client NUMBER,
    date_commande DATE,
    montant_total NUMBER,
    nb_billets NUMBER,
    CONSTRAINT fk_commande_client FOREIGN KEY (id_client) REFERENCES client(id_client),
    CONSTRAINT chk_commande_montant_total CHECK (montant_total >= 0),
    CONSTRAINT chk_commande_nb_billets_total CHECK (nb_billets >= 0)
);

-- Création de la table 'tourniquet'
CREATE TABLE tourniquet (
    id_attraction NUMBER NOT NULL,
    heure DATE NOT NULL,
    entree_ou_sortie VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_tourniquet_attraction FOREIGN KEY (id_attraction) REFERENCES attraction(id_attraction),
    CONSTRAINT chk_entree_ou_sortie CHECK (entree_ou_sortie IN ('entrée', 'sortie'))
);

-- Création de la table réduction
CREATE TABLE reduction (
    nom_reduction VARCHAR2(100) PRIMARY KEY,
    reduction NUMBER,
    date_debut DATE,
    date_fin DATE,
    constraint chk_reduction CHECK (reduction >= 0 and reduction < 1),
    constraint chk_reduction_date_fin CHECK (date_fin >= date_debut or date_fin is null)
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
    CONSTRAINT fk_billet_commande FOREIGN KEY (id_commande) REFERENCES commande(id_commande)ON DELETE CASCADE,
    CONSTRAINT fk_billet_tarif FOREIGN KEY (tarif) REFERENCES tarif(nom_tarif) ON DELETE SET NULL,
    CONSTRAINT fk_billet_reduction FOREIGN KEY (reduction) REFERENCES reduction(nom_reduction) ON DELETE SET NULL
);

-- Triggers

-- Procedure pour scanner un billet
create or replace procedure scanne_billet (id in number) as
    date_debut_validite date;  -- Date de début de validité du billet
    date_fin_validite date;  -- Date de fin de validité du billet
    scanne number;  -- Billet scanné ou non
begin
    -- Récupération des dates de validité et du statut de scan du billet
    select date_debut_validite into date_debut_validite from billet where billet.id_billet = id;
    select date_fin_validite into date_fin_validite from billet where billet.id_billet = id;
    select scanne into scanne from billet where billet.id_billet = id;

    -- Vérification des conditions de validité du billet
    if scanne = 1 then
        raise_application_error(-20001, 'Le billet a déjà été scanné');
    end if;

    if date_debut_validite > sysdate then
        raise_application_error(-20002, 'Le billet n''est pas encore valide');
    end if;

    if date_fin_validite < sysdate then
        raise_application_error(-20003, 'Le billet n''est plus valide');
    end if;

    -- Mise à jour du statut de scan du billet
    update billet set scanne = 1 where id_billet = id_billet;
end;

-- Trigger pour empecher la suppression de contrat finit il y a moins de 5 ans

CREATE OR REPLACE TRIGGER trg_contrat_delete
BEFORE DELETE ON contrat
FOR EACH ROW
BEGIN
    IF :OLD.date_fin >= SYSDATE - INTERVAL '5' YEAR THEN
        RAISE_APPLICATION_ERROR(-20001, 'Impossible de supprimer un contrat fini il y a moins de 5 ans');
    END IF;
END;

-- Trigger pour empecher un travail d'etre en cours ou terminé s'il n'y a pas de date de début

create or replace trigger trg_travaux_sans_date_debut
before insert or update on travaux
for each row
begin
    if (:new.etat = 'en cours' or :new.etat = 'terminé') and :new.date_debut is null then
        raise_application_error(-20001, 'Impossible de mettre un travail en cours sans date de début');
    end if;
end;

-- Trigger pour modifier l'état de l'attraction s'il y a ou non des travaux en cours.

create or replace trigger trg_attraction_etat
before insert or update on travaux
for each row
declare
    v_etat varchar2(50);
begin
    select etat into v_etat from attraction where id_attraction = :new.id_attraction;
    if :new.etat = 'en cours' and v_etat = 'ouverte' then
        update attraction set etat = 'en travaux' where id_attraction = :new.id_attraction;
    elsif :new.etat = 'terminé' and v_etat = 'en travaux' then
        update attraction set etat = 'ouverte' where id_attraction = :new.id_attraction;
    end if;
end;

-- Trigger pour vérifier qu'un billet "enfant" nécessite un billet "normal" ou "étudiant" pour la même commande et la même date,
-- C'est-à-dire qu'un billet "enfant" ne peut pas être acheté seul, il a besoin d'un accompagnateur.
CREATE OR REPLACE TRIGGER trg_billet_enfant
AFTER INSERT OR UPDATE ON billet
DECLARE
    normal_or_student_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO normal_or_student_count
    FROM billet b1
    WHERE b1.reduction = 'enfant'
      AND NOT EXISTS (
          SELECT 1
          FROM billet b2
          WHERE b1.id_commande = b2.id_commande
            AND b1.date_debut_validite = b2.date_debut_validite
            AND b2.reduction IN ('normal', 'étudiant')
      );

    IF normal_or_student_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Un billet "enfant" nécessite un billet "normal" ou "étudiant" pour la même commande et la même date.');
    END IF;
END;
/


-- Trigger pour calculer le prix total d'une commande
CREATE OR REPLACE TRIGGER trg_calcul_prix_total_commande
AFTER INSERT OR UPDATE ON billet
FOR EACH ROW
DECLARE
    v_prix NUMBER; -- Variable pour le prix du billet actuel
    v_reduction NUMBER; -- Variable pour la réduction éventuelle
    v_nb_billets NUMBER; -- Variable pour le nombre de billets
BEGIN
    -- Récupérer le prix du tarif du billet
    SELECT t.prix, NVL(r.reduction, 0)
    INTO v_prix, v_reduction
    FROM tarif t
    LEFT JOIN reduction r ON r.nom_reduction = :NEW.reduction
    WHERE t.nom_tarif = :NEW.tarif;

    -- Calculer le prix réel du billet après réduction
    v_prix := v_prix * (1 - v_reduction);

    IF INSERTING THEN
        -- Ajouter le prix du billet à la commande
        UPDATE commande
        SET montant_total = NVL(montant_total, 0) + v_prix,
            nb_billets = NVL(nb_billets, 0) + 1
        WHERE id_commande = :NEW.id_commande;

        SELECT nb_billets
        INTO v_nb_billets
        FROM commande
        WHERE id_commande = :NEW.id_commande;

        IF v_nb_billets = 8 THEN
            UPDATE commande
            SET montant_total = commande.montant_total * (1 - 0.10)
            WHERE id_commande = :NEW.id_commande;
        end if;

    ELSIF UPDATING THEN
        -- Calculer la différence entre l'ancien et le nouveau prix du billet
        DECLARE
            v_old_prix NUMBER;
            v_old_reduction NUMBER;
        BEGIN
            -- Récupérer l'ancien prix et réduction
            SELECT t.prix, NVL(r.reduction, 0)
            INTO v_old_prix, v_old_reduction
            FROM tarif t
            LEFT JOIN reduction r ON r.nom_reduction = :OLD.reduction
            WHERE t.nom_tarif = :OLD.tarif;

            -- Calculer le prix ancien après réduction
            v_old_prix := v_old_prix * (1 - v_old_reduction);

            -- Mettre à jour la commande en ajustant la différence
            UPDATE commande
            SET montant_total = NVL(montant_total, 0) + (v_prix - v_old_prix)
            WHERE id_commande = :NEW.id_commande;
        END;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_empêcher_entrée_si_attraction_fermée_ou_travaux
BEFORE INSERT ON tourniquet
FOR EACH ROW
DECLARE
    v_etat_attraction VARCHAR2(50);
BEGIN
    -- Récupérer l'état de l'attraction associée
    SELECT etat
    INTO v_etat_attraction
    FROM attraction
    WHERE id_attraction = :NEW.id_attraction;

    -- Vérifier si l'attraction est "fermée" ou "en travaux"
    IF v_etat_attraction IN ('fermée', 'en travaux') THEN
        -- Si l'attraction est fermée ou en travaux, lever une erreur
        RAISE_APPLICATION_ERROR(-20003, 'Impossible d''enregistrer une entrée pour une attraction fermée ou en travaux.');
    END IF;
END;


-- création d'une vue temps d'attente par attraction en se basant sur les tourniquets et la capacité horaire des attractions
CREATE OR REPLACE VIEW vue_temps_attente AS
SELECT
    a.nom AS nom_attraction,
    ROUND(((COUNT(t.id_attraction)-COUNT(t2.id_attraction)) / a.capacite_horaire) * 60, 2) AS temps_attente_moyen
FROM attraction a
LEFT JOIN tourniquet t ON a.id_attraction = t.id_attraction
LEFT JOIN tourniquet t2 ON a.id_attraction = t2.id_attraction AND t2.entree_ou_sortie = 'sortie'
WHERE t.entree_ou_sortie = 'entrée'
GROUP BY a.nom, a.capacite_horaire;


select * from vue_temps_attente;

SELECT a.nom, entrees.nb_entrees, sorties.nb_sorties
FROM attraction a
LEFT JOIN (
    SELECT t.id_attraction, COUNT(*) AS nb_entrees
    FROM tourniquet t
    WHERE t.entree_ou_sortie = 'entrée'
    GROUP BY t.id_attraction
) entrees ON a.id_attraction = entrees.id_attraction
LEFT JOIN (
    SELECT t.id_attraction, COUNT(*) AS nb_sorties
    FROM tourniquet t
    WHERE t.entree_ou_sortie = 'sortie'
    GROUP BY t.id_attraction
) sorties ON a.id_attraction = sorties.id_attraction;

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
INSERT INTO parc VALUES (15, 'Wonderland Adventure', DATE '2020-06-15', 120, 'Australie', 'Sydney');
INSERT INTO parc VALUES (16, 'Galaxy World', DATE '2019-09-20', 150, 'Canada', 'Toronto');
INSERT INTO parc VALUES (17, 'Dream Park', DATE '2021-07-01', 80, 'Japon', 'Tokyo');
INSERT INTO parc VALUES (18, 'Adventure City', DATE '2018-03-10', 95, 'Chine', 'Shanghai');
INSERT INTO parc VALUES (19, 'Future Fun', DATE '2017-11-05', 110, 'Corée du Sud', 'Séoul');
INSERT INTO parc VALUES (20, 'Fantasy Land', DATE '2022-04-25', 90, 'Mexique', 'Mexico');
INSERT INTO parc VALUES (21, 'Oceanic Thrills', DATE '2016-10-12', 130, 'Afrique du Sud', 'Cape Town');
INSERT INTO parc VALUES (22, 'Extreme Rides', DATE '2015-08-18', 140, 'Russie', 'Moscou');
INSERT INTO parc VALUES (23, 'Magic Horizons', DATE '2020-02-14', 100, 'Brésil', 'Rio de Janeiro');
INSERT INTO parc VALUES (24, 'Luna Park', DATE '2014-05-20', 60, 'Italie', 'Rome');
INSERT INTO parc VALUES (25, 'Skyline Adventures', DATE '2019-11-11', 150, 'Nouvelle-Zélande', 'Auckland');
INSERT INTO parc VALUES (26, 'Velocity Valley', DATE '2021-09-09', 200, 'États-Unis', 'Las Vegas');
INSERT INTO parc VALUES (27, 'Gravity Park', DATE '2018-12-25', 85, 'Espagne', 'Barcelone');
INSERT INTO parc VALUES (28, 'Sunset Thrills', DATE '2016-06-06', 100, 'Portugal', 'Lisbonne');
INSERT INTO parc VALUES (29, 'Moonlit Adventures', DATE '2023-03-21', 75, 'Grèce', 'Athènes');
INSERT INTO parc VALUES (30, 'Star Quest', DATE '2017-01-01', 120, 'Inde', 'Mumbai');

-- Insertions tarif
INSERT INTO tarif VALUES ('journalier', 50, 1, DATE '2021-01-01', null);
INSERT INTO tarif VALUES ('2 jours', 80, 2,  DATE '2021-01-01', null);
INSERT INTO tarif VALUES ('annuel', 500, 365,  DATE '2021-01-01', null);
INSERT INTO tarif VALUES ('nocturne', 30, 1,  DATE '2021-01-01', null);
INSERT INTO tarif VALUES ('noel', 60, 1,  DATE '2020-11-15', DATE '2021-12-31');

-- Insertions clients
INSERT INTO client VALUES (sequence_id_client.nextval, 'john.doe@example.com', 'Doe', 'John', '123 Main Street', '555-0101', 'Springfield', 'USA');
INSERT INTO client VALUES (sequence_id_client.nextval, 'jane.smith@example.com', 'Smith', 'Jane', '456 Elm Street', '555-0202', 'Shelbyville', 'USA');
INSERT INTO client VALUES (sequence_id_client.nextval, 'emily.johnson@example.com', 'Johnson', 'Emily', '789 Oak Avenue', '555-0303', 'Ogdenville', 'Canada');
INSERT INTO client VALUES (sequence_id_client.nextval, 'michael.brown@example.com', 'Brown', 'Michael', '321 Pine Lane', '555-0404', 'North Haverbrook', 'USA');
INSERT INTO client VALUES (sequence_id_client.nextval, 'sarah.davis@example.com', 'Davis', 'Sarah', '654 Maple Boulevard', '555-0505', 'Capital City', 'UK');
INSERT INTO client VALUES (sequence_id_client.nextval, 'david.wilson@example.com', 'Wilson', 'David', '987 Cedar Road', '555-0606', 'Springfield', 'Australia');
INSERT INTO client VALUES (sequence_id_client.nextval, 'lisa.taylor@example.com', 'Taylor', 'Lisa', '135 Willow Circle', '555-0707', 'Shelbyville', 'New Zealand');
INSERT INTO client VALUES (sequence_id_client.nextval, 'paul.martin@example.com', 'Martin', 'Paul', '246 Aspen Court', '555-0808', 'Ogdenville', 'Ireland');
INSERT INTO client VALUES (sequence_id_client.nextval, 'laura.thomas@example.com', 'Thomas', 'Laura', '357 Birch Way', '555-0909', 'North Haverbrook', 'France');
INSERT INTO client VALUES (sequence_id_client.nextval, 'james.moore@example.com', 'Moore', 'James', '468 Cherry Street', '555-1010', 'Capital City', 'Germany');
INSERT INTO client VALUES (sequence_id_client.nextval, 'ana.robin@example.com', 'Robin', 'Ana', '10 Rue Jean Moulin', '0756123487', 'Grenoble', 'France');
INSERT INTO client VALUES (sequence_id_client.nextval, 'marc.garcia@example.com', 'Garcia', 'Marc', '11 Rue de Provence', '0623456790', 'Dijon', 'France');
INSERT INTO client VALUES (sequence_id_client.nextval, 'elise.benoit@example.com', 'Benoit', 'Elise', '12 Rue des Carmes', '0645236789', 'Le Havre', 'France');
INSERT INTO client VALUES (sequence_id_client.nextval, 'nathan.morel@example.com', 'Morel', 'Nathan', '13 Rue du Marché', '0634236789', 'Toulon', 'France');
INSERT INTO client VALUES (sequence_id_client.nextval, 'ines.bernard@example.com', 'Bernard', 'Ines', '14 Rue Saint-Honoré', '0612234789', 'Saint-Étienne', 'France');
INSERT INTO client VALUES (sequence_id_client.nextval, 'emilie.martinez@example.com', 'Martinez', 'Emilie', '15 Rue de la République', '0698123456', 'Rennes', 'France');
INSERT INTO client VALUES (sequence_id_client.nextval, 'mathieu.fabre@example.com', 'Fabre', 'Mathieu', '16 Rue de Metz', '0623456789', 'Aix-en-Provence', 'France');
INSERT INTO client VALUES (sequence_id_client.nextval, 'lea.clement@example.com', 'Clément', 'Lea', '17 Rue des Peupliers', '0678236789', 'Montpellier', 'France');
INSERT INTO client VALUES (sequence_id_client.nextval, 'juliette.david@example.com', 'David', 'Juliette', '18 Rue des Acacias', '0654123678', 'Orléans', 'France');
INSERT INTO client VALUES (sequence_id_client.nextval, 'maxime.renard@example.com', 'Renard', 'Maxime', '19 Avenue de l''Europe', '0687345678', 'Clermont-Ferrand', 'France');
INSERT INTO client VALUES (sequence_id_client.nextval, 'emilie.dupuis@example.com', 'Dupuis', 'Emilie', '20 Rue des Lilas', '0645123789', 'Nancy', 'France');
INSERT INTO client VALUES (sequence_id_client.nextval, 'vincent.robert@example.com', 'Robert', 'Vincent', '21 Rue des Tulipes', '0698123478', 'Metz', 'France');
INSERT INTO client VALUES (sequence_id_client.nextval, 'sophie.lopez@example.com', 'Lopez', 'Sophie', '22 Boulevard Gambetta', '0634234789', 'Tours', 'France');
INSERT INTO client VALUES (sequence_id_client.nextval, 'lucas.navarro@example.com', 'Navarro', 'Lucas', '23 Rue des Mimosas', '0687345789', 'Angers', 'France');
INSERT INTO client VALUES (sequence_id_client.nextval, 'melanie.dumont@example.com', 'Dumont', 'Melanie', '24 Avenue Jules Ferry', '0623456897', 'Perpignan', 'France');
INSERT INTO client VALUES (sequence_id_client.nextval, 'etienne.guillaume@example.com', 'Guillaume', 'Etienne', '25 Rue de Lorraine', '0654123489', 'Limoges', 'France');
INSERT INTO client VALUES (sequence_id_client.nextval, 'florence.roger@example.com', 'Roger', 'Florence', '26 Rue de l''Abbaye', '0678123467', 'Béziers', 'France');
INSERT INTO client VALUES (sequence_id_client.nextval, 'quentin.lefevre@example.com', 'Lefevre', 'Quentin', '27 Rue de la Liberté', '0689234789', 'Pau', 'France');
INSERT INTO client VALUES (sequence_id_client.nextval, 'helene.durieux@example.com', 'Durieux', 'Helene', '28 Rue des Vignes', '0612234689', 'Avignon', 'France');
INSERT INTO client VALUES (sequence_id_client.nextval, 'thibault.rousseau@example.com', 'Rousseau', 'Thibault', '29 Rue des Marronniers', '0698123467', 'Valence', 'France');

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
INSERT INTO attraction values (sequence_id_attraction.nextval, 'OzIris', DATE'2012-04-07', 'Bolliger & Mabillard', 90, 1600, 3.2, 40, 3, 32, 5, 1000, 'Inverted Coaster', 135, 'ouverte', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Pégase Express', DATE'2017-06-11', 'Gerstlauer', 52, 1200, 2.1, 20, 4, 20, 0, 928, 'Family Coaster', 120, 'ouverte', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Tonnerre 2 Zeus', DATE'1997-04-07', 'Custom Coasters International', 90, 1440, 2.1, 29.90, 2, 24, 0, 1232.60, 'Wooden Coaster', 125, 'ouverte', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Goudurix', DATE'1989-04-30', 'Vekoma', 90, 1100, 4.5, 36.10, 2, 28, 7, 950, 'Steel Coaster', 80, 'ouverte', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Trace du Hourra', DATE'2001-03-31', 'Mack Rides', 60, 1500, 1.8, 31, 5, 14, 0, 900, 'Bobsleigh', 170, 'ouverte', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Menhir Express', DATE'1995-04-07', 'Hopkins Ride', 36, 1200, 0, 13, 30, 4, 0, 627, 'Log Flume', 300, 'ouverte', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Grand Splatch', DATE'1989-04-30', 'Intamin', 42, 1400, 3.5, 11, 9, 20, 0, 627, 'Log Flume', 360, 'ouverte', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Toutatis', DATE'2023-04-08', 'Intamin', 110, 1260, 1.1, 51, 3, 20, 3, 1075, 'Launched Coaster', 123, 'ouverte', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Le vol d\Icare', DATE'1994-04-07', 'Zierer', 42, 1150, 1, 10.70, 5, 4, 0, 410, 'Family Coaster', 75, 'ouverte', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'SOS Tournevis', DATE'1990-04-30', 'Zierer', 32, 1000, 1.2, 6, 1, 30, 0, 199, 'Family Coaster', 90, 'ouverte', 4);
INSERT INTO attraction values (sequence_id_attraction.nextval, 'Romus et Rapidus', DATE'2004-04-07', 'Hopkins Ride', 22, 1200, 0, 13, 30, 4, 0, 627, 'Log Flume', 300, 'ouverte', 4);

-- Insertions travaux

insert into travaux values (sequence_id_travaux.nextval, 1, DATE '2021-01-01', DATE '2021-01-15', 'Maintenance annuelle', 10000, 'terminé', 'Reparator 3000');
insert into travaux values (sequence_id_travaux.nextval, 2, DATE '2021-01-01', DATE '2021-01-15', 'Maintenance annuelle', 10000, 'terminé', 'Attraction Comme Neuves INC');
insert into travaux values (sequence_id_travaux.nextval, 3, DATE '2021-01-01', DATE '2021-01-15', 'Rethématisation', 10000, 'terminé', 'DecoraMax');
insert into travaux values (sequence_id_travaux.nextval, 4, DATE '2021-01-01', DATE '2021-01-15', 'Maintenance annuelle', 10000, 'terminé', 'Reparator 3000');
insert into travaux values (sequence_id_travaux.nextval, 5, DATE '2021-01-01', DATE '2021-01-15', 'Maintenance annuelle', 10000, 'terminé', 'Attraction Comme Neuves INC');
insert into travaux values (sequence_id_travaux.nextval, 6, DATE '2021-01-01', DATE '2021-01-15', 'Rethématisation', 10000, 'terminé', 'DecoraMax');
insert into travaux values (sequence_id_travaux.nextval, 7, DATE '2021-01-01', DATE '2021-01-15', 'Maintenance annuelle', 10000, 'terminé', 'Reparator 3000');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 1, DATE '2021-02-01', DATE '2021-02-10', 'Révision matérielle', 12000, 'terminé', 'FixIt Fast');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 2, DATE '2021-03-01', DATE '2021-03-15', 'Maintenance annuelle', 8000, 'terminé', 'Reparator 3000');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 3, DATE '2021-04-05', DATE '2021-04-20', 'Test de sécurité', 15000, 'terminé', 'SafeCheck Pro');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 4, DATE '2021-05-01', DATE '2021-05-10', 'Réparation urgente', 20000, 'terminé', 'RepairHub');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 5, DATE '2021-06-01', DATE '2021-06-12', 'Amélioration technique', 18000, 'terminé', 'TechnoPatch');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 6, DATE '2021-07-10', DATE '2021-07-25', 'Maintenance annuelle', 10000, 'prévu', 'FixIt Fast');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 7, DATE '2021-08-01', DATE '2021-08-20', 'Test de sécurité', 16000, 'terminé', 'SafeCheck Pro');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 8, DATE '2021-09-01', DATE '2021-09-15', 'Révision matérielle', 14000, 'terminé', 'Reparator 3000');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 9, DATE '2021-10-01', DATE '2021-10-20', 'Réparation urgente', 22000, 'terminé', 'RepairHub');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 10, DATE '2021-11-01', DATE '2021-11-15', 'Amélioration technique', 17000, 'terminé', 'TechnoPatch');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 11, DATE '2021-12-01', DATE '2021-12-10', 'Maintenance annuelle', 12000, 'terminé', 'FixIt Fast');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 12, DATE '2021-02-15', DATE '2021-03-01', 'Réparation urgente', 25000, 'terminé', 'RepairHub');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 13, DATE '2021-03-10', DATE '2021-03-25', 'Test de sécurité', 20000, 'terminé', 'SafeCheck Pro');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 14, DATE '2021-04-15', DATE '2021-05-05', 'Amélioration technique', 30000, 'prévu', 'TechnoPatch');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 15, DATE '2021-05-10', DATE '2021-05-25', 'Maintenance annuelle', 9000, 'terminé', 'Reparator 3000');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 16, DATE '2021-06-15', DATE '2021-07-01', 'Réparation urgente', 24000, 'terminé', 'FixIt Fast');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 17, DATE '2021-07-20', DATE '2021-08-10', 'Révision matérielle', 15000, 'terminé', 'RepairHub');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 18, DATE '2021-08-25', DATE '2021-09-10', 'Test de sécurité', 12000, 'terminé', 'SafeCheck Pro');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 19, DATE '2021-10-01', DATE '2021-10-15', 'Amélioration technique', 21000, 'terminé', 'TechnoPatch');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 20, DATE '2021-11-10', DATE '2021-11-25', 'Maintenance annuelle', 10000, 'prévu', 'Reparator 3000');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 21, DATE '2021-01-10', DATE '2021-01-20', 'Test de sécurité', 13000, 'terminé', 'SafeCheck Pro');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 22, DATE '2021-02-05', DATE '2021-02-15', 'Révision matérielle', 17000, 'terminé', 'Reparator 3000');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 23, DATE '2021-03-05', DATE '2021-03-18', 'Maintenance annuelle', 12000, 'terminé', 'FixIt Fast');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 24, DATE '2021-04-05', DATE '2021-04-15', 'Réparation urgente', 25000, 'prévu', 'RepairHub');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 25, DATE '2021-05-10', DATE '2021-05-20', 'Amélioration technique', 30000, 'terminé', 'TechnoPatch');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 26, DATE '2021-06-15', DATE '2021-06-25', 'Test de sécurité', 22000, 'terminé', 'SafeCheck Pro');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 27, DATE '2021-07-01', DATE '2021-07-10', 'Maintenance annuelle', 15000, 'terminé', 'Reparator 3000');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 28, DATE '2021-08-05', DATE '2021-08-15', 'Révision matérielle', 16000, 'terminé', 'FixIt Fast');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 29, DATE '2021-09-10', DATE '2021-09-20', 'Maintenance annuelle', 18000, 'terminé', 'RepairHub');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 30, DATE '2021-10-05', DATE '2021-10-15', 'Test de sécurité', 25000, 'terminé', 'SafeCheck Pro');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 31, DATE '2021-11-15', DATE '2021-11-25', 'Réparation urgente', 26000, 'prévu', 'RepairHub');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 32, DATE '2021-12-01', DATE '2021-12-12', 'Maintenance annuelle', 14000, 'terminé', 'TechnoPatch');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 33, DATE '2021-01-05', DATE '2021-01-15', 'Révision matérielle', 16000, 'terminé', 'FixIt Fast');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 34, DATE '2021-02-10', DATE '2021-02-20', 'Test de sécurité', 18000, 'terminé', 'SafeCheck Pro');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 1, DATE '2023-01-10', DATE '2023-01-20', 'Inspection de sécurité', 12000, 'terminé', 'SafeCheck Pro');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 1, DATE '2024-05-15', DATE '2025-06-01', 'Réparation majeure', 35000, 'en cours', 'RepairHub');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 2, DATE '2023-03-01', DATE '2023-03-15', 'Amélioration technique', 20000, 'terminé', 'TechnoPatch');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 2, DATE '2024-07-10', DATE '2024-07-25', 'Maintenance annuelle', 15000, 'prévu', 'FixIt Fast');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 3, DATE '2024-02-20', DATE '2024-03-05', 'Révision matérielle', 14000, 'terminé', 'Reparator 3000');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 3, DATE '2023-11-01', DATE '2023-11-20', 'Test de sécurité', 16000, 'terminé', 'SafeCheck Pro');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 4, DATE '2023-06-01', DATE '2023-06-15', 'Réparation urgente', 25000, 'terminé', 'RepairHub');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 4, DATE '2024-09-01', DATE '2025-09-15', 'Amélioration technique', 28000, 'en cours', 'TechnoPatch');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 5, DATE '2023-08-01', DATE '2023-08-10', 'Maintenance annuelle', 10000, 'terminé', 'Reparator 3000');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 5, DATE '2024-10-15', DATE '2024-10-30', 'Inspection de sécurité', 12000, 'prévu', 'SafeCheck Pro');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 6, DATE '2023-05-01', DATE '2023-05-10', 'Révision matérielle', 11000, 'terminé', 'FixIt Fast');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 6, DATE '2024-11-01', DATE '2025-11-10', 'Réparation urgente', 18000, 'en cours', 'RepairHub');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 7, DATE '2023-04-15', DATE '2023-04-30', 'Test de sécurité', 15000, 'terminé', 'SafeCheck Pro');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 7, DATE '2024-12-01', DATE '2024-12-15', 'Amélioration technique', 22000, 'prévu', 'TechnoPatch');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 8, DATE '2023-09-01', DATE '2023-09-10', 'Maintenance annuelle', 9000, 'terminé', 'Reparator 3000');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 8, DATE '2024-03-01', DATE '2024-03-15', 'Révision matérielle', 14000, 'terminé', 'FixIt Fast');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 9, DATE '2023-02-01', DATE '2023-02-10', 'Réparation urgente', 30000, 'terminé', 'RepairHub');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 9, DATE '2024-04-10', DATE '2024-04-20', 'Test de sécurité', 16000, 'terminé', 'SafeCheck Pro');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 10, DATE '2023-12-01', DATE '2023-12-10', 'Amélioration technique', 25000, 'prévu', 'TechnoPatch');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 10, DATE '2024-06-10', DATE '2024-06-20', 'Maintenance annuelle', 12000, 'terminé', 'Reparator 3000');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 1, TRUNC(SYSDATE, 'YEAR') - INTERVAL '10' MONTH, TRUNC(SYSDATE, 'YEAR') - INTERVAL '9' MONTH, 'Révision annuelle', 15000, 'terminé', 'FixIt Fast');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 1, TRUNC(SYSDATE, 'YEAR') - INTERVAL '6' MONTH, TRUNC(SYSDATE, 'YEAR') - INTERVAL '5' MONTH, 'Test de sécurité', 12000, 'terminé', 'SafeCheck Pro');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 5, TRUNC(SYSDATE, 'YEAR') - INTERVAL '11' MONTH, TRUNC(SYSDATE, 'YEAR') - INTERVAL '10' MONTH, 'Maintenance préventive', 18000, 'terminé', 'RepairHub');
INSERT INTO travaux VALUES (sequence_id_travaux.nextval, 5, TRUNC(SYSDATE, 'YEAR') - INTERVAL '3' MONTH, TRUNC(SYSDATE, 'YEAR') - INTERVAL '2' MONTH, 'Amélioration technique', 20000, 'terminé', 'TechnoPatch');


-- Insertions employés

INSERT INTO employe VALUES (100000001, 5, 'Dupont', 'Jean', '0123456789', 'jean.dupont@example.com', '10 Brühl Avenue', 'Brühl','Allemagne');
INSERT INTO employe VALUES (100000002, 12, 'Martin', 'Sophie', '0234567890', 'sophie.martin@example.com', '20 Rust Street', 'Rust','Allemagne');
INSERT INTO employe VALUES (100000003, 8, 'Bernard', 'Luc', '0345678901', 'luc.bernard@example.com', '30 Disneyland Road', 'Marne-la-Vallée', 'France');
INSERT INTO employe VALUES (100000004, 15, 'Durand', 'Emma', '0456789012', 'emma.durand@example.com', '40 Asterix Boulevard', 'Plailly', 'France');
INSERT INTO employe VALUES (100000005, 20, 'Moreau', 'Louis', '0567890123', 'louis.moreau@example.com', '50 Futuroscope Way', 'Chasseneuil-du-Poitou', 'France');
INSERT INTO employe VALUES (100000006, 25, 'Roux', 'Julie', '0678901234', 'julie.roux@example.com', '60 Walibi Lane', 'Les Avenières', 'France');
INSERT INTO employe VALUES (100000007, 30, 'Petit', 'Paul', '0789012345', 'paul.petit@example.com', '70 Sud-Ouest Drive', 'Roquefort', 'France');
INSERT INTO employe VALUES (100000008, 34, 'Richard', 'Claire', '0890123456', 'claire.richard@example.com', '80 Alton Towers Road', 'Alton', 'Royaume-Uni');
INSERT INTO employe VALUES (100000009, 2, 'Durand', 'Marc', '0901234567', 'marc.durand@example.com', '90 Thorpe Park Lane', 'Chertsey', 'Royaume-Uni');
INSERT INTO employe VALUES (100000010, 6, 'Dubois', 'Marie', '0112345678', 'marie.dubois@example.com', '100 PortAventura Street', 'Salou', 'Espagne');
INSERT INTO employe VALUES (100000011, 14, 'Blanc', 'Alice', '0123456789', 'alice.blanc@example.com', '110 Disney Drive', 'Anaheim', 'États-Unis');
INSERT INTO employe VALUES (100000012, 10, 'Fabre', 'Hugo', '0234567890', 'hugo.fabre@example.com', '120 Universal Boulevard', 'Los Angeles', 'États-Unis');
INSERT INTO employe VALUES (100000013, 18, 'Lemoine', 'Sarah', '0345678901', 'sarah.lemoine@example.com', '130 Six Flags Road', 'Valencia', 'États-Unis');
INSERT INTO employe VALUES (100000014, 22, 'Noir', 'Lucas', '0456789012', 'lucas.noir@example.com', '140 Cedar Avenue', 'Sandusky', 'États-Unis');
INSERT INTO employe VALUES (100000015, 9, 'Clément', 'Chloe', '0567890123', 'chloe.clement@example.com', '150 Brühl Avenue', 'Brühl', 'Allemagne');
INSERT INTO employe VALUES (100000016, 11, 'Perrin', 'Thomas', '0678901234', 'thomas.perrin@example.com', '160 Rust Street', 'Rust', 'Allemagne');
INSERT INTO employe VALUES (100000017, 16, 'Leclerc', 'Emma', '0789012345', 'emma.leclerc@example.com', '170 Disneyland Road', 'Marne-la-Vallée', 'France');
INSERT INTO employe VALUES (100000018, 21, 'Lemoine', 'Victor', '0890123456', 'victor.lemoine@example.com', '180 Asterix Boulevard', 'Plailly', 'France');
INSERT INTO employe VALUES (100000019, 19, 'Simon', 'Anais', '0901234567', 'anais.simon@example.com', '190 Futuroscope Way', 'Chasseneuil-du-Poitou', 'France');
INSERT INTO employe VALUES (100000020, 24, 'Michel', 'Arthur', '0112345678', 'arthur.michel@example.com', '200 Walibi Lane', 'Les Avenières', 'France');
INSERT INTO employe VALUES (100000021, 27, 'Garcia', 'Elisa', '0123456789', 'elisa.garcia@example.com', '210 Sud-Ouest Drive', 'Roquefort', 'France');
INSERT INTO employe VALUES (100000022, 28, 'Fernandez', 'Nathan', '0234567890', 'nathan.fernandez@example.com', '220 Alton Towers Road', 'Alton', 'Royaume-Uni');
INSERT INTO employe VALUES (100000023, 3, 'Lopez', 'Camille', '0345678901', 'camille.lopez@example.com', '230 Thorpe Park Lane', 'Chertsey', 'Royaume-Uni');
INSERT INTO employe VALUES (100000024, 7, 'Morin', 'Julien', '0456789012', 'julien.morin@example.com', '240 PortAventura Street', 'Salou', 'Espagne');
INSERT INTO employe VALUES (100000025, 13, 'Morel', 'Celine', '0567890123', 'celine.morel@example.com', '250 Disney Drive', 'Anaheim', 'États-Unis');
INSERT INTO employe VALUES (100000026, 4, 'Guerin', 'Leo', '0678901234', 'leo.guerin@example.com', '260 Universal Boulevard', 'Los Angeles', 'États-Unis');
INSERT INTO employe VALUES (100000027, 23, 'Fournier', 'Eva', '0789012345', 'eva.fournier@example.com', '270 Six Flags Road', 'Valencia', 'États-Unis');
INSERT INTO employe VALUES (100000028, 17, 'Girard', 'Adam', '0890123456', 'adam.girard@example.com', '280 Cedar Avenue', 'Sandusky', 'États-Unis');
INSERT INTO employe VALUES (100000029, 26, 'Andre', 'Lola', '0901234567', 'lola.andre@example.com', '290 Brühl Avenue', 'Brühl', 'Allemagne');
INSERT INTO employe VALUES (100000030, 31, 'Mercier', 'Noah', '0112345678', 'noah.mercier@example.com', '300 Rust Street', 'Rust', 'Allemagne');
INSERT INTO employe VALUES (100000031, 32, 'Dupuis', 'Alice', '0123456789', 'alice.dupuis@example.com', '310 Disneyland Road', 'Marne-la-Vallée', 'France');
INSERT INTO employe VALUES (100000032, 33, 'Lambert', 'Louis', '0234567890', 'louis.lambert@example.com', '320 Asterix Boulevard', 'Plailly', 'France');
INSERT INTO employe VALUES (100000033, 29, 'Fontaine', 'Sophie', '0345678901', 'sophie.fontaine@example.com', '330 Futuroscope Way', 'Chasseneuil-du-Poitou', 'France');
INSERT INTO employe VALUES (100000034, 2, 'Roche', 'Emma', '0456789012', 'emma.roche@example.com', '340 Walibi Lane', 'Les Avenières', 'France');
INSERT INTO employe VALUES (100000035, 1, 'Chevalier', 'Hugo', '0567890123', 'hugo.chevalier@example.com', '350 Sud-Ouest Drive', 'Roquefort', 'France');
INSERT INTO employe VALUES (100000036, 12, 'Francois', 'Paul', '0678901234', 'paul.francois@example.com', '360 Alton Towers Road', 'Alton', 'Royaume-Uni');
INSERT INTO employe VALUES (100000037, 18, 'Perrot', 'Lucas', '0789012345', 'lucas.perrot@example.com', '370 Thorpe Park Lane', 'Chertsey', 'Royaume-Uni');
INSERT INTO employe VALUES (100000038, 20, 'Lemoine', 'Sarah', '0890123456', 'sarah.lemoine@example.com', '380 PortAventura Street', 'Salou', 'Espagne');
INSERT INTO employe VALUES (100000039, 14, 'Benoit', 'Julien', '0901234567', 'julien.benoit@example.com', '390 Disney Drive', 'Anaheim', 'États-Unis');
INSERT INTO employe VALUES (100000040, 10, 'Antoine', 'Eve', '0112345678', 'eve.antoine@example.com', '400 Universal Boulevard', 'Los Angeles', 'États-Unis');
INSERT INTO employe VALUES (100000041, 30, 'Navarro', 'Chloe', '0123456789', 'chloe.navarro@example.com', '410 Six Flags Road', 'Valencia', 'États-Unis');
INSERT INTO employe VALUES (100000042, 21, 'Renaud', 'Victor', '0234567890', 'victor.renaud@example.com', '420 Cedar Avenue', 'Sandusky', 'États-Unis');
INSERT INTO employe VALUES (100000043, 9, 'Lemoine', 'Anais', '0345678901', 'anais.lemoine@example.com', '430 Brühl Avenue', 'Brühl', 'Allemagne');

-- Insertions contrats

INSERT INTO contrat VALUES (1, 100000001, DATE '2022-01-01', SYSDATE + INTERVAL '2' MONTH, 'Technicien', 2500, 'CDI');
INSERT INTO contrat VALUES (2, 100000002, DATE '2021-05-01', DATE '2023-05-01', 'Manager', 3500, 'CDD');
INSERT INTO contrat VALUES (3, 100000003, DATE '2020-09-01', SYSDATE + INTERVAL '1' MONTH, 'Agent d''entretien', 1800, 'CDI');
INSERT INTO contrat VALUES (4, 100000004, DATE '2022-06-15', DATE '2023-06-15', 'Responsable attraction', 3200, 'Stage');
INSERT INTO contrat VALUES (5, 100000005, DATE '2023-02-01', NULL, 'Administrateur', 4000, 'Alternance');
INSERT INTO contrat VALUES (6, 100000006, DATE '2021-09-01', DATE '2022-09-01', 'Technicien', 2700, 'CDD');
INSERT INTO contrat VALUES (7, 100000007, DATE '2023-03-01', NULL, 'Manager', 3600, 'CDI');
INSERT INTO contrat VALUES (8, 100000008, DATE '2020-07-01', DATE '2023-07-01', 'Agent d''entretien', 1900, 'CDD');
INSERT INTO contrat VALUES (9, 100000009, DATE '2022-05-01', NULL, 'Responsable attraction', 3400, 'CDI');
INSERT INTO contrat VALUES (10, 100000010, DATE '2023-01-15', DATE '2023-12-31', 'Administrateur', 4100, 'Stage');
INSERT INTO contrat VALUES (11, 100000011, DATE '2021-11-01', DATE '2022-11-01', 'Technicien', 2600, 'CDD');
INSERT INTO contrat VALUES (12, 100000012, DATE '2022-10-01', DATE '2024-10-01', 'Manager', 3700, 'CDI');
INSERT INTO contrat VALUES (13, 100000013, DATE '2021-06-15', DATE '2023-06-15', 'Agent d''entretien', 2000, 'CDD');
INSERT INTO contrat VALUES (14, 100000014, DATE '2022-03-01', DATE '2022-12-31', 'Responsable attraction', 3300, 'Stage');
INSERT INTO contrat VALUES (15, 100000015, DATE '2020-09-01', NULL, 'Administrateur', 4200, 'Alternance');
INSERT INTO contrat VALUES (16, 100000016, DATE '2023-02-01', DATE '2024-02-01', 'Technicien', 2800, 'CDI');
INSERT INTO contrat VALUES (17, 100000017, DATE '2022-01-01', DATE '2023-01-01', 'Manager', 3800, 'CDD');
INSERT INTO contrat VALUES (18, 100000018, DATE '2021-08-01', NULL, 'Agent d''entretien', 2100, 'CDI');
INSERT INTO contrat VALUES (19, 100000019, DATE '2022-11-01', DATE '2024-11-01', 'Responsable attraction', 3500, 'CDD');
INSERT INTO contrat VALUES (20, 100000020, DATE '2020-04-01', DATE '2022-04-01', 'Administrateur', 4300, 'CDI');
INSERT INTO contrat VALUES (21, 100000021, DATE '2021-10-01', DATE '2022-10-01', 'Technicien', 2400, 'CDD');
INSERT INTO contrat VALUES (22, 100000022, DATE '2022-06-01', DATE '2024-06-01', 'Manager', 3900, 'Alternance');
INSERT INTO contrat VALUES (23, 100000023, DATE '2020-12-01', DATE '2023-12-01', 'Agent d''entretien', 2200, 'CDI');
INSERT INTO contrat VALUES (24, 100000024, DATE '2021-07-01', DATE '2022-07-01', 'Responsable attraction', 3100, 'Stage');
INSERT INTO contrat VALUES (25, 100000025, DATE '2022-03-01', NULL, 'Administrateur', 4400, 'CDI');
INSERT INTO contrat VALUES (26, 100000026, DATE '2023-01-15', DATE '2023-12-15', 'Technicien', 2900, 'CDD');
INSERT INTO contrat VALUES (27, 100000027, DATE '2020-09-01', DATE '2022-09-01', 'Manager', 4000, 'CDI');
INSERT INTO contrat VALUES (28, 100000028, DATE '2021-11-01', DATE '2023-11-01', 'Agent d''entretien', 2300, 'CDD');
INSERT INTO contrat VALUES (29, 100000029, DATE '2022-02-01', DATE '2024-02-01', 'Responsable attraction', 3600, 'Alternance');
INSERT INTO contrat VALUES (30, 100000030, DATE '2021-08-01', NULL, 'Administrateur', 4500, 'CDI');
INSERT INTO contrat VALUES (31, 100000031, DATE '2022-03-01', DATE '2024-03-01', 'Technicien', 2500, 'CDI');
INSERT INTO contrat VALUES (32, 100000032, DATE '2023-01-15', NULL, 'Responsable attraction', 3200, 'Alternance');
INSERT INTO contrat VALUES (33, 100000033, DATE '2022-06-01', DATE '2023-06-01', 'Manager', 3500, 'CDD');
INSERT INTO contrat VALUES (34, 100000034, DATE '2021-09-01', DATE '2023-09-01', 'Agent d''entretien', 2000, 'CDD');
INSERT INTO contrat VALUES (35, 100000035, DATE '2022-11-01', DATE '2024-11-01', 'Administrateur', 4000, 'CDI');
INSERT INTO contrat VALUES (36, 100000036, DATE '2020-07-01', DATE '2022-07-01', 'Technicien', 2800, 'CDD');
INSERT INTO contrat VALUES (37, 100000037, DATE '2023-05-01', NULL, 'Responsable attraction', 3300, 'CDI');
INSERT INTO contrat VALUES (38, 100000038, DATE '2021-08-15', DATE '2023-08-15', 'Manager', 3700, 'CDD');
INSERT INTO contrat VALUES (39, 100000039, DATE '2022-12-01', DATE '2023-12-01', 'Agent d''entretien', 2200, 'Alternance');
INSERT INTO contrat VALUES (40, 100000040, DATE '2020-04-01', NULL, 'Administrateur', 4500, 'CDI');
INSERT INTO contrat VALUES (41, 100000041, DATE '2023-02-01', DATE '2024-02-01', 'Technicien', 2700, 'CDD');
INSERT INTO contrat VALUES (42, 100000042, DATE '2022-09-01', DATE '2023-09-01', 'Responsable attraction', 3600, 'CDD');
INSERT INTO contrat VALUES (43, 100000043, DATE '2021-03-01', NULL, 'Manager', 3900, 'CDI');

-- Insertions commandes

INSERT INTO commande VALUES (1, 12, DATE '2023-11-01', 0, 0);
INSERT INTO commande VALUES (2, 7, DATE '2023-11-02', 0, 0);
INSERT INTO commande VALUES (3, 23, DATE '2023-11-03', 0, 0);
INSERT INTO commande VALUES (4, 5, DATE '2023-11-04', 0, 0);
INSERT INTO commande VALUES (5, 19, DATE '2023-11-05', 0, 0);
INSERT INTO commande VALUES (6, 15, DATE '2023-11-06', 0, 0);
INSERT INTO commande VALUES (7, 8, DATE '2023-11-07', 0, 0);
INSERT INTO commande VALUES (8, 27, DATE '2022-11-08', 0, 0);
INSERT INTO commande VALUES (9, 1, DATE '2023-11-09', 0, 0);
INSERT INTO commande VALUES (10, 29, DATE '2023-11-10', 0, 0);
INSERT INTO commande VALUES (11, 6, DATE '2023-11-11', 0, 0);
INSERT INTO commande VALUES (12, 18, DATE '2023-11-12', 0, 0);
INSERT INTO commande VALUES (13, 14, DATE '2023-11-13', 0, 0);
INSERT INTO commande VALUES (14, 21, DATE '2023-11-14', 0, 0);
INSERT INTO commande VALUES (15, 9, DATE '2023-11-15', 0, 0);
INSERT INTO commande VALUES (16, 3, DATE '2023-11-16', 0, 0);
INSERT INTO commande VALUES (17, 10, DATE '2023-11-17', 0, 0);
INSERT INTO commande VALUES (18, 22, DATE '2023-11-18', 0, 0);
INSERT INTO commande VALUES (19, 26, DATE '2023-11-19', 0, 0);
INSERT INTO commande VALUES (20, 4, DATE '2023-11-20', 0, 0);
INSERT INTO commande VALUES (21, 25, DATE '2023-11-21', 0, 0);
INSERT INTO commande VALUES (22, 2, DATE '2023-11-22', 0, 0);
INSERT INTO commande VALUES (23, 17, DATE '2023-11-23', 0, 0);
INSERT INTO commande VALUES (24, 13, DATE '2023-11-24', 0, 0);
INSERT INTO commande VALUES (25, 19, DATE '2023-11-25', 0, 0);
INSERT INTO commande VALUES (26, 11, DATE '2023-11-26', 0, 0);
INSERT INTO commande VALUES (27, 29, DATE '2023-11-27', 0, 0);
INSERT INTO commande VALUES (28, 16, DATE '2023-11-28', 0, 0);
INSERT INTO commande VALUES (29, 8, DATE '2023-11-29', 0, 0);
INSERT INTO commande VALUES (30, 20, DATE '2023-11-30', 0, 0);
INSERT INTO commande VALUES (31, 5, DATE '2023-12-01', 0, 0);
INSERT INTO commande VALUES (32, 24, DATE '2023-12-02', 0, 0);
INSERT INTO commande VALUES (33, 12, DATE '2023-12-03', 0, 0);
INSERT INTO commande VALUES (34, 28, DATE '2023-12-04', 0, 0);
INSERT INTO commande VALUES (35, 7, DATE '2023-12-05', 0, 0);
INSERT INTO commande VALUES (36, 2, DATE '2023-12-06', 0, 0);
INSERT INTO commande VALUES (37, 9, DATE '2023-12-07', 0, 0);
INSERT INTO commande VALUES (38, 15, DATE '2023-12-08', 0, 0);
INSERT INTO commande VALUES (39, 1, DATE '2023-12-09', 0, 0);
INSERT INTO commande VALUES (40, 19, DATE '2023-12-10', 0, 0);
INSERT INTO commande VALUES (41, 14, DATE '2023-12-11', 0, 0);
INSERT INTO commande VALUES (42, 22, DATE '2023-12-12', 0, 0);
INSERT INTO commande VALUES (43, 3, DATE '2023-12-13', 0, 0);
INSERT INTO commande VALUES (44, 10, DATE '2023-12-14', 0, 0);
INSERT INTO commande VALUES (45, 18, DATE '2023-12-15', 0, 0);
INSERT INTO commande VALUES (46, 21, DATE '2023-12-16', 0, 0);
INSERT INTO commande VALUES (47, 27, DATE '2023-12-17', 0, 0);
INSERT INTO commande VALUES (48, 6, DATE '2023-12-18', 0, 0);
INSERT INTO commande VALUES (49, 11, DATE '2023-12-19', 0, 0);
INSERT INTO commande VALUES (50, 29, DATE '2023-12-20', 0, 0);

-- Insertions tourniquets

-- Code PL/SQL pour générer beaucoup de données dans la table tourniquet

-- DECLARE
--     i INTEGER := 0;
-- BEGIN
--     WHILE i < 1000 LOOP
--         INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie)
--         VALUES (
--     TRUNC(DBMS_RANDOM.VALUE(1, (SELECT MAX(id_attraction) FROM attraction) + 1)),
--             TO_DATE(
--                 TO_CHAR(TRUNC(SYSDATE - DBMS_RANDOM.VALUE(0, 365)), 'YYYY-MM-DD') || ' ' ||
--                 TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(9, 20)), '00') || ':' ||
--                 TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(0, 60)), '00') || ':' ||
--                 TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(0, 60)), '00'),
--                 'YYYY-MM-DD HH24:MI:SS'
--             ), -- Heure entre 09:00:00 et 19:59:59
--             CASE
--                 WHEN DBMS_RANDOM.VALUE(0, 1) < 0.6 THEN 'entrée'
--                 ELSE 'sortie'
--             END
--         );
--         i := i + 1;
--     END LOOP;
--     COMMIT;
-- END;
-- /

-- Sinon INSERT

-- Attraction 1: Plusieurs entrées/sorties
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (1, TO_DATE('2023-12-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (1, TO_DATE('2023-12-01 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (1, TO_DATE('2023-12-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (1, TO_DATE('2023-12-01 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie');

-- Attraction 2: Une seule entrée
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (2, TO_DATE('2023-12-01 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');

-- Attraction 3: Pas d'entrée
-- Pas d'INSERT pour cette attraction.

-- Attraction 4: Une entrée/sortie
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (4, TO_DATE('2023-12-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (4, TO_DATE('2023-12-01 12:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie');

-- Attraction 5: Nombreuses entrées/sorties
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (5, TO_DATE('2023-12-01 09:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (5, TO_DATE('2023-12-01 09:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (5, TO_DATE('2023-12-01 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (5, TO_DATE('2023-12-01 10:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (5, TO_DATE('2023-12-01 11:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');

-- Attraction 6: Pas d'entrée
-- Pas d'INSERT pour cette attraction.

-- Attraction 7: Peu de passages
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (7, TO_DATE('2023-12-01 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (7, TO_DATE('2023-12-01 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie');

-- Attraction 8: Une seule sortie
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (8, TO_DATE('2023-12-01 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie');

-- Attraction 9: Beaucoup d'entrées
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (9, TO_DATE('2023-12-01 09:05:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (9, TO_DATE('2023-12-01 09:35:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (9, TO_DATE('2023-12-01 10:05:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (9, TO_DATE('2023-12-01 10:35:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');

-- Répétition avec d'autres attractions
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (10, TO_DATE('2023-12-01 09:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (10, TO_DATE('2023-12-01 09:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (11, TO_DATE('2023-12-01 10:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (12, TO_DATE('2023-12-01 10:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (12, TO_DATE('2023-12-01 11:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'sortie');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (13, TO_DATE('2023-12-01 11:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (14, TO_DATE('2023-12-01 12:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (15, TO_DATE('2023-12-01 12:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (16, TO_DATE('2023-12-01 13:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (17, TO_DATE('2023-12-01 13:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (18, TO_DATE('2023-12-01 14:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (19, TO_DATE('2023-12-01 14:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (20, TO_DATE('2023-12-01 15:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (21, TO_DATE('2023-12-01 15:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (22, TO_DATE('2023-12-01 16:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (23, TO_DATE('2023-12-01 16:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (24, TO_DATE('2023-12-01 17:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (25, TO_DATE('2023-12-01 17:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (26, TO_DATE('2023-12-01 18:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (27, TO_DATE('2023-12-01 18:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (28, TO_DATE('2023-12-01 19:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (29, TO_DATE('2023-12-01 19:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');
INSERT INTO tourniquet (id_attraction, heure, entree_ou_sortie) VALUES (30, TO_DATE('2023-12-01 20:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'entrée');

-- Insertions réductions

INSERT INTO reduction VALUES ('étudiant', 0.1, DATE '2021-01-01', NULL);
INSERT INTO reduction VALUES ('senior', 0.05, DATE '2021-01-01', NULL);
INSERT INTO reduction VALUES ('enfant', 0.5, DATE '2021-01-01', NULL);
INSERT INTO reduction VALUES ('normal', 0, DATE '2021-01-01', NULL);

-- Insertions dans la table billets

INSERT INTO billet VALUES (1, 1, 12, DATE '2023-12-01', DATE '2023-12-01', 'journalier', 'normal', 0);
INSERT INTO billet VALUES (2, 2, 17, DATE '2023-12-05', DATE '2023-12-06', '2 jours', 'étudiant', 0);
INSERT INTO billet VALUES (3, 3, 21, DATE '2023-12-10', DATE '2023-12-10', 'noel', 'normal', 0);
INSERT INTO billet VALUES (4, 4, 4, DATE '2023-12-03', DATE '2023-12-03', 'journalier', 'senior', 1);
INSERT INTO billet VALUES (71, 1, 30, DATE '2023-12-15', DATE '2023-12-15', 'nocturne', 'normal', 0);
INSERT INTO billet VALUES (5, 1, 30, DATE '2023-12-15', DATE '2023-12-15', 'nocturne', 'enfant', 0);
INSERT INTO billet VALUES (6, 2, 43, DATE '2023-12-25', DATE '2023-12-26', 'annuel', 'étudiant', 0);
INSERT INTO billet VALUES (7, 3, 8, DATE '2023-12-01', DATE '2023-12-01', 'journalier', 'normal', 0);
INSERT INTO billet VALUES (78, 3, 8, DATE '2022-12-01', DATE '2022-12-01', 'journalier', 'normal', 1);
INSERT INTO billet VALUES (8, 4, 10, DATE '2023-12-04', DATE '2023-12-05', '2 jours', 'normal', 1);
INSERT INTO billet VALUES (9, 1, 14, DATE '2023-12-10', DATE '2023-12-10', 'noel', 'senior', 0);
INSERT INTO billet VALUES (10, 2, 20, DATE '2023-12-03', DATE '2023-12-03', 'journalier', 'normal', 0);
INSERT INTO billet VALUES (11, 3, 29, DATE '2023-12-20', DATE '2023-12-20', 'nocturne', 'normal', 0);
INSERT INTO billet VALUES (12, 4, 1, DATE '2023-12-18', DATE '2023-12-19', 'annuel', 'étudiant', 1);
INSERT INTO billet VALUES (13, 1, 7, DATE '2023-12-11', DATE '2023-12-11', 'journalier', 'senior', 0);
INSERT INTO billet VALUES (14, 2, 13, DATE '2023-12-22', DATE '2023-12-23', '2 jours', 'normal', 1);
INSERT INTO billet VALUES (15, 3, 28, DATE '2023-12-25', DATE '2023-12-25', 'noel', 'normal', 0);
INSERT INTO billet values (72, 4, 42, DATE '2023-12-30', DATE '2023-12-30', 'journalier', 'étudiant', 0);
INSERT INTO billet VALUES (16, 4, 42, DATE '2023-12-30', DATE '2023-12-30', 'journalier', 'enfant', 0);
INSERT INTO billet VALUES (17, 1, 35, DATE '2023-12-15', DATE '2023-12-15', 'nocturne', 'étudiant', 1);
INSERT INTO billet VALUES (18, 2, 6, DATE '2023-12-12', DATE '2023-12-13', 'annuel', 'normal', 0);
INSERT INTO billet VALUES (19, 3, 19, DATE '2023-12-01', DATE '2023-12-01', 'journalier', 'normal', 0);
INSERT INTO billet VALUES (20, 4, 15, DATE '2023-12-05', DATE '2023-12-05', '2 jours', 'normal', 0);
INSERT INTO billet VALUES (79, 1, 25, DATE '2023-12-07', DATE '2023-12-07', 'noel', 'normal', 0);
INSERT INTO billet VALUES (21, 1, 25, DATE '2023-12-07', DATE '2023-12-07', 'noel', 'enfant', 0);
INSERT INTO billet VALUES (22, 2, 33, DATE '2023-12-20', DATE '2023-12-20', 'journalier', 'étudiant', 0);
INSERT INTO billet VALUES (23, 3, 3, DATE '2023-12-23', DATE '2023-12-23', 'nocturne', 'normal', 1);
INSERT INTO billet VALUES (24, 4, 22, DATE '2023-12-29', DATE '2023-12-30', 'annuel', 'normal', 0);
INSERT INTO billet VALUES (25, 1, 38, DATE '2023-12-06', DATE '2023-12-06', 'journalier', 'senior', 0);
INSERT INTO billet VALUES (26, 2, 10, DATE '2023-12-12', DATE '2023-12-13', '2 jours', 'normal', 0);
INSERT INTO billet VALUES (27, 3, 47, DATE '2023-12-18', DATE '2023-12-18', 'noel', 'étudiant', 1);
INSERT INTO billet VALUES (73, 4, 32, DATE '2023-12-22', DATE '2023-12-22', 'journalier', 'étudiant', 0);
INSERT INTO billet VALUES (28, 4, 32, DATE '2023-12-22', DATE '2023-12-22', 'journalier', 'enfant', 0);
INSERT INTO billet VALUES (29, 1, 2, DATE '2023-12-27', DATE '2023-12-27', 'nocturne', 'normal', 0);
INSERT INTO billet VALUES (30, 2, 40, DATE '2023-12-29', DATE '2023-12-30', 'annuel', 'normal', 1);
INSERT INTO billet VALUES (31, 3, 48, DATE '2023-12-01', DATE '2023-12-01', 'journalier', 'normal', 0);
INSERT INTO billet VALUES (32, 4, 5, DATE '2023-12-07', DATE '2023-12-07', '2 jours', 'normal', 0);
INSERT INTO billet VALUES (33, 1, 13, DATE '2023-12-15', DATE '2023-12-15', 'noel', 'senior', 1);
INSERT INTO billet VALUES (34, 2, 37, DATE '2023-12-22', DATE '2023-12-22', 'journalier', 'normal', 0);
INSERT INTO billet VALUES (35, 3, 9, DATE '2023-12-30', DATE '2023-12-30', 'nocturne', 'normal', 0);
INSERT INTO billet VALUES (74, 4, 16, DATE '2023-12-03', DATE '2023-12-03', 'journalier', 'normal', 0);
INSERT INTO billet VALUES (36, 4, 16, DATE '2023-12-03', DATE '2023-12-03', 'annuel', 'enfant', 1);
INSERT INTO billet VALUES (37, 1, 20, DATE '2023-12-10', DATE '2023-12-11', '2 jours', 'étudiant', 0);
INSERT INTO billet VALUES (38, 2, 24, DATE '2023-12-18', DATE '2023-12-18', 'noel', 'normal', 0);
INSERT INTO billet VALUES (39, 3, 11, DATE '2023-12-28', DATE '2023-12-28', 'journalier', 'normal', 0);
INSERT INTO billet VALUES (40, 4, 41, DATE '2023-12-04', DATE '2023-12-04', 'nocturne', 'normal', 1);
INSERT INTO billet VALUES (41, 1, 18, DATE '2023-12-07', DATE '2023-12-07', 'annuel', 'senior', 0);
INSERT INTO billet VALUES (42, 2, 28, DATE '2023-12-14', DATE '2023-12-14', 'journalier', 'normal', 0);
INSERT INTO billet VALUES (43, 3, 19, DATE '2023-12-01', DATE '2023-12-02', '2 jours', 'normal', 1);
INSERT INTO billet VALUES (44, 4, 8, DATE '2023-12-09', DATE '2023-12-10', 'noel', 'étudiant', 0);
INSERT INTO billet VALUES (45, 1, 26, DATE '2023-12-13', DATE '2023-12-13', 'journalier', 'senior', 0);
INSERT INTO billet VALUES (80, 2, 44, DATE '2023-12-20', DATE '2023-12-20', 'nocturne', 'normal', 0);
INSERT INTO billet VALUES (46, 3, 44, DATE '2023-12-20', DATE '2023-12-20', 'nocturne', 'enfant', 0);
INSERT INTO billet VALUES (47, 4, 15, DATE '2023-12-26', DATE '2023-12-27', 'annuel', 'normal', 1);
INSERT INTO billet VALUES (48, 1, 2, DATE '2023-12-06', DATE '2023-12-07', '2 jours', 'normal', 0);
INSERT INTO billet VALUES (49, 2, 12, DATE '2023-12-15', DATE '2023-12-15', 'journalier', 'senior', 0);
INSERT INTO billet VALUES (50, 3, 39, DATE '2023-12-29', DATE '2023-12-29', 'noel', 'étudiant', 1);
INSERT INTO billet VALUES (51, 4, 31, DATE '2023-12-22', DATE '2023-12-22', 'journalier', 'normal', 0);
INSERT INTO billet VALUES (75, 1, 23, DATE '2023-12-01', DATE '2023-12-02', '2 jours', 'étudiant', 0);
INSERT INTO billet VALUES (52, 1, 23, DATE '2023-12-01', DATE '2023-12-02', '2 jours', 'enfant', 0);
INSERT INTO billet VALUES (53, 2, 48, DATE '2023-12-10', DATE '2023-12-10', 'noel', 'normal', 1);
INSERT INTO billet VALUES (54, 3, 33, DATE '2023-12-20', DATE '2023-12-20', 'journalier', 'senior', 0);
INSERT INTO billet VALUES (55, 4, 6, DATE '2023-12-30', DATE '2023-12-30', 'nocturne', 'normal', 0);
INSERT INTO billet VALUES (56, 1, 5, DATE '2023-12-18', DATE '2023-12-18', 'annuel', 'normal', 1);
INSERT INTO billet VALUES (57, 2, 14, DATE '2023-12-02', DATE '2023-12-03', '2 jours', 'normal', 0);
INSERT INTO billet VALUES (58, 3, 27, DATE '2023-12-07', DATE '2023-12-07', 'journalier', 'senior', 0);
INSERT INTO billet VALUES (59, 4, 45, DATE '2023-12-14', DATE '2023-12-14', 'noel', 'normal', 0);
INSERT INTO billet VALUES (60, 1, 35, DATE '2023-12-29', DATE '2023-12-29', 'journalier', 'normal', 0);
INSERT INTO billet VALUES (61, 2, 25, DATE '2023-12-01', DATE '2023-12-02', '2 jours', 'étudiant', 0);
INSERT INTO billet VALUES (76, 3, 30, DATE '2023-12-10', DATE '2023-12-11', 'nocturne', 'normal', 0);
INSERT INTO billet VALUES (62, 3, 30, DATE '2023-12-10', DATE '2023-12-11', 'nocturne', 'enfant', 0);
INSERT INTO billet VALUES (63, 4, 40, DATE '2023-12-18', DATE '2023-12-18', 'annuel', 'senior', 1);
INSERT INTO billet VALUES (64, 1, 9, DATE '2023-12-07', DATE '2023-12-07', 'journalier', 'normal', 0);
INSERT INTO billet VALUES (65, 2, 37, DATE '2023-12-25', DATE '2023-12-25', 'noel', 'normal', 0);
INSERT INTO billet VALUES (66, 3, 41, DATE '2023-12-22', DATE '2023-12-23', '2 jours', 'normal', 0);
INSERT INTO billet VALUES (67, 4, 46, DATE '2023-12-04', DATE '2023-12-04', 'journalier', 'senior', 1);
INSERT INTO billet VALUES (68, 1, 3, DATE '2023-12-15', DATE '2023-12-15', 'nocturne', 'normal', 0);
INSERT INTO billet VALUES (69, 2, 10, DATE '2023-12-19', DATE '2023-12-19', 'annuel', 'étudiant', 0);
insert into billet values (77, 3, 20, DATE '2023-12-30', DATE '2023-12-30', 'journalier', 'normal', 0);
INSERT INTO billet VALUES (70, 3, 20, DATE '2023-12-30', DATE '2023-12-30', 'journalier', 'enfant', 0);
INSERT INTO billet VALUES (81, 4, 34, DATE '2023-12-01', DATE '2023-12-02', '2 jours', 'normal', 1);
INSERT INTO billet VALUES (82, 4, 36, DATE '2023-12-01', DATE '2023-12-02', '2 jours', 'étudiant', 1);
INSERT INTO billet VALUES (83, 4, 49, DATE '2023-12-01', DATE '2023-12-02', '2 jours', 'senior', 1);
INSERT INTO billet VALUES (84, 4, 50, DATE '2023-12-01', DATE '2023-12-02', 'journalier', 'étudiant', 1);
INSERT INTO billet VALUES (85, 4, 50, DATE '2023-12-01', DATE '2023-12-02', 'journalier', 'enfant', 1);
INSERT INTO billet VALUES (86, 4, 50, DATE '2023-12-01', DATE '2023-12-02', 'journalier', 'senior', 1);
INSERT INTO billet VALUES (87, 4, 50, DATE '2023-12-01', DATE '2023-12-02', 'journalier', 'normal', 1);
INSERT INTO billet VALUES (88, 4, 50, DATE '2023-12-01', DATE '2023-12-02', 'journalier', 'normal', 1);
INSERT INTO billet VALUES (89, 4, 50, DATE '2023-12-01', DATE '2023-12-02', 'journalier', 'normal', 1);
INSERT INTO billet VALUES (90, 4, 50, DATE '2023-12-01', DATE '2023-12-02', 'journalier', 'normal', 1);
INSERT INTO billet VALUES (91, 4, 50, DATE '2023-12-01', DATE '2023-12-02', 'journalier', 'normal', 1);

-- Droits et vues

-- Vues

-- Liste des travaux réalisés pour chaque attraction.
CREATE OR REPLACE VIEW vue_travaux_par_attraction AS
SELECT
    a.nom AS nom_attraction,
    t.date_debut,
    t.date_fin,
    t.etat,
    t.cout
FROM travaux t
JOIN attraction a ON t.id_attraction = a.id_attraction;

-- Liste des revenus totaux générés par chaque parc, en tenant compte des tarifs appliqués et des réductions associées.
CREATE OR REPLACE VIEW vue_revenus_parc AS
SELECT
    p.nom AS nom_parc,
    NVL(SUM(t.prix * (1 - NVL(r.reduction, 0))), 0) AS revenus_totaux
FROM parc p
LEFT JOIN billet b ON p.id_parc = b.id_parc
LEFT JOIN tarif t ON b.tarif = t.nom_tarif
LEFT JOIN reduction r ON b.reduction = r.nom_reduction
GROUP BY p.nom;

-- Liste des clients avec leur nombre de commandes et la date de leur dernière commande.
CREATE OR REPLACE VIEW vue_clients_commandes AS
SELECT
    c.id_client,
    c.nom || ' ' || c.prenom AS nom_complet,
    c.email,
    COUNT(co.id_commande) AS nombre_commandes,
    MAX(co.date_commande) AS derniere_commande
FROM client c
LEFT JOIN commande co ON c.id_client = co.id_client
GROUP BY c.id_client, c.nom, c.prenom, c.email;

-- Liste des travaux actuellement en cours, incluant le nom de l'attraction, la description des travaux, les dates de début et fin, et leur coût.
CREATE OR REPLACE VIEW vue_travaux_en_cours AS
SELECT
    a.nom AS nom_attraction,
    t.description,
    t.date_debut,
    t.date_fin,
    t.cout
FROM travaux t
JOIN attraction a ON t.id_attraction = a.id_attraction
WHERE t.etat = 'en cours';

-- Liste des attractions avec leurs statistiques, triées par capacité horaire décroissante.
CREATE OR REPLACE VIEW vue_statistiques_attractions AS
SELECT
    nom,
    vitesse_maximale,
    hauteur_maximale,
    etat,
    capacite_horaire
FROM attraction
ORDER BY capacite_horaire DESC;

-- Liste des employés affectés à chaque attraction, incluant leurs coordonnées.
CREATE OR REPLACE VIEW vue_employes_par_attraction AS
SELECT
    a.nom AS nom_attraction,
    e.nom || ' ' || e.prenom AS nom_complet_employe,
    e.telephone,
    e.email
FROM employe e
JOIN attraction a ON e.id_attraction = a.id_attraction;

-- Liste des employés et leurs salaires par parc, avec le type de contrat associé.
CREATE OR REPLACE VIEW vue_salaire_employes_parc AS
SELECT
    p.nom AS nom_parc,
    e.nom || ' ' || e.prenom AS nom_complet_employe,
    c.salaire,
    c.type AS type_contrat
FROM employe e
JOIN attraction a ON e.id_attraction = a.id_attraction
JOIN parc p ON a.id_parc = p.id_parc
JOIN contrat c ON e.numero_de_securite_sociale = c.numero_de_securite_sociale;

-- Liste des billets d'un client spécifique, filtrée par son email.
CREATE OR REPLACE VIEW vue_mes_billets AS
SELECT
    b.id_billet,
    b.id_parc,
    b.date_debut_validite,
    b.date_fin_validite,
    b.tarif,
    b.reduction
FROM billet b
JOIN commande c ON b.id_commande = c.id_commande
JOIN client cl ON c.id_client = cl.id_client
WHERE cl.email = :email; -- Filtre les billets selon l'email de l'utilisateur connecté.

-- Dirigeants

CREATE ROLE C##dirigeants;

GRANT SELECT ON parc TO C##dirigeants;
GRANT SELECT ON attraction TO C##dirigeants;
GRANT SELECT ON employe TO C##dirigeants;
GRANT SELECT ON travaux TO C##dirigeants;

GRANT UPDATE, INSERT ON parc TO C##dirigeants;

GRANT SELECT ON vue_revenus_parc TO C##dirigeants;
GRANT SELECT ON vue_travaux_par_attraction TO C##dirigeants;

-- Service clientèle

CREATE ROLE C##service_client;

GRANT SELECT, INSERT, UPDATE, DELETE ON billet TO C##service_client;
GRANT SELECT, INSERT, UPDATE, DELETE ON commande TO C##service_client;
GRANT SELECT ON client TO C##service_client;

GRANT SELECT ON vue_clients_commandes TO C##service_client;

-- Directeur de parc

CREATE ROLE C##directeur_parc;

GRANT SELECT, UPDATE, DELETE ON attraction TO C##directeur_parc;
GRANT SELECT, UPDATE, DELETE ON employe TO C##directeur_parc;
GRANT SELECT, INSERT, UPDATE, DELETE ON tarif TO C##directeur_parc;
GRANT SELECT, INSERT, UPDATE, DELETE ON reduction TO C##directeur_parc;
GRANT SELECT, INSERT, UPDATE, DELETE ON parc TO C##directeur_parc;

GRANT SELECT ON vue_travaux_en_cours TO C##directeur_parc;

-- Responsable des attractions

CREATE ROLE C##responsable_attractions;

GRANT SELECT, UPDATE ON attraction TO C##responsable_attractions;
GRANT SELECT, UPDATE ON travaux TO C##responsable_attractions;
GRANT SELECT, UPDATE ON employe TO C##responsable_attractions;

GRANT SELECT ON vue_statistiques_attractions TO C##responsable_attractions;
GRANT SELECT ON vue_employes_par_attraction TO C##responsable_attractions;

-- Gestionnaire des ressources humaines

CREATE ROLE C##gestionnaire_rh;

GRANT SELECT, INSERT, UPDATE ON employe TO C##gestionnaire_rh;
GRANT SELECT, INSERT, UPDATE, DELETE ON contrat TO C##gestionnaire_rh;

GRANT SELECT ON vue_salaire_employes_parc TO C##gestionnaire_rh;

-- Clients

CREATE ROLE C##clients;

GRANT SELECT ON vue_mes_billets TO C##clients;

-- Requêtes

-- 1 Quels sont les parcs ouverts depuis plus de 10 ans ?
SELECT nom, date_ouverture
FROM parc
WHERE date_ouverture < SYSDATE - INTERVAL '10' YEAR;

-- 2 Combien d'employés travaillent dans chaque parc ?
SELECT p.nom, COUNT(distinct (e.numero_de_securite_sociale)) AS nb_employes
FROM parc p
LEFT JOIN attraction a ON p.id_parc = a.id_parc
LEFT JOIN employe e ON a.id_attraction = e.id_attraction
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

-- 7 Combien de travaux ont eu lieu pour chaque attraction au cours des cinq dernières années ?
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
WHERE t.nom_tarif = 'journalier'
group by t.nom_tarif;

-- 10 Quels employés ont un contrat en cours, mais dont le contrat se termine dans les trois prochains mois ?
SELECT e.nom, e.prenom
FROM employe e
JOIN contrat c ON e.numero_de_securite_sociale = c.numero_de_securite_sociale
WHERE c.date_fin >= SYSDATE AND c.date_fin <= SYSDATE + INTERVAL '3' MONTH;

-- 11 S’il n’y avait pas de tarif étudiant, combien chaque parc aurait-il gagné en plus ?
SELECT
    p.nom AS nom_parc,
    SUM(
        CASE
            -- Si la réduction est "étudiant", on calcule la différence entre le prix avec réduction normale et celui avec réduction étudiante.
            WHEN b.reduction = 'étudiant' THEN
                t.prix * (1 - COALESCE(r_normal.reduction, 0)) - t.prix * (1 - r.reduction)
            ELSE 0 -- Pour les autres réductions, aucun gain supplémentaire n'est ajouté
        END
    ) AS gain_si_tarif_etudiant_non_existant -- Résultat final : gain total supplémentaire pour chaque parc
FROM parc p
JOIN billet b ON p.id_parc = b.id_parc
JOIN tarif t ON b.tarif = t.nom_tarif
JOIN reduction r ON b.reduction = r.nom_reduction
LEFT JOIN reduction r_normal ON r_normal.nom_reduction = 'normal'
GROUP BY p.nom;

-- 12 Liste des parcs avec le nombre d'attractions ayant des inversions, triés par ordre décroissant
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

-- 15 Quels sont pour chaque parc les trois attractions qui ont coûté le plus en termes de maintenance ?
SELECT parc_nom, attraction_nom, cout
FROM (
    SELECT p.nom AS parc_nom, a.nom AS attraction_nom, t.cout,
           ROW_NUMBER() OVER (PARTITION BY p.nom ORDER BY t.cout DESC) AS rank
    FROM parc p
    JOIN attraction a ON p.id_parc = a.id_parc
    JOIN travaux t ON a.id_attraction = t.id_attraction
)
WHERE rank <= 3
ORDER BY parc_nom, rank;

-- 16 Pour chaque parc, quelle attraction a eu le plus de travaux ?
SELECT parc_nom, attraction_nom, nb_travaux
FROM (
    SELECT p.nom AS parc_nom,
           a.nom AS attraction_nom,
           COUNT(t.id_travaux) AS nb_travaux,
           ROW_NUMBER() OVER (PARTITION BY p.nom ORDER BY COUNT(t.id_travaux) DESC) AS rank
    FROM parc p
    JOIN attraction a ON p.id_parc = a.id_parc
    JOIN travaux t ON a.id_attraction = t.id_attraction
    GROUP BY p.nom, a.nom
)
WHERE rank = 1
ORDER BY parc_nom;

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
SELECT parc_fideles.nom_parc, parc_fideles.nom_client, parc_fideles.prenom_client, parc_fideles.nb_billets
FROM (
    SELECT
        p.nom AS nom_parc,
        c.nom AS nom_client,
        c.prenom AS prenom_client,
        COUNT(b.id_billet) AS nb_billets,
        RANK() OVER (PARTITION BY p.nom ORDER BY COUNT(b.id_billet) DESC) AS rang_client
    FROM parc p
    JOIN billet b ON p.id_parc = b.id_parc
    JOIN commande co ON b.id_commande = co.id_commande
    JOIN client c ON co.id_client = c.id_client
    GROUP BY p.nom, c.nom, c.prenom
) parc_fideles
WHERE parc_fideles.rang_client = 1;

-- Création d'une vue temps d'attente par attraction en fonction de la capacité horaire et des tourniquets
CREATE OR REPLACE VIEW vue_temps_attente AS
SELECT
    a.nom AS nom_attraction,
    ROUND(((COUNT(t.id_attraction)-COUNT(t2.id_attraction)) / a.capacite_horaire) * 60, 2) AS temps_attente_moyen
FROM attraction a
LEFT JOIN tourniquet t ON a.id_attraction = t.id_attraction
LEFT JOIN tourniquet t2 ON a.id_attraction = t2.id_attraction AND t2.entree_ou_sortie = 'sortie'
WHERE t.entree_ou_sortie = 'entrée'
GROUP BY a.nom, a.capacite_horaire;
