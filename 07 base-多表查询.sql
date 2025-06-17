-- 多对多 ----------------
create table student(
    id int auto_increment primary key comment '主键ID',
    name varchar(10) comment '姓名',
    no varchar(10) comment '学号'
) comment '学生表';
insert into student values (null, '黛绮丝', '2000100101'),(null, '谢逊', '2000100102'),(null, '殷天正', '2000100103'),(null, '韦一笑', '2000100104');


create table course(
    id int auto_increment primary key comment '主键ID',
    name varchar(10) comment '课程名称'
) comment '课程表';
insert into course values (null, 'Java'), (null, 'PHP'), (null , 'MySQL') , (null, 'Hadoop');


create table student_course(
    id int auto_increment comment '主键' primary key,
    studentid int not null comment '学生ID',
    courseid  int not null comment '课程ID',
    constraint fk_courseid foreign key (courseid) references course (id),
    constraint fk_studentid foreign key (studentid) references student (id)
)comment '学生课程中间表';

insert into student_course values (null,1,1),(null,1,2),(null,1,3),(null,2,2),(null,2,3),(null,3,4);




-- --------------------------------- 一对一 ---------------------------
create table tb_user(
    id int auto_increment primary key comment '主键ID',
    name varchar(10) comment '姓名',
    age int comment '年龄',
    gender char(1) comment '1: 男 , 2: 女',
    phone char(11) comment '手机号'
) comment '用户基本信息表';

create table tb_user_edu(
    id int auto_increment primary key comment '主键ID',
    degree varchar(20) comment '学历',
    major varchar(50) comment '专业',
    primaryschool varchar(50) comment '小学',
    middleschool varchar(50) comment '中学',
    university varchar(50) comment '大学',
    userid int unique comment '用户ID',
    constraint fk_userid foreign key (userid) references tb_user(id)
) comment '用户教育信息表';


insert into tb_user(id, name, age, gender, phone) values
        (null,'黄渤',45,'1','18800001111'),
        (null,'冰冰',35,'2','18800002222'),
        (null,'码云',55,'1','18800008888'),
        (null,'李彦宏',50,'1','18800009999');

insert into tb_user_edu(id, degree, major, primaryschool, middleschool, university, userid) values
        (null,'本科','舞蹈','静安区第一小学','静安区第一中学','北京舞蹈学院',1),
        (null,'硕士','表演','朝阳区第一小学','朝阳区第一中学','北京电影学院',2),
        (null,'本科','英语','杭州市第一小学','杭州市第一中学','杭州师范大学',3),
        (null,'本科','应用数学','阳泉第一小学','阳泉区第一中学','清华大学',4);



-- ------------------------------------> 多表查询 <--------------------------------------------
-- 准备数据
create table dept(
    id   int auto_increment comment 'ID' primary key,
    name varchar(50) not null comment '部门名称'
)comment '部门表';

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

-- 添加外键
alter table emp add constraint fk_emp_dept_id foreign key (dept_id) references dept(id);



INSERT INTO dept (id, name) VALUES (1, '研发部'), (2, '市场部'),(3, '财务部'), (4, '销售部'), (5, '总经办'), (6, '人事部');
INSERT INTO emp (id, name, age, job,salary, entrydate, managerid, dept_id) VALUES
            (1, '金庸', 66, '总裁',20000, '2000-01-01', null,5),

            (2, '张无忌', 20, '项目经理',12500, '2005-12-05', 1,1),
            (3, '杨逍', 33, '开发', 8400,'2000-11-03', 2,1),
            (4, '韦一笑', 48, '开发',11000, '2002-02-05', 2,1),
            (5, '常遇春', 43, '开发',10500, '2004-09-07', 3,1),
            (6, '小昭', 19, '程序员鼓励师',6600, '2004-10-12', 2,1),

            (7, '灭绝', 60, '财务总监',8500, '2002-09-12', 1,3),
            (8, '周芷若', 19, '会计',48000, '2006-06-02', 7,3),
            (9, '丁敏君', 23, '出纳',5250, '2009-05-13', 7,3),

            (10, '赵敏', 20, '市场部总监',12500, '2004-10-12', 1,2),
            (11, '鹿杖客', 56, '职员',3750, '2006-10-03', 10,2),
            (12, '鹤笔翁', 19, '职员',3750, '2007-05-09', 10,2),
            (13, '方东白', 19, '职员',5500, '2009-02-12', 10,2),

            (14, '张三丰', 88, '销售总监',14000, '2004-10-12', 1,4),
            (15, '俞莲舟', 38, '销售',4600, '2004-10-12', 14,4),
            (16, '宋远桥', 40, '销售',4600, '2004-10-12', 14,4),
            (17, '陈友谅', 42, null,2000, '2011-10-12', 1,null);



#-------------------------多表查询

select * from emp,dept;#笛卡尔积

#在多表查询消除笛卡尔积  第17个员工没有分配部门，无法查询出来
select * from dept,emp where dept_id=dept.id;


#内连接演示
#查询每个员工的姓名和部门名称，隐式内连接
select emp.name,emp.dept_id,dept.name from emp,dept where dept_id=dept.id;

#为了方便起别名,但是起了别名之后，就不可以通过原名访问
select e.name,d.name from emp e, dept d where e.dept_id=d.id;

#通过显示内连接查询  inner join ....on
select e.name,d.name from emp e inner join dept d on e.dept_id = d.id;


#外连接，查询emp表所有数据，和对应的部门信息
#左外链接  A left outer join B on 条件
select e.*,d.name from emp e left outer join dept d on e.dept_id = d.id;

#右外链接,查询dep表的所有数据和对应的员工信息
select e.*,d.* from emp e right outer join dept d on e.dept_id = d.id;


