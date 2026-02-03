-- Where

select * from students where age>21;

select * from students where active_flag=1;

select * from courses where fees between 1000 and 5000;

select * from students where age in(20,22,25);



-- And/Or

select * from students where age>20 and active_flag=1;

select * from students where age<20 or active_flag=0;

select * from courses where fees>2000 and course_name like '%Data%';

-- Like pattern

select email from students where email like '%gmail.com';

select course_name from courses where course_name like 'Data%'; 

select * from courses where course_name like '%C%';

--Null checks

insert into students values(2224112701,'Harati','harati32@gmail.com', null, '2021-02-02', 1, 7017268737);

select * from students where age is null;

select * from students where age is not null;



