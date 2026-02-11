use college_db;

--creating tables

create table customers(
			cust_id int primary key,
			cust_name varchar(25) not null,
			email varchar(30) unique,
			phone bigint,
			city varchar(20),
			created_at date default getdate());

create table orders(
			order_id int primary key,
			cust_id int,
			order_date date default getdate(),
			amount int,
			constraint custidcon foreign key (cust_id) references customers (cust_id));

create table products(
			product_id int primary key,
			cust_id int,
			order_id int,
			product_name varchar(25) not null,
			constraint custidcon1 foreign key (cust_id) references customers (cust_id),
			constraint orderidcon foreign key (order_id) references orders (order_id));

create table employee(
			empid int primary key,
			emp_name varchar(25) not null,
			email varchar(30) unique,
			salary int,
			role varchar(25),
			deptid int,
			manager_id int ,
			mentor varchar(25),
			constraint deptidcon foreign key (deptid) references department(deptid));

create table department(
			deptid int primary key,
			deptname varchar(25) not null,
			location varchar(20));

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


use college_db;

--inserting vaues into tables

select * from customers;
insert into customers(cust_id, cust_name, email, phone, city) 
values(501, 'Harati', 'harati@gmail.com', 1098276534, 'Hyderabad'),
	  (502, 'Sanjana', 'sanjana@gmail.com', 9872340534, 'Chennai'),
	  (503, 'Srinivas', 'srinivas@gmail.com', 8846389209, 'Kolkata'),
	  (504, 'Hriday', 'hriday@gmail.com', 9867345209, 'Chennai'),
	  (505, 'Reneesh', 'reneesh@gmail.com', 7609835267, 'Hyderabad');	

insert into orders(order_id, cust_id, amount)
values(991, 504, 3000),
	  (992, 501, 8000),
	  (993, 505, 2500),
	  (994, 503, 5500),
	  (995, 502, 4500);

insert into products(product_id, cust_id, order_id, product_name)
values(1001, 501, 992, 'Lights'),
	  (1002, 502, 995, 'Ventilator'),
	  (1003, 505, 993, 'Air conditioner'),
	  (1004, 503, 994, 'Wheel chair');




insert into employee(empid, emp_name, email, salary, role, deptid, manager_id, mentor)
values(240, 'Harati', 'harati@outlook.com', 4000, 'Developer',173, 2001, 'Harsha'),
	  (241, 'Krishna', 'krishna@outlook.com', 3500, 'Analyst',174, 2001, 'Rohit'),
	  (242, 'Shruti', 'shruti@outlook.com', 3500, 'Developer',173, 2001, 'Harsha'),
	  (243, 'Reneesh', 'reneesh@outlook.com', 5000, 'BA',175, 2001, 'Vignesh'),
	  (244, 'Grishma', 'grishma@outlook.com', 4500, 'QA',174, 2001, 'Rohit');

insert into department(deptid, deptname, location)
values(172, 'Human Resources', 'Chennai'),
	  (173, 'IT', 'Hyderabad'),
	  (174, 'Operations', 'Chennai'),
	  (175, 'Marketing', 'Chennai'),
	  (176, 'Sales', 'Hyderabad');


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

select * from orders;
select * from customers;
select * from products;
select * from employee;
select * from department;
select * from students;
select * from courses;
select * from enrollments;

--INNER JOIN Tasks
/*
Customers with their orders
Orders with customer name and city
Employees with departments
Orders with products (3-table join)
Select multiple columns from joined tables
Filter joined rows using WHERE amount > X
Filter joined rows using LIKE pattern
*/


select o.cust_id, c.cust_name, o.order_id  
from orders as o 
inner join customers as c 
on o.cust_id = c.cust_id;


select o.order_id, c.cust_name, c.city  
from orders as o 
inner join customers as c 
on o.cust_id = c.cust_id;


select e.empid, e.emp_name, d.deptid, d.deptname 
from employee as e 
inner join department as d 
on e.deptid = d.deptid;


select c.cust_name, o.order_id, p.product_name
from products as p 
join orders as o on p.order_id = o.order_id
join customers as c on c.cust_id= p.cust_id;

select s.student_id, s.name, e.enroll_id 
from students as s 
inner join enrollments as e 
on s.student_id = e.student_id;


