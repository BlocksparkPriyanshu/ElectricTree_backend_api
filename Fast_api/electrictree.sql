-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: electrictree_db
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `adminId` int NOT NULL AUTO_INCREMENT,
  `adminEmail` varchar(255) NOT NULL,
  `adminName` varchar(255) NOT NULL,
  `adminPassword` varchar(255) NOT NULL,
  `adminStatus` tinyint(1) NOT NULL,
  `adminLastLogin` datetime DEFAULT NULL,
  `ModifiedBy` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`adminId`),
  UNIQUE KEY `adminEmail` (`adminEmail`),
  UNIQUE KEY `adminEmail_2` (`adminEmail`),
  UNIQUE KEY `adminEmail_3` (`adminEmail`),
  UNIQUE KEY `adminEmail_4` (`adminEmail`),
  UNIQUE KEY `adminEmail_5` (`adminEmail`),
  UNIQUE KEY `adminEmail_6` (`adminEmail`),
  UNIQUE KEY `adminEmail_7` (`adminEmail`),
  KEY `admins_admin_email_admin_name_admin_status` (`adminEmail`,`adminName`,`adminStatus`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'mayur.blockspark@gmail.com','Mayur Patel','$2a$10$VqIOmFDvAkZ3nq4cTtyhw.ujyChMnkJduQh4HhDThbb2MKhmr7OOm',1,NULL,'mayur.blockspark@gmail.com','2024-08-13 12:45:33','2024-08-13 12:45:33'),(6,'priyanshu.blockspark@gmail.com','Priyanshu Patel','$2a$10$EH5TEIIAz/nCu822uJryw.mIfqzOEkgpnVADZ/vS3p8B59Ij/55L.',1,NULL,'priyanshu.blockspark@gmail.com','2024-08-16 14:00:59','2024-08-16 14:00:59'),(8,'harsh@gmail.com','Harsh Patel','$2a$10$IiWNPeOn89c0nhlDjFCBhuxf6.xTfhJGCJ8HTY9lDixC15E0MwflS',1,NULL,'hasrh@gmail.com','2024-08-20 06:27:29','2024-08-20 06:27:29'),(10,'deep@gmail.com','Deep Patel','$2a$10$0L0s2Ha1tlStfvPpbdE2iuXA2cf20faA6e5oVS1v8AEejt1QGT6wi',1,NULL,'deep@gmail.com','2024-08-21 05:56:47','2024-08-21 05:56:47'),(11,'tirth@gmail.com','Tirth Patel','$2a$10$Ehsaw0TIxAvn2j6IXfR9B.jv9j7tGobQQ6yX54Ty5e4w5GBWGLkOe',1,NULL,'tirth@gmail.com','2024-08-21 07:14:25','2024-08-21 07:14:25'),(12,'priyanshu@gmail.com','Priyanshu Patel','$2a$10$4OAGOL6Mm0XPnRU2/kIBh.L/mhIGJMRd2CfsrOTNC3TjLovi1g5SS',1,NULL,'priyanshu@@gmail.com','2024-08-21 07:15:38','2024-08-21 07:15:38'),(14,'mayur@gmail.com','Mayur','$2a$10$AJc0lf9iyfszIk.XDr3y2.ok2UbCInyNf26nxCHeXdB8gZUCg4Q.i',1,NULL,'default','2024-08-21 11:55:51','2024-08-21 11:55:51');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buyer_details`
--

DROP TABLE IF EXISTS `buyer_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buyer_details` (
  `buyer_id` int NOT NULL AUTO_INCREMENT,
  `buyer_name` varchar(255) NOT NULL,
  `buyer_password` varchar(245) NOT NULL,
  `contact_email` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `purchase_capacity` decimal(10,2) DEFAULT NULL,
  `status` enum('active','inactive','pending') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`buyer_id`),
  UNIQUE KEY `contact_email_UNIQUE` (`contact_email`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyer_details`
--

