-- Insert

use college_db;

insert into students(student_id, name , email, age, join_date , active_flag)
values (2224112711,'Hasini','hasini32@gmail.com', 21, '2021-02-02', 1),
	   (2224112712,'Haggu','haggu134@gmail.com', 19, '2021-11-17', 1),
	   (2224112713,'Renny','renny156@gmail.com', 20, '2021-09-14', 1);

insert into courses values (106, 'Internet OT',5000);

insert into enrollments(enroll_id, student_id, course_id)
values (218,2224112710, 102),
	   (219,2224112712, 106),
	   (220,2224112713, 103),
	   (221,2224112706, 106),
	   (222,2224112711, 101);

-- Select

select * from students;

select name, email from students;

select * from students order by age desc;

select top 5 * from students order by join_date;

select distinct age from students;

select distinct course_name from courses;

-- Update

update students set age=20 where student_id=2224112707;

update students set active_flag=0 where student_id= 2224112709 or name= 'Vignesh';

update courses set fees=1.1*fees where course_name='Database MS';

-- Delete

delete from students where student_id=2224112701;

delete from courses where fees<1000;

delete from enrollments where enroll_timestamp>'2026-02-03 10:41:33.480';

-- Alter

alter table students alter column name varchar(25);

exec sp_rename 'students.join_date','registration_date', 'column';

alter table students add phone_number varchar(15);