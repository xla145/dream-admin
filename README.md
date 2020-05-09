## 平台简介
dream-admin是基于springBoot 2.0 的一个快速开发平台，拥有用户管理、部门管理、角色管理、菜单管理、用户权限分配 等功能。

## 具有如下特点
- 友好的代码结构及注释，便于阅读及二次开发
- 灵活的权限控制，可控制到页面和按钮，满足绝大部分的权限需求
- 页面使用layui，封装了常用组件，不必再写一堆重复的js，只需在html页面简单配置

## 如何交流、反馈、参与贡献？
- Git仓库：https://github.com/xla145/dream-admin
- 如需关注项目最新动态，请Watch、Star项目

## 技术选型：
- 核心框架：Spring Boot 2.0.0 RELEASE
- 安全框架：Apache Shiro 1.4
- 持久层框架：easy-dao  [参考使用](https://github.com/xla145/easy-dao)
- 数据库连接池：Druid 1.1.3
- 日志管理：SLF4J 1.7、Log4j
- 页面：layui

## 本地部署
- 通过git下载源码
- 创建数据库dream-admin，数据库编码为UTF-8
- 执行doc/dream-admin.sql文件，初始化数据
- 修改application-dev.yml，更新MySQL账号和密码
- 项目访问路径：http://localhost:8080/
- 账号密码：admin/123456

## 效果图
![输入图片说明](https://github.com/xla145/dream-admin/blob/master/screenshots/1535616251.jpg "1535616251.png")
![输入图片说明](https://github.com/xla145/dream-admin/blob/master/screenshots/1535616281.jpg "1535616281.png")
![输入图片说明](https://github.com/xla145/dream-admin/blob/master/screenshots/1535616301.jpg "1535616301.png")
![输入图片说明](https://github.com/xla145/dream-admin/blob/master/screenshots/1535616321.jpg "1535616321.png")
![输入图片说明](https://github.com/xla145/dream-admin/blob/master/screenshots/1535616357.jpg "1535616357.png")

## 注意

由于项目中 `shiro-freemarker-tags` 和 `easy-dao` 包不来源于互联网，所以使用前参考以下方法引入

* [如何引入`shiro-freemarker-tags`](https://github.com/xla145/shiro-freemarker-tags) 
* [如何引入`esay-dao`](https://github.com/xla145/easy-dao) 