select o.cust_id, c.cust_name, o.order_id, o.amount  
from orders as o 
inner join customers as c 
on o.cust_id = c.cust_id 
where amount > 4000;



select o.cust_id, p.product_name, o.order_id  
from orders as o 
inner join products as p 
on o.order_id = p.order_id 
where p.product_name like '%r';


--LEFT JOIN Tasks
/* 
All customers with orders including NULLs
Customers without orders
All departments with employees
Departments without employees
Products not ordered
LEFT JOIN with WHERE filter
LEFT JOIN with LIKE filter
*/

insert into customers(cust_id, cust_name, email, phone, city) 
values(506, 'Vaishu', 'vaishu@gmail.com', 7653498776, 'Hyderabad'),
	  (507, 'Haggu', 'haggu@gmail.com', 8907340534, 'Chennai');

select c.cust_id, c.cust_name, o.order_id 
from customers as c 
left join orders as o 
on c.cust_id= o.cust_id; 


select c.cust_id, c.cust_name, o.order_id 
from customers as c 
left join orders as o 
on c.cust_id= o.cust_id 
where o.order_id is not null; 



select d.deptname, e.emp_name 
from department as d 
left join employee as e 
on d.deptid= e.deptid; 


insert into products(product_id, product_name)
values(1005, 'LED'),
	  (1006, 'Books'),
	  (1007, 'Desks');


select p.product_id , p.product_name 
from products as p 
left join orders as o 
on p.order_id = o.order_id 
where p.order_id is null; 



select o.cust_id, p.product_name 
from orders as o 
left join products as p 
on o.order_id = p.order_id 
where p.product_name is null ;


select s.name, e.enroll_id 
from students as s 
left join enrollments as e 
on s.student_id = e.student_id 
where s.name like 'H%' or s.name like '%h';


---RIGHT JOIN Tasks
/*
All orders with customer info
Orders without matching customers
All departments even if empty
RIGHT JOIN with WHERE condition
RIGHT JOIN with COUNT per parent
*/


select o.*, c.cust_name, c.email, c.phone
from customers as c
right join orders as o
on c.cust_id = o.cust_id;

select o.*, c.cust_name, c.email, c.phone
from customers as c
right join orders as o
on c.cust_id = o.cust_id
where o.cust_id is null;

insert into employee values(2001,'Deepak', 'deepak@gmail.com',10000, 'Manager',null, null, null);
insert into employee values(2002,'Rajashekar', 'rajashekar@gmail.com',10000, 'Manager',null, null, null);

select d.*
from employee as e
right join department as d
on e.deptid = d.deptid;

select e.*
from department as d
right join employee as e
on e.deptid = d.deptid
where manager_id is null;

select d.deptname, count(empid)
from employee as e
right join department as d
on e.deptid = d.deptid
group by d.deptname;



---FULL OUTER JOIN Tasks (UNION Method)
/*Combine all customers and orders
Show matched and unmatched rows
Employees + departments full list
Write FULL JOIN using LEFT + RIGHT + UNION
*/


select o.cust_id
from orders as o 
union 
select c.cust_id
from customers as c ;

select *
from customers as c 
left join orders as o 
on c.cust_id= o.cust_id
union 
select *
from customers as c 
right join orders as o 
on c.cust_id= o.cust_id;

select *
from customers as c 
left join orders as o 
on c.cust_id!= o.cust_id
union 
select *
from customers as c 
right join orders as o 
on c.cust_id!= o.cust_id; 

select *
from employee as e 
left join department as d 
on e.deptid = d.deptid
union 
select *
from employee as e 
right join department as d 
on e.deptid = d.deptid; 

select *
from students as s 
left join enrollments as e 
on s.student_id= e.student_id
union 
select *
from students as s 
right join enrollments as e 
on s.student_id= e.student_id; 


---🔹 SELF JOIN Tasks
/*
Employee with manager name
Employees under same manager
List only managers
Employee–mentor mapping
Show reporting hierarchy pairs
*/

select e1.emp_name, e2.emp_name as manager
from employee as e1 
join employee as e2
on e1.manager_id = e2.empid; 

update employee set manager_id = 2002 where empid in (240, 243, 244);

select e1.emp_name, e2.emp_name as manager
from employee as e1 
join employee as e2
on e1.manager_id = e2.empid
where e1.manager_id = 2002;

select e.emp_name as manager_name
from employee as e 
where e.role= 'manager';

insert into employee values(245, 'Harsha', 'harsha@outlook.com',6000, 'Mentor', 173, 2002, null );
insert into employee values(246, 'Rohit', 'rohit@outlook.com',6000, 'Mentor', 173, 2001, null );

select e1.emp_name, e2.mentor 
from employee as e1 
join employee as e2
on e1.empid = e2.empid;



---CROSS JOIN Tasks
/*
All customer–product combinations
All employee–role combinations
Generate all pair combinations from two tables
*/

select *
from customers as c 
cross join products as p;


select e1.emp_name, e2.role
from employee as e1 
cross join employee as e2;


select *
from students as s
cross join enrollments as e;



---Multi-Table JOIN Tasks
/*
customers + orders + order_items
orders + products + suppliers
employees + departments + locations
Build full order report (4 tables)
Select columns from all joined tables
*/

select c.cust_name, o.order_id, p.product_name
from products as p 
join orders as o on p.order_id = o.order_id
join customers as c on c.cust_id= p.cust_id;

select o.order_id, p.product_name
from orders as o
join 
products as p
on p.order_id = o.order_id;

select e.emp_name, d.deptname, d.location
from employee as e
join 
department as d
on d.deptid = e.deptid;


---🔹 JOIN + GROUP BY Tasks
/*
Order count per customer
Total order amount per customer
Employee count per department
Product order count
Department salary total
*/

select  c.cust_name, count(o.cust_id)
from customers as c
join orders as o
on c.cust_id= o.cust_id
group by c.cust_name;

select  c.cust_name, sum(o.amount)
from customers as c
join orders as o
on c.cust_id= o.cust_id
group by c.cust_name;

select  d.deptname, count(e.empid)
from employee as e
join  department as d
on e.deptid = d.deptid
group by d.deptname;

select p.product_name, count(o.order_id) as total_orders
from products as p
join  orders as o
on p.order_id = o.order_id
group by p.product_name;


select  d.deptname, sum(e.salary)
from department as d
join  employee as e
on d.deptid = e.deptid
group by d.deptname;

---🔹 JOIN + HAVING Tasks
/*
Customers with more than 3 orders
Departments with more than 5 employees
Products ordered more than 10 times
Customers with total order value > X
*/

select c.cust_name, count(o.order_id)
from customers as c
join orders as o
on c.cust_id= o.cust_id
group by c.cust_name;


select  d.deptname, count(e.empid)
from department as d
join  employee as e
on d.deptid = e.deptid
group by d.deptname
having count(e.empid) > 3;

select p.product_name, count(o.order_id) as total_orders
from products as p
join  orders as o
on p.order_id = o.order_id
group by p.product_name
having count(o.order_id) > 1;

select  c.cust_name, count(o.cust_id)
from customers as c
join orders as o
on c.cust_id= o.cust_id
group by c.cust_name
having count(o.cust_id) > 2;


---JOIN + COUNT Tasks
/*
Count orders per customer
Count employees per department
Count products per category
Count orders per city
*/


select c.cust_name, count(o.order_id)
from customers as c
join orders as o
on c.cust_id= o.cust_id
group by c.cust_name;


select  d.deptname, count(e.empid)
from department as d
join  employee as e
on d.deptid = e.deptid
group by d.deptname;


select c.city, count(o.order_id) as employees
from customers as c
join orders as o
on c.cust_id= o.cust_id
group by c.city;


---JOIN + WHERE Tasks
/*
Orders after certain date with customer data
Employees in specific department
Customers from specific city with orders
Products above certain price in orders
*/

select c.cust_name, o.order_id, o.order_date
from customers as c
join orders as o
on c.cust_id= o.cust_id
where o.order_date < '2026-02-09';


select  d.deptname, e.emp_name
from department as d
join  employee as e
on d.deptid = e.deptid
where d.deptname = 'IT';


select c.cust_name, o.*
from customers as c
join orders as o
on c.cust_id= o.cust_id
where c.city = 'Chennai';


select p.product_name, o.amount
from products as p
join  orders as o
on p.order_id = o.order_id
where o.amount > 3000;


---🔹 JOIN + LIKE Tasks
/*
Customers starting with ‘A’ with orders
Employees name LIKE pattern + department
Products LIKE filter with order data
*/

select c.cust_name, o.*
from customers as c
join orders as o
on c.cust_id= o.cust_id
where c.cust_name like 'h%';

select  d.*, e.emp_name
from department as d
join  employee as e
on d.deptid = e.deptid
where e.emp_name like '%i';

select p.product_name, o.amount
from products as p
join  orders as o
on p.order_id = o.order_id
where p.product_name like '%r';


---🔹 JOIN + Constraints Tasks
/*
Create FK and test join results
Insert child without parent → test error
Use UNIQUE column in join lookup
Use NOT NULL join columns
Test join behavior with constraint failures
*/

create table orders(
			order_id int primary key,
			cust_id int,
			order_date date default getdate(),
			amount int,
			constraint custidcon foreign key (cust_id) references customers (cust_id));

select * 
from orders as o 
join customers as c
on o.cust_id = c.cust_id;

insert into orders values(981, 508 , '2026-01-01',5000);

select  d.*, e.emp_name
from department as d
join  employee as e
on d.deptid = e.deptid
where d.deptname is null;

---🔹 JOIN + Subquery Tasks (IN / NOT IN / EXISTS / NOT EXISTS)
/*
Customers whose id IN (select customer_id from orders)
Customers whose id NOT IN (select customer_id from orders)
Products NOT IN ordered products list
Employees NOT IN departments table
Orders where amount > (subquery average amount)
Customers who placed orders above average order value
Employees earning more than department average (subquery + join)
Departments IN list of active departments (subquery)
Customers NOT IN cancelled orders list
Use subquery inside JOIN condition
Use subquery as derived table and join it
Use EXISTS to find customers with orders
Use NOT EXISTS to find customers without orders
Use correlated subquery with join
Join with subquery that returns aggregated data
*/

select c.cust_name, o.*
from customers as c
join orders as o
on c.cust_id= o.cust_id
where c.cust_id in (501,502,503);

select c.cust_name, o.*
from customers as c
join orders as o
on c.cust_id= o.cust_id
where c.cust_id not in (504, 501, 507);

select p.*, o.*
from products as p
join  orders as o
on p.order_id = o.order_id
where p.product_id not in (1002, 1011, 1009);
select * from employee;

select * 
from employee 
where deptid is null;

select * 
from orders 
where amount > (select avg(amount) from orders);

select c.cust_name, o.*
from customers as c
join orders as o
on c.cust_id= o.cust_id
where c.cust_id in (select cust_id from orders where amount > (select avg(amount) from orders));


select * from employee as emp
join 
(select d.deptid, avg(salary) as avgerage from employee as e join department as d on d.deptid = e.deptid group by d.deptid) as dept
on emp.deptid = dept.deptid where emp.salary > dept.avgerage;

select  distinct d.deptname
from department as d
join  employee as e
on d.deptid = e.deptid
where d.deptname in (select deptname from department where deptid is not null);

select  d.deptname
from department as d
join  employee as e
on d.deptid = e.deptid
where exists (select d.deptname from department);

select d.deptid
from department as d
join  employee as e
on d.deptid = e.deptid
where not exists (select deptid from department where location='Banglore');

---Multi-Select JOIN Tasks
/*
Select multiple columns from joins
Use column aliases in joins
Use expressions with joins
Use CASE with joins
*/

select c.cust_name, c.city, c.email,
(select count(*) from orders as a where a.cust_id=c.cust_id) as total_orders,
(select avg(amount) from orders) as avg_amount
from customers as c
join orders as o
on c.cust_id= o.cust_id;

select c.cust_name as Customer_name, c.city as Customer_location, c.email as Customer_emailid,
(select min(amount) from orders) as min_order
from customers as c
join orders as o
on c.cust_id= o.cust_id;

select c.cust_name as Customer_name, c.city as Customer_location, c.email as Customer_emailid,
(o.amount*1.18) as Hike,
(select max(amount) from orders) as max_order
from customers as c
join orders as o
on c.cust_id= o.cust_id;


select c.cust_name, o.order_id,
case 
when o.amount > (select avg(amount) from orders)
then 'average'
when o.amount > (select avg(amount)*1.18 from orders)
then 'high'
else 'normal'
end as categoryOfAmount
from customers as c
join orders as o
on c.cust_id= o.cust_id;
