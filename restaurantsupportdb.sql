CREATE DATABASE  IF NOT EXISTS `restaurantsupport` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `restaurantsupport`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: restaurantsupport
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `customer_name` char(20) NOT NULL,
  `cell` char(20) NOT NULL,
  `email_id` char(100) NOT NULL,
  `satisfaction_rating` int NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `customer_id_UNIQUE` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Alice Johnson','555-1234','alice@email.com',4),(2,'Bob Smith','555-5678','bob@email.com',5),(3,'Charlie Brown','555-8765','charlie@email.com',3),(4,'David Williams','555-4321','david@email.com',4);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loyalty`
--

DROP TABLE IF EXISTS `loyalty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loyalty` (
  `loyalty_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `loyalty_points` int DEFAULT '0',
  `tier_level` enum('Bronze','Silver','Gold') DEFAULT 'Bronze',
  `last_visit_date` date DEFAULT NULL,
  PRIMARY KEY (`loyalty_id`),
  KEY `loyalty_customer_id` (`customer_id`),
  CONSTRAINT `loyalty_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loyalty`
--

LOCK TABLES `loyalty` WRITE;
/*!40000 ALTER TABLE `loyalty` DISABLE KEYS */;
INSERT INTO `loyalty` VALUES (1,1,120,'Silver','2024-11-01'),(2,2,300,'Gold','2024-10-20'),(3,3,50,'Bronze','2024-11-10'),(4,4,150,'Silver','2024-11-05');
/*!40000 ALTER TABLE `loyalty` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `loyalty_AFTER_UPDATE` AFTER UPDATE ON `loyalty` FOR EACH ROW BEGIN
IF NEW.loyalty_points >= 300 AND NEW.tier_level != 'Gold' THEN
        UPDATE Loyalty
        SET tier_level = 'Gold'
        WHERE customer_id = NEW.customer_id;
    ELSEIF NEW.loyalty_points >= 100 AND NEW.tier_level != 'Silver' THEN
        UPDATE Loyalty
        SET tier_level = 'Silver'
        WHERE customer_id = NEW.customer_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `reservetable`
--

DROP TABLE IF EXISTS `reservetable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservetable` (
  `number_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `time_date` date NOT NULL,
  `restaurant_id` int NOT NULL,
  PRIMARY KEY (`number_id`),
  KEY `reservetable_ibfk_2_idx` (`customer_id`),
  KEY `reservetable_restaurant_id_idx` (`restaurant_id`),
  CONSTRAINT `reservetable_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE,
  CONSTRAINT `reservetable_restaurant_id` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`restaurant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservetable`
--

LOCK TABLES `reservetable` WRITE;
/*!40000 ALTER TABLE `reservetable` DISABLE KEYS */;
INSERT INTO `reservetable` VALUES (1,1,'2024-11-20',1),(2,2,'2024-11-20',2),(3,3,'2024-11-20',1),(4,4,'2024-11-21',3);
/*!40000 ALTER TABLE `reservetable` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_loyalty_points` AFTER INSERT ON `reservetable` FOR EACH ROW BEGIN
    DECLARE current_points INT;

    -- Check if customer already has loyalty points
    SELECT loyalty_points INTO current_points
    FROM Loyalty
    WHERE customer_id = NEW.customer_id;

    -- If customer has loyalty, update points
    IF current_points IS NOT NULL THEN
        UPDATE Loyalty
        SET loyalty_points = loyalty_points + 10  -- Add points for reservation (adjust as needed)
        WHERE customer_id = NEW.customer_id;
    
    -- If no loyalty points, create a new record for the customer
    ELSE
        INSERT INTO Loyalty (customer_id, loyalty_points, tier_level, last_visit_date)
        VALUES (NEW.customer_id, 10, 'Bronze', CURDATE());  -- Initial points and Bronze tier
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant` (
  `restaurant_id` int NOT NULL AUTO_INCREMENT,
  `street_address` char(100) NOT NULL,
  `city` char(50) NOT NULL,
  `state` char(20) NOT NULL,
  `zip_code` int NOT NULL,
  `capacity` int NOT NULL,
  PRIMARY KEY (`restaurant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES (1,'123 Main St','CityA','StateX',12345,50),(2,'456 Oak Ave','CityB','StateY',67890,60),(3,'789 Pine Rd','CityC','StateZ',11223,40);
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server`
--

DROP TABLE IF EXISTS `server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `server` (
  `employee_id` int NOT NULL,
  `salary` double NOT NULL,
  `first_name` char(50) NOT NULL,
  `last_name` char(50) NOT NULL,
  `restaurant_id` int DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `server_restaurant_Id_idx` (`restaurant_id`),
  CONSTRAINT `server_restaurant_Id` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`restaurant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server`
--

LOCK TABLES `server` WRITE;
/*!40000 ALTER TABLE `server` DISABLE KEYS */;
INSERT INTO `server` VALUES (1,35000,'Sophia','Davis',1),(2,42000,'Liam','Martinez',2),(3,38000,'Olivia','Taylor',1),(4,40000,'Ethan','Miller',3);
/*!40000 ALTER TABLE `server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waitlist`
--

DROP TABLE IF EXISTS `waitlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `waitlist` (
  `waitlist_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `party_size` int NOT NULL,
  `estimated_wait_time` int DEFAULT NULL,
  `arrival_time` timestamp NULL DEFAULT NULL,
  `status` enum('waiting','seated','cancelled') DEFAULT NULL,
  `notification_preference` enum('SMS','Email') DEFAULT NULL,
  `restaurant_id` int DEFAULT NULL,
  PRIMARY KEY (`waitlist_id`),
  KEY `reservetable_ibfk_1_idx` (`customer_id`),
  KEY `fk_restaurant_id_idx` (`restaurant_id`),
  CONSTRAINT `fk_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_restaurant_id` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`restaurant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waitlist`
--

LOCK TABLES `waitlist` WRITE;
/*!40000 ALTER TABLE `waitlist` DISABLE KEYS */;
INSERT INTO `waitlist` VALUES (1,1,2,30,'2024-11-19 22:30:00','waiting','SMS',1),(2,2,3,45,'2024-11-20 00:00:00','waiting','Email',2),(3,3,2,15,'2024-11-20 00:30:00','waiting','SMS',1),(4,4,4,60,'2024-11-20 01:30:00','waiting','Email',3);
/*!40000 ALTER TABLE `waitlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'restaurantsupport'
--

--
-- Dumping routines for database 'restaurantsupport'
--
/*!50003 DROP PROCEDURE IF EXISTS `UpdateWaitlistStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateWaitlistStatus`(IN waitlistId INT, IN newStatus ENUM('waiting', 'seated', 'cancelled'))
BEGIN
    UPDATE Waitlist
    SET status = newStatus
    WHERE waitlist_id = waitlistId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-05 14:29:38
