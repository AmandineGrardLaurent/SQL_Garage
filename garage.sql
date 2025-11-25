-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 25 nov. 2025 à 12:30
-- Version du serveur : 8.4.7
-- Version de PHP : 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `garage`
--

-- --------------------------------------------------------

--
-- Structure de la table `g_article`
--

DROP TABLE IF EXISTS `g_article`;
CREATE TABLE IF NOT EXISTS `g_article` (
  `a_id` int NOT NULL AUTO_INCREMENT,
  `a_reference` varchar(50) DEFAULT NULL,
  `a_designation` varchar(50) DEFAULT NULL,
  `a_marque` varchar(50) DEFAULT NULL,
  `a_quantite` int DEFAULT NULL,
  PRIMARY KEY (`a_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `g_article`
--

INSERT INTO `g_article` (`a_id`, `a_reference`, `a_designation`, `a_marque`, `a_quantite`) VALUES
(1, 'AE237ER', 'filtre à air', 'peugeot', 12),
(2, 'ATRE877ER', 'rétroviseur', 'ford', 32),
(3, 'EFE0998E237ER', 'ceinture conducteur', 'BMW', 4),
(4, 'KDHFKJHF237ER', 'filtre à air', 'citroen', 9),
(5, '75765UJ7ER', 'pneu avant gauche', 'ford', 54),
(6, 'AEDEFRE7777R', 'filtre à air', 'mazda', 3),
(7, '98780707HLJHL', 'rétroviseur', 'volkswagen', 24);

-- --------------------------------------------------------

--
-- Structure de la table `g_voiture`
--

DROP TABLE IF EXISTS `g_voiture`;
CREATE TABLE IF NOT EXISTS `g_voiture` (
  `v_id` int NOT NULL AUTO_INCREMENT,
  `v_marque` varchar(50) DEFAULT NULL,
  `v_type` varchar(50) DEFAULT NULL,
  `v_energie` varchar(50) DEFAULT NULL,
  `v_fk_article_voiture_id` int DEFAULT NULL,
  PRIMARY KEY (`v_id`),
  KEY `v_fk_article_voiture_id` (`v_fk_article_voiture_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `g_voiture`
--

INSERT INTO `g_voiture` (`v_id`, `v_marque`, `v_type`, `v_energie`, `v_fk_article_voiture_id`) VALUES
(1, 'peugeot', '407', 'diesel', 1),
(2, 'ford', 'fiesta', 'essence', 2),
(3, 'BMW', 'X5', 'diesel', 3),
(4, 'citroen', 'C4', 'diesel', 4),
(5, 'ford', 'kuga', 'essence', 2);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `g_voiture`
--
ALTER TABLE `g_voiture`
  ADD CONSTRAINT `g_voiture_ibfk_1` FOREIGN KEY (`v_fk_article_voiture_id`) REFERENCES `g_article` (`a_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
