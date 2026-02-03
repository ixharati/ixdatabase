-- Count

select count(student_id) as Total_students from students;

select count(active_flag) from students where active_flag = 1;

-- Sum/Avg

select sum(fees) as Total_fees from courses;

select avg(fees) as Avg_fees from courses;

select sum(fees) as Total_fees from courses where fees>2000;

--Min/Max

select min(age) from students;

select max(fees) from courses;

select max(registration_date) from students;

select min(registration_date) from students;

-- Group by

select active_flag from students group by active_flag;

select age from students group by age;

select sum(fees) as Total_fees from courses group by course_name;

-- Having 

select * from enrollments;

select course_id, count(course_id) as enrollments from enrollments group by course_id having count(course_id)>3;

select age from students group by age having avg(age)>21;

select course_id, count(course_id) as enrollments from enrollments where course_id != 102 group by course_id having count(course_id)>2 ;



