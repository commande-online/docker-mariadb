-- MySQL dump 10.16  Distrib 10.1.13-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: col2-preprod
-- ------------------------------------------------------
-- Server version       10.1.13-MariaDB-1~trusty

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cart_payments`
--

DROP TABLE IF EXISTS `cart_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cart` int(11) NOT NULL,
  `token` varchar(45) DEFAULT NULL,
  `amount` decimal(8,2) NOT NULL,
  `provider_name` varchar(64) NOT NULL,
  `provider_id` varchar(64) DEFAULT NULL,
  `payer_id` varchar(64) DEFAULT NULL,
  `date_transaction` datetime NOT NULL,
  `status` tinyint(4) NOT NULL,
  `provider_refund` varchar(64) DEFAULT NULL,
  `provider_ipn` varchar(64) DEFAULT NULL,
  `provider_processed` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart` (`cart`),
  CONSTRAINT `cart_payments_ibfk_1` FOREIGN KEY (`cart`) REFERENCES `carts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11158 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cart_products`
--

DROP TABLE IF EXISTS `cart_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cart` int(11) NOT NULL,
  `product` varchar(24) NOT NULL DEFAULT '0',
  `quantity` int(11) NOT NULL,
  `amount` decimal(8,3) NOT NULL,
  `ingredients` text,
  PRIMARY KEY (`id`),
  KEY `cart` (`cart`),
  KEY `product` (`product`),
  CONSTRAINT `cart_products_ibfk_3` FOREIGN KEY (`cart`) REFERENCES `carts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74473 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site` int(11) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `billing` int(11) DEFAULT NULL,
  `shipping` int(11) DEFAULT NULL,
  `comment` mediumtext,
  `delivery_partner` varchar(64) DEFAULT NULL,
  `delivery_time` datetime DEFAULT NULL,
  `delivery_url` varchar(64) DEFAULT NULL,
  `delivery_id` varchar(64) DEFAULT NULL,
  `delivery_cost` decimal(8,3) DEFAULT NULL,
  `amount` decimal(8,3) NOT NULL,
  `vat` decimal(8,3) NOT NULL,
  `discount` decimal(8,3) NOT NULL DEFAULT '0.000',
  `created_by` int(11) NOT NULL,
  `created_from` varchar(3) DEFAULT NULL,
  `table_number` varchar(3) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `last_update_at` datetime DEFAULT NULL,
  `last_update_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `site` (`site`,`owner`,`billing`,`shipping`),
  KEY `owner` (`owner`),
  KEY `billing` (`billing`),
  KEY `shipping` (`shipping`),
  CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`site`) REFERENCES `sites` (`id`),
  CONSTRAINT `carts_ibfk_2` FOREIGN KEY (`owner`) REFERENCES `users` (`id`),
  CONSTRAINT `carts_ibfk_3` FOREIGN KEY (`billing`) REFERENCES `user_addresses` (`id`),
  CONSTRAINT `carts_ibfk_4` FOREIGN KEY (`shipping`) REFERENCES `user_addresses` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12431 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fb_comments`
--

