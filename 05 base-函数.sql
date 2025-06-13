


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



#--------------------------------------------1.字符串函数
#concat字符串拼接
select concat('hello','mysql');

#lower 全部转为小写
select lower('Hello');
#upper 全部转为大写
select upper('Hello');
#lpad 用字符串对另一字符串进行左填充   ---01
select lpad('01',5,'-');
#rpad 右填充  02---
select rpad('02',5,'-');

#trim 去除头尾的空格
select trim(' hello  mysql ');
#substring  从第几个位置，截取几个，注意，下标从1开始
select substr('hello  mysql',1,5);

#对员工的编号进行更新，达到五位数
update emp set worknum = lpad (worknum,5,'0');


#-----------------------------------------------2.数值函数
#ceil向上取整
select ceil('1.2');
#floor 向下取整
select floor('2.1');
#mod 取模
select mod(5,2);
#rand 取随机数 0-1之间
select rand();
#round 保留小数 2.35
select round(2.345,2);

#生成一个六位数的验证码
select lpad(round(rand()*1000000,0),6,'0') ;



#------------------------------------3.日期函数
#curdate 当前日期
select curdate();
#curtime 当前时间
select curtime();
#now 当前日期时间
select now();


#获取year month  day
select year(now());
select month(now());
select day(now());

#date_add 在某一时间 加上某时间
select date_add(now(),interval 70 year );


#dategiff 两个指定时间相差的天数
select datediff('2020=03-01','2020-02-01');

#查询所有员工入职天数，并按照入职天数倒叙排序
select name,datediff(now(),entrydate) as 'entrydays' from emp order by entrydays desc ;


#--------------------------------流程控制函数
#if 如果1为真，返回2，否则返回3
select if(1,'ok','not');
#ifnull 如果1不为空，返回1，否则返回2  这里的空指的是否为null值
select  ifnull('','not');

#case when then else end
#查询员工姓名和工作地址（如果为北京或者上海，为一线，其余为二线）
select
    emp.name,case
    emp.workaddress when'北京' then '一线城市' when '上海' then '一线城市' else '二线城市' end
from emp;




-- 案例: 统计班级各个学员的成绩，展示的规则如下：
-- >= 85，展示优秀
-- >= 60，展示及格
-- 否则，展示不及格

create table score(
    id int comment 'ID',
    name varchar(20) comment '姓名',
    math int comment '数学',
    english int comment '英语',
    chinese int comment '语文'
) comment '学员成绩表';
insert into score(id, name, math, english, chinese) VALUES (1, 'Tom', 67, 88, 95 ), (2, 'Rose' , 23, 66, 90),(3, 'Jack', 56, 98, 76);

select id ,name,
    (case  when  math>=85 then '优秀' when math>=60 then '及格' else '不及格' end)'数学',
    (case  when  english>=85 then '优秀' when english>=60 then '及格' else '不及格' end)'英语',
    (case  when  chinese>=85 then '优秀' when chinese>=60 then '及格' else '不及格' end)'语文'
from score;