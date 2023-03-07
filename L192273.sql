--create database l192273_final
--use l192273_final

--create database final
--use final

go
create table Department(
Dept_No int primary key,
Dept_Name varchar(20) not null,
[Location] varchar(20) not null
)

go

create table Employee(
Emp_No int primary key,
Emp_Name varchar(20) not null,
city varchar(20) not null,
Dept_No int foreign key references Department(Dept_No),
Manager int foreign key references Employee(Emp_No) default NULL
)

go
create table Designation(
id int primary key,
Des_Name varchar (30)
)

go
create Table Salary(
Emp_ID int foreign key references Employee(Emp_No),
salary float not null,
joining_Date date not null,
Designation int foreign key references Designation(id) not null,
primary key( Emp_ID)
)

go
create table Project_Type(
[type_id] int primary key,
[type_name] varchar(30) not null
)

go
create table Projects(
pro_id int primary key,
dept_id int foreign key references Department(Dept_No),
pro_Type int foreign key references Project_Type([type_id]),
pro_Name varchar(50) not null,
details varchar(100) not null,
)

go
create table Employee_Project(
Emp_No int foreign key references Employee(Emp_No),
Pro_id int foreign key references projects(pro_id),
primary key(Emp_No,Pro_id)
)

go

insert into Department values(1,'CS','East'),
(2,'Electrical Eng','West'),
(3,'Civil','East/west'),
(4,'Urdu','Mid East'),
(5,'Mechanical Engr','South'),
(6,'Arabic','North')

go

insert into Employee values(1,'Ahmad','Narowal',1,NULL),
(11,'Gul Khan','Rawalpindi',3,NULL),
(4,'Nargas','Kasuar',2,NULL),
(8,'Imran','Lahore',4,NULL),

(2,'Ali','Lahore',1,1),
(3,'Furqan','Sialkot',1,1),

(5,'Alisha','Jhang',2,4),
(6,'Sana','D.G.Khan',2,4),
(7,'Akbar','Sahiwal',2,4),

(9,'Faisal','Islamabad',4,8),
(10,'Zain','Attock',4,8),

(12,'kamran','Narowal',3,11),
(13,'Abu Bakr','Karachi',3,11),
(14,'Ramzan','Peshawar',1,1)

go

insert into Designation values(1,'Professor'),
(2,'Assistant Prof.'),
(3,'Associate Prof.'),
(4,'Lecturer'),
(5,'Instructor'),
(6,'R/O')

go

insert into Salary values(1,64350,'2000-07-05',6),
(2,67000,'2005-03-01',5),
(3,120000,'2002-07-05',4),
(4,232850,'2008-01-05',1),
(5,35000,'2009-07-01',6),
(6,36500,'2007-09-02',6),
(7,145000,'2011-08-05',1),
(8,50000,'2001-07-05',6),
(9,21500,'1999-07-05',1),
(10,120000,'1999-07-05',4),
(11,120050,'2003-01-05',3),
(12,135000,'1999-08-09',2),
(13,92000,'1998-07-05',6),
(14,140000,'2004-09-05',2)

go

insert into Project_Type values(1,'DataMining'),
(2,'Artificial Intelligence'),
(3,'CloudComputing'),
(4,'Software Engineering'),
(5,'Computer vision'),
(6,'Mobile Computing'),
(7,'HCI')

go

insert into projects values(1,1,2,'Smart Recognition', 'Find the bones length and detect the person'),
(2,1,6,'Super CPU Mobile', 'Find the ways to utilize the CPU 99%'),
(3,2,2,'3D Printing', 'Print small the in 3D'),
(4,1,3,'Information Retrievel', 'Find the ways to retrieve data using optimal search algo'),
(5,1,1,'Data Mining', 'Generate new information fron raw data'),
(6,2,2,'Robo Servent', 'A robot can help people in daily tasks'),
(7,1,2,'Mobo Mechanics', 'Tell the problems and solutions in the car')

