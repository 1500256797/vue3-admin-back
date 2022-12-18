
drop database if exists member_db;

create database member_db;

use member_db;

CREATE TABLE `user_score` (
  `user_uuid` char(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户id',
  `level` tinyint(3) NOT NULL DEFAULT '1' COMMENT '等级',
  `total_score` int(11) NOT NULL DEFAULT '0' COMMENT '总积分',
  `usable_score` int(11) NOT NULL DEFAULT '0' COMMENT '可用积分',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`user_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户积分账户表';


CREATE TABLE `score_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'auto id',
  `user_uuid` char(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户id',
  `source_id` int(11) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '-1' COMMENT '来源id',
  `source_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 任务 2 系统赠送 3 取消订单 4 签到 5 兑换奖品 6过期',
   `exprie_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否过期0 没过期 1 过期',
  `remark` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `symbol` varchar(3) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'in 收入 out 支出',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '分值',
   `expire_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `UCID` (`user_uuid`,`create_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='积分记录表';


CREATE TABLE `user_sign_in` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'auto id',
  `user_uuid` char(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户id',
  `continue_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '持续签到天数',
  `period_day` tinyint(3) NOT NULL DEFAULT '0' COMMENT '周期内签到天数',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `UCID` (`user_uuid`,`create_at`),
  KEY `create_at` (`create_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户签到表';

 CREATE TABLE `prize` (
 `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'auto id',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '所需积分',
  `stock` int(11) NOT NULL DEFAULT '0' COMMENT '库存',
  `name` char(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '名称',
  `img_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '图片url',
  `introduction` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '简介',
  `content` text COLLATE utf8mb4_general_ci NOT NULL COMMENT '内容',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 0 草稿 1 发布 2  停用',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `action_user` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作人',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='奖品表';

 CREATE TABLE `prize_order` (
 `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'auto id',
  `user_uuid` char(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户id',
   `prize_id` int(11) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '奖品id',
  `deduct_score` int(11) NOT NULL DEFAULT '0' COMMENT '扣除积分',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 待审核 1 经审核 2 不通过，3取消',
  `audit_at` datetime DEFAULT NULL COMMENT '审核时间',
  `remark` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `action_user` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作人',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `user_uuid` (`user_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='奖品兑换订单表';



CREATE TABLE `task` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'auto id',
  `name` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '简体名称',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '分值',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 0 草稿 1 发布 2 停用',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `is_pro` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 pro专属',
  `is_once` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 一次性任务',
  `link_params` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务链接参数',
  `page_url` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '页面',
  `thumb_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '图标',
  `identify` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标识符',
  `remark` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `action_user` varchar(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作人',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `identify` (`identify`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='任务表';


CREATE TABLE `task_finish` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'auto id',
  `user_uuid` char(32) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户id',
  `task_id` int(11) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '任务Id',
  `score_uuid` int(11) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '积分记录id',
  `finish_score` int(11) NOT NULL DEFAULT '0' COMMENT '完成获得积分',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `UCID` (`user_uuid`,`create_at`),
  KEY `UTCID` (`user_uuid`,`task_id`,`create_at`),
  KEY `create_at` (`create_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='完成记录表';