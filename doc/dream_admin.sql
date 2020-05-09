/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 50728
 Source Host           : localhost:3306
 Source Schema         : dream_admin

 Target Server Type    : MySQL
 Target Server Version : 50728
 File Encoding         : 65001

 Date: 09/05/2020 16:08:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_action
-- ----------------------------
DROP TABLE IF EXISTS `sys_action`;
CREATE TABLE `sys_action`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '功能名称',
  `url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'javascript:void(0);' COMMENT '功能url',
  `type` int(2) NOT NULL COMMENT '1：系统功能 2：导航菜单',
  `parent_id` int(11) NOT NULL DEFAULT 0 COMMENT '父级菜单id',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '备注',
  `perms` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `icon` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '图标',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `weight` int(11) NOT NULL DEFAULT 99 COMMENT '权重 越大越靠前',
  `status` int(11) NULL DEFAULT 1 COMMENT '状态 1:可用 0：不可用 -1：删除',
  `update_time` timestamp(0) NULL DEFAULT NULL COMMENT '更新时间',
  `parent_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父级名称',
  `level` tinyint(4) NOT NULL COMMENT '等级',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 377 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_action
-- ----------------------------
INSERT INTO `sys_action` VALUES (2, '系统管理', 'javascript:void(0);', 2, -1, '系统管理', NULL, 'layui-icon layui-icon-set', '2017-06-05 14:57:25', 0, 1, '2018-06-13 14:55:51', NULL, 1);
INSERT INTO `sys_action` VALUES (3, '系统用户', '/sysuser/index.html', 2, 2, '系统用户', 'sysuser:index,sysuser:list', ' ', '2017-06-05 14:58:46', 4, 1, '2017-09-26 10:37:33', NULL, 2);
INSERT INTO `sys_action` VALUES (4, '系统功能', '/sysAction/index.html', 2, 2, '系统功能', 'sysAction:index,sysAction:list', ' ', '2017-06-05 14:59:15', 1, 1, '2017-09-26 10:38:03', NULL, 2);
INSERT INTO `sys_action` VALUES (6, '权限管理', '/sysUserAuth/index.html?uid=1', 1, 2, ' 权限管理', 'sysRoleAuth:index', ' ', '2017-06-05 20:45:05', 0, 1, '2017-09-26 10:38:03', NULL, 2);
INSERT INTO `sys_action` VALUES (9, '角色权限', '/sysRoleAuth/index.html', 2, 2, '角色权限', 'sysRoleAuth:index', ' ', '2017-06-06 19:46:58', 3, 1, '2017-09-26 10:38:25', NULL, 2);
INSERT INTO `sys_action` VALUES (111, '角色管理', '/sysRole/index', 2, 2, '角色管理', 'sysRole:index,sysRole:list', '', '2018-01-16 17:38:58', 2, 1, '2018-01-16 17:38:58', '系统管理', 2);
INSERT INTO `sys_action` VALUES (146, '添加', 'javascript:void(0);', 3, 4, '添加', 'sysAction:getView,sysAction:add', '', '2018-06-19 11:23:33', 99, 1, '2018-06-19 11:45:21', '系统功能', 3);
INSERT INTO `sys_action` VALUES (148, '编辑', 'javascript:void(0);', 3, 4, '编辑', 'sysAction:getView,sysAction:edit', '', '2018-06-19 11:24:25', 99, 1, '2018-06-19 11:24:25', '系统功能', 3);
INSERT INTO `sys_action` VALUES (149, '删除', 'javascript:void(0);', 3, 4, '删除', 'sysAction:del', '', '2018-06-19 11:25:58', 99, 1, '2018-06-19 11:25:58', '系统功能', 3);
INSERT INTO `sys_action` VALUES (187, '用户添加', 'javascript:void(0);', 3, 3, '添加', 'sysuser:add', '', '2018-06-19 11:18:24', 99, 1, '2018-06-19 11:18:24', '系统用户', 3);
INSERT INTO `sys_action` VALUES (188, '用户编辑', 'javascript:void(0);', 3, 3, '编辑', 'sysuser:getView,sysuser:edit', '', '2018-06-19 11:19:08', 99, 1, '2018-06-19 17:46:20', '系统用户', 3);
INSERT INTO `sys_action` VALUES (189, '用户赋权', 'javascript:void(0);', 3, 3, '赋权', 'sysUserAuth:index', '', '2018-06-19 11:19:35', 99, 1, '2018-06-19 11:19:35', '系统用户', 3);
INSERT INTO `sys_action` VALUES (190, '角色权限-角色分配', 'javascript:void(0);', 3, 9, '角色分配', 'sysRoleAuth:editRoleAction', '', '2018-06-19 15:26:13', 99, 1, '2018-06-19 15:29:29', '角色权限', 3);

