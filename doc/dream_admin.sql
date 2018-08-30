/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50723
Source Host           : localhost:3306
Source Database       : dream_admin

Target Server Type    : MYSQL
Target Server Version : 50723
File Encoding         : 65001

Date: 2018-08-30 15:18:17
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_action
-- ----------------------------
DROP TABLE IF EXISTS `sys_action`;
CREATE TABLE `sys_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(100) NOT NULL COMMENT '功能名称',
  `url` varchar(100) NOT NULL DEFAULT 'javascript:void(0);' COMMENT '功能url',
  `type` int(2) NOT NULL COMMENT '1：系统功能 2：导航菜单',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '父级菜单id',
  `remark` varchar(200) NOT NULL COMMENT '备注',
  `perms` varchar(255) DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `icon` varchar(500) DEFAULT '' COMMENT '图标',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `weight` int(11) NOT NULL DEFAULT '99' COMMENT '权重 越大越靠前',
  `status` int(11) DEFAULT '1' COMMENT '状态 1:可用 0：不可用 -1：删除',
  `update_time` datetime NOT NULL,
  `parent_name` varchar(20) DEFAULT NULL COMMENT '父级名称',
  `level` tinyint(4) NOT NULL COMMENT '等级',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=377 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_action
-- ----------------------------
INSERT INTO `sys_action` VALUES ('2', '系统管理', 'javascript:void(0);', '2', '-1', '系统管理', null, 'layui-icon layui-icon-set', '2017-06-05 14:57:25', '0', '1', '2018-06-13 14:55:51', null, '1');
INSERT INTO `sys_action` VALUES ('3', '系统用户', '/sysuser/index.html', '2', '2', '系统用户', 'sysuser:index,sysuser:list', ' ', '2017-06-05 14:58:46', '4', '1', '2017-09-26 10:37:33', null, '2');
INSERT INTO `sys_action` VALUES ('4', '系统功能', '/sysAction/index.html', '2', '2', '系统功能', 'sysAction:index,sysAction:list', ' ', '2017-06-05 14:59:15', '1', '1', '2017-09-26 10:38:03', null, '2');
INSERT INTO `sys_action` VALUES ('6', '权限管理', '/sysUserAuth/index.html?uid=1', '1', '2', ' 权限管理', 'sysRoleAuth:index', ' ', '2017-06-05 20:45:05', '0', '1', '0000-00-00 00:00:00', null, '2');
INSERT INTO `sys_action` VALUES ('9', '角色权限', '/sysRoleAuth/index.html', '2', '2', '角色权限', 'sysRoleAuth:index', ' ', '2017-06-06 19:46:58', '3', '1', '2017-09-26 10:38:25', null, '2');
INSERT INTO `sys_action` VALUES ('111', '角色管理', '/sysRole/index', '2', '2', '角色管理', 'sysRole:index,sysRole:list', '', '2018-01-16 17:38:58', '2', '1', '2018-01-16 17:38:58', '系统管理', '2');
INSERT INTO `sys_action` VALUES ('146', '添加', 'javascript:void(0);', '3', '4', '添加', 'sysAction:getView,sysAction:add', '', '2018-06-19 11:23:33', '99', '1', '2018-06-19 11:45:21', '系统功能', '3');
INSERT INTO `sys_action` VALUES ('148', '编辑', 'javascript:void(0);', '3', '4', '编辑', 'sysAction:getView,sysAction:edit', '', '2018-06-19 11:24:25', '99', '1', '2018-06-19 11:24:25', '系统功能', '3');
INSERT INTO `sys_action` VALUES ('149', '删除', 'javascript:void(0);', '3', '4', '删除', 'sysAction:del', '', '2018-06-19 11:25:58', '99', '1', '2018-06-19 11:25:58', '系统功能', '3');
INSERT INTO `sys_action` VALUES ('187', '用户添加', 'javascript:void(0);', '3', '3', '添加', 'sysuser:add', '', '2018-06-19 11:18:24', '99', '1', '2018-06-19 11:18:24', '系统用户', '3');
INSERT INTO `sys_action` VALUES ('188', '用户编辑', 'javascript:void(0);', '3', '3', '编辑', 'sysuser:getView,sysuser:edit', '', '2018-06-19 11:19:08', '99', '1', '2018-06-19 17:46:20', '系统用户', '3');
INSERT INTO `sys_action` VALUES ('189', '用户赋权', 'javascript:void(0);', '3', '3', '赋权', 'sysUserAuth:index', '', '2018-06-19 11:19:35', '99', '1', '2018-06-19 11:19:35', '系统用户', '3');
INSERT INTO `sys_action` VALUES ('190', '角色权限-角色分配', 'javascript:void(0);', '3', '9', '角色分配', 'sysRoleAuth:editRoleAction', '', '2018-06-19 15:26:13', '99', '1', '2018-06-19 15:29:29', '角色权限', '3');

-- ----------------------------
-- Table structure for sys_operator_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_operator_log`;
CREATE TABLE `sys_operator_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sys_uid` varchar(20) NOT NULL COMMENT '操作人uid',
  `sys_name` varchar(255) NOT NULL COMMENT '操作人名字',
  `operation` varchar(100) NOT NULL COMMENT '操作名字',
  `ip` varchar(20) NOT NULL COMMENT '用户ip地址',
  `params` varchar(512) NOT NULL COMMENT '操作内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `method` varchar(255) NOT NULL COMMENT '方法名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2331 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_operator_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `name` varchar(200) NOT NULL COMMENT '角色名称',
  `describe` varchar(200) NOT NULL COMMENT '角色描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '超级管理员', '超级管理员');