go
insert into Employee_Project values(1,2),
(1,4),
(1,3),
(3,4),
(12,2),
(4,1),
(5,2),
(9,3),
(6,6),
(1,7),
(7,2),
(14,7),
(14,5),
(10,6)

go
select * from Department
select * from Employee
select * from Salary
select * from Designation
select * from Project_Type
select * from projects
select * from Employee_Project
go

-----------------------------------------------
-----------------------------------
----------------------------------
-------Q1

--Task 1
create trigger insertEmployee
on Employee
instead of insert
as
	declare @emp_num int
	declare @m_num int

	set @emp_num = (select max(Emp_No) from Employee)

	set	@m_num = (select top 1 manager,count(*) as Ecount from employee group by Manager order by count(*)desc)

	
	
	insert into Employee (Emp_no,Manager) values(@emp_num,@m_num)

end


--Task 2
drop procedure UDF
create procedure UDF
@dept_id int,
@Proj_id int output
as 
begin
	set @Proj_id = (select max(numOfEmp) from Employee_Project where numOfEmp in(
	select count(*) as numOfEmp from Employee_Project where Pro_id in(
	select pro_id from Employee_Project where emp_no in( 
	select emp_no from Employee where dept_No = @dept_id))))
end

declare @id int
Execute UDF
@dept_id = 2,
@Proj_id=@id output

select @id


--Task 3
create procedure InsertEmp
@emp_name varchar(15),
@city  varchar(7) ,
@dept_no int , 
@Salary int,
@designation int
as
begin
	insert into Employee values (Null,@emp_name,@city,@dept_no,NULL)
	
	declare @id int
	Execute UDF
	@dept_id = 2,
	@Proj_id=@id output
	
	declare @emp_no int
	set @emp_no=(select emp_no from employee where emp_name=@emp_name) 

	insert into Employee_Project values(@emp_no,@id)

	declare @date date
	set @date = curdate 
	insert into salary values (@emp_no,@Salary,@date,@designation)
end

Execute InsertEmp
@emp_name = 'faseeh',
@city='lhr',
@dept_no='2',
@Salary='11',
@designation='1'



-----------------------------------------------
-----------------------------------
----------------------------------
-------Q2

create trigger ManagerUpdate
on Employee
after update
as
begin tran
	declare @count int
	set @count = (select count(*) 
	from Salary e 
	where e.emp_id = (select (select manager from employee where emp_id=e.emp_no) from Salary m 
	where e.joining_Date < m.joining_Date and m.dept_no=e.dept_no))

	if(@count>0)
		begin
		print('manager should be senior person or same department')
		rollback
		end

	else 
	begin
		print('updated successfully')
	end

end



-----------------------------------------------
-----------------------------------
----------------------------------
-------Q3

--Task 1
select e.emp_id,(select emp_Name from employee where emp_no=e.emp_id),e.joining_date,m.emp_id,(select emp_Name from employee where emp_no=m.emp_id),m.joining_date,m.dept_name 
from Salary e 
where e.emp_id = (select (select manager from employee where emp_id=e.emp_no) from Salary m 
where e.joining_Date > m.joining_Date)



--Task 2

select emp_name,(select dept_name from Department d where dept_no=d.dep_no) from  employee where emp_no =(
select top 1 emp_id from salary order by joining_date desc)


--Task 3
create procedure number
@number int,
@emp_no int output,
@emp_name varchar(20) output,
@high int output
as
begin
	set @high=(select top (@number) emp_id from salary)
	set @emp_no=(select emp_id from salary where salary=@high)
	set @emp_name=(select emp_name from employee where @emp_no=emp_id)
end

declare @emp_id int
declare @emp_nam varchar(20)
declare @highest int
Execute number
@number = 5,
@emp_no=@emp_id output,
@emp_name=@emp_nam output,
@high=@highest output





-----------------------------------------------
-----------------------------------
----------------------------------
-------Q4

create view detail
as
select emp_no,emp_name,(select designamtion,joining_date,salary
 from salary 
where emp_id=emp_no) where emp_no = (
select manager,count(*) as num from employee 
group by manager
 having count(*)>0)




