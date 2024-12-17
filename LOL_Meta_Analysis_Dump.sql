CREATE DATABASE  IF NOT EXISTS `bax421_project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bax421_project`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: bax421_project
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `champion`
--

DROP TABLE IF EXISTS `champion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `champion` (
  `key` int NOT NULL COMMENT 'Champion ID',
  `id` varchar(45) NOT NULL COMMENT 'Champion letter ID',
  `name` varchar(45) NOT NULL COMMENT 'Champion name',
  `title` varchar(45) NOT NULL COMMENT 'Champion title in game',
  `tags` varchar(45) NOT NULL COMMENT 'Champion role in game',
  `partype` varchar(45) NOT NULL COMMENT 'Champion resource type: can be either mana, energy, none, or misc. ',
  `hp` decimal(10,0) NOT NULL COMMENT 'Champion health at level 1',
  `hpperlevel` decimal(10,0) NOT NULL COMMENT 'Health gained per level up',
  `mp` decimal(10,0) NOT NULL COMMENT 'Champion mana at level 1',
  `mpperlevel` decimal(10,0) NOT NULL COMMENT 'Mana gained per level up',
  `movespeed` decimal(10,0) NOT NULL COMMENT 'Champion movement speed',
  `armor` decimal(10,0) NOT NULL COMMENT 'Champion armor, which is used to calculate physical damage mitigation',
  `armorperlevel` decimal(10,0) NOT NULL COMMENT 'Armor gained per level up',
  `spellblock` decimal(10,0) NOT NULL COMMENT 'Champion magic resist, which is used to calculate magic damage mitigation',
  `spellblockperlevel` decimal(10,0) NOT NULL COMMENT 'Magic resist gained per level up',
  `attackrange` decimal(10,0) NOT NULL COMMENT 'Champion normal attack range',
  `hpregen` decimal(10,0) NOT NULL COMMENT 'Champion''s rate of HP regeneration',
  `hpregenperlevel` decimal(10,0) NOT NULL COMMENT 'HP regen gained per level up',
  `mpregen` decimal(10,0) NOT NULL COMMENT 'Champion''s mana regeneration at level 1',
  `mpregenperlevel` decimal(10,0) NOT NULL COMMENT 'MP regen per level up',
  `crit` decimal(10,0) NOT NULL COMMENT 'Champion''s chance to score a critical attack at level 1',
  `critperlevel` decimal(10,0) NOT NULL COMMENT 'Critical attack chance gained per level up',
  `attackdamage` decimal(10,0) NOT NULL COMMENT 'Champion''s attack damage at level one, which affects normla attack damage and damage from spells with attack damage scaling',
  `attackdamageperlevel` decimal(10,0) NOT NULL COMMENT 'Attack damage gained per level up',
  `attackspeedperlevel` decimal(10,0) NOT NULL COMMENT 'Attack speed gained per level up',
  `attackspeed` decimal(10,0) NOT NULL COMMENT 'The rate by which a champion can cast normal attack consecutively',
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `itemId` int NOT NULL COMMENT 'Item ID',
  `name` varchar(45) NOT NULL COMMENT 'Name of the item',
  `upperItem` varchar(45) DEFAULT NULL COMMENT 'Items from which this item acts as a component',
  `buyPrice` int NOT NULL COMMENT 'Gold amount needed to purchase the item',
  `sellPrice` int NOT NULL COMMENT 'Gold gained when selling the item',
  `tag` varchar(45) DEFAULT NULL COMMENT 'Usages of the item',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loserdata`
--

