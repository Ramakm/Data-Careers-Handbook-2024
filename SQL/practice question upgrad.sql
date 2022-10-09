create table table1(
coulmn_a int,
column_b int
);

create table table2(
coulmn_a int,
column_b int
);

insert into table1 values(23,34), (23,46), (21,43),(20,34),(18,46);

insert into table2 values (23,98), (23,97), (10,30),(20,null),(21,9),(34,29);


select *
from table1, table2
where table1.coulmn_a = table2.coulmn_a;

select insert ('Mahaveer' ,3 , 4, 'Jain') ;

create table marks(
application_id int,
email_id varchar(30),
physics int,
chemestry int,
math int
);

insert into marks values(01,"x@gmail.com",30,40,50),(02,"y@gmail.com",70,80,30),(03,"z@gmail.com",50,90,40);

select * from marks;

use upgrad;
# Write your code below
 
select email_id from marks order by physics+math+chemestry desc, 
  math desc, physics desc limit 3;
  