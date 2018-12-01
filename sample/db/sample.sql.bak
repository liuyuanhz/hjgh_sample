DROP DATABASE IF EXISTS `bubble_mc`;
CREATE DATABASE IF NOT EXISTS `bubble_mc` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
use bubble_mc;

--
-- Table structure for table `t_chat_msg`
--

DROP TABLE IF EXISTS `t_chat_msg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_chat_msg` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `guid` bigint(20) NOT NULL,
  `from_user_id` bigint(20) NOT NULL,
  `to_user_id` bigint(20) NOT NULL,
  `corp_id` bigint(20) NOT NULL,
  `session_id` varchar(100) NOT NULL,
  `msg_type` tinyint(4) NOT NULL,
  `content` blob NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_guid` (`guid`),
  KEY `index_corp_session` (`corp_id`,`session_id`),
  KEY `index_corp_from` (`corp_id`,`from_user_id`),
  KEY `index_corp_to` (`corp_id`,`to_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9433 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_group_msg`
--

DROP TABLE IF EXISTS `t_group_msg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_group_msg` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `guid` bigint(20) NOT NULL,
  `uri` bigint(20) NOT NULL,
  `corp_id` bigint(20) NOT NULL,
  `msg_from` varchar(100) NOT NULL COMMENT '群信令，为群uri;群消息,为发送者user_id',
  `content` blob NOT NULL,
  `msg_type` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_guid` (`guid`),
  KEY `index_uri_corp` (`corp_id`,`uri`),
  KEY `index_corp_from` (`corp_id`,`msg_from`)
) ENGINE=InnoDB AUTO_INCREMENT=35014 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_group_user`
--

DROP TABLE IF EXISTS `t_group_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_group_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `corp_id` bigint(20) NOT NULL,
  `uri` bigint(20) NOT NULL,
  `join_guid` bigint(20) NOT NULL,
  `leave_guid` bigint(20) NOT NULL,
  `last_guid` bigint(20) DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_corp_user_uri` (`corp_id`,`user_id`,`uri`),
  KEY `index_corp_uri` (`corp_id`,`uri`)
) ENGINE=InnoDB AUTO_INCREMENT=373330 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_msggw_msg`
--

DROP TABLE IF EXISTS `t_msggw_msg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_msggw_msg` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `guid` bigint(20) NOT NULL,
  `content` blob NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_guid` (`guid`)
) ENGINE=InnoDB AUTO_INCREMENT=18118 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_msggw_user`
--

DROP TABLE IF EXISTS `t_msggw_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_msggw_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `corp_id` bigint(20) NOT NULL,
  `guid` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_corp_user_guid` (`corp_id`,`user_id`,`guid`)
) ENGINE=InnoDB AUTO_INCREMENT=543925 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_user_guid`
--

DROP TABLE IF EXISTS `t_user_guid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user_guid` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `corp_id` bigint(20) NOT NULL,
  `guid` bigint(20) NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_corp_user` (`corp_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=122269 DEFAULT CHARSET=utf8mb4;
