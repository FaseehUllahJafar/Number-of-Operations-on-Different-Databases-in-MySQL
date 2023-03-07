use Lab
go

create table [User](
[userId] int primary key,
[name] varchar(20) not null,
[phoneNum] varchar(15) not null,
[city] varchar(20) not null
)
go

create table CardType(
[cardTypeID] int primary key,
[name] varchar(15),
[description] varchar(40) null
)
go
create Table [Card](
cardNum Varchar(20) primary key,
cardTypeID int foreign key references  CardType([cardTypeID]),
PIN varchar(4) not null,
[expireDate] date not null,
balance float not null
)
go


Create table UserCard(
userID int foreign key references [User]([userId]),
cardNum varchar(20) foreign key references [Card](cardNum),
primary key(cardNum)
)
go
create table [Transaction](
transId int primary key,
transDate date not null,
cardNum varchar(20) foreign key references [Card](cardNum),
amount int not null
)


INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (1, N'Ali', N'03036067000', N'Narowal')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (2, N'Ahmed', N'03036047000', N'Lahore')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (3, N'Aqeel', N'03036063000', N'Karachi')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (4, N'Usman', N'03036062000', N'Sialkot')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (5, N'Hafeez', N'03036061000', N'Lahore')
GO


INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (1, N'Debit', N'Spend Now, Pay Now')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (2, N'Credit', N'Spend Now, Pay later')
GO

INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1234', 1, N'1770', CAST(N'2022-07-01' AS Date), 43025.31)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1235', 1, N'9234', CAST(N'2020-03-02' AS Date), 14425.62)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1236', 1, N'1234', CAST(N'2019-02-06' AS Date), 34325.52)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1237', 2, N'1200', CAST(N'2021-02-05' AS Date), 24325.3)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1238', 2, N'9004', CAST(N'2020-09-02' AS Date), 34025.12)
GO

INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'1234')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'1235')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (2, N'1236')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (3, N'1238')
GO
Insert  [dbo].[UserCard] ([userID], [cardNum]) VALUES (4, N'1237')

INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (1, CAST(N'2017-02-02' AS Date), N'1234', 500)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (2, CAST(N'2018-02-03' AS Date), N'1235', 3000)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (3, CAST(N'2020-01-06' AS Date), N'1236', 2500)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (4, CAST(N'2016-09-09' AS Date), N'1238', 2000)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (5, CAST(N'2020-02-10' AS Date), N'1234', 6000)
GO


Select * from [User]
Select * from UserCard
Select * from [Card]
Select * from CardType
Select * from [Transaction]

--Task1
Create View UserDetails
As 
select * from [User]

select* from UserDetails
--Task2
create View AtmUsers
as
select [name],phoneNum,city,cardNum from [User] u
join UserCard c on u.userid=c.userId

select * from AtmUsers

--Task3
drop procedure NameDetail

Create procedure NameDetail
@userName varchar(20)
as 
Begin
select * from [User] where [name]=@userName
end

Execute NameDetail @userName='Ahmed'

--Task4
drop procedure minBalance

Create procedure minBalance
@minBal float output
as
Begin
set @minBal=(select min(balance) from [Card])
End


Declare @min float
Execute minBalance @minBal=@min output
select @min as Minimum

--Task5
drop Procedure NoOfCards

create Procedure NoOfCards
@userName varchar (20),
@userID int,
@num int output
as
Begin
set @num = (
select count(*) from UserCard where userId=@userID)
End


Declare @number int 
Execute NoOfCards
@userName='Ali',
@userID=1,
@num=@number output

select @number as NumberOfCards

--Task6
drop Procedure [Login]

create procedure [Login]
@cardNumber varchar(20),
@cardPin varchar(4),
@status int output
as
begin
declare @check int
set @check=
(select count(*) from [Card] where cardNum=@cardNumber and PIN=@cardPin)
	if @check=0
		begin
		set @status=0
		end
	else
		begin
		set @status=1
		end
end


Declare @s int
Execute [Login]
@cardNumber=1234,
@cardPin=1770,
@status=@s output

Select @s as [Status]

--Task7
drop Procedure UpdatePin

create Procedure UpdatePin
@cardNumber varchar(20),
@oldPin varchar(4),
@NewPin varchar(10),
@output varchar(20) output
as
begin
declare @comp int
set @comp=(select COUNT(*) from [Card] where cardNum=@cardNumber and PIN=@oldPin)
	if @comp=0 or LEN(@NewPin)>4
		begin
		set @output = 'Error'
		end
	else
		begin
		update [Card] set pin=@NewPin where cardNum=@cardNumber and PIN=@oldPin
		set @output=@NewPin
		end
end


declare @result varchar(20)
Execute UpdatePin
@cardNumber=1234,
@oldPin=1111,
@NewPin=1770,
@output=@result output

Select @result as [Output]

--Task8
drop Procedure WithDraw

create  Procedure WithDraw
@cardNum varchar(20),
@Pin varchar(4),
@ammount int,
@transType int output
as
begin
declare @check int
Declare @s int
Execute [Login]
@cardNumber=@cardNum,
@cardPin=@Pin,
@status=@check output
	if @check=1
		if (select balance-@ammount from [Card] where cardNum=@cardNum)>-1	--Successful transaction
			begin
			insert into [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) 
			VALUES((select max(transId)+1 from [Transaction]), getdate(), @cardNum, @ammount)
			set @transType=1
			update [Card] set balance=(select balance from [Card] where cardNum=@cardNum)-@ammount where cardNum=@cardNum 
			end
		else --balance can become low than 0
			begin
			set @transType=4
			end
	else--cannot login
		begin
		set @transType=4
		end
end


declare @Transfer int
Execute WithDraw
@cardNum=1235,
@Pin=9234,
@ammount=100,
@transType=@Transfer output

Select @Transfer as [Output]
select * from [Card]
Select * from [Transaction]