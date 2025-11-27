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




