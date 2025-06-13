create table user(
    id int primary key auto_increment comment '编号',
    name varchar(10) not null unique comment '姓名',
    age int check ( age>0 && age <=120 ) comment '年龄',
    status char(1) default '1' comment '状态',
    gender char(1) comment '性别'
)comment '用户表';

drop table user;
insert into user( name, age, status, gender) values ('tom1',16,'1','男'),('tom2',23,'0','男');
insert into user( name, age, status, gender) values ('tom3',24,'1','女');

#不能插入相同的名字
insert into user (name, age, status, gender)
values ('tom3',23,'2','男');
#名字不能插入空
insert into user (name, age, status, gender)
values (null,23,'3','女');

#年龄不能超范围
insert into user (name, age, status, gender)
values ('tom6',121,'2','a');

#状态不插入，默认为1
insert into user ( name, age, gender)
values ('tom',24,'a');


-- --------------------------------------------- 约束 (外键) -------------------------------------
-- 准备数据
create table dept(
    id   int auto_increment comment 'ID' primary key,
    name varchar(50) not null comment '部门名称'
)comment '部门表';
INSERT INTO dept (id, name) VALUES (1, '研发部'), (2, '市场部'),(3, '财务部'), (4, '销售部'), (5, '总经办');

drop table dept;
create table emp(
    id  int auto_increment comment 'ID' primary key,
    name varchar(50) not null comment '姓名',
    age  int comment '年龄',
    job varchar(20) comment '职位',
    salary int comment '薪资',
    entrydate date comment '入职时间',
    managerid int comment '直属领导ID',
    dept_id int comment '部门ID'
)comment '员工表';

INSERT INTO emp (id, name, age, job,salary, entrydate, managerid, dept_id) VALUES
            (1, '金庸', 66, '总裁',20000, '2000-01-01', null,5),(2, '张无忌', 20, '项目经理',12500, '2005-12-05', 1,1),
            (3, '杨逍', 33, '开发', 8400,'2000-11-03', 2,1),(4, '韦一笑', 48, '开发',11000, '2002-02-05', 2,1),
            (5, '常遇春', 43, '开发',10500, '2004-09-07', 3,1),(6, '小昭', 19, '程序员鼓励师',6600, '2004-10-12', 2,1);
drop table emp;
#添加外键
alter table emp add constraint constraint_emp_dept_id foreign key (dept_id) references dept(id);
#删除外键
alter table emp drop foreign key constraint_emp_dept_id;

#-----------------外键删除更新行为
# cascade子表会随着父表更新或删除
alter table emp add constraint constraint_emp_dept_id foreign key (dept_id) references dept(id) on update cascade on delete cascade ;
#set null  父表删除，子表会置为null
alter table emp add constraint constraint_emp_dept_id foreign key (dept_id) references dept(id) on update set null on delete set null ;