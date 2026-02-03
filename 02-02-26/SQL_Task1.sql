create database college_db;
use college_db;

create table students(student_id bigint primary key,
					  name varchar(20),
					  email varchar(25) unique,
					  age int,
					  join_date date,
					  active_flag bit default 1 );

create table courses(course_id int primary key, 
					 course_name varchar(20) not null, 
					 fees decimal(10,2));

create table enrollments(enroll_id bigint primary key,
						 student_id bigint,
						 course_id int,
						 enroll_timestamp datetime default getdate());

