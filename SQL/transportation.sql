
use demonstration;

select * FROM demonstration.transportation;

--- Update Command

update transportation set toll_required = 5 where ship = "Jeep";

select * from transportation;

--- DELETE Command

delete from transportation where vehicle = "Jeep";

select * from transportation;

--- DDL Query for new column add

alter table transportation add column Vehicle_number varchar(30);

desc transportation;

update transportation set Vehicle_number = "MH-02-56984" where  ship = "DELIVERY TRUCK";

select * from transportation;