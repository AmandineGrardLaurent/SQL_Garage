-- Création des tables

CREATE TABLE IF NOT EXISTS g_article(
	a_id INT PRIMARY KEY  AUTO_INCREMENT NOT NULL,
	a_reference VARCHAR(50),
	a_designation VARCHAR(50),
	a_marque VARCHAR(50),
	a_quantite INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS g_voiture(
	v_id INT PRIMARY KEY  AUTO_INCREMENT NOT NULL,
	v_marque VARCHAR(50),
	v_type VARCHAR(50),
	v_energie VARCHAR(50),
	v_fk_article_voiture_id INT,
	FOREIGN KEY (v_fk_article_voiture_id)
	REFERENCES g_article(a_id)
) ENGINE=InnoDB CHARSET=utf8mb4;

-- Insertion de données

INSERT INTO g_article(a_designation, a_marque, a_quantite, a_reference) VALUES 
("filtre à air", "peugeot", 12, "AE237ER"),
("rétroviseur", "ford", 32, "ATRE877ER"),
("ceinture conducteur", "BMW", 4, "EFE0998E237ER"),
("filtre à air", "citroen", 9, "KDHFKJHF237ER"),
("pneu avant gauche", "ford", 54, "75765UJ7ER");

INSERT INTO g_voiture(v_energie, v_marque, v_type, v_fk_article_voiture_id) VALUES 
("diesel", "peugeot", "407", 1 ),
("essence", "ford", "fiesta", 2),
("diesel", "BMW", "X5", 3),
("diesel", "citroen", "C4", 4),
("essence", "ford", "kuga", 2);

-- Affichage de données en utilisant JOIN

SELECT v_energie, a_reference, a_marque FROM g_voiture 
JOIN g_article
ON g_article.a_id = g_voiture.v_fk_article_voiture_id

-- autre solution

SELECT v_energie, a_reference, a_marque FROM g_voiture 
JOIN g_article
ON a_id = v_fk_article_voiture_id;

-- Insertion de données

INSERT INTO g_article(a_designation, a_marque, a_quantite, a_reference) VALUES 
("filtre à air", "mazda", 3, "AEDEFRE7777R"),
("rétroviseur", "Volkswagen", 24, "98780707HLJHL");

-- Affichage de données en utilisant LEFT JOIN et RIGHT JOIN

SELECT v_marque, v_energie, a_reference FROM g_voiture
LEFT JOIN g_article
ON a_id = v_fk_article_voiture_id

SELECT v_marque, v_energie, a_reference FROM g_voiture
RIGHT JOIN g_article
ON a_id = v_fk_article_voiture_id

-- Affichage de données en ajoutant une condition WHERE

SELECT a_designation, a_quantite, v_marque, v_type, a_reference  
FROM g_voiture 
JOIN g_article
ON a_id = v_fk_article_voiture_id
WHERE a_reference = "ATRE877ER";

-- Affichage de données en utilisant GROUP BY

SELECT a_designation, a_quantite, v_marque, v_type, a_reference  
FROM g_voiture 
JOIN g_article
ON a_id = v_fk_article_voiture_id
WHERE a_reference = "ATRE877ER"
GROUP BY v_marque;

-- Affichage de données en utilisant ORDER BY

SELECT a_designation, a_quantite, v_marque, v_type, a_reference  
FROM g_voiture 
JOIN g_article
ON a_id = v_fk_article_voiture_id
WHERE a_reference = "ATRE877ER"
GROUP BY v_type
ORDER BY v_type DESC;

-- Modification de la quantité de l'article 1 de la table g_article

UPDATE g_article
SET 
a_quantite = 15
WHERE a_id = 1;