#自连接，可以内连接也可以外连接
#查询员工及其领导的名字，把一个表起两个别名后当成一个表
select a.name,b.name from emp a,emp b where a.managerid=b.id;
#查询所有员工emp 及其领导的名字，没有领导也要查询出来，使用外连接
select a.name,b.name from emp a left outer join emp b on a.managerid=b.id;


#联合查询，多张表的列数需要保持一致，字段列表也要保持一致
#将薪资低于5000和年龄大于50的查询出来,union all 不去重，union 去重
select * from emp where salary<5000
union
select * from emp where age>50;

select * from emp where age>50||salary<5000;

#-------------------------子查询
#标量子查询   列子查询  行子查询   表子查询

#标量子查询，子查询结果返回的单个值
#查询销售部所有员工信息
select * from emp where dept_id = (select id from dept where name='销售部');
#查询在房东白入职之后的员工
#1.查询方东白的入职时间
select emp.entrydate from emp where name='方东白';
#2.查询指定日期之后的入职员工
select * from emp where entrydate > (select emp.entrydate from emp where name='方东白');


#列子查询，子查询返回的是一列
#常用操作符，in  ，not in，any，some，all
#in（在指定范围内选择1）  not in（不在指定范围内） any（子查询返回列表中，有1个满足即可）  some（与any相同）  all（子查询返回列表必须都满足）

#查询销售部和市场部所有员工信息
select * from emp where dept_id in (select dept.id from dept where dept.name = '销售部' || dept.name = '市场部');

#查询比财务处所有人工资都高的员工信息

#先查询财务处所有人的工资
select emp.salary from emp where dept_id = (select id from dept where dept.name = '财务部');
select * from emp where salary > all (select emp.salary from emp where dept_id = (select id from dept where dept.name = '财务部'));
#查询比研发部任意一人工资高的员工信息
select * from emp where salary > any (select salary from emp where dept_id = (select id from dept where dept.name ='研发部'));


#行子查询
#查询与张无忌薪资及直属领导相同的员工信息
select emp.salary,emp.managerid from emp where name = '张无忌';

select * from emp where (salary,managerid) = (select emp.salary,emp.managerid from emp where name = '张无忌');

#查询与路障可，宋远桥的职位和薪资相同的员工信息
select emp.salary,emp.job from emp where name = '宋远桥' || name = '鹿杖客';
select * from emp where (salary,job) in (select emp.salary,emp.job from emp where name = '宋远桥' || name = '鹿杖客');

#查询入职日期是‘2006-01-01’之后的员工信息，及其部门信息
select * from emp where entrydate >'2006-01-01';
select e.*,d.* from (select * from emp where entrydate >'2006-01-01') e left join dept d on e.dept_id = d.id;




-- ---------------------------------------> 多表查询案例 <----------------------------------
create table salgrade(
    grade int,
    losal int,
    hisal int
) comment '薪资等级表';

insert into salgrade values (1,0,3000);
insert into salgrade values (2,3001,5000);
insert into salgrade values (3,5001,8000);
insert into salgrade values (4,8001,10000);
insert into salgrade values (5,10001,15000);
insert into salgrade values (6,15001,20000);
insert into salgrade values (7,20001,25000);
insert into salgrade values (8,25001,30000);



#查询员工姓名、年龄、职位、部门信息---隐式内连接
select e.name,e.age,e.job,d.name from emp e, dept d where e.dept_id = d.id;
#查询年龄小于30的员工姓名、年龄、职位、部门信息----显式内连接
select e.name,e.age,e.job,d.name from emp e inner join dept d on e.dept_id = d.id where e.age<30;
#查询拥有员工的部门ID、名称
select distinct d.id,d.name from emp e ,dept d where e.dept_id = d.id;
#查询所有年龄大于40的员工，及其归属部门，员工没有部门也要展示出来
select e.name,d.name from emp e left join dept d on e.dept_id = d.id where e.age>40;
#查询所有员工的工资等级
select e.*,s.grade,s.losal,s.hisal from emp e,salgrade s where e.salary>=s.losal&&e.salary<=s.hisal;
select e.*,s.grade,s.losal,s.hisal from emp e,salgrade s where e.salary between s.losal and s.hisal;
#查询研发部所有员工信息及工资等级
select id from dept where name = '研发部';

select e.*, s.grade
from emp e,
     salgrade s
where dept_id = (select id from dept where name = '研发部') && e.salary between s.losal and s.hisal;

#查询研发部员工的平均薪资
select avg(e.salary) from emp e,dept d where e.dept_id = d.id and d.name = '研发部';
#查询工工资比灭绝高的员工信息
select emp.salary from emp where name = '灭绝';
select * from emp e where salary > (select emp.salary from emp where name = '灭绝');
#查询比平均薪资高的员工共信息
select avg(salary) from emp e ;
select * from emp e where salary > (select avg(salary) from emp e );
#查询工资低于本部门平均工资的员工信息
select avg(salary) from emp e1 where dept_id = 1;
select avg(salary) from emp e1 where dept_id = 2;

select * ,(select avg(salary) from emp e1 where e1.dept_id = e2.dept_id ) '平均 'from emp e2 where e2.salary <(select avg(salary) from emp e1 where e1.dept_id = e2.dept_id );
#查询所有部门薪资，并统计部门员工人数
select count(*) from emp e where dept_id = 1;
select d.* ,(select count(*) from emp e where e.dept_id = d.id) '人数' from dept d;

#查询所有学生的选课情况，展示出学生名称、学号、课程名称
select s.name,s.no,c.name from student s,student_course sc ,course c where s.id = sc.studentid and sc.courseid = c.id;

