create database if not exists seata_order;

use seata_order;

DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) NOT NULL COMMENT '用户id',
  `product_id` varchar(32) NOT NULL COMMENT '产品id',
  `count` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '数量',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '订单状态：0：创建中；1：已完结',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `segment`;
CREATE TABLE `segment` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `VERSION` bigint NOT NULL DEFAULT '0' COMMENT '版本号',
  `business_type` varchar(63) NOT NULL DEFAULT '' COMMENT '业务类型，唯一',
  `max_id` bigint NOT NULL DEFAULT '0' COMMENT '当前最大id',
  `step` int DEFAULT '0' COMMENT '步长',
  `increment` int NOT NULL DEFAULT '1' COMMENT '每次id增量',
  `remainder` int NOT NULL DEFAULT '0' COMMENT '余数',
  `created_at` bigint unsigned NOT NULL COMMENT '创建时间',
  `updated_at` bigint unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_business_type` (`business_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='号段表';

INSERT INTO `segment` VALUES ('1', '1', 'order_business', '1000', '1000', '1', '0', '20220118161721', '20220118161721');

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

