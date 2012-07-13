CREATE DATABASE `welcu` /*!40100 DEFAULT CHARACTER SET utf8 */$$

delimiter $$

CREATE TABLE `queries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_id` varchar(255) DEFAULT NULL,
  `query` text,
  `getted` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8$$
delimiter $$

CREATE TABLE `tweets` (
  `id` varchar(255) NOT NULL,
  `tweet` text,
  `user` varchar(45) DEFAULT NULL,
  `query_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `query` (`query_id`),
  KEY `query_id` (`query_id`),
  CONSTRAINT `query_id` FOREIGN KEY (`query_id`) REFERENCES `queries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8$$


