/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50625
Source Host           : localhost:3306
Source Database       : sboot_shiro_l

Target Server Type    : MYSQL
Target Server Version : 50625
File Encoding         : 65001

Date: 2018-01-11 18:10:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) DEFAULT NULL,
  `resource_type` int(2) DEFAULT NULL COMMENT '资源类型：1-menu（菜单）；2-button（按钮）',
  `url` varchar(255) DEFAULT NULL COMMENT '资源路径',
  `code` varchar(255) DEFAULT NULL COMMENT '权限字符串（menu例子：role:*；button例子：role:create,role:update,role:delete,role:view）',
  `parent_id` bigint(20) DEFAULT NULL,
  `parent_ids` varchar(255) DEFAULT NULL,
  `available` int(1) DEFAULT NULL COMMENT '是否可用：0-不可用；1-可用',
  `create_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `update_user` bigint(20) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique-code` (`code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='权限';

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES ('1', '用户管理', '1', 'sys/user/list', 'sys:user:view', '0', '0/', '1', '1', '2017-11-24 10:30:23', '1', '2017-11-24 10:30:26');
INSERT INTO `sys_permission` VALUES ('2', '用户添加', '2', 'sys/user/add', 'sys:user:add', '1', '0/1', '1', '1', '2017-11-24 10:31:57', '1', '2017-11-24 10:31:59');
INSERT INTO `sys_permission` VALUES ('3', '用户修改', '2', 'sys/user/edit', 'sys:user:edit', '1', '0/1', '1', '1', '2017-11-24 10:32:46', '1', '2017-11-24 10:32:50');
INSERT INTO `sys_permission` VALUES ('4', '用户删除', '2', 'sys/user/del', 'sys:user:del', '1', '0/1', '1', '1', '2017-11-24 10:33:38', '1', '2017-11-24 10:33:41');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `available` int(1) DEFAULT NULL COMMENT '是否可用：0-不可用；1-可用',
  `create_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `update_user` bigint(20) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique-code` (`code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', 'role-admin', '超管角色', '拥有所有权限', '1', '1', '2017-11-24 10:20:08', '1', '2017-11-24 10:20:12');

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission` (
  `role_id` bigint(20) NOT NULL,
  `permission_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES ('1', '1');
INSERT INTO `sys_role_permission` VALUES ('1', '2');
INSERT INTO `sys_role_permission` VALUES ('1', '3');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `login_name` varchar(50) NOT NULL COMMENT '登录名',
  `name` varchar(50) DEFAULT NULL COMMENT '姓名',
  `password` varchar(50) NOT NULL COMMENT '密码',
  `salt` varchar(255) DEFAULT NULL COMMENT '加密密码盐',
  `state` int(2) DEFAULT NULL COMMENT '用户状态：0-创建未认证（未激活、待验证等）；1-正常；2-锁定',
  `create_user` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `update_user` bigint(20) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique-login-name` (`login_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '超管', '123456', '1', '1', '1', '2017-11-24 10:17:11', '1', '2017-11-24 10:17:13');
INSERT INTO `sys_user` VALUES ('2', 'guest', '客户', '123', '1', '1', '1', '2017-12-15 14:11:00', '1', '2017-12-15 14:11:04');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1');
