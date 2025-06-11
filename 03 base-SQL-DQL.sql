#DQL语句编写顺序
# select 字段列表 from 表名列表 where 条件列表 group by 分组字段列表 having 分组后条件列表 order by 排序字段列表 limit 分页参数

#DQL语句执行顺序
    #1.from
    #2.where
    #3.group by  having
    #4.select
    #5.order by
    #6.limit


##################1.基本查询


create table emp(
    id int comment '编号',
    worknum varchar(10) comment '工号',
    name varchar(10) comment '姓名',
    gender char(1) comment '性别',
    age tinyint unsigned comment '年龄',
    idcard char(18) comment '身份证号',
    workaddress varchar(50) comment '工作地址',
    entrydate date comment '入职时间'
)comment '职工表';



INSERT INTO emp (id, worknum, name, gender, age, idcard, workaddress, entrydate)
VALUES
    (1, '1', '柳岩', '女', 20, '123456789012345678', '北京', '2000-01-01'),
    (2, '2', '张无忌', '男', 18, '123456789012345670', '北京', '2005-09-01'),
    (3, '3', '韦一笑', '男', 38, '123456789712345670', '上海', '2005-08-01'),
    (4, '4', '赵敏', '女', 18, '123456757123845670', '北京', '2009-12-01'),
    (5, '5', '小昭', '女', 16, '123456769012345678', '上海', '2007-07-01'),
    (6, '6', '杨逍', '男', 28, '12345678931234567X', '北京', '2006-01-01'),
    (7, '7', '范瑶', '男', 40, '123456789212345670', '北京', '2005-05-01'),
    (8, '8', '黛绮丝', '女', 38, '123456157123645670', '天津', '2015-05-01'),
    (9, '9', '范凉凉', '女', 45, '123156789012345678', '北京', '2010-04-01'),
    (10, '10', '陈友谅', '男', 53, '123456789012345670', '上海', '2011-01-01'),
    (11, '11', '张士诚', '男', 55, '123567897123465670', '江苏', '2015-05-01'),
    (12, '12', '常遇春', '男', 32, '123446757152345670', '北京', '2004-02-01'),
    (13, '13', '张三丰', '男', 88, '123656789012345678', '江苏', '2020-11-01'),
    (14, '14', '灭绝', '女', 65, '123456719012345670', '西安', '2019-05-01'),
    (15, '15', '胡青牛', '男', 70, '12345674971234567X', '西安', '2018-04-01'),
    (16,'16','周芷若','女',18,null,'北京','2012-06-01');


#1.基本查询，查询name、worknum、age并返回
select name,age,worknum from emp;

#2.查询返回所有字段
select id, worknum, name, gender, age, idcard, workaddress, entrydate from emp;
#开发中尽量不写*
select *from emp;

#3.查询所有员工工作地址，起别名
select emp.workaddress as '工作地址' from emp;
select emp.workaddress  '工作地址' from emp;

#4.查询上班地址，不重复
select distinct workaddress  '工作地址' from emp;


#######################----------2.条件查询

#1.年龄=88
select * from emp where age=88;

select * from emp where age<20;

select * from emp where age<=20;

select * from emp where idcard is null;

select  * from emp where !(idcard is null);

select  * from emp where age !=88;

select * from emp where age >=15&&age <=20;
select  * from emp where age>=15 and age<=20;
select * from emp where age between 15 and 20;

select  * from emp  where gender='女'&&age<25;

select * from emp where age=18||age=20||age=40;
select  * from emp where age in(18,20,40);#in()，表示列表满足其一即可

#查询姓名为两个字的员工  _代表一个字符  %代表任意字符
select * from emp where name like '__';
#查找身份证最后一位为x
select * from emp where idcard like '%x';


###############-----------------3.聚合函数，作用于某一列
#统计企业员工的数量
select count(id) from emp;
select count(emp.idcard) from emp;#null值不参与聚合运算

#统计平均年龄
select avg(emp.age) from emp;
#最大年龄
select max(emp.age) from emp;

select  min(emp.age) from emp;

#统计西安地区元员工年龄之和
select sum(emp.age) from emp where workaddress='西安';

##############-------------------------4.分组查询
#where和having的区别
#where对分组前数据过滤，且不能使用聚合函数
#having对分组后过滤，可以使用聚合函数
#进行分组后，查询的；一般为分组后的字段和聚类函数，其他无意义


#根据性别分组，统计男女数量
select emp.gender,count(*) from emp group by gender;

#根据性别分组，统计男女平均年龄
select emp.gender,avg(emp.age) from emp group by gender;

#查询年龄<45的员工，按照工作地点分组，获取员工数量>3的工作地址
#执行顺序 where>聚合函数>having
select emp.workaddress,count(*) from emp where age<45 group by workaddress having (count(workaddress)>=3);



###############--------------------------5，排序查询
#多字段排序，第一个字段相同时，按照输入的第二个字段进行查询

#根据年龄进行升序排序
select * from emp order by age ;
select * from emp order by age desc ;

#根据入职时间对员工降序排序
select *from emp order by entrydate desc ;

#年龄升序，相同使用入职时按降序
select * from emp order by age ,entrydate desc ;

##################-----------------------------6,分页查询
#limit 起始索引(页码下标*查询的记录数) ，查询记录数（查询的记录数）
# 页数-1，和数据下表一样
#查询第一页，每页10记录
select * from emp limit 0,10;
select * from emp limit 10;

#查询第二页，10条
select * from emp limit 10,10;

####------------------案例
#年龄为20，21，22，23岁员工
select * from emp where age in (20,21,22,23)&&gender='女';
#性别为男，年龄在20--40，且名字为三个字的员工
select * from emp where gender='男'and 20<age&&age<=40&&name like '___';
#年龄小于60，男性员工和女数量
select emp.gender,count(*) from emp where age<60 group by emp.gender ;

#查询所有年龄小于等于35的员工姓名和年龄，对结果按照年龄升序排序，年龄相同按照入职时间降序
select emp.name,emp.age,entrydate  from emp where age<=35 order by age asc ,entrydate desc ;

#男，年龄在20-40的前五个员工信息，对结果按照年龄升序，年龄相同，按入职时间升序
select * from emp where gender='男' &&age>20&&age<=40 order by  age,entrydate limit 0,5;
