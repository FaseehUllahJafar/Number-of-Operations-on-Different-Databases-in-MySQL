use l192273_Lab_Final


create table Person(
PersonID int primary key,
LastName varchar(20),
FirstName varchar(20),
DateofBirtth date,
DateOfDeath date,
Gender char,
Assets int
);

create table MaritalStatus(
PersonID int, --primary key,
MaritalStatusFromDate date,
MaritalStatusDescription varchar(100),
MaritalStatusToDate date

FOREIGN KEY (PersonID) REFERENCES Person (PersonID) ON DELETE CASCADE ON UPDATE CASCADE
);

create table PersonRelationship(
PersonID1 int, 
PersonID2 int,
PersonRelationshipFromDate date,
PersonRelationshipToDate date,
RelationShipDescription varchar(100),

FOREIGN KEY (PersonID1) REFERENCES Person (PersonID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (PersonID2) REFERENCES Person (PersonID) ON DELETE CASCADE ON UPDATE CASCADE,

--primary key(PersonID1,PersonID2)
);

create table Activity(
PersonID1 int,
PersonID2 int,
ActivityID int primary key,
AtivityTypeCode varchar(50),
Ammount int,

FOREIGN KEY (PersonID1) REFERENCES Person (PersonID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (PersonID2) REFERENCES Person (PersonID) ON DELETE CASCADE ON UPDATE CASCADE
);

alter table Person add constraint Assets DEFAULT 0;

alter table MaritalStatus add constraint MaritalStausDescription DEFAULT 'Single';

alter table PersonRelationship alter column PersonRelationshipFromDate date Not Null;

alter table Activity add constraint Ammount check(Ammount > 0);

alter table PersonRelationShip add constraint PersonID1PersonID2 check(PersonID1!=PersonID2);

alter table PersonRelationShip add PersonRelationShipID int not null primary key;

alter table MaritalStatus add FOREIGN KEY (PersonID) REFERENCES Person (PersonID) ON DELETE CASCADE ON UPDATE CASCADE;

alter table Activity add FOREIGN KEY (PersonID1) REFERENCES Person (PersonID) ON DELETE no Action ON UPDATE CASCADE;

