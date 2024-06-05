-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for template
DROP DATABASE IF EXISTS `template`;
CREATE DATABASE IF NOT EXISTS `template` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `template`;

-- Dumping structure for table template.about
DROP TABLE IF EXISTS `about`;
CREATE TABLE IF NOT EXISTS `about` (
  `about_id` int unsigned NOT NULL AUTO_INCREMENT,
  `page` text NOT NULL,
  PRIMARY KEY (`about_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.about: ~0 rows (approximately)
DELETE FROM `about`;

-- Dumping structure for table template.administrator
DROP TABLE IF EXISTS `administrator`;
CREATE TABLE IF NOT EXISTS `administrator` (
  `administrator_id` int unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`administrator_id`) USING BTREE,
  UNIQUE KEY `uq_firstname_lastname_email` (`firstname`,`lastname`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.administrator: ~1 rows (approximately)
DELETE FROM `administrator`;
INSERT INTO `administrator` (`administrator_id`, `firstname`, `lastname`, `email`, `password`) VALUES
	(1, 'Mudzahid', 'Ceric', 'm.ceric@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE');

-- Dumping structure for table template.administrator_token
DROP TABLE IF EXISTS `administrator_token`;
CREATE TABLE IF NOT EXISTS `administrator_token` (
  `administrator_token_id` int unsigned NOT NULL AUTO_INCREMENT,
  `administrator_id` int unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `expire_at` datetime NOT NULL,
  `is_valid` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`administrator_token_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.administrator_token: ~1 rows (approximately)
DELETE FROM `administrator_token`;
INSERT INTO `administrator_token` (`administrator_token_id`, `administrator_id`, `created_at`, `token`, `expire_at`, `is_valid`) VALUES
	(24, 1, '2022-09-16 13:16:17', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NjYwMTI1NzYuOTczLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwNS4wLjAuMCBTYWZhcmkvNTM3LjM2IEVkZy8xMDUuMC4xMzQzLjMzIiwiaWF0IjoxNjYzMzM0MTc2fQ.kwQJ68D8fiU-0YNzAfNnct9aTlMz2_WlsjsLEfDwO4k', '2022-10-17 13:16:16', 1);

-- Dumping structure for table template.article
DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `article_id` int unsigned NOT NULL,
  `title` varchar(50) NOT NULL,
  `excerpt` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `photo_id` int unsigned DEFAULT NULL,
  `category_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`article_id`),
  UNIQUE KEY `uq_title` (`title`),
  KEY `fk_article_photo_id_photos_photo_id` (`photo_id`),
  KEY `fk_article_category_id_category_category_id` (`category_id`),
  CONSTRAINT `fk_article_category_id_category_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_article_photo_id_photos_photo_id` FOREIGN KEY (`photo_id`) REFERENCES `photos` (`photo_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.article: ~0 rows (approximately)
DELETE FROM `article`;

-- Dumping structure for table template.category
DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(100) NOT NULL,
  `metaTitle` varchar(100) NOT NULL,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `icon_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `parent_id` int unsigned DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `uq_name` (`name`),
  UNIQUE KEY `uq_icon_path` (`icon_path`) USING BTREE,
  KEY `fk_category_parent__category_id` (`parent_id`),
  CONSTRAINT `fk_category_parent__category_id` FOREIGN KEY (`parent_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.category: ~1 rows (approximately)
DELETE FROM `category`;
INSERT INTO `category` (`category_id`, `slug`, `metaTitle`, `name`, `icon_path`, `parent_id`, `content`) VALUES
	(1, 'Nki slug', 'Meta title', 'Postovi', '/image/image.png', NULL, 'Content');

-- Dumping structure for table template.employee
DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
  `employee_id` int unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `role_id` int unsigned NOT NULL,
  `createdBy` int unsigned NOT NULL,
  `updatedBy` int unsigned NOT NULL,
  `code` varchar(100) NOT NULL,
  `status` smallint NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `startsAt` datetime DEFAULT NULL,
  `endsAt` datetime DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`employee_id`),
  KEY `idx_employee_user` (`user_id`),
  KEY `idx_employee_organization` (`organization_id`),
  KEY `idx_employee_role` (`role_id`),
  KEY `idx_employee_creator` (`createdBy`),
  KEY `idx_employee_modifier` (`updatedBy`),
  CONSTRAINT `fk_employee_creator` FOREIGN KEY (`createdBy`) REFERENCES `user` (`user_id`),
  CONSTRAINT `fk_employee_modifier` FOREIGN KEY (`updatedBy`) REFERENCES `user` (`user_id`),
  CONSTRAINT `fk_employee_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`organization_id`),
  CONSTRAINT `fk_employee_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  CONSTRAINT `fk_employee_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.employee: ~0 rows (approximately)
DELETE FROM `employee`;

-- Dumping structure for table template.gallery
DROP TABLE IF EXISTS `gallery`;
CREATE TABLE IF NOT EXISTS `gallery` (
  `gallery_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(132) NOT NULL,
  PRIMARY KEY (`gallery_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.gallery: ~0 rows (approximately)
DELETE FROM `gallery`;

-- Dumping structure for table template.gallery_photos
DROP TABLE IF EXISTS `gallery_photos`;
CREATE TABLE IF NOT EXISTS `gallery_photos` (
  `gallery_photos_id` int unsigned NOT NULL AUTO_INCREMENT,
  `gallery_id` int unsigned NOT NULL,
  `photo_id` int unsigned NOT NULL,
  PRIMARY KEY (`gallery_photos_id`),
  UNIQUE KEY `uq_gallery_id_photo_id` (`gallery_id`,`photo_id`),
  KEY `fk_gallery_photos_photos_photo_id` (`photo_id`),
  CONSTRAINT `fk_gallery_photos_gallery_gallery_id` FOREIGN KEY (`gallery_id`) REFERENCES `gallery` (`gallery_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_gallery_photos_photos_photo_id` FOREIGN KEY (`photo_id`) REFERENCES `photos` (`photo_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.gallery_photos: ~0 rows (approximately)
DELETE FROM `gallery_photos`;

-- Dumping structure for table template.icons
DROP TABLE IF EXISTS `icons`;
CREATE TABLE IF NOT EXISTS `icons` (
  `icon_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `icon_path` varchar(250) NOT NULL,
  PRIMARY KEY (`icon_id`),
  UNIQUE KEY `uq_icon_path` (`icon_path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.icons: ~0 rows (approximately)
DELETE FROM `icons`;

-- Dumping structure for table template.organization
DROP TABLE IF EXISTS `organization`;
CREATE TABLE IF NOT EXISTS `organization` (
  `organization_id` int unsigned NOT NULL AUTO_INCREMENT,
  `createdBy` int unsigned NOT NULL,
  `updatedBy` int unsigned NOT NULL,
  `title` varchar(75) NOT NULL,
  `metaTitle` varchar(100) DEFAULT NULL,
  `slug` varchar(100) NOT NULL,
  `summary` tinytext,
  `status` smallint NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `profile` text,
  `content` text,
  PRIMARY KEY (`organization_id`),
  UNIQUE KEY `uq_slug` (`slug`),
  KEY `idx_organization_creator` (`createdBy`),
  KEY `idx_organization_modifier` (`updatedBy`),
  CONSTRAINT `fk_organization_creator` FOREIGN KEY (`createdBy`) REFERENCES `user` (`user_id`),
  CONSTRAINT `fk_organization_modifier` FOREIGN KEY (`updatedBy`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.organization: ~0 rows (approximately)
DELETE FROM `organization`;

-- Dumping structure for table template.organization_meta
DROP TABLE IF EXISTS `organization_meta`;
CREATE TABLE IF NOT EXISTS `organization_meta` (
  `organization_meta_id` int NOT NULL AUTO_INCREMENT,
  `organization_id` int unsigned NOT NULL,
  `key` varchar(50) NOT NULL,
  `content` text,
  PRIMARY KEY (`organization_meta_id`),
  UNIQUE KEY `uq_meta_organization` (`organization_id`,`key`),
  KEY `idx_meta_organization` (`organization_id`),
  CONSTRAINT `fk_meta_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.organization_meta: ~0 rows (approximately)
DELETE FROM `organization_meta`;

-- Dumping structure for table template.permission
DROP TABLE IF EXISTS `permission`;
CREATE TABLE IF NOT EXISTS `permission` (
  `permission_id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(75) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` tinytext,
  `type` smallint NOT NULL DEFAULT '0',
  `active` tinyint NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`permission_id`),
  UNIQUE KEY `uq_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.permission: ~0 rows (approximately)
DELETE FROM `permission`;

-- Dumping structure for table template.photos
DROP TABLE IF EXISTS `photos`;
CREATE TABLE IF NOT EXISTS `photos` (
  `photo_id` int unsigned NOT NULL AUTO_INCREMENT,
  `photo_path` varchar(250) NOT NULL,
  PRIMARY KEY (`photo_id`),
  UNIQUE KEY `uq_photo_path` (`photo_path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.photos: ~0 rows (approximately)
DELETE FROM `photos`;

-- Dumping structure for table template.post
DROP TABLE IF EXISTS `post`;
CREATE TABLE IF NOT EXISTS `post` (
  `post_id` int unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int unsigned DEFAULT NULL,
  `parent_id` int unsigned DEFAULT NULL,
  `title` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'unset',
  `metaTitle` varchar(100) DEFAULT NULL,
  `slug` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'unset',
  `summary` tinytext,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT NULL,
  `publishedAt` datetime DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`post_id`),
  UNIQUE KEY `uq_slug` (`slug`),
  KEY `idx_post_user` (`author_id`),
  KEY `idx_post_parent` (`parent_id`),
  CONSTRAINT `fk_post_parent` FOREIGN KEY (`parent_id`) REFERENCES `post` (`post_id`),
  CONSTRAINT `fk_post_user` FOREIGN KEY (`author_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.post: ~2 rows (approximately)
DELETE FROM `post`;
INSERT INTO `post` (`post_id`, `author_id`, `parent_id`, `title`, `metaTitle`, `slug`, `summary`, `published`, `createdAt`, `updatedAt`, `publishedAt`, `content`) VALUES
	(1, 1, NULL, 'The standard Lorem Ipsum passage, used since the 1500s', 'Neque porro quisquam est qui dolorem ipsum', 'Excepteur sint occaecat cupidatat non', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ...', 0, '2022-09-21 16:30:29', NULL, NULL, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
	(14, 1, NULL, 'The standard Lorem Ipsum passage, used since the', 'Neque porro quisquam est qui dolorem ipsum 1', 'Excepteur sint occaecat cupidatat non proident 2', '3 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ...', 1, '2022-09-21 22:09:33', '2022-09-22 21:55:56', '2022-09-27 21:53:56', '4 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.');

-- Dumping structure for table template.post_category
DROP TABLE IF EXISTS `post_category`;
CREATE TABLE IF NOT EXISTS `post_category` (
  `post_category_id` int unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int unsigned NOT NULL,
  `category_id` int unsigned NOT NULL,
  PRIMARY KEY (`post_category_id`),
  KEY `idx_pc_category` (`category_id`),
  KEY `idx_pc_post` (`post_id`),
  CONSTRAINT `fk_pc_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`),
  CONSTRAINT `fk_pc_post` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.post_category: ~1 rows (approximately)
DELETE FROM `post_category`;
INSERT INTO `post_category` (`post_category_id`, `post_id`, `category_id`) VALUES
	(2, 14, 1);

-- Dumping structure for table template.post_comment
DROP TABLE IF EXISTS `post_comment`;
CREATE TABLE IF NOT EXISTS `post_comment` (
  `post_comment_id` int unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int unsigned NOT NULL,
  `parent_id` int unsigned DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `publishedAt` datetime DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`post_comment_id`),
  KEY `idx_comment_post` (`post_id`),
  KEY `idx_comment_parent` (`parent_id`),
  CONSTRAINT `fk_comment_parent` FOREIGN KEY (`parent_id`) REFERENCES `post_comment` (`post_comment_id`),
  CONSTRAINT `fk_comment_post` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.post_comment: ~1 rows (approximately)
DELETE FROM `post_comment`;
INSERT INTO `post_comment` (`post_comment_id`, `post_id`, `parent_id`, `title`, `published`, `createdAt`, `publishedAt`, `content`) VALUES
	(1, 1, NULL, 'naziv komentara', 1, '2022-09-21 18:39:48', '2022-09-21 18:39:50', 'SadrÄąÄľaj komentara');

-- Dumping structure for table template.post_meta
DROP TABLE IF EXISTS `post_meta`;
CREATE TABLE IF NOT EXISTS `post_meta` (
  `post_mata_id` int unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int unsigned NOT NULL,
  `key` varchar(50) NOT NULL,
  `content` text,
  PRIMARY KEY (`post_mata_id`),
  UNIQUE KEY `uq_post_meta` (`post_id`,`key`),
  KEY `idx_meta_post` (`post_id`),
  CONSTRAINT `fk_meta_post` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.post_meta: ~0 rows (approximately)
DELETE FROM `post_meta`;

-- Dumping structure for table template.post_tag
DROP TABLE IF EXISTS `post_tag`;
CREATE TABLE IF NOT EXISTS `post_tag` (
  `post_tag_id` int unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int unsigned NOT NULL,
  `tag_id` int unsigned NOT NULL,
  PRIMARY KEY (`post_tag_id`) USING BTREE,
  KEY `idx_pt_tag` (`tag_id`),
  KEY `idx_pt_post` (`post_id`),
  CONSTRAINT `fk_pt_post` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`),
  CONSTRAINT `fk_pt_tag` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.post_tag: ~1 rows (approximately)
DELETE FROM `post_tag`;
INSERT INTO `post_tag` (`post_tag_id`, `post_id`, `tag_id`) VALUES
	(4, 14, 8);

-- Dumping structure for table template.role
DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `role_id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(75) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` tinytext,
  `type` smallint NOT NULL DEFAULT '0',
  `active` tinyint NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `uq_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.role: ~0 rows (approximately)
DELETE FROM `role`;

-- Dumping structure for table template.role_permission
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE IF NOT EXISTS `role_permission` (
  `role_id` int unsigned NOT NULL AUTO_INCREMENT,
  `permission_id` int unsigned NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`role_id`,`permission_id`),
  KEY `idx_rp_role` (`role_id`),
  KEY `idx_rp_permission` (`permission_id`),
  CONSTRAINT `fk_rp_permission` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`permission_id`),
  CONSTRAINT `fk_rp_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.role_permission: ~0 rows (approximately)
DELETE FROM `role_permission`;

-- Dumping structure for table template.services
DROP TABLE IF EXISTS `services`;
CREATE TABLE IF NOT EXISTS `services` (
  `service_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `excerpt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `icon_id` int unsigned DEFAULT NULL,
  `photo_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`service_id`),
  KEY `fk_services_icon_id_icons_icon_id` (`icon_id`),
  KEY `fk_services_photo_id_photos_photo_id` (`photo_id`),
  CONSTRAINT `fk_services_icon_id_icons_icon_id` FOREIGN KEY (`icon_id`) REFERENCES `icons` (`icon_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_services_photo_id_photos_photo_id` FOREIGN KEY (`photo_id`) REFERENCES `photos` (`photo_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.services: ~0 rows (approximately)
DELETE FROM `services`;

-- Dumping structure for table template.tag
DROP TABLE IF EXISTS `tag`;
CREATE TABLE IF NOT EXISTS `tag` (
  `tag_id` int unsigned NOT NULL AUTO_INCREMENT,
  `tags` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.tag: ~1 rows (approximately)
DELETE FROM `tag`;
INSERT INTO `tag` (`tag_id`, `tags`) VALUES
	(8, 'tag1, tag2, tag3, tag4');

-- Dumping structure for table template.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `firstName` varchar(50) DEFAULT NULL,
  `middleName` varchar(50) DEFAULT NULL,
  `lastName` varchar(50) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `passwordHash` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `registeredAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastLogin` datetime DEFAULT NULL,
  `intro` tinytext,
  `profile` text,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uq_mobile` (`mobile`),
  UNIQUE KEY `uq_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.user: ~2 rows (approximately)
DELETE FROM `user`;
INSERT INTO `user` (`user_id`, `firstName`, `middleName`, `lastName`, `mobile`, `email`, `passwordHash`, `registeredAt`, `lastLogin`, `intro`, `profile`) VALUES
	(1, 'Mudzahid', 'Mudzy', 'CeriĂ„â€ˇ', '062429038', 'mudi123@gmail.com', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', '2022-09-21 16:13:06', '2022-09-21 18:13:08', 'Neki intro', 'Opis profila'),
	(4, 'Goran', 'Gogo', 'KaroviÄ‡', '0624290383', 'g.karovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', '2022-09-23 21:38:00', NULL, 'Neki intro', 'Opis profila');

-- Dumping structure for table template.user_token
DROP TABLE IF EXISTS `user_token`;
CREATE TABLE IF NOT EXISTS `user_token` (
  `user_token_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `expire_at` datetime NOT NULL,
  `is_valid` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_token_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table template.user_token: ~1 rows (approximately)
DELETE FROM `user_token`;
INSERT INTO `user_token` (`user_token_id`, `user_id`, `created_at`, `token`, `expire_at`, `is_valid`) VALUES
	(1, 4, '2022-09-23 21:40:03', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo0LCJpZGVudGl0eSI6Imcua2Fyb3ZpY0BlcGJpaC5iYSIsImV4cCI6MTY2NjY0NzYwMy4xODMsImlwIjoiOjoxIiwidWEiOiJQb3N0bWFuUnVudGltZS83LjI5LjIiLCJpYXQiOjE2NjM5NjkyMDN9.eJfXkoc2ywLhanQVXjPMWTyQf3y924LMQJp8CNbmSXs', '2022-10-24 21:40:03', 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
