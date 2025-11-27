-- en saisissant une ref on veut consulter son stock et à quel véhicule l'article correspond

SELECT a_designation, a_ref, a_qty, cv_marque, cv_type FROM g_article_catalogue_vehicule
JOIN g_article
ON a_id=acv_fk_article_id
JOIN g_catalogue_voiture
ON acv_fk_catalogue_voiture_id=cv_id
WHERE a_ref="REF001";

-- en saisissant un nom on retrouve les données du client et de sa voiture

SELECT c_nom, c_adresse, c_tel, cv_type, cv_marque, cv_energie, vc_annee, vc_plaque, a_designation FROM g_client
JOIN g_vehicule_client
ON c_id=vc_fk_client_id
JOIN g_catalogue_voiture
ON cv_id=vc_fk_catalogue_voiture_id
JOIN g_article_catalogue_vehicule
ON cv_id=acv_fk_catalogue_voiture_id
JOIN g_article
ON a_id=acv_fk_article_id
WHERE c_nom="Lucas Bernard";

-- en saisissant une plaque d'immatriculation on retrouve les données du client et de sa voiture

SELECT c_nom, c_adresse, c_tel, cv_type, cv_marque, cv_energie, vc_annee, vc_plaque, a_designation FROM g_client
JOIN g_vehicule_client
ON c_id=vc_fk_client_id
JOIN g_catalogue_voiture
ON cv_id=vc_fk_catalogue_voiture_id
JOIN g_article_catalogue_vehicule
ON cv_id=acv_fk_catalogue_voiture_id
JOIN g_article
ON a_id=acv_fk_article_id
WHERE vc_plaque="FG-678-HI";

-- en saisissant le nom on retrouve les données des OR

SELECT c_nom, vc_plaque, or_main_doeuvre_qty, or_montant_mo, a_ref, a_designation, ora_qty, ora_montant_a
FROM g_client c
JOIN g_vehicule_client vc ON vc.vc_fk_client_id = c.c_id
JOIN g_or o ON o.or_fk_vehicule_client_id = vc.vc_id
JOIN g_or_article oa ON oa.ora_fk_or_id = o.or_id
JOIN g_article a ON a.a_id = oa.ora_fk_article_id
WHERE c_nom = "Martin Dupont";

-- en saisissant une plaque d'immatriculation on retrouve les données des OR

SELECT c_nom, vc_plaque, or_main_doeuvre_qty, or_montant_mo, a_ref, a_designation, ora_qty, ora_montant_a
FROM g_client c
JOIN g_vehicule_client vc ON vc.vc_fk_client_id = c.c_id
JOIN g_or o ON o.or_fk_vehicule_client_id = vc.vc_id
JOIN g_or_article oa ON oa.ora_fk_or_id = o.or_id
JOIN g_article a ON a.a_id = oa.ora_fk_article_id
WHERE vc_plaque="AB-123-CD";

-- Facture pour un OR

SELECT
    -- infos client
    c_nom,
    c_tel,
    c_adresse,

    -- véhicule du client
    vc_plaque,
    vc_annee,
    cv_marque,
    cv_type,
    cv_energie,

    -- détails de l'ordre de réparation
    or_main_doeuvre_qty,
    mo_tarif_horaire,
    (or_main_doeuvre_qty * mo_tarif_horaire) AS total_main_oeuvre,

    -- les articles utilisés
    a_designation,
    a_prix AS prix_unitaire,
    ora_qty,
    ora_montant_a AS total_article,

    -- total facture
    (SELECT SUM(ora_montant_a)
     FROM g_or_article
     WHERE ora_fk_or_id = or_id)
     + (or_main_doeuvre_qty * mo_tarif_horaire) AS total_facture

FROM g_or
JOIN g_main_doeuvre ON mo_id = or_fk_main_doeuvre_id
JOIN g_vehicule_client ON vc_id = or_fk_vehicule_client_id
JOIN g_client ON c_id = vc_fk_client_id
JOIN g_catalogue_voiture ON cv_id = vc_fk_catalogue_voiture_id
JOIN g_or_article ON ora_fk_or_id = or_id
JOIN g_article ON a_id = ora_fk_article_id

WHERE or_id = 21;

-- mise à jour du stock pour l'article 1 après un or

UPDATE g_article 
JOIN g_or_article
    ON a_id = ora_fk_article_id
SET a_qty=(a_qty-ora_qty)
WHERE ora_fk_article_id=1;

-- exo 4 afficher le stock pour une même désignation et même marque

SELECT 
    a_designation,
    a_marque,
    SUM(a_qty) AS total_quantite
FROM g_article
GROUP BY a_designation, a_marque 
ORDER BY a_marque;

-- afficher le compte de désignation filtre à air pour des marques différentes

SELECT 
    a_designation,
    COUNT(a_designation) AS stock
FROM g_article
WHERE a_designation="Filtre à air"
GROUP BY a_designation
HAVING stock > 1;

-- afficher le compte d'une marque pour des articles différents

SELECT 
    a_marque,
    COUNT(a_marque) AS stock
FROM g_article
GROUP BY a_marque
HAVING stock > 1;

-- exo 5 afficher le nombre d'or pour un même véhicule

SELECT 
    c_nom,
    vc_plaque,
   	COUNT(or_fk_vehicule_client_id) AS nb_or
FROM g_vehicule_client
JOIN g_client
ON c_id=vc_fk_client_id
JOIN g_or
ON vc_id=or_fk_vehicule_client_id
WHERE vc_id = (
    SELECT MIN(vc_id)
    FROM g_vehicule_client
    WHERE vc_fk_client_id = c_id
)
GROUP BY vc_id, c_nom, vc_plaque;


--
SELECT 
    c.c_nom,
    v.v_marque ,
    v.v_modele ,
    v.v_plaque,
    COUNT(DISTINCT o.ord_fk_id_facture) AS Nombre_de_passages
FROM g_voiture v
JOIN g_client c ON v.v_fk_id_client = c.c_id
JOIN g_ordre o ON o.ord_fk_id_client = c.c_id
GROUP BY c_nom
ORDER BY Nombre_de_passages DESC;
--

-- exo 5 afficher la moyenne des filtres toutes marques confondus et par marque 

SELECT
    a_marque,
    ROUND(AVG(a_prix),2) AS prix_moyen_marque
FROM g_article
WHERE a_designation LIKE "%Filtre%"
GROUP BY a_marque
UNION ALL
SELECT
    'MOYENNE FILTRES -->' AS a_marque,
    ROUND(AVG(prix_moyen_marque),2) AS prix_moyen_marque
FROM (
    SELECT AVG(a_prix) AS prix_moyen_marque
    FROM g_article
    WHERE a_designation LIKE "%Filtre%"
    GROUP BY a_marque
) moyenne_filtre;


SELECT 
    a_marque,
    a_prix,
    ROUND(AVG(a_prix) OVER (), 2) AS moy_prix_filtres,
    ROUND(AVG(a_prix) OVER (PARTITION BY a_marque), 2) AS moy_prix_par_marque
FROM g_article
WHERE a_designation LIKE '%filtre%';