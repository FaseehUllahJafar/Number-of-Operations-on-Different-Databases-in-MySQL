drop table if exists Student
drop table if exists Attendance
drop table if exists ClassVenue
drop table if exists Teacher


--creating Tables
create table Student
(
	RollNum varchar(7) not null,
	Name varchar(25),
	Gender varchar(6),
	Phone varchar(12)
)
create table Attendance
(
	RollNum varchar(7) not null,
	Date datetime,
	Status char,
	ClassVenue int
)
create table ClassVenue
(
	ID int not null,
	Building varchar(20),
	RoomNum int,
	Teacher varchar(30)
)
create table Teacher
(
	Name varchar(30) not null,
	Designation varchar(20),
	Department varchar(20),
)


--inserting data

insert into Student
values
('L164123','Ali Ahmad','Male','0333-3333333'),
('L164124','Rafia Ahmed','Female','0333-3456789'),
('L164125','Basit Junaid','Male','0345-3243567')

insert into Attendance
values
('L164123','2-22-2016','P',2),
('L164124','2-23-2016','A',1),
('L164125','3-4-2016','P',2)

insert into ClassVenue
values
(1,'CS',2,'Sarim Baig'),
(2,'Civil',7,'Bismillah Jan')

insert into Teacher
values
('Sarim Baig','Assistant Prof.','Computer Science'),
('Bismillah Jan','Lecturer','Civil Eng.'),
('Kashif zafar','Professor','Electrical Eng.')


-- alter table commands
Alter Table Student add constraint PK_STUDENT primary key (RollNum)
Alter Table Attendance add constraint PK_ATTENDANCE primary key (RollNum)
Alter Table ClassVenue add constraint PK_CLASSVENUE primary key (ID)
Alter Table Teacher add constraint PK_TEACHER primary key (Name)


-- adding foreing key constraints
Alter Table Attendance add constraint FK_ATTENDANCE foreign key (RollNum) references
Student(RollNum) on delete Cascade on update Cascade
Alter Table Attendance add constraint FK_ATT foreign key (ClassVenue) references
ClassVenue(ID) on delete Cascade on update Cascade
Alter Table ClassVenue add constraint FK_CLASSVENUE foreign key (Teacher) references
Teacehr(Name)on delete Cascade on update Cascade

--altering stdent table
alter table Student drop column Phone
alter table Student add warningCount int


--DML actions
Add new row into Student table, values <L162334, Fozan Shahid, Male, 3.2 >
Add new row into ClassVenue table, values <3, CS, 5, Ali>
Update Teacher table Change "Kashif zafar" name to "Dr. Kashif Zafar".
Delete Student with RollNum
"L162334"

Delete Student with RollNum
"L164123"

Delete Attendance with RollNum
"L164124", if his status is absent.


--Altering tables
Alter Table Teacher add constraint UNIQUE_CONSTRAINT_Teacher_NAME Unique (Name)

alter table Student add Constraint STUDENT_CHECK_Gender
check (Gender = "Male" AND Gender = "Female")

alter table Attendance add Constraint STUDENT_CHECK_Gender
check (Status = "A" AND Status = "P")