DROP TABLE IF EXISTS `loserdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loserdata` (
  `gameId_loser` varchar(45) NOT NULL COMMENT 'ID of a game',
  `teamId` int NOT NULL COMMENT 'ID of the team that lost the game',
  `win` varchar(45) NOT NULL COMMENT 'Victory condition',
  `firstBlood` varchar(45) NOT NULL COMMENT 'If the team scored the first champion takedown of the game. First blood rewards extra gold to the player that scored the takedown',
  `firstTower` varchar(45) NOT NULL COMMENT 'If the team scored the first tower takedown of the game. First tower rewards extra gold to the team that scored the takedown',
  `firstInhibitor` varchar(45) NOT NULL COMMENT 'If the team scored the first inhibitor takedown of the game. No bonus for taking down the first inhibitor, but taking down an inhibitor usually means a team is amassing a considerable lead in the game',
  `firstBaron` varchar(45) NOT NULL COMMENT 'If the team scored the first Baron takedown of the game. The Baron is a neutral monster that is very difficult to takedown but reward the team with a handsome team-wide power-up for a limited periold of time',
  `firstDragon` varchar(45) NOT NULL COMMENT 'If the team scored the first dragon takedown of the game. Taking down dragons provide the team with minor permanent power-ups. ',
  `firstRiftHerald` varchar(45) NOT NULL COMMENT 'If the team scored the first Rift Herald of the game. Taking down the rift herald provides the team with an consumable item that can greatly assist tower takedowns. ',
  `towerKills` int NOT NULL COMMENT 'Total number of tower takedowns in a game for a team. Max number is 8',
  `inhibitorKills` int NOT NULL COMMENT 'Total inhibitor takedowns in a game for a team. Max number is not limited because inhibitors can regenerate. ',
  `baronKills` int NOT NULL COMMENT 'Total number of Baron takedowns in a game for a team. ',
  `dragonKills` int NOT NULL COMMENT 'Total number of dragon takedowns in a game for a team. ',
  `riftHeraldKills` int NOT NULL COMMENT 'Total number of dragon takedowns in a game for a team. ',
  `firstBan_loser` int DEFAULT NULL COMMENT 'ID of the first champion the team banned. Banned champion cannot be selected by any player in a game. ',
  `secondBan_loser` int DEFAULT NULL COMMENT 'ID of the second champion the team banned. Banned champion cannot be selected by any player in a game. ',
  `thirdBan_loser` int DEFAULT NULL COMMENT 'ID of the third champion the team banned. Banned champion cannot be selected by any player in a game. ',
  `forthBan_loser` int DEFAULT NULL COMMENT 'ID of the forth champion the team banned. Banned champion cannot be selected by any player in a game. ',
  `fifthBan_loser` int DEFAULT NULL COMMENT 'ID of the fifth champion the team banned. Banned champion cannot be selected by any player in a game. ',
  PRIMARY KEY (`gameId_loser`,`teamId`),
  KEY `firstBan_idx` (`firstBan_loser`),
  KEY `secondBan_loser_idx` (`secondBan_loser`),
  KEY `thirdBan_loser_idx` (`thirdBan_loser`),
  KEY `forthBan_loser_idx` (`forthBan_loser`),
  KEY `fifthBan_idx` (`fifthBan_loser`),
  CONSTRAINT `gameId_loser` FOREIGN KEY (`gameId_loser`) REFERENCES `matches` (`gameId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matches`
--

DROP TABLE IF EXISTS `matches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matches` (
  `gameId` varchar(45) NOT NULL COMMENT 'ID of a game',
  `gameDuration` int NOT NULL COMMENT 'The ducation of a game in seconds. ',
  `gameMode` varchar(45) NOT NULL COMMENT 'The mode of the game. ',
  `gameVersion` varchar(45) NOT NULL COMMENT 'The patch version when the game took place.',
  PRIMARY KEY (`gameId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matchparticipants`
--

DROP TABLE IF EXISTS `matchparticipants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matchparticipants` (
  `gameId` varchar(45) NOT NULL COMMENT 'ID of the game',
  `accountId` varchar(150) NOT NULL COMMENT 'ID of a player''s account ',
  `participantId` varchar(45) NOT NULL COMMENT 'ID of a player in a specific game',
  `teamId` varchar(45) NOT NULL COMMENT 'The team that the player plays in in a game. ',
  `championId` int NOT NULL COMMENT 'The ID of a champion that a player plays in a game. ',
  `role` varchar(45) DEFAULT NULL COMMENT 'The role a player queued up for. ',
  `lane` varchar(45) DEFAULT NULL COMMENT 'The lane a player is assgined to.',
  `spell1Id` varchar(45) NOT NULL COMMENT 'The ID of the first summor''s spell. ',
  `spell2Id` varchar(45) NOT NULL COMMENT 'The ID of the second summoner''s spell. ',
  `item0` int DEFAULT NULL COMMENT 'The ID of the item in the first item slot. ',
  `item1` int DEFAULT NULL COMMENT 'The ID of the item in the second item slot. ',
  `item2` int DEFAULT NULL COMMENT 'The ID of the item in the third item slot. ',
  `item3` int DEFAULT NULL COMMENT 'The ID of the item in the forth item slot. ',
  `item4` int DEFAULT NULL COMMENT 'The ID of the item in the fifth item slot. ',
  `item5` int DEFAULT NULL COMMENT 'The ID of the item in the sixth item slot. ',
  `item6` int DEFAULT NULL COMMENT 'The ID of the item in the seventh item slot. ',
  `kills` int DEFAULT NULL COMMENT 'Number of takedowns a player scored in a game. ',
  `deaths` int DEFAULT NULL COMMENT 'Number of death of a player in a game. ',
  `assists` int DEFAULT NULL COMMENT 'Number of times when a player assisting their teammate to score a takedown. ',
  `largestKillingSpree` int DEFAULT NULL COMMENT 'A player''s max number of consecutive takedowns before being takedown in a game. ',
  `largestMultiKill` int DEFAULT NULL COMMENT 'A player''s max number of consecutive takedowns in a quick succession. ',
  `killingSprees` int DEFAULT NULL COMMENT 'A player''s total number of consecutive takedowns in a game.',
  `longestTimeSpentLiving` int DEFAULT NULL COMMENT 'A player''s longest consecutive time alive. ',
  `doubleKills` int DEFAULT NULL COMMENT 'The total number of times when a player scored two takedowns in quick succession. ',
  `tripleKills` int DEFAULT NULL COMMENT 'The total number of times when a player scored three takedowns in quick succession. ',
  `quadraKills` int DEFAULT NULL COMMENT 'The total number of times when a player scored four takedowns in quick succession. ',
  `pentaKills` int DEFAULT NULL COMMENT 'The total number of times when a player scored five takedowns in quick succession. ',
  PRIMARY KEY (`gameId`,`accountId`),
  KEY `accountId_idx` (`accountId`),
  KEY `championId_idx` (`championId`),
  KEY `item0_idx` (`item0`),
  KEY `item1_idx` (`item1`),
  KEY `item2_idx` (`item2`),
  KEY `item3_idx` (`item3`),
  KEY `item4_idx` (`item4`),
  KEY `item5_idx` (`item5`),
  KEY `item6_idx` (`item6`),
  CONSTRAINT `accountId` FOREIGN KEY (`accountId`) REFERENCES `playeraccounts` (`accountId`),
  CONSTRAINT `championId` FOREIGN KEY (`championId`) REFERENCES `champion` (`key`),
  CONSTRAINT `gameId` FOREIGN KEY (`gameId`) REFERENCES `matches` (`gameId`),
  CONSTRAINT `irem3` FOREIGN KEY (`item3`) REFERENCES `item` (`itemId`),
  CONSTRAINT `item0` FOREIGN KEY (`item0`) REFERENCES `item` (`itemId`),
  CONSTRAINT `item1` FOREIGN KEY (`item1`) REFERENCES `item` (`itemId`),
  CONSTRAINT `item2` FOREIGN KEY (`item2`) REFERENCES `item` (`itemId`),
  CONSTRAINT `item4` FOREIGN KEY (`item4`) REFERENCES `item` (`itemId`),
  CONSTRAINT `item5` FOREIGN KEY (`item5`) REFERENCES `item` (`itemId`),
  CONSTRAINT `item6` FOREIGN KEY (`item6`) REFERENCES `item` (`itemId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `playeraccounts`
--

DROP TABLE IF EXISTS `playeraccounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playeraccounts` (
  `accountId` varchar(150) NOT NULL COMMENT 'ID of a player''s account. ',
  `summonerName` varchar(45) NOT NULL COMMENT 'The user-generated name of a player''s account. ',
  `platformId` varchar(45) NOT NULL COMMENT 'The ID of the server where the player''s account resides. ',
  PRIMARY KEY (`accountId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `winnerdata`
--

DROP TABLE IF EXISTS `winnerdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `winnerdata` (
  `gameId_winner` varchar(45) NOT NULL COMMENT 'ID of a game',
  `teamId` int NOT NULL COMMENT 'ID of the team that lost the game',
  `win` varchar(45) NOT NULL COMMENT 'Victory condition',
  `firstBlood` varchar(45) NOT NULL COMMENT 'If the team scored the first champion takedown of the game. First blood rewards extra gold to the player that scored the takedown',
  `firstTower` varchar(45) NOT NULL COMMENT 'If the team scored the first tower takedown of the game. First tower rewards extra gold to the team that scored the takedown',
  `firstInhibitor` varchar(45) NOT NULL COMMENT 'If the team scored the first inhibitor takedown of the game. No bonus for taking down the first inhibitor, but taking down an inhibitor usually means a team is amassing a considerable lead in the game',
  `firstBaron` varchar(45) NOT NULL COMMENT 'If the team scored the first Baron takedown of the game. The Baron is a neutral monster that is very difficult to takedown but reward the team with a handsome team-wide power-up for a limited periold of time',
  `firstDragon` varchar(45) NOT NULL COMMENT 'If the team scored the first dragon takedown of the game. Taking down dragons provide the team with minor permanent power-ups. ',
  `firstRiftHerald` varchar(45) NOT NULL COMMENT 'If the team scored the first Rift Herald of the game. Taking down the rift herald provides the team with an consumable item that can greatly assist tower takedowns. ',
  `towerKills` int NOT NULL COMMENT 'Total number of tower takedowns in a game for a team. Max number is 8',
  `inhibitorKills` int NOT NULL COMMENT 'Total inhibitor takedowns in a game for a team. Max number is not limited because inhibitors can regenerate. ',
  `baronKills` int NOT NULL COMMENT 'Total number of Baron takedowns in a game for a team. ',
  `dragonKills` int NOT NULL COMMENT 'Total number of dragon takedowns in a game for a team. ',
  `riftHeraldKills` int NOT NULL COMMENT 'Total number of dragon takedowns in a game for a team. ',
  `firstBan_winner` int DEFAULT NULL COMMENT 'ID of the first champion the team banned. Banned champion cannot be selected by any player in a game. ',
  `secondBan_winner` int DEFAULT NULL COMMENT 'ID of the second champion the team banned. Banned champion cannot be selected by any player in a game. ',
  `thirdBan_winner` int DEFAULT NULL COMMENT 'ID of the third champion the team banned. Banned champion cannot be selected by any player in a game. ',
  `forthBan_winner` int DEFAULT NULL COMMENT 'ID of the forth champion the team banned. Banned champion cannot be selected by any player in a game. ',
  `fifthBan_winner` int DEFAULT NULL COMMENT 'ID of the fifth champion the team banned. Banned champion cannot be selected by any player in a game. ',
  PRIMARY KEY (`teamId`,`gameId_winner`),
  KEY `gameId_winner_idx` (`gameId_winner`),
  CONSTRAINT `gameId_winner` FOREIGN KEY (`gameId_winner`) REFERENCES `matches` (`gameId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-16 22:31:37
