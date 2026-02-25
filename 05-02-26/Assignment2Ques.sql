select * from customers;
select * from orders;
select * from products;

select o.cust_id, avgerTable.average
from orders as o
join 
(select o.cust_id,avg(amount) as average from orders as o join customers as c on c.cust_id = o.cust_id group by o.cust_id) avgerTable
on o.cust_id = avgerTable.cust_id where avgerTable.average < o.amount;

select * from customers where not exists (select cust_id from orders where customers.cust_id= orders.cust_id);

select p.product_name, sum(o.amount) as Total_sum, count(o.order_id) as Total_count,
case 
when p.product_name like '%r'
then 'furniture'
when p.product_name like '%s'
then 'books'
else 'other'
end as category
from products as p
left join 
orders as o
on p.product_id = p.product_id
where o.order_id in (select o.order_id from orders as o right join customers as c 
on o.cust_id = c.cust_id)
group by p.product_name
having count(o.order_id) > 1;

---Fetch employees who earn more than their manager
 
select * from employee;
select e.emp_name
from employee as e
join employee as m
on e.manager_id = m.empid
where e.salary > m.salary;

---Display customers with orders, but exclude customers whose every order value is below 1000.
select * from customers;
select * from orders;

select c.*
from customers as c
join orders as o
on c.cust_id = o.cust_id
where o.amount > 1000;

---Show customers who placed orders in every year present in the orders table.

select c.*
from customers as c
join orders as o
on c.cust_id = o.cust_id
where exists (select order_date from orders);
 