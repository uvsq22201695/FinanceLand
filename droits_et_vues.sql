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