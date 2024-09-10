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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyer_details`
--

LOCK TABLES `buyer_details` WRITE;
/*!40000 ALTER TABLE `buyer_details` DISABLE KEYS */;
INSERT INTO `buyer_details` VALUES (1,'Priyanshu Patel','Admin','priyanshu@gmail.com',NULL,NULL,NULL,'active','2024-08-23 11:13:30'),(2,'Mayur Patel','Admin1','mayur@gmail.com',NULL,NULL,NULL,'active','2024-08-23 14:36:49'),(3,'Shyam Patel','Admin12','shyam@gmail.com',NULL,NULL,NULL,'active','2024-08-25 05:04:19'),(4,'Deep Patel','Admin13','deep@gmail.com',NULL,NULL,NULL,'active','2024-08-28 12:05:31'),(5,'Akash Patel','Admin14','akash@gmail.com',NULL,NULL,NULL,'active','2024-08-28 13:06:00'),(6,'Sanjay Patel','Admin15','sanjay@gmail.com',NULL,NULL,NULL,'active','2024-08-28 13:25:05'),(7,'Vraj Patel','Admin16','vraj1@gmail.com',NULL,NULL,NULL,'active','2024-08-28 13:35:47'),(8,'Venil Patel','Admin17','venil1@gmail.com',NULL,NULL,NULL,'active','2024-08-28 14:00:48'),(9,'Ronak Patel','Admin18','ronak@gmail.com',NULL,NULL,NULL,'active','2024-08-29 06:13:39'),(10,'Viraj Patel','Admin19','viraj@gmail.com',NULL,NULL,NULL,'active','2024-08-29 06:27:47'),(11,'Chetan Patel','Admin20','chetan1@gmail.com',NULL,NULL,NULL,'active','2024-08-29 06:38:33'),(12,'Ravi Patel','Admin21','ravi@gmail.com',NULL,NULL,NULL,'active','2024-08-29 06:40:20'),(13,'Garv Patel','Admin22','garv@gmail.com',NULL,NULL,NULL,'active','2024-08-29 08:00:55'),(14,'Ved','Admin23','ved@gmail.com.com',NULL,NULL,NULL,'active','2024-09-02 07:28:27'),(15,'Dax Patel','Admin24','dax6@gmail.com',NULL,NULL,NULL,'active','2024-09-02 14:49:33'),(16,'Kunj Patel','Admin25','kunj@gmail.com',NULL,NULL,NULL,'active','2024-09-10 13:02:09'),(17,'Kunj Patel','Admin25','kunjpatel@gmail.com',NULL,NULL,NULL,'active','2024-09-10 13:03:44');
/*!40000 ALTER TABLE `buyer_details` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier_details`
--

LOCK TABLES `supplier_details` WRITE;
/*!40000 ALTER TABLE `supplier_details` DISABLE KEYS */;
INSERT INTO `supplier_details` VALUES (1,'Priyanshu Patel','Admin','priyanshu@gmail.com',NULL,NULL,NULL,'active','2024-08-23 11:37:26'),(2,'Mayur Patel','Admin1','mayur@gmail.com',NULL,NULL,NULL,'active','2024-08-25 05:21:25'),(3,'Deep Patel','Admin2','deep1@gmail.com',NULL,NULL,NULL,'active','2024-08-28 13:28:09'),(4,'Harsh Patel','Admin3','harsh@gmail.com',NULL,NULL,NULL,'active','2024-08-28 14:02:37'),(5,'Raju Patel','Admin4','raju1@gmail.com',NULL,NULL,NULL,'active','2024-08-28 14:33:18'),(6,'Raj Patel','Admin5','raj@gmail.com',NULL,NULL,NULL,'active','2024-08-29 05:55:27'),(7,'Dev Patel','Admin6','dev@gmail.com',NULL,NULL,NULL,'active','2024-08-29 06:01:03'),(8,'Shivang Patel','Admin7','shivang@gmail.com',NULL,NULL,NULL,'active','2024-08-29 06:10:33'),(9,'Chetan Patel','Admin8','chetan@gmail.com',NULL,NULL,NULL,'active','2024-08-29 06:37:15'),(10,'Aaksh Patel','Admin9','aaksh@gmail.com',NULL,NULL,NULL,'active','2024-08-29 08:04:36'),(11,'Chirag','Admin10','chirag@gmail.com',NULL,NULL,NULL,'active','2024-09-02 08:00:28'),(12,'Deep Parekh','Admin11','deepparekh@gmail.com.com',NULL,NULL,NULL,'active','2024-09-02 14:53:51'),(13,'Deep Parekh1','Admin12','deepparekh1@gmail.com.com',NULL,NULL,NULL,'active','2024-09-02 14:55:26'),(14,'Nishit Patel','Admin13','nishit@gmail.com',NULL,NULL,NULL,'active','2024-09-10 13:05:59');
/*!40000 ALTER TABLE `supplier_details` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_details`
--

LOCK TABLES `user_details` WRITE;
/*!40000 ALTER TABLE `user_details` DISABLE KEYS */;
INSERT INTO `user_details` VALUES (1,'Priyanshu Patel','Admin','priyanshu@gmail.com','verified','2024-09-09 08:15:58'),(2,'Mayur Patel','Admin1','mayur@gmail.com','verified','2024-09-10 13:00:31');
/*!40000 ALTER TABLE `user_details` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-10 18:49:44
