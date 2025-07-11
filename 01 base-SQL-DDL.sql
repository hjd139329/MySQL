/*
#1.数据库操作
#查看当前有哪些数据库
SHOW DATABASE；

#创建数据库
CREATE DATABASE [IF NOT EXISTS] 数据库名 ；

#使用某个数据库
USE 数据库名 ；

#查看当前数据库
SELECT 数据库() ；

#删除数据库
DROP DATABASE [IF EXISTS]数据库名；


#2.表操作
#查看当前数据库所有的表
SHOW TABLE；

#创建表
CREATE Table 表名(
    字段 字段类型 [COMMENT] '',
    字段 字段类型 [COMMENT] '',
    字段 字段类型 [COMMENT] '',
    字段 字段类型 [COMMENT] ''
)[COMMENT] '';

#查看某个表字段
DESC 表名;

#查看创建表时的语句
SHOW CREATE TABLE 表名;

#添加字段/修改字段类型/修改字段名称及类型/删除字段/修改表名
ALTER TABLE ADD/MODIFY/CHANGE/DROP/RENAME TO/... ;

#删除表名
DROP Table 表名;

 */