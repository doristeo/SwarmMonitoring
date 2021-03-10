CREATE DATABASE swarms;
USE swarms;
CREATE TABLE `nodes` (
  `timeof` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(60) NOT NULL,
  `peers` int NOT NULL,
  `diskavail` bigint DEFAULT NULL,
  `diskfree` bigint DEFAULT NULL,
  `cheque` int NOT NULL,
  KEY `index1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
