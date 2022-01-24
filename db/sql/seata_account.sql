create database if not exists seata_account;

use seata_account;

DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `user_id` varchar(32) NOT NULL COMMENT '用户id',
  `total` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '总额度',
  `used` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '已用余额',
  `residue` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '剩余可用额度',
  `frozen` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'TCC事务锁定的金额',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `account` VALUES ('29136c94f8d94d24913a021cbd8208d2', 'user001', '5000.00', '0.00', '5000.00', '0.00');

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

