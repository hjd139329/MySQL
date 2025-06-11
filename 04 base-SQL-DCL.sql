#DCL用户控制
#创建用户itcast，只能在当前主机访问，密码123456
create user 'itcast'@'localhost' identified by '123456';

#创建用户itheima，可以在任意主机访问，密码123456
create user 'itheima'@'%' identified by '123456';
#修改itheima的密码为1234
alter user 'itheima'@'%' identified with mysql_native_password by '1234';

#删除itcast@localhost用户
drop user 'itcast'@'localhost';


#多个权限之间使用，分隔

#查询权限
show grants for 'itheima'@'%';

#授予权限
#授权时，数据库和表名都可以使用*进行统配，表示全部
grant all on itcast.* to 'itheima'@'%';

#撤销权限
revoke  all on itcast.* from 'itheima'@'%';
