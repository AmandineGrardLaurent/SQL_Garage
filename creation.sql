-- Création table article

CREATE TABLE IF NOT EXISTS g_article(
	a_id INT PRIMARY KEY  AUTO_INCREMENT NOT NULL,
	a_ref VARCHAR(50),
	a_designation VARCHAR(50),
	a_marque VARCHAR(50),
	a_qty INT,
	a_prix FLOAT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- Création table catalogue_voiture

CREATE TABLE IF NOT EXISTS g_catalogue_voiture(
	cv_id INT PRIMARY KEY  AUTO_INCREMENT NOT NULL,
	cv_marque VARCHAR(50),
	cv_type VARCHAR(50),
	cv_energie VARCHAR(50),
	cv_fk_article_id INT,
	FOREIGN KEY (cv_fk_article_id)
	REFERENCES g_article(a_id)
) ENGINE=InnoDB CHARSET=utf8mb4;


-- Création table client

CREATE TABLE IF NOT EXISTS g_client(
    c_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    c_nom VARCHAR(50),
	c_tel INT,
	c_adresse VARCHAR(100)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	

-- Création table véhicule_client

CREATE TABLE IF NOT EXISTS g_vehicule_client(
	vc_id INT PRIMARY KEY  AUTO_INCREMENT NOT NULL,
	vc_plaque VARCHAR(50),
	vc_année INT,
	vc_fk_catalogue_voiture_id INT,
	FOREIGN KEY (vc_fk_catalogue_voiture_id)
	REFERENCES g_catalogue_voiture(cv_id),
	vc_fk_client_id INT,
	FOREIGN KEY (vc_fk_client_id)
	REFERENCES g_client(c_id)
) ENGINE=InnoDB CHARSET=utf8mb4;


-- Création table main_doeuvre

CREATE TABLE IF NOT EXISTS g_main_doeuvre(
	mo_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    mo_tarif_horaire FLOAT
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	

-- Création table or	
	
CREATE TABLE IF NOT EXISTS g_or(
	or_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	or_main_doeuvre_qty FLOAT,
    or_montant_mo FLOAT,
	
	or_fk_vehicule_client_id INT,
	FOREIGN KEY (or_fk_vehicule_client_id)
	REFERENCES g_vehicule_client(vc_id),
	
	or_fk_main_doeuvre_id INT,
	FOREIGN KEY (or_fk_main_doeuvre_id)
	REFERENCES g_main_doeuvre(mo_id)
	
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	

-- Création table or_article

CREATE TABLE IF NOT EXISTS g_or_article(
	ora_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	ora_qty INT,
    ora_montant_a FLOAT,
	ora_fk_or_id INT,
	FOREIGN KEY (ora_fk_or_id)
	REFERENCES g_or(or_id),
	ora_fk_article_id INT,
	FOREIGN KEY (ora_fk_article_id)
	REFERENCES g_article(a_id)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;