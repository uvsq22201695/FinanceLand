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
                t.prix * (1 - COALESCE(r_normal.reduction, 0)) -- Prix recalculé avec réduction normale
                - t.prix * (1 - r.reduction) -- Prix actuel avec réduction étudiante
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
