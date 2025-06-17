-- ---------------------------- 事务操作 ----------------------------
-- 数据准备
create table account(
    id int auto_increment primary key comment '主键ID',
    name varchar(10) comment '姓名',
    money int comment '余额'
) comment '账户表';
insert into account(id, name, money) VALUES (null,'张三',2000),(null,'李四',2000);


#恢复数据
update account set money = 2000 where name = '张三' || name = '李四';

#---------------通过修改事务提交方式
#查看事务提交
select @@autocommit;
#设置事务提交
set @@autocommit = 0;


#张三给李四转账1000
#1.查询张三余额
select account.money from account where name = '张三';
#2.张三余额-1000
update account set money = money -1000 where name = '张三';
#3.李四余额+1000
update account set money = money +1000 where name = '李四';

commit ;


#张三给李四转账1000
#1.查询张三余额
select account.money from account where name = '张三';
#2.张三余额-1000
update account set money = money -1000 where name = '张三';
#程序报错...
#3.李四余额+1000
update account set money = money +1000 where name = '李四';
#程序报错执行回滚事务
rollback ;


#------------通过开启事务的方式
start transaction ;
#张三给李四转账1000
#1.查询张三余额
select account.money from account where name = '张三';
#2.张三余额-1000
update account set money = money -1000 where name = '张三';
程序报错...
#3.李四余额+1000
update account set money = money +1000 where name = '李四';

commit ;
rollback ;



select @@transaction_isolation;
set session transaction isolation level read uncommitted ;
set session transaction isolation level repeatable read ;
#事务隔离级别
#read uncommitted  读取未提交    read committed  读取提交   repeatable read  默认   serializable（串行化，只允许一个事务进行并发操作）
#一个事务读取到另一个事务未提交的数据称为脏读
#同一个事务中读取到数据不一样，不可重复读