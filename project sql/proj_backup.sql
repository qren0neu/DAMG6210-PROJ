-- MySQL dump 10.13  Distrib 8.0.28, for macos11 (x86_64)
--
-- Host: 127.0.0.1    Database: hospital_test
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `Admin`
--

DROP TABLE IF EXISTS `Admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Admin` (
  `pkAdmin` varchar(10) NOT NULL,
  `adminAccount` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `fkStaff` varchar(10) NOT NULL,
  PRIMARY KEY (`pkAdmin`),
  KEY `admin_fk1_idx` (`fkStaff`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment` (
  `pkAppoint` mediumint NOT NULL AUTO_INCREMENT,
  `appointmentTime` datetime NOT NULL,
  `price` smallint DEFAULT NULL,
  `type` char(1) NOT NULL COMMENT 'N means normal, e means expert, f means follow-up appointment',
  `status` char(1) NOT NULL,
  `fkInvoice` mediumint DEFAULT NULL,
  `fkPatient` varchar(10) NOT NULL,
  `fkSchedule` mediumint NOT NULL,
  PRIMARY KEY (`pkAppoint`),
  KEY `fkPatient` (`fkPatient`),
  KEY `fkSchedule` (`fkSchedule`),
  KEY `fkInvoice` (`fkInvoice`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`fkPatient`) REFERENCES `patient` (`pkPatient`),
  CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`fkSchedule`) REFERENCES `schedule` (`pkSchedule`),
  CONSTRAINT `appointment_ibfk_3` FOREIGN KEY (`fkInvoice`) REFERENCES `invoice` (`pkInvoice`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `invoice` BEFORE INSERT ON `appointment` FOR EACH ROW BEGIN
  set @money = new.price;
  insert into invoice values (null, date(now()), adddate(now(), interval 2 month), 'a', @money, 'u');
  set new.fkInvoice = LAST_INSERT_ID();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `clinic`
--

DROP TABLE IF EXISTS `clinic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinic` (
  `pkClinic` smallint NOT NULL AUTO_INCREMENT,
  `usage` varchar(30) NOT NULL,
  `fkRoom` smallint NOT NULL,
  PRIMARY KEY (`pkClinic`),
  KEY `fkRoom` (`fkRoom`),
  CONSTRAINT `clinic_ibfk_1` FOREIGN KEY (`fkRoom`) REFERENCES `room` (`pkRoom`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `pkDepartment` tinyint NOT NULL AUTO_INCREMENT,
  `name` varchar(24) NOT NULL,
  `description` text,
  PRIMARY KEY (`pkDepartment`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `departmentstaffnumberview`
--

DROP TABLE IF EXISTS `departmentstaffnumberview`;
/*!50001 DROP VIEW IF EXISTS `departmentstaffnumberview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `departmentstaffnumberview` AS SELECT 
 1 AS `staffNumber`,
 1 AS `name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `device`
--

DROP TABLE IF EXISTS `device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device` (
  `pkDevice` smallint NOT NULL AUTO_INCREMENT,
  `deviceName` varchar(20) NOT NULL,
  `description` text,
  PRIMARY KEY (`pkDevice`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `device_order`
--

DROP TABLE IF EXISTS `device_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_order` (
  `pkOrder` mediumint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `quantity` smallint NOT NULL,
  `itemPrice` float NOT NULL,
  `fkDevice` smallint NOT NULL,
  `fkProducer` smallint NOT NULL,
  PRIMARY KEY (`pkOrder`),
  KEY `fkProducer` (`fkProducer`),
  KEY `fkDevice` (`fkDevice`),
  CONSTRAINT `device_order_ibfk_1` FOREIGN KEY (`fkProducer`) REFERENCES `producer` (`pkProducer`),
  CONSTRAINT `device_order_ibfk_2` FOREIGN KEY (`fkDevice`) REFERENCES `device` (`pkDevice`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `diagnosis`
--

DROP TABLE IF EXISTS `diagnosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diagnosis` (
  `pkDiagonsis` mediumint NOT NULL AUTO_INCREMENT,
  `description` varchar(50) DEFAULT NULL,
  `fkDisease` mediumint DEFAULT NULL,
  `fkInquiry` mediumint DEFAULT NULL,
  PRIMARY KEY (`pkDiagonsis`),
  KEY `fkInquiry` (`fkInquiry`),
  CONSTRAINT `diagnosis_ibfk_1` FOREIGN KEY (`fkInquiry`) REFERENCES `inquiry` (`pkInquiry`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `disease`
--

DROP TABLE IF EXISTS `disease`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disease` (
  `pkDisease` mediumint NOT NULL AUTO_INCREMENT,
  `diseaseName` varchar(36) NOT NULL,
  `description` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`pkDisease`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `diseasethatmayleadpatienttobeinhospitalview`
--

DROP TABLE IF EXISTS `diseasethatmayleadpatienttobeinhospitalview`;
/*!50001 DROP VIEW IF EXISTS `diseasethatmayleadpatienttobeinhospitalview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `diseasethatmayleadpatienttobeinhospitalview` AS SELECT 
 1 AS `patientName`,
 1 AS `inquiryDate`,
 1 AS `doctorName`,
 1 AS `diseaseName`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor` (
  `pkDoctor` varchar(10) NOT NULL COMMENT 'Id for the doctor, to support further change, use varchar(10)',
  `introduction` varchar(100) DEFAULT NULL,
  `fkStaff` varchar(10) NOT NULL,
  PRIMARY KEY (`pkDoctor`),
  KEY `doctor_ibfk_1` (`fkStaff`),
  CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`fkStaff`) REFERENCES `staff` (`pkStaff`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `pkEquipment` smallint NOT NULL AUTO_INCREMENT,
  `status` char(1) DEFAULT NULL COMMENT 'A is available, u is unavailable',
  `fkDevice` smallint NOT NULL,
  `fkRoom` smallint NOT NULL,
  PRIMARY KEY (`pkEquipment`),
  KEY `fkDevice` (`fkDevice`),
  KEY `fkRoom` (`fkRoom`),
  CONSTRAINT `equipment_ibfk_1` FOREIGN KEY (`fkDevice`) REFERENCES `device` (`pkDevice`),
  CONSTRAINT `equipment_ibfk_2` FOREIGN KEY (`fkRoom`) REFERENCES `room` (`pkRoom`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `factory`
--

DROP TABLE IF EXISTS `factory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factory` (
  `pkFactory` smallint NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`pkFactory`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hospitalization`
--

DROP TABLE IF EXISTS `hospitalization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospitalization` (
  `pkHos` mediumint NOT NULL AUTO_INCREMENT,
  `fromDate` date NOT NULL,
  `toDate` date NOT NULL,
  `dailyExpense` smallint DEFAULT NULL,
  `fkWard` smallint NOT NULL,
  `fkStaff` varchar(10) DEFAULT NULL,
  `fkPatient` varchar(10) NOT NULL,
  `fkInvoice` mediumint NOT NULL,
  PRIMARY KEY (`pkHos`),
  KEY `fkWard` (`fkWard`),
  KEY `fkStaff` (`fkStaff`),
  KEY `fkPatient` (`fkPatient`),
  KEY `hos_fk4_idx` (`fkInvoice`),
  CONSTRAINT `hos_fk4` FOREIGN KEY (`fkInvoice`) REFERENCES `invoice` (`pkInvoice`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `hospitalization_ibfk_1` FOREIGN KEY (`fkWard`) REFERENCES `ward` (`pkWard`),
  CONSTRAINT `hospitalization_ibfk_2` FOREIGN KEY (`fkStaff`) REFERENCES `staff` (`pkStaff`),
  CONSTRAINT `hospitalization_ibfk_3` FOREIGN KEY (`fkPatient`) REFERENCES `patient` (`pkPatient`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `invoiceHouse` BEFORE INSERT ON `hospitalization` FOR EACH ROW BEGIN
  set @hosMoney = (datediff(new.todate, new.fromdate) * new.dailyExpense);
  insert into invoice values (null, date(now()), adddate(now(), interval 2 month), 'a', @hosMoney, 'u');
  set new.fkInvoice = LAST_INSERT_ID();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `inquiry`
--

DROP TABLE IF EXISTS `inquiry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inquiry` (
  `pkInquiry` mediumint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `memo` varchar(120) DEFAULT NULL,
  `fkPatient` varchar(10) NOT NULL,
  `fkDoctor` varchar(10) NOT NULL,
  PRIMARY KEY (`pkInquiry`),
  KEY `fkDoctor` (`fkDoctor`),
  KEY `fkPatient` (`fkPatient`),
  CONSTRAINT `inquiry_ibfk_1` FOREIGN KEY (`fkDoctor`) REFERENCES `doctor` (`pkDoctor`),
  CONSTRAINT `inquiry_ibfk_2` FOREIGN KEY (`fkPatient`) REFERENCES `patient` (`pkPatient`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `pkInvoice` mediumint NOT NULL AUTO_INCREMENT,
  `creationDate` date NOT NULL,
  `dueDate` date NOT NULL,
  `type` char(1) NOT NULL COMMENT 'Appointment invoice is type a, prescription invoice is p, hospitalization is h',
  `price` float NOT NULL,
  `status` char(1) DEFAULT NULL COMMENT 'P is paid, u is unpaid, c is cancelled',
  PRIMARY KEY (`pkInvoice`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medicine`
--

DROP TABLE IF EXISTS `medicine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicine` (
  `pkMedicine` mediumint NOT NULL AUTO_INCREMENT,
  `medicineName` varchar(36) NOT NULL,
  `productionDate` date NOT NULL,
  `expirationDate` date NOT NULL,
  `price` float NOT NULL,
  `stock` mediumint DEFAULT NULL,
  PRIMARY KEY (`pkMedicine`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medicine_order`
--

DROP TABLE IF EXISTS `medicine_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicine_order` (
  `pkOrder` mediumint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `quantity` mediumint NOT NULL,
  `itemPrice` float NOT NULL,
  `fkMedicine` mediumint NOT NULL,
  `fkFactory` smallint NOT NULL,
  PRIMARY KEY (`pkOrder`),
  KEY `fkMedicine` (`fkMedicine`),
  KEY `fkFactory` (`fkFactory`),
  CONSTRAINT `medicine_order_ibfk_1` FOREIGN KEY (`fkMedicine`) REFERENCES `medicine` (`pkMedicine`),
  CONSTRAINT `medicine_order_ibfk_2` FOREIGN KEY (`fkFactory`) REFERENCES `factory` (`pkFactory`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nurse`
--

DROP TABLE IF EXISTS `nurse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nurse` (
  `pkNurse` varchar(10) NOT NULL,
  `fkStaff` varchar(10) NOT NULL,
  PRIMARY KEY (`pkNurse`),
  KEY `nurse_ibfk_1` (`fkStaff`),
  CONSTRAINT `nurse_ibfk_1` FOREIGN KEY (`fkStaff`) REFERENCES `staff` (`pkStaff`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `pkPatient` varchar(10) NOT NULL,
  `fname` varchar(60) NOT NULL,
  `lname` varchar(60) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(90) DEFAULT NULL,
  `password` varchar(20) NOT NULL,
  PRIMARY KEY (`pkPatient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `patient_update_backup` BEFORE UPDATE ON `patient` FOR EACH ROW INSERT INTO patient_record
  VALUES
    (null, old.pkPatient, old.fname, old.lname, old.dateOfBirth, old.phone, old.email, old.password, 'd', now()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `patient_delete_backup` BEFORE DELETE ON `patient` FOR EACH ROW INSERT INTO patient_record
  VALUES
    (null, old.pkPatient, old.fname, old.lname, old.dateOfBirth, old.phone, old.email, old.password, 'd', now()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `patient_record`
--

DROP TABLE IF EXISTS `patient_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_record` (
  `recordId` int NOT NULL AUTO_INCREMENT,
  `patientId` varchar(10) NOT NULL,
  `fname` varchar(60) NOT NULL,
  `lname` varchar(60) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(90) DEFAULT NULL,
  `password` varchar(20) NOT NULL,
  `type` char(1) NOT NULL COMMENT 'U means update, d means delete',
  `recordTime` datetime NOT NULL,
  PRIMARY KEY (`recordId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `patientwithmedicinepaymentview`
--

DROP TABLE IF EXISTS `patientwithmedicinepaymentview`;
/*!50001 DROP VIEW IF EXISTS `patientwithmedicinepaymentview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `patientwithmedicinepaymentview` AS SELECT 
 1 AS `patientName`,
 1 AS `inquiryDate`,
 1 AS `medicine`,
 1 AS `doctorName`,
 1 AS `medicinePayment`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `prescription`
--

DROP TABLE IF EXISTS `prescription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescription` (
  `pkPrescription` mediumint NOT NULL AUTO_INCREMENT,
  `instruction` varchar(120) DEFAULT NULL,
  `quantity` tinyint NOT NULL,
  `fkInvoice` mediumint DEFAULT NULL,
  `fkDiagnose` mediumint NOT NULL,
  `fkMedicine` mediumint NOT NULL,
  PRIMARY KEY (`pkPrescription`),
  KEY `fkDiagnose` (`fkDiagnose`),
  KEY `fkMedicine` (`fkMedicine`),
  KEY `pres_fk3_idx` (`fkInvoice`),
  CONSTRAINT `pres_fk3` FOREIGN KEY (`fkInvoice`) REFERENCES `invoice` (`pkInvoice`),
  CONSTRAINT `prescription_ibfk_1` FOREIGN KEY (`fkDiagnose`) REFERENCES `diagnosis` (`pkDiagonsis`),
  CONSTRAINT `prescription_ibfk_2` FOREIGN KEY (`fkMedicine`) REFERENCES `medicine` (`pkMedicine`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `invoicePres` BEFORE INSERT ON `prescription` FOR EACH ROW BEGIN
  set @presMoney = ((select price from medicine where pkMedicine = new.fkMedicine) * new.quantity);
  insert into invoice values (null, date(now()), adddate(now(), interval 2 month), 'a', @presMoney, 'u');
  set new.fkInvoice = LAST_INSERT_ID();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `producer`
--

DROP TABLE IF EXISTS `producer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producer` (
  `pkProducer` smallint NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `address` varchar(120) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  PRIMARY KEY (`pkProducer`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `pkRoom` smallint NOT NULL COMMENT 'Room number in the building',
  `floor` tinyint(1) NOT NULL COMMENT 'The floor of the room',
  `type` char(1) NOT NULL COMMENT 'The type of the room, w means ward, c means clinic',
  PRIMARY KEY (`pkRoom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salary_payment`
--

DROP TABLE IF EXISTS `salary_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salary_payment` (
  `pkPayment` mediumint NOT NULL AUTO_INCREMENT,
  `salary` float NOT NULL,
  `tax` float NOT NULL,
  `date` date NOT NULL,
  `fkStaff` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`pkPayment`),
  KEY `fkStaff` (`fkStaff`),
  CONSTRAINT `salary_payment_ibfk_1` FOREIGN KEY (`fkStaff`) REFERENCES `staff` (`pkStaff`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule` (
  `pkSchedule` mediumint NOT NULL AUTO_INCREMENT,
  `fromTime` datetime NOT NULL,
  `toTime` datetime NOT NULL,
  `status` char(1) NOT NULL COMMENT 'A means approved, c means cancelled, f means finished',
  `fkNurse` varchar(10) DEFAULT NULL COMMENT 'Nurse is not mandatory in a schedule',
  `fkDoctor` varchar(10) NOT NULL,
  `fkRoom` smallint NOT NULL,
  PRIMARY KEY (`pkSchedule`),
  KEY `schedule_fk3_idx` (`fkRoom`),
  KEY `schedule_ibfk_2` (`fkDoctor`),
  KEY `schedule_ibfk_1` (`fkNurse`),
  CONSTRAINT `schedule_fk3` FOREIGN KEY (`fkRoom`) REFERENCES `clinic` (`pkClinic`),
  CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`fkNurse`) REFERENCES `nurse` (`pkNurse`),
  CONSTRAINT `schedule_ibfk_2` FOREIGN KEY (`fkDoctor`) REFERENCES `doctor` (`pkDoctor`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `pkStaff` varchar(10) NOT NULL COMMENT 'Staff Number',
  `fname` varchar(60) NOT NULL,
  `lname` varchar(60) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(90) DEFAULT NULL,
  `password` varchar(20) NOT NULL,
  `address` varchar(120) NOT NULL,
  `type` char(1) NOT NULL COMMENT 'A means system administrator, d means doctor, n means nurse, s means staff',
  `jobTitle` varchar(30) NOT NULL,
  `salary` float NOT NULL,
  `bankaccount` char(16) NOT NULL,
  `fkDepartment` tinyint DEFAULT NULL,
  PRIMARY KEY (`pkStaff`),
  KEY `fkDepartment` (`fkDepartment`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`fkDepartment`) REFERENCES `department` (`pkDepartment`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `staff_update_backup` BEFORE UPDATE ON `staff` FOR EACH ROW INSERT INTO staff_record
  VALUES
    (null, old.pkStaff, old.fname, old.lname, old.dateOfBirth, old.phone, old.email, old.password, old.type, now(), old.jobTitle, old.salary, old.bankaccount, 'u') */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `staff_delete_backup` BEFORE DELETE ON `staff` FOR EACH ROW INSERT INTO staff_record
  VALUES
    (null, old.pkStaff, old.fname, old.lname, old.dateOfBirth, old.phone, old.email, old.password, old.type, now(), old.jobTitle, old.salary, old.bankaccount, 'd') */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `staff_record`
--

DROP TABLE IF EXISTS `staff_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff_record` (
  `recordId` int NOT NULL AUTO_INCREMENT,
  `staffId` varchar(10) NOT NULL,
  `fname` varchar(60) NOT NULL,
  `lname` varchar(60) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(90) DEFAULT NULL,
  `password` varchar(20) NOT NULL,
  `type` char(1) NOT NULL,
  `recordTime` datetime NOT NULL,
  `jobTitle` varchar(30) NOT NULL,
  `salary` float NOT NULL,
  `bankaccount` char(16) NOT NULL,
  `recordType` char(1) NOT NULL,
  PRIMARY KEY (`recordId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `topdevicesellerview`
--

DROP TABLE IF EXISTS `topdevicesellerview`;
/*!50001 DROP VIEW IF EXISTS `topdevicesellerview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `topdevicesellerview` AS SELECT 
 1 AS `orderCount`,
 1 AS `producerName`,
 1 AS `totalQuantity`,
 1 AS `turnover`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `topmedicinesellerview`
--

DROP TABLE IF EXISTS `topmedicinesellerview`;
/*!50001 DROP VIEW IF EXISTS `topmedicinesellerview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `topmedicinesellerview` AS SELECT 
 1 AS `orderCount`,
 1 AS `medicineFactor`,
 1 AS `totalQuantity`,
 1 AS `turnover`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `ward`
--

DROP TABLE IF EXISTS `ward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ward` (
  `pkWard` smallint NOT NULL AUTO_INCREMENT COMMENT 'An auto increment ward No.',
  `bedQuantity` tinyint DEFAULT NULL COMMENT 'Total number of beds in this ward.',
  `fkRoom` smallint NOT NULL COMMENT 'Room number of the building.',
  PRIMARY KEY (`pkWard`),
  KEY `ward_ibfk_1` (`fkRoom`),
  CONSTRAINT `ward_ibfk_1` FOREIGN KEY (`fkRoom`) REFERENCES `room` (`pkRoom`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'hospital_test'
--

--
-- Dumping routines for database 'hospital_test'
--
/*!50003 DROP FUNCTION IF EXISTS `getAutoIncrement` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getAutoIncrement`(dbname varchar(24), tablename varchar(24)) RETURNS int
    DETERMINISTIC
begin
	return (SELECT `AUTO_INCREMENT`
		FROM  INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = dbname
		AND   TABLE_NAME   = tablename);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getDoctorAppointment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getDoctorAppointment`(in staffId varchar(10), in workDay date)
begin select concat(sf.fname, " ", sf.lname) as doctorName, 
s.fromTime as fromTime, 
s.toTime as toTime, 
a.appointmentTime as appointmentTime,  
concat(p.fname, " ", p.lname) 
as patientName 
from appointment a 
inner join schedule s 
on a.fkSchedule = s.pkSchedule 
inner join doctor d 
on s.fkDoctor = d.pkDoctor 
inner join staff sf 
on d.fkStaff = sf.pkStaff 
inner join patient p 
on a.fkPatient = p.pkPatient 
where s.status = 'a'  and sf.pkStaff = staffId and workDay = date(fromTime); 
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getDoctorPrescription` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getDoctorPrescription`(in staffId varchar(10))
begin
select concat(sf.fname, " ", sf.lname) as doctorName, 
concat(p.fname, " ", p.lname) as patientName,
i.`date` as onDate,
i.memo as memo,
me.medicineName as medicineName,
ps.instruction as doctorInstruction
from inquiry i 
inner join doctor d 
on i.fkDoctor = d.pkDoctor 
inner join staff sf 
on d.fkStaff = sf.pkStaff 
inner join patient p
on i.fkPatient = p.pkPatient
inner join diagnosis di
on di.fkInquiry = i.pkInquiry
inner join prescription ps
on ps.fkDiagnose = di.pkDiagonsis
inner join medicine me
on ps.fkMedicine = me.pkMedicine
where sf.pkStaff = staffId;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPatientPrescription` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPatientPrescription`(in patientId varchar(10))
begin
select concat(sf.fname, " ", sf.lname) as doctorName, 
concat(p.fname, " ", p.lname) as patientName,
i.`date` as onDate,
i.memo as memo,
me.medicineName as medicineName,
ps.instruction as doctorInstruction
from inquiry i 
inner join doctor d 
on i.fkDoctor = d.pkDoctor 
inner join staff sf 
on d.fkStaff = sf.pkStaff 
inner join patient p
on i.fkPatient = p.pkPatient
inner join diagnosis di
on di.fkInquiry = i.pkInquiry
inner join prescription ps
on ps.fkDiagnose = di.pkDiagonsis
inner join medicine me
on ps.fkMedicine = me.pkMedicine
where p.pkPatient = patientId;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getSalaryPaymentDuring` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSalaryPaymentDuring`(in dateFrom date, in dateTo date)
begin
select count(pkStaff) as staffNumber, name, sum(p.salary) as departmentSalaryPayment
from staff s 
inner join department d 
on s.fkDepartment = d.pkDepartment
inner join salary_payment p
on s.pkStaff = p.fkStaff
where p.date < dateTo and p.date > dateFrom
group by s.fkDepartment;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `departmentstaffnumberview`
--

/*!50001 DROP VIEW IF EXISTS `departmentstaffnumberview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `departmentstaffnumberview` AS select count(`s`.`pkStaff`) AS `staffNumber`,`d`.`name` AS `name` from (`staff` `s` left join `department` `d` on((`s`.`fkDepartment` = `d`.`pkDepartment`))) group by `s`.`fkDepartment` order by `staffNumber` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `diseasethatmayleadpatienttobeinhospitalview`
--

/*!50001 DROP VIEW IF EXISTS `diseasethatmayleadpatienttobeinhospitalview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `diseasethatmayleadpatienttobeinhospitalview` AS select concat(`p`.`fname`,' ',`p`.`lname`) AS `patientName`,`i`.`date` AS `inquiryDate`,concat(`s`.`fname`,' ',`s`.`lname`) AS `doctorName`,`des`.`diseaseName` AS `diseaseName` from ((((((`patient` `p` join `inquiry` `i` on((`p`.`pkPatient` = `i`.`fkPatient`))) join `doctor` `d` on((`i`.`fkDoctor` = `d`.`pkDoctor`))) join `staff` `s` on((`d`.`fkStaff` = `s`.`pkStaff`))) join `diagnosis` `di` on((`di`.`fkInquiry` = `i`.`pkInquiry`))) join `hospitalization` `hos` on((`hos`.`fkPatient` = `p`.`pkPatient`))) join `disease` `des` on((`di`.`fkDisease` = `des`.`pkDisease`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `patientwithmedicinepaymentview`
--

/*!50001 DROP VIEW IF EXISTS `patientwithmedicinepaymentview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `patientwithmedicinepaymentview` AS select concat(`p`.`fname`,' ',`p`.`lname`) AS `patientName`,`i`.`date` AS `inquiryDate`,`m`.`medicineName` AS `medicine`,concat(`s`.`fname`,' ',`s`.`lname`) AS `doctorName`,`iv`.`price` AS `medicinePayment` from (((((((`patient` `p` join `inquiry` `i` on((`p`.`pkPatient` = `i`.`fkPatient`))) join `doctor` `d` on((`i`.`fkDoctor` = `d`.`pkDoctor`))) join `staff` `s` on((`d`.`fkStaff` = `s`.`pkStaff`))) join `diagnosis` `di` on((`di`.`fkInquiry` = `i`.`pkInquiry`))) join `prescription` `ps` on((`ps`.`fkDiagnose` = `di`.`pkDiagonsis`))) join `medicine` `m` on((`ps`.`fkMedicine` = `m`.`pkMedicine`))) join `invoice` `iv` on((`ps`.`fkInvoice` = `iv`.`pkInvoice`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `topdevicesellerview`
--

/*!50001 DROP VIEW IF EXISTS `topdevicesellerview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `topdevicesellerview` AS select count(`deo`.`pkOrder`) AS `orderCount`,`p`.`name` AS `producerName`,sum(`deo`.`quantity`) AS `totalQuantity`,(sum((`deo`.`itemPrice` * `deo`.`quantity`)) DIV 1) AS `turnover` from ((`device_order` `deo` join `producer` `p` on((`deo`.`fkProducer` = `p`.`pkProducer`))) join `device` `d` on((`deo`.`fkDevice` = `d`.`pkDevice`))) group by `p`.`name` order by `orderCount` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `topmedicinesellerview`
--

/*!50001 DROP VIEW IF EXISTS `topmedicinesellerview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `topmedicinesellerview` AS select count(`mo`.`pkOrder`) AS `orderCount`,`f`.`name` AS `medicineFactor`,sum(`mo`.`quantity`) AS `totalQuantity`,(sum((`mo`.`itemPrice` * `mo`.`quantity`)) DIV 1) AS `turnover` from ((`medicine_order` `mo` join `medicine` `m` on((`mo`.`fkMedicine` = `m`.`pkMedicine`))) join `factory` `f` on((`f`.`pkFactory` = `mo`.`fkFactory`))) group by `medicineFactor` order by `orderCount` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-09 17:24:51