DROP TABLE IF EXISTS `fb_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fb_comments` (
  `id` varchar(64) NOT NULL,
  `site` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `authorId` bigint(20) unsigned NOT NULL,
  `authorName` varchar(64) NOT NULL,
  `message` text NOT NULL,
  `numLikes` smallint(5) unsigned NOT NULL,
  `numComments` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site` (`site`),
  CONSTRAINT `fb_comments_ibfk_1` FOREIGN KEY (`site`) REFERENCES `sites` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fidelity_configs`
--

DROP TABLE IF EXISTS `fidelity_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fidelity_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `zone` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `site` int(11) DEFAULT NULL,
  `name` varchar(80) NOT NULL,
  `value` varchar(100) NOT NULL,
  `label` varchar(150) NOT NULL,
  `dateCreation` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` int(11) NOT NULL,
  `version` mediumint(9) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `zone` (`zone`),
  KEY `site` (`site`),
  KEY `fidelity_configs_ibfk_1` (`createdBy`),
  KEY `name_version` (`name`,`version`),
  CONSTRAINT `fidelity_configs_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fidelity_ledger`
--

DROP TABLE IF EXISTS `fidelity_ledger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fidelity_ledger` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site` int(11) NOT NULL,
  `zone` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines the geo zone where the points are valid',
  `user` int(11) NOT NULL,
  `accounting` int(11) NOT NULL,
  `validUntil` date NOT NULL,
  `amountDebited` mediumint(9) unsigned DEFAULT NULL,
  `amountCredited` mediumint(9) unsigned NOT NULL,
  `remainingCredit` mediumint(9) unsigned NOT NULL,
  `valid` tinyint(1) NOT NULL DEFAULT '1',
  `suspicious` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user` (`user`),
  KEY `accounting` (`accounting`),
  KEY `userZone` (`user`,`zone`),
  KEY `remainingCredit` (`remainingCredit`),
  KEY `fidelity_ledger_ibfk_1` (`site`),
  CONSTRAINT `fidelity_ledger_ibfk_1` FOREIGN KEY (`site`) REFERENCES `sites` (`id`),
  CONSTRAINT `fidelity_ledger_ibfk_2` FOREIGN KEY (`user`) REFERENCES `users` (`id`),
  CONSTRAINT `fidelity_ledger_ibfk_3` FOREIGN KEY (`accounting`) REFERENCES `site_accounting` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8386 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fidelity_suspicious_transaction_details`
--

DROP TABLE IF EXISTS `fidelity_suspicious_transaction_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fidelity_suspicious_transaction_details` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ledger` int(10) unsigned NOT NULL,
  `reason` tinyint(3) unsigned DEFAULT NULL,
  `reviewed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `reviewDate` datetime DEFAULT NULL,
  `reviewedByUser` int(11) DEFAULT NULL,
  `reviewComment` text,
  PRIMARY KEY (`id`),
  KEY `ledger` (`ledger`),
  KEY `fidelity_suspicious_transaction_details_ibfk_2` (`reviewedByUser`),
  CONSTRAINT `fidelity_suspicious_transaction_details_ibfk_1` FOREIGN KEY (`ledger`) REFERENCES `fidelity_ledger` (`id`),
  CONSTRAINT `fidelity_suspicious_transaction_details_ibfk_2` FOREIGN KEY (`reviewedByUser`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1015 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media_links`
--

DROP TABLE IF EXISTS `media_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_links` (
  `idMedia` int(11) NOT NULL,
  `site` int(11) NOT NULL,
  `type` varchar(127) NOT NULL,
  `idOther` varchar(24) NOT NULL,
  `lang` varchar(2) NOT NULL,
  `position` int(11) NOT NULL,
  PRIMARY KEY (`idMedia`,`type`,`idOther`,`lang`),
  KEY `site` (`site`),
  CONSTRAINT `media_links_ibfk_1` FOREIGN KEY (`site`) REFERENCES `sites` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medias`
--

DROP TABLE IF EXISTS `medias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site` int(11) NOT NULL,
  `type` varchar(63) NOT NULL,
  `user` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  `fileName` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `fileSize` int(10) unsigned NOT NULL,
  `filePath` varchar(255) NOT NULL,
  `public` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `widthHeightRatio` decimal(10,5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`user`),
  KEY `site` (`site`),
  CONSTRAINT `medias_ibfk_1` FOREIGN KEY (`user`) REFERENCES `users` (`id`),
  CONSTRAINT `medias_ibfk_2` FOREIGN KEY (`site`) REFERENCES `sites` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=305 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_comments`
--

DROP TABLE IF EXISTS `product_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product` int(11) DEFAULT NULL,
  `site` int(11) DEFAULT NULL,
  `user` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `comment` mediumtext,
  `status` tinyint(4) DEFAULT NULL,
  `score` int(2) DEFAULT NULL,
  `reply` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product` (`product`,`site`,`user`),
  KEY `site` (`site`),
  KEY `user` (`user`),
  KEY `reply` (`reply`),
  CONSTRAINT `product_comments_ibfk_1` FOREIGN KEY (`product`) REFERENCES `products` (`id`),
  CONSTRAINT `product_comments_ibfk_2` FOREIGN KEY (`site`) REFERENCES `sites` (`id`),
  CONSTRAINT `product_comments_ibfk_3` FOREIGN KEY (`user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_fields`
--

DROP TABLE IF EXISTS `product_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site` int(11) DEFAULT NULL,
  `product` int(11) DEFAULT NULL,
  `field` varchar(24) DEFAULT NULL,
  `value` text,
  `type` tinyint(4) DEFAULT NULL,
  `lang` varchar(2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site` (`site`,`product`),
  KEY `product` (`product`),
  CONSTRAINT `product_fields_ibfk_1` FOREIGN KEY (`site`) REFERENCES `sites` (`id`),
  CONSTRAINT `product_fields_ibfk_2` FOREIGN KEY (`product`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=580 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_prices`
--

DROP TABLE IF EXISTS `product_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_prices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product` int(11) NOT NULL,
  `field` varchar(24) DEFAULT NULL,
  `value` decimal(10,3) NOT NULL,
  `vat` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT '0',
  `value_onsite` decimal(10,3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product` (`product`),
  CONSTRAINT `product_prices_ibfk_1` FOREIGN KEY (`product`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=886 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_tags`
--

DROP TABLE IF EXISTS `product_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product` int(11) NOT NULL,
  `tag` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product` (`product`),
  CONSTRAINT `product_tags_ibfk_1` FOREIGN KEY (`product`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2187 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site` int(11) DEFAULT NULL,
  `template` varchar(24) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `website` tinyint(1) NOT NULL DEFAULT '1',
  `barcode` varchar(255) DEFAULT NULL,
  `order_button_color` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `site` (`site`,`template`,`owner`),
  KEY `template` (`template`),
  KEY `owner` (`owner`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`site`) REFERENCES `sites` (`id`),
  CONSTRAINT `products_ibfk_3` FOREIGN KEY (`owner`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=584 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `session_data`
--

DROP TABLE IF EXISTS `session_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session_data` (
  `session_id` varchar(35) NOT NULL,
  `data` text NOT NULL,
  `created_at` int(15) unsigned NOT NULL,
  `modified_at` int(15) unsigned DEFAULT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `site_accounting`
--

DROP TABLE IF EXISTS `site_accounting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_accounting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `flow` tinyint(1) NOT NULL,
  `account` tinyint(1) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `cart` int(11) DEFAULT NULL,
  `comment` text,
  `payment` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `site` (`site`),
  KEY `user` (`user`),
  KEY `cart` (`cart`),
  KEY `payment` (`payment`),
  CONSTRAINT `site_accounting_ibfk_1` FOREIGN KEY (`site`) REFERENCES `sites` (`id`),
  CONSTRAINT `site_accounting_ibfk_2` FOREIGN KEY (`user`) REFERENCES `users` (`id`),
  CONSTRAINT `site_accounting_ibfk_3` FOREIGN KEY (`cart`) REFERENCES `carts` (`id`),
  CONSTRAINT `site_accounting_ibfk_4` FOREIGN KEY (`payment`) REFERENCES `cart_payments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11139 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `site_comments`
--

DROP TABLE IF EXISTS `site_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `text` text NOT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`user`),
  KEY `site` (`site`),
  CONSTRAINT `site_comments_ibfk_1` FOREIGN KEY (`site`) REFERENCES `sites` (`id`),
  CONSTRAINT `site_comments_ibfk_2` FOREIGN KEY (`user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `site_configs`
--

DROP TABLE IF EXISTS `site_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_configs` (
  `name` varchar(80) NOT NULL,
  `value` varchar(500) NOT NULL,
  `label` varchar(150) NOT NULL,
  `category` varchar(40) NOT NULL,
  `site` int(11) NOT NULL,
  PRIMARY KEY (`name`,`site`),
  KEY `site` (`site`),
  CONSTRAINT `site_configs_ibfk_1` FOREIGN KEY (`site`) REFERENCES `sites` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `site_invoices`
--

DROP TABLE IF EXISTS `site_invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_invoices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `amount` decimal(8,2) NOT NULL,
  `cart` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `site` (`site`,`cart`),
  KEY `cart` (`cart`),
  CONSTRAINT `site_invoices_ibfk_1` FOREIGN KEY (`site`) REFERENCES `sites` (`id`),
  CONSTRAINT `site_invoices_ibfk_2` FOREIGN KEY (`cart`) REFERENCES `carts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `site_options`
--

DROP TABLE IF EXISTS `site_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_options` (
  `site` int(11) NOT NULL DEFAULT '0',
  `name` varchar(30) NOT NULL DEFAULT '',
  `value` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`site`,`name`),
  CONSTRAINT `site_options_ibfk_1` FOREIGN KEY (`site`) REFERENCES `sites` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `site_pages`
--

DROP TABLE IF EXISTS `site_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(120) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `limited` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `site` int(11) NOT NULL,
  `main_menu` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site` (`site`),
  CONSTRAINT `site_pages_ibfk_1` FOREIGN KEY (`site`) REFERENCES `sites` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `site_urls`
--

DROP TABLE IF EXISTS `site_urls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_urls` (
  `site` int(11) NOT NULL,
  `url` varchar(64) NOT NULL,
  `default_lang` varchar(5) NOT NULL,
  `debug` tinyint(4) NOT NULL,
  PRIMARY KEY (`site`,`url`),
  CONSTRAINT `site_urls_ibfk_1` FOREIGN KEY (`site`) REFERENCES `sites` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `zip_code` varchar(10) DEFAULT NULL,
  `city` varchar(64) DEFAULT NULL,
  `country` varchar(32) DEFAULT NULL,
  `registration_number` varchar(32) DEFAULT NULL,
  `VAT_number` varchar(32) DEFAULT NULL,
  `telephone` varchar(22) DEFAULT NULL,
  `email` varchar(32) DEFAULT NULL,
  `registration_date` date DEFAULT NULL,
  `paid_until_date` date NOT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `type` tinyint(4) NOT NULL,
  `fidelity_zone` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `latitude` decimal(9,6) DEFAULT NULL,
  `longitude` decimal(9,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`),
  CONSTRAINT `sites_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stats_processed`
--

DROP TABLE IF EXISTS `stats_processed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stats_processed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `period` varchar(5) NOT NULL,
  `uri` int(11) NOT NULL,
  `num` int(11) NOT NULL,
  `site` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site` (`site`),
  CONSTRAINT `stats_processed_ibfk_1` FOREIGN KEY (`site`) REFERENCES `sites` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stats_raw`
--

DROP TABLE IF EXISTS `stats_raw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stats_raw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user` int(11) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `uri` varchar(100) NOT NULL,
  `cart` int(11) NOT NULL,
  `site` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site` (`site`),
  CONSTRAINT `stats_raw_ibfk_1` FOREIGN KEY (`site`) REFERENCES `sites` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transaction_tokens`
--

DROP TABLE IF EXISTS `transaction_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `zone` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `site` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `token` varchar(200) NOT NULL,
  `dateCreation` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateExpiration` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_addresses`
--

DROP TABLE IF EXISTS `user_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(11) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `fullname` varchar(64) NOT NULL,
  `address` varchar(64) DEFAULT NULL,
  `zipcode` varchar(10) DEFAULT NULL,
  `city` varchar(64) DEFAULT NULL,
  `country` varchar(64) DEFAULT NULL,
  `comment` mediumtext,
  `status` tinyint(4) DEFAULT NULL,
  `last_update` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user` (`user`),
  CONSTRAINT `user_addresses_ibfk_1` FOREIGN KEY (`user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2005 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_devices`
--

DROP TABLE IF EXISTS `user_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_devices` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user` int(11) NOT NULL,
  `deviceType` varchar(16) DEFAULT NULL,
  `appName` varchar(32) DEFAULT NULL,
  `deviceToken` varchar(255) DEFAULT NULL,
  `deviceId` varchar(64) DEFAULT NULL,
  `dateCreation` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`user`),
  CONSTRAINT `user_devices_ibfk_1` FOREIGN KEY (`user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_fields`
--

DROP TABLE IF EXISTS `user_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL,
  `site` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`user`),
  KEY `type` (`type`),
  KEY `site` (`site`),
  CONSTRAINT `user_fields_ibfk_1` FOREIGN KEY (`user`) REFERENCES `users` (`id`),
  CONSTRAINT `user_fields_ibfk_2` FOREIGN KEY (`site`) REFERENCES `sites` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_friends`
--

DROP TABLE IF EXISTS `user_friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_friends` (
  `user` int(11) NOT NULL,
  `facebookId` int(11) NOT NULL,
  `friendsId` int(11) DEFAULT NULL,
  `name` varchar(250) NOT NULL,
  `birthday` date NOT NULL,
  `status` tinyint(2) NOT NULL,
  PRIMARY KEY (`user`,`facebookId`),
  KEY `birthday` (`birthday`),
  KEY `friendsId` (`friendsId`),
  CONSTRAINT `user_friends_ibfk_1` FOREIGN KEY (`user`) REFERENCES `users` (`id`),
  CONSTRAINT `user_friends_ibfk_2` FOREIGN KEY (`friendsId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_messages`
--

DROP TABLE IF EXISTS `user_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user` int(11) NOT NULL,
  `site` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL,
  `date` datetime NOT NULL,
  `status` tinyint(4) NOT NULL,
  `render` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`user`),
  KEY `site` (`site`),
  CONSTRAINT `user_messages_ibfk_1` FOREIGN KEY (`user`) REFERENCES `users` (`id`),
  CONSTRAINT `user_messages_ibfk_2` FOREIGN KEY (`site`) REFERENCES `sites` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23380 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_privileges`
--

DROP TABLE IF EXISTS `user_privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_privileges` (
  `user` int(11) NOT NULL DEFAULT '0',
  `site` int(11) NOT NULL DEFAULT '0',
  `name` varchar(32) DEFAULT NULL,
  `fb_token` varchar(255) DEFAULT NULL,
  `last_update` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user`,`site`),
  KEY `site` (`site`),
  CONSTRAINT `user_privileges_ibfk_1` FOREIGN KEY (`user`) REFERENCES `users` (`id`),
  CONSTRAINT `user_privileges_ibfk_2` FOREIGN KEY (`site`) REFERENCES `sites` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_promotions`
--

DROP TABLE IF EXISTS `user_promotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_promotions` (
  `user` int(11) NOT NULL,
  `promotion` varchar(25) NOT NULL,
  `site` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`user`,`promotion`),
  KEY `promotion` (`promotion`),
  KEY `site` (`site`),
  KEY `status` (`status`),
  CONSTRAINT `user_promotions_ibfk_1` FOREIGN KEY (`user`) REFERENCES `users` (`id`),
  CONSTRAINT `user_promotions_ibfk_3` FOREIGN KEY (`site`) REFERENCES `sites` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(64) DEFAULT NULL,
  `lastname` varchar(64) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL COMMENT 'md5',
  `hash` varchar(4) DEFAULT NULL,
  `facebook_id` varchar(64) DEFAULT NULL,
  `telephone` varchar(22) DEFAULT NULL,
  `optin_site` tinyint(4) DEFAULT NULL,
  `optin_affiliate` tinyint(4) DEFAULT NULL,
  `comment` mediumtext,
  `registration_date` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `last_connection` datetime NOT NULL,
  `birthdate` date DEFAULT NULL,
  `gender` tinyint(3) unsigned DEFAULT NULL,
  `notificationFrequency` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ios_token` char(35) DEFAULT NULL,
  `android_token` varchar(255) DEFAULT NULL,
  `last_update` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2123 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-12 21:56:27
