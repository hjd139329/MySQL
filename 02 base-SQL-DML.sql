





#添加数据，选择要添加的字段
insert into employee(id, worknu, name, gender, age, idcard, entrydate) values (1,'1','Itcast','男',10,'123456789123456789','2020-01-01');
#显示表
select * from employee;
#添加数据，全部字段都添加
insert into employee values (2,'2','张无忌','男',18,'123456789012345678','2005-01-02');
#添加多条数据
insert into employee values (3,'3','周芷若','女',18,'123456789012345679','2006-09-09'),
                            (4,'4','赵敏','女',17,'123456789012345670','2004-09-09');

#修改表内容
update employee set name = 'Itheima' where id = 1;
#按条件修改表内容
update employee set name = '小昭', gender = '女' where id = 1;
#不按条件，修改所有
update  employee set entrydate = '2008-01-01';

#按照条件删除
delete from employee where id = 1;
#不按照条件删除
delete from employee ;



