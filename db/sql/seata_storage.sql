create database if not exists seata_storage;

use seata_storage;

DROP TABLE IF EXISTS `storage`;
CREATE TABLE `storage` (
  `id` varchar(32) NOT NULL,
  `product_id` varchar(32) NOT NULL COMMENT '产品id',
  `total` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '总库存',
  `used` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '已用库存',
  `residue` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '剩余库存',
  `frozen` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'TCC事务锁定的库存',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `storage` VALUES ('5f35ce5d6b7741e5879c62a3fd47ee09', 'pd001', '100.00', '0.00', '100.00', '0.00');

DROP TABLE IF EXISTS `undo_log`;
CREATE TABLE `undo_log` (
  `branch_id` bigint NOT NULL COMMENT 'branch transaction id',
  `xid` varchar(100) NOT NULL COMMENT 'global transaction id',
  `context` varchar(128) NOT NULL COMMENT 'undo_log context,such as serialization',
  `rollback_info` longblob NOT NULL COMMENT 'rollback info',
  `log_status` int NOT NULL COMMENT '0:normal status,1:defense status',
  `log_created` datetime(6) NOT NULL COMMENT 'create datetime',
  `log_modified` datetime(6) NOT NULL COMMENT 'modify datetime',
  UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='AT transaction mode undo table';
