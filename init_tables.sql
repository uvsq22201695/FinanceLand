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