-- ----------------------------
-- Table structure for sys_operator_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_operator_log`;
CREATE TABLE `sys_operator_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sys_uid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作人uid',
  `sys_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作人名字',
  `operation` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作名字',
  `ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户ip地址',
  `params` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作内容',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '方法名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2331 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `describe` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', '超级管理员');

-- ----------------------------
-- Table structure for sys_role_action
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_action`;
CREATE TABLE `sys_role_action`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `action_id` int(11) NOT NULL COMMENT '功能id',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_uid` int(11) NOT NULL COMMENT '创建人id',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14366 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `uid` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户uid',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `pswd` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码',
  `real_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '真实姓名',
  `mobile` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `qq` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系qq',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系邮箱',
  `create_uid` int(11) NOT NULL COMMENT '创建人',
  `type` int(2) NOT NULL COMMENT '1:根用户 2：商户',
  `is_valid` int(1) NOT NULL DEFAULT 0 COMMENT '0 无效 1 有效',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL COMMENT '更新时间',
  `last_login_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后登录时间',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `sys_code` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'xdwl' COMMENT '系统码',
  `del_flag` int(2) NULL DEFAULT NULL COMMENT '删除标识',
  PRIMARY KEY (`uid`) USING BTREE,
  UNIQUE INDEX `uniq`(`name`) USING BTREE,
  INDEX `idx`(`name`, `pswd`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', 'E10ADC3949BA59ABBE56E057F20F883E', '管理员', '17620027932', '11111', '11111@qq.com', -1, 2, 1, '2020-05-09 16:07:34', '2017-11-21 18:03:04', '2020-05-09 16:07:34', '种子用户', 'xdwl', 1);

-- ----------------------------
-- Table structure for sys_user_action
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_action`;
CREATE TABLE `sys_user_action`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户uid',
  `action_id` int(11) NOT NULL COMMENT '功能id',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_uid` int(11) NOT NULL COMMENT '创建人',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `role_id` int(11) NULL DEFAULT NULL COMMENT '角色编号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_1`(`uid`, `action_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 77717 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_action
-- ----------------------------
INSERT INTO `sys_user_action` VALUES (77702, 1, 2, '2020-05-09 12:54:42', 1, NULL, NULL);
INSERT INTO `sys_user_action` VALUES (77703, 1, 3, '2020-05-09 12:54:42', 1, NULL, NULL);
INSERT INTO `sys_user_action` VALUES (77704, 1, 4, '2020-05-09 12:54:42', 1, NULL, NULL);
INSERT INTO `sys_user_action` VALUES (77705, 1, 6, '2020-05-09 12:54:42', 1, NULL, NULL);
INSERT INTO `sys_user_action` VALUES (77706, 1, 9, '2020-05-09 12:54:42', 1, NULL, NULL);
INSERT INTO `sys_user_action` VALUES (77707, 1, 111, '2020-05-09 12:54:42', 1, NULL, NULL);
INSERT INTO `sys_user_action` VALUES (77708, 1, 146, '2020-05-09 12:54:42', 1, NULL, NULL);
INSERT INTO `sys_user_action` VALUES (77709, 1, 148, '2020-05-09 12:54:42', 1, NULL, NULL);
INSERT INTO `sys_user_action` VALUES (77710, 1, 149, '2020-05-09 12:54:42', 1, NULL, NULL);
INSERT INTO `sys_user_action` VALUES (77711, 1, 187, '2020-05-09 12:54:42', 1, NULL, NULL);
INSERT INTO `sys_user_action` VALUES (77712, 1, 188, '2020-05-09 12:54:42', 1, NULL, NULL);
INSERT INTO `sys_user_action` VALUES (77713, 1, 189, '2020-05-09 12:54:42', 1, NULL, NULL);
INSERT INTO `sys_user_action` VALUES (77714, 1, 190, '2020-05-09 12:54:42', 1, NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户id',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 785 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