LOCK TABLES `buyer_details` WRITE;
/*!40000 ALTER TABLE `buyer_details` DISABLE KEYS */;
INSERT INTO `buyer_details` VALUES (1,'Priyanshu Patel','Admin','priyanshu@gmail.com',NULL,NULL,NULL,'active','2024-08-23 11:13:30'),(2,'Mayur Patel','Admin1','mayur@gmail.com',NULL,NULL,NULL,'active','2024-08-23 14:36:49'),(3,'Shyam Patel','Admin12','shyam@gmail.com',NULL,NULL,NULL,'active','2024-08-25 05:04:19'),(4,'Deep Patel','Admin13','deep@gmail.com',NULL,NULL,NULL,'active','2024-08-28 12:05:31'),(5,'Akash Patel','Admin14','akash@gmail.com',NULL,NULL,NULL,'active','2024-08-28 13:06:00'),(6,'Sanjay Patel','Admin15','sanjay@gmail.com',NULL,NULL,NULL,'active','2024-08-28 13:25:05'),(7,'Vraj Patel','Admin16','vraj1@gmail.com',NULL,NULL,NULL,'active','2024-08-28 13:35:47'),(8,'Venil Patel','Admin17','venil1@gmail.com',NULL,NULL,NULL,'active','2024-08-28 14:00:48'),(9,'Ronak Patel','Admin18','ronak@gmail.com',NULL,NULL,NULL,'active','2024-08-29 06:13:39'),(10,'Viraj Patel','Admin19','viraj@gmail.com',NULL,NULL,NULL,'active','2024-08-29 06:27:47'),(11,'Chetan Patel','Admin20','chetan1@gmail.com',NULL,NULL,NULL,'active','2024-08-29 06:38:33'),(12,'Ravi Patel','Admin21','ravi@gmail.com',NULL,NULL,NULL,'active','2024-08-29 06:40:20'),(13,'Garv Patel','Admin22','garv@gmail.com',NULL,NULL,NULL,'active','2024-08-29 08:00:55'),(14,'Ved','Admin23','ved@gmail.com.com',NULL,NULL,NULL,'active','2024-09-02 07:28:27'),(15,'Dax Patel','Admin24','dax6@gmail.com',NULL,NULL,NULL,'active','2024-09-02 14:49:33');
/*!40000 ALTER TABLE `buyer_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `categoryName` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`categoryName`),
  KEY `categories_category_name` (`categoryName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coincategories`
--

DROP TABLE IF EXISTS `coincategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coincategories` (
  `coinCategoryId` int NOT NULL AUTO_INCREMENT,
  `coinId` int DEFAULT NULL,
  `categoryName` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`coinCategoryId`),
  UNIQUE KEY `CoinCategories_coinId_categoryName_unique` (`coinId`,`categoryName`),
  KEY `categoryName` (`categoryName`),
  CONSTRAINT `coincategories_ibfk_1` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_10` FOREIGN KEY (`categoryName`) REFERENCES `categories` (`categoryName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_11` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_12` FOREIGN KEY (`categoryName`) REFERENCES `categories` (`categoryName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_13` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_14` FOREIGN KEY (`categoryName`) REFERENCES `categories` (`categoryName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_15` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_16` FOREIGN KEY (`categoryName`) REFERENCES `categories` (`categoryName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_17` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_18` FOREIGN KEY (`categoryName`) REFERENCES `categories` (`categoryName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_19` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_2` FOREIGN KEY (`categoryName`) REFERENCES `categories` (`categoryName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_20` FOREIGN KEY (`categoryName`) REFERENCES `categories` (`categoryName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_21` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_22` FOREIGN KEY (`categoryName`) REFERENCES `categories` (`categoryName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_23` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_24` FOREIGN KEY (`categoryName`) REFERENCES `categories` (`categoryName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_25` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_26` FOREIGN KEY (`categoryName`) REFERENCES `categories` (`categoryName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_27` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_28` FOREIGN KEY (`categoryName`) REFERENCES `categories` (`categoryName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_3` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_4` FOREIGN KEY (`categoryName`) REFERENCES `categories` (`categoryName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_5` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_6` FOREIGN KEY (`categoryName`) REFERENCES `categories` (`categoryName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_7` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_8` FOREIGN KEY (`categoryName`) REFERENCES `categories` (`categoryName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coincategories_ibfk_9` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coincategories`
--

LOCK TABLES `coincategories` WRITE;
/*!40000 ALTER TABLE `coincategories` DISABLE KEYS */;
/*!40000 ALTER TABLE `coincategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coins`
--

DROP TABLE IF EXISTS `coins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coins` (
  `coinId` int NOT NULL AUTO_INCREMENT,
  `coinName` varchar(255) NOT NULL,
  `coinAddress` varchar(255) NOT NULL,
  `coinSymbol` varchar(255) NOT NULL,
  `coinDecimalPlaces` int NOT NULL,
  `coinLogoUrl` varchar(255) NOT NULL,
  `coinABI` json NOT NULL,
  `coinChainID` varchar(255) NOT NULL,
  `coinType` varchar(255) NOT NULL,
  `coinStatus` tinyint(1) DEFAULT '0',
  `createdBy` varchar(255) NOT NULL,
  `modifiedBy` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`coinId`),
  UNIQUE KEY `coinName` (`coinName`),
  UNIQUE KEY `coinName_2` (`coinName`),
  UNIQUE KEY `coinName_3` (`coinName`),
  UNIQUE KEY `coinName_4` (`coinName`),
  UNIQUE KEY `coinName_5` (`coinName`),
  UNIQUE KEY `coinName_6` (`coinName`),
  UNIQUE KEY `coinName_7` (`coinName`),
  UNIQUE KEY `coinName_8` (`coinName`),
  UNIQUE KEY `coinName_9` (`coinName`),
  UNIQUE KEY `coinName_10` (`coinName`),
  UNIQUE KEY `coinName_11` (`coinName`),
  UNIQUE KEY `coinName_12` (`coinName`),
  UNIQUE KEY `coinName_13` (`coinName`),
  UNIQUE KEY `coinName_14` (`coinName`),
  KEY `coins_coin_name_coin_address_coin_symbol` (`coinName`,`coinAddress`,`coinSymbol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coins`
--

LOCK TABLES `coins` WRITE;
/*!40000 ALTER TABLE `coins` DISABLE KEYS */;
/*!40000 ALTER TABLE `coins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kyc_documents_details`
--

DROP TABLE IF EXISTS `kyc_documents_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kyc_documents_details` (
  `kyc_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `document_type` enum('passport','driving_license','id_card','utility_bill') NOT NULL,
  `document_number` varchar(255) NOT NULL,
  `issued_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `status` enum('pending','verified','rejected') NOT NULL,
  `submitted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`kyc_id`),
  KEY `fk_user_id_idx` (`user_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_details` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kyc_documents_details`
--

LOCK TABLES `kyc_documents_details` WRITE;
/*!40000 ALTER TABLE `kyc_documents_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `kyc_documents_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kyc_verification_details`
--

DROP TABLE IF EXISTS `kyc_verification_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kyc_verification_details` (
  `verification_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL,
  `initiated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `verified_at` timestamp NULL DEFAULT NULL,
  `rejected_reason` varchar(255) DEFAULT NULL,
  `comments` text,
  PRIMARY KEY (`verification_id`),
  KEY `fk_user_id_idx` (`user_id`),
  CONSTRAINT `fk_verification_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_details` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kyc_verification_details`
--

LOCK TABLES `kyc_verification_details` WRITE;
/*!40000 ALTER TABLE `kyc_verification_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `kyc_verification_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paymentgateways`
--

DROP TABLE IF EXISTS `paymentgateways`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paymentgateways` (
  `gatewayId` int NOT NULL,
  `gatewayName` varchar(255) DEFAULT NULL,
  `gatewayAPI` varchar(255) DEFAULT NULL,
  `gateWayKey` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`gatewayId`),
  KEY `payment_gateways_gateway_name_gateway_a_p_i` (`gatewayName`,`gatewayAPI`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paymentgateways`
--

LOCK TABLES `paymentgateways` WRITE;
/*!40000 ALTER TABLE `paymentgateways` DISABLE KEYS */;
/*!40000 ALTER TABLE `paymentgateways` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_details`
--

DROP TABLE IF EXISTS `product_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_details` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_details`
--

LOCK TABLES `product_details` WRITE;
/*!40000 ALTER TABLE `product_details` DISABLE KEYS */;
INSERT INTO `product_details` VALUES (1,'Iphone 13','This is Iphone 13 mobile phone.',80000.00,'2024-09-03 10:58:16','2024-09-03 10:58:16'),(4,'Reebok Shoes','This is reebox shoes.',1499.99,'2024-09-03 14:09:43','2024-09-03 14:14:31');
/*!40000 ALTER TABLE `product_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_details`
--

DROP TABLE IF EXISTS `project_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_details` (
  `project_id` int NOT NULL AUTO_INCREMENT,
  `project_name` varchar(255) NOT NULL,
  `project_description` text,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `status` enum('ongoing','completed','on hold') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_details`
--

LOCK TABLES `project_details` WRITE;
/*!40000 ALTER TABLE `project_details` DISABLE KEYS */;
INSERT INTO `project_details` VALUES (1,'ElectricTree','Carbon removal is the process of removing carbon dioxide from the atmosphere and locking it away for decades, centuries, or millennia.','2024-08-30','2024-10-30','ongoing','2024-08-30 11:41:43','2024-08-30 11:41:43'),(3,'Blockchain','This is blockchain project.','2024-09-03','2024-10-04','ongoing','2024-09-03 07:00:42','2024-09-03 07:00:42');
/*!40000 ALTER TABLE `project_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_details`
--

DROP TABLE IF EXISTS `stock_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_details` (
  `stock_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `stock_quantity` int NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `product_name` varchar(245) NOT NULL,
  PRIMARY KEY (`stock_id`),
  KEY `fk_product_id_idx` (`product_id`),
  KEY `fk_product_name_idx` (`product_name`),
  CONSTRAINT `fk_product_id` FOREIGN KEY (`product_id`) REFERENCES `product_details` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_details`
--

LOCK TABLES `stock_details` WRITE;
/*!40000 ALTER TABLE `stock_details` DISABLE KEYS */;
INSERT INTO `stock_details` VALUES (1,1,80,'2024-09-03 10:58:16','Iphone 13'),(5,4,50,'2024-09-03 14:13:26','Nike Shoes'),(6,4,200,'2024-09-03 15:02:04','Reebok Shoes'),(7,4,150,'2024-09-03 15:09:11','Reebok Shoes');
/*!40000 ALTER TABLE `stock_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier_details`
--

DROP TABLE IF EXISTS `supplier_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier_details` (
  `supplier_id` int NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(255) NOT NULL,
  `supplier_password` varchar(255) NOT NULL,
  `contact_email` varchar(245) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `country` varchar(245) DEFAULT NULL,
  `supply_capacity` decimal(10,2) DEFAULT NULL,
  `status` enum('active','inactive','pending') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier_details`
--

LOCK TABLES `supplier_details` WRITE;
/*!40000 ALTER TABLE `supplier_details` DISABLE KEYS */;
INSERT INTO `supplier_details` VALUES (1,'Priyanshu Patel','Admin','priyanshu@gmail.com',NULL,NULL,NULL,'active','2024-08-23 11:37:26'),(2,'Mayur Patel','Admin1','mayur@gmail.com',NULL,NULL,NULL,'active','2024-08-25 05:21:25'),(3,'Deep Patel','Admin2','deep1@gmail.com',NULL,NULL,NULL,'active','2024-08-28 13:28:09'),(4,'Harsh Patel','Admin3','harsh@gmail.com',NULL,NULL,NULL,'active','2024-08-28 14:02:37'),(5,'Raju Patel','Admin4','raju1@gmail.com',NULL,NULL,NULL,'active','2024-08-28 14:33:18'),(6,'Raj Patel','Admin5','raj@gmail.com',NULL,NULL,NULL,'active','2024-08-29 05:55:27'),(7,'Dev Patel','Admin6','dev@gmail.com',NULL,NULL,NULL,'active','2024-08-29 06:01:03'),(8,'Shivang Patel','Admin7','shivang@gmail.com',NULL,NULL,NULL,'active','2024-08-29 06:10:33'),(9,'Chetan Patel','Admin8','chetan@gmail.com',NULL,NULL,NULL,'active','2024-08-29 06:37:15'),(10,'Aaksh Patel','Admin9','aaksh@gmail.com',NULL,NULL,NULL,'active','2024-08-29 08:04:36'),(11,'Chirag','Admin10','chirag@gmail.com',NULL,NULL,NULL,'active','2024-09-02 08:00:28'),(12,'Deep Parekh','Admin11','deepparekh@gmail.com.com',NULL,NULL,NULL,'active','2024-09-02 14:53:51'),(13,'Deep Parekh1','Admin12','deepparekh1@gmail.com.com',NULL,NULL,NULL,'active','2024-09-02 14:55:26');
/*!40000 ALTER TABLE `supplier_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `txId` int NOT NULL,
  `txHash` varchar(255) DEFAULT NULL,
  `txData` varchar(255) DEFAULT NULL,
  `txCoins` json DEFAULT NULL,
  `txFees` int DEFAULT NULL,
  `txStatus` varchar(255) DEFAULT NULL,
  `uId` int DEFAULT NULL,
  `vaultId` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`txId`),
  KEY `transactions_tx_hash_tx_status` (`txHash`,`txStatus`),
  KEY `uId` (`uId`),
  KEY `vaultId` (`vaultId`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`uId`) REFERENCES `users` (`userId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_10` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_11` FOREIGN KEY (`uId`) REFERENCES `users` (`userId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_12` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_13` FOREIGN KEY (`uId`) REFERENCES `users` (`userId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_14` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_15` FOREIGN KEY (`uId`) REFERENCES `users` (`userId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_16` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_17` FOREIGN KEY (`uId`) REFERENCES `users` (`userId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_18` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_19` FOREIGN KEY (`uId`) REFERENCES `users` (`userId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_20` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_21` FOREIGN KEY (`uId`) REFERENCES `users` (`userId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_22` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_23` FOREIGN KEY (`uId`) REFERENCES `users` (`userId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_24` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_25` FOREIGN KEY (`uId`) REFERENCES `users` (`userId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_26` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_27` FOREIGN KEY (`uId`) REFERENCES `users` (`userId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_28` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_3` FOREIGN KEY (`uId`) REFERENCES `users` (`userId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_4` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_5` FOREIGN KEY (`uId`) REFERENCES `users` (`userId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_6` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_7` FOREIGN KEY (`uId`) REFERENCES `users` (`userId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_8` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_9` FOREIGN KEY (`uId`) REFERENCES `users` (`userId`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_details`
--

DROP TABLE IF EXISTS `user_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_details` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `status` enum('pending','verified','rejected') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_details`
--

LOCK TABLES `user_details` WRITE;
/*!40000 ALTER TABLE `user_details` DISABLE KEYS */;
INSERT INTO `user_details` VALUES (1,'Priyanshu Patel','Admin','priyanshu@gmail.com','verified','2024-09-09 08:15:58');
/*!40000 ALTER TABLE `user_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `userAddress` varchar(255) NOT NULL,
  `userName` varchar(255) NOT NULL,
  `userProvider` varchar(255) NOT NULL,
  `userStatus` tinyint(1) NOT NULL,
  `userLastLogin` datetime DEFAULT NULL,
  `modifiedBy` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `userAddress` (`userAddress`),
  UNIQUE KEY `userAddress_2` (`userAddress`),
  UNIQUE KEY `userAddress_3` (`userAddress`),
  UNIQUE KEY `userAddress_4` (`userAddress`),
  UNIQUE KEY `userAddress_5` (`userAddress`),
  UNIQUE KEY `userAddress_6` (`userAddress`),
  UNIQUE KEY `userAddress_7` (`userAddress`),
  UNIQUE KEY `userAddress_8` (`userAddress`),
  UNIQUE KEY `userAddress_9` (`userAddress`),
  UNIQUE KEY `userAddress_10` (`userAddress`),
  UNIQUE KEY `userAddress_11` (`userAddress`),
  UNIQUE KEY `userAddress_12` (`userAddress`),
  UNIQUE KEY `userAddress_13` (`userAddress`),
  UNIQUE KEY `userAddress_14` (`userAddress`),
  KEY `users_user_address_user_name` (`userAddress`,`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uservaults`
--

DROP TABLE IF EXISTS `uservaults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uservaults` (
  `userVaultId` int NOT NULL,
  `userId` int DEFAULT NULL,
  `vaultId` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`userVaultId`),
  UNIQUE KEY `UserVaults_vaultId_userId_unique` (`userId`,`vaultId`),
  KEY `vaultId` (`vaultId`),
  CONSTRAINT `uservaults_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_10` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_11` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_12` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_13` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_14` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_15` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_16` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_17` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_18` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_19` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_2` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_20` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_21` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_22` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_23` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_24` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_25` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_26` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_27` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_28` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_3` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_4` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_5` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_6` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_7` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_8` FOREIGN KEY (`vaultId`) REFERENCES `vaults` (`vaultId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservaults_ibfk_9` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uservaults`
--

LOCK TABLES `uservaults` WRITE;
/*!40000 ALTER TABLE `uservaults` DISABLE KEYS */;
/*!40000 ALTER TABLE `uservaults` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaults`
--

DROP TABLE IF EXISTS `vaults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaults` (
  `vaultId` int NOT NULL,
  `vaultName` varchar(255) NOT NULL,
  `vaultDescription` varchar(255) DEFAULT NULL,
  `vaultBuytype` varchar(255) DEFAULT NULL,
  `vaultStrategy` varchar(255) DEFAULT NULL,
  `vaultRebalancing` tinyint(1) DEFAULT NULL,
  `vaultHoldterm` varchar(255) DEFAULT NULL,
  `vaultProvider` varchar(255) DEFAULT NULL,
  `vaultCoins` json DEFAULT NULL,
  `coinId` int DEFAULT NULL,
  `vaultStatus` tinyint(1) DEFAULT '0',
  `createdBy` varchar(255) DEFAULT NULL,
  `modifiedBy` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`vaultId`),
  KEY `vaults_vault_id_vault_name_vault_description` (`vaultId`,`vaultName`,`vaultDescription`),
  KEY `coinId` (`coinId`),
  CONSTRAINT `vaults_ibfk_1` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON UPDATE CASCADE,
  CONSTRAINT `vaults_ibfk_10` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON UPDATE CASCADE,
  CONSTRAINT `vaults_ibfk_11` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON UPDATE CASCADE,
  CONSTRAINT `vaults_ibfk_12` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON UPDATE CASCADE,
  CONSTRAINT `vaults_ibfk_13` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON UPDATE CASCADE,
  CONSTRAINT `vaults_ibfk_14` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON UPDATE CASCADE,
  CONSTRAINT `vaults_ibfk_2` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON UPDATE CASCADE,
  CONSTRAINT `vaults_ibfk_3` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON UPDATE CASCADE,
  CONSTRAINT `vaults_ibfk_4` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON UPDATE CASCADE,
  CONSTRAINT `vaults_ibfk_5` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON UPDATE CASCADE,
  CONSTRAINT `vaults_ibfk_6` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON UPDATE CASCADE,
  CONSTRAINT `vaults_ibfk_7` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON UPDATE CASCADE,
  CONSTRAINT `vaults_ibfk_8` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON UPDATE CASCADE,
  CONSTRAINT `vaults_ibfk_9` FOREIGN KEY (`coinId`) REFERENCES `coins` (`coinId`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaults`
--

LOCK TABLES `vaults` WRITE;
/*!40000 ALTER TABLE `vaults` DISABLE KEYS */;
/*!40000 ALTER TABLE `vaults` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-09 18:13:52