-- ----------------------------
-- Table structure for sys_role_action
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_action`;
CREATE TABLE `sys_role_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `action_id` int(11) NOT NULL COMMENT '功能id',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_uid` int(11) NOT NULL COMMENT '创建人id',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14366 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_action
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户uid',
  `name` varchar(20) NOT NULL COMMENT '用户名',
  `pswd` varchar(100) NOT NULL COMMENT '用户密码',
  `real_name` varchar(100) NOT NULL COMMENT '真实姓名',
  `mobile` varchar(11) DEFAULT NULL COMMENT '手机号',
  `qq` varchar(15) DEFAULT NULL COMMENT '联系qq',
  `email` varchar(50) DEFAULT NULL COMMENT '联系邮箱',
  `create_uid` int(11) NOT NULL COMMENT '创建人',
  `type` int(2) NOT NULL COMMENT '1:根用户 2：商户',
  `is_valid` int(1) NOT NULL DEFAULT '0' COMMENT '0 无效 1 有效',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `last_login_time` datetime NOT NULL COMMENT '最后登录时间',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `sys_code` varchar(128) DEFAULT 'xdwl' COMMENT '系统码',
  `del_flag` int(2) DEFAULT NULL COMMENT '删除标识',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uniq` (`name`),
  KEY `idx` (`name`,`pswd`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', 'E10ADC3949BA59ABBE56E057F20F883E', '管理员', '17620027932', '11111', '11111@qq.com', '-1', '2', '1', '2017-05-23 19:11:43', '2017-11-21 18:03:04', '2018-08-30 12:01:26', '种子用户', 'xdwl', '1');

-- ----------------------------
-- Table structure for sys_user_action
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_action`;
CREATE TABLE `sys_user_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户uid',
  `action_id` int(11) NOT NULL COMMENT '功能id',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_uid` int(11) NOT NULL COMMENT '创建人',
  `remark` varchar(200) NOT NULL COMMENT '备注',
  `role_id` int(11) DEFAULT NULL COMMENT '角色编号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_1` (`uid`,`action_id`)
) ENGINE=InnoDB AUTO_INCREMENT=77700 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_user_cache
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_cache`;
CREATE TABLE `sys_user_cache` (
  `cache_id` varchar(100) NOT NULL COMMENT 'session编号',
  `session` blob NOT NULL COMMENT 'session 值',
  `expiration` double NOT NULL DEFAULT '0' COMMENT '过期时间',
  PRIMARY KEY (`cache_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user_cache
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户id',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `remark` varchar(200) NOT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=785 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
