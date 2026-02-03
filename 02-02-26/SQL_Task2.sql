use college_db;


insert into students(student_id, name , email, age, join_date , active_flag)
values (2224112701,'Harati','harati32@gmail.com', 21, '2021-02-02', 1),
	   (2224112702,'Vaishnavi','vaish12@gmail.com', 20, '2021-03-17', 0),
	   (2224112703,'Sonu','sonu87@gmail.com', 20, '2020-09-08', 1),
	   (2224112704,'Reneesh','reneesh98@gmail.com', 21, '2020-08-01', 0),
	   (2224112705,'Grishma','grishma14@gmail.com', 20, '2021-12-10', 1),
	   (2224112706,'Vignesh','vignesh90@gmail.com', 22, '2021-05-02', 1),
	   (2224112707,'Arha','arhagoud827@gmail.com', 21, '2021-06-02', 0),
	   (2224112708,'Pranay','pranay975@gmail.com', 20, '2021-04-02', 0),
	   (2224112709,'Nithin','nithinkumar@gmail.com', 19, '2020-09-22', 1),
	   (2224112710,'Sujata','sujata564@gmail.com', 23, '2020-02-17', 0);

insert into courses(course_id, course_name, fees)
values (101, 'Web Programming',2100),
	   (102, 'Cloud Computing',2500),
	   (103, 'AI',1500),
	   (104, 'Database MS',1000),
	   (105, 'Cyber Security',3500);

insert into enrollments(enroll_id, student_id, course_id)
values (202,2224112710, 102),
	   (203,2224112701, 101),
	   (204,2224112708, 103),
	   (205,2224112701, 104),
	   (206,2224112701, 105),
	   (207,2224112704, 103),
	   (208,2224112710, 105),
	   (209,2224112703, 101),
	   (210,2224112707, 104),
	   (211,2224112701, 105),
	   (212,2224112702, 103),
	   (213,2224112705, 102),
	   (214,2224112706, 104),
	   (215,2224112707, 102),
	   (216,2224112709, 102),
	   (217,2224112709, 103);

select * from enrollments;