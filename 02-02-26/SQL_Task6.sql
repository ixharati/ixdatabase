-- Combined Queries

select * from students where age>20 order by age;

select * from students where name like '%a%';

select course_name from courses where fees between 2500 and 4000 order by fees;

select * from students where active_flag=0 and age is not null;

select course_id,count(course_id) as Total_courses from enrollments group by course_id having count(course_id)>1;