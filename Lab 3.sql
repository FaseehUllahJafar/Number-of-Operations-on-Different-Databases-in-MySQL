--create Database l192273_Lab3
--use l192273_Lab3 

-----------------------------------------

--drop table  salesman
--drop table customers
--drop table  orders

--create table salesman(
--salesman_id int not null primary key,
--name varchar(30),
--city varchar(30),
--commission float
--)

--create table customers(
--customer_id int not null primary key,
--cust_name varchar(30),
--city varchar(30),
--grade int,
--salesman_id int foreign key references salesman(salesman_id)
--)


--create table orders(
--ord_no int not null primary key,
--purch_amt float,
--ord_date date,
--customer_id int foreign key references customers(customer_id),
--salesman_id int foreign key references salesman(salesman_id)
--)


--insert into salesman values
--(5001,'James Hoog', 'New York', 0.15),
--(5002,'Nail Knite', 'Paris', 0.13),
--(5005,'Pit Alex', 'London' ,0.11),
--(5006,'Mc Lyon', 'Paris' ,0.14),
--(5007,'Paul Adam', 'San Jose',0.13),
--(5003,'Lauson Hen', 'San Jose',0.12);

--insert into customers values
--(3002, 'Nick Rimando' ,'New York', 100, 5001),
--(3007, 'John Brad Davis' ,'New York', 200, 5001),
--(3005 ,'Graham Zusi' ,'California', 200, 5002),
--(3008, 'Julian Green' ,'London' ,300, 5002),
--(3004, 'Fabian Johnson' ,'Paris' ,300, 5006),
--(3009, 'Geoff Cameron' ,'Berlin' ,100, 5003),
--(3003, 'Jozy Altidor' ,'Moscow' ,200,5007),
--(3001, 'John Brad Guzan', 'London' ,Null, 5005);

--insert into orders values
--(70001, 150.5, '2012-10-05', 3005, 5002),
--(70009, 270.65, '2011-09-10', 3001, 5005),
--(70002, 65.26, '2014-10-05', 3002, 5001),
--(70004, 110.5, '2011-08-17', 3009, 5003),
--(70007, 948.5, '2012-09-10', 3005, 5002),
--(70005, 2400.6, '2010-07-27', 3007, 5001),
--(70008, 5760, '2013-09-10', 3002, 5001),
--(70010, 1983.43, '2010-10-10', 3004, 5006),
--(70003, 2480.4, '2013-10-10', 3009, 5003),
--(70012, 250.45, '2010-06-27', 3008, 5002),
--(70011, 75.29, '2014-08-17', 3003, 5007),
--(70013, 3045.6, '2010-04-25', 3002, 5001);

--Task 1
--select * from customers where city='New York' order by cust_name asc

--Task 2
--select * from customers where (city='New York' or city='London' or city='Paris')  and cust_name like '%John%'

--Task 3
--select * from customers where (city='New York' or city='London')

--Task 4
--select * from orders where purch_amt>500

--Task 5
--select * from salesman where name like '_a%'

--Task 6
--select * from salesman where city='San jose'
--update salesman set commission=commission+0.5 where city='San jose'
--select * from salesman

--Task 7
--select * from orders order by ord_date asc

--Task 8
--select name as first_name from saleman where name='% '

--Task 9
