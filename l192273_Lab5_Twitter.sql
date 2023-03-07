use Lab
go

create table Users
(
User_ID int,
UserName varchar(20) primary key,
Age int,
Country varchar(20),
privacy int
)

go

INSERT [dbo].[users] (User_ID,[UserName], [Age], [Country],privacy) VALUES (1,N'Ali123', 18, N'Pakistan',1)
INSERT [dbo].[users] (User_ID,[UserName], [Age], [Country],privacy) VALUES (2,N'Aliza', 40, N'USA',1)
INSERT [dbo].[users] (User_ID,[UserName], [Age], [Country],privacy) VALUES (3,N'Aysha', 19, N'Iran',0)
INSERT [dbo].[users] (User_ID,[UserName], [Age], [Country],privacy) VALUES (4,N'DonaldTrump', 60, N'USA',0)
INSERT [dbo].[users] (User_ID,[UserName], [Age], [Country],privacy) VALUES (5,N'ImranKhan', 55, N'Pakistan',0)
INSERT [dbo].[users] (User_ID,[UserName], [Age], [Country],privacy) VALUES (6,N'Natasha', 28, N'USA',0)
INSERT [dbo].[users] (User_ID,[UserName], [Age], [Country],privacy) VALUES (7,N'Samuel', 37, N'Australia',0)
INSERT [dbo].[users] (User_ID,[UserName], [Age], [Country],privacy) VALUES (8,N'Sara', 30, N'Iran',1)



go

create table Following
(
FollowerUserName varchar(20) Foreign key References Users(UserName) ,
FollowedUserName varchar(20) Foreign key References Users(UserName),
primary key (FollowerUserName, FollowedUserName)
)

go

INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'Ali123', N'DonaldTrump')
INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'Aliza', N'Ali123')
INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'Aliza', N'DonaldTrump')
INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'Aliza', N'ImranKhan')
INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'Aysha', N'ImranKhan')
INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'DonaldTrump', N'ImranKhan')
INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'ImranKhan', N'DonaldTrump')
INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'Natasha', N'ImranKhan')
INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'Samuel', N'DonaldTrump')
INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'Samuel', N'ImranKhan')
INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'Sara', N'DonaldTrump')
go

Create table Tweets
(
TweetID int primary key,
UserName varchar(20) Foreign key References Users(UserName),
[Text] varchar(140)
)

go

INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (1, N'Ali123', N'Pakistan’s largest-ever population #Census  starts today in 63 districts after 19 years. ')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (2, N'ImranKhan', N'Pakistan’s largest-ever population #Census  starts today in 63 districts after 19 years. ')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (3, N'Sara', N'Take the soldier who come to our door for #Census as A ThankYou from Pakistan Army for our devotion. #CensusWithSupportOfArmy')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (4, N'ImranKhan', N'Pakistan is going to experience 6th #Census 2017.')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (5, N'Sara', N'Only #census can reveal where this aunty lives ')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (6, N'ImranKhan', N'Quand tu te lèves 3h en avance (littéralement) pour la #massecritique ')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (7, N'Sara', N'Over 1 million decrypted Gmail and Yahoo accounts allegedly up for sale on the Dark Web https://geekz0ne.fr/shaarli/?wQRSoQ  #piratage')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (8, N'Sara', N'Harry pot-head and the Sorcerer''s stoned')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (9, N'DonaldTrump', N'LSDespicable Me  #DrugMovies')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (10, N'ImranKhan', N'Forrest Bump #DrugMovies @midnight')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (12, N'DonaldTrump', N'Quand tu te lèves 3h en avance (littéralement) pour la #massecritique ')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (13, N'Sara', N'#DrugMovies')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (14, N'DonaldTrump', N'Quand tu te lèves 3h en avance (littéralement) pour la #massecritique ')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (15, N'Aliza', N'Quand tu te lèves 3h en avance (littéralement) pour la #massecritique ')

go

Create table Likes
(
TweetID int Foreign key References Tweets(TweetID),
LikeByUserName varchar(20) Foreign key References Users(UserName),
LikeOnDate date
primary key (TweetID ,LikeByUserName)
)

GO
INSERT [dbo].[Likes] ([TweetID], [LikeByUserName], [LikeOnDate]) VALUES (1, N'Aliza', CAST(0x693C0B00 AS Date))
INSERT [dbo].[Likes] ([TweetID], [LikeByUserName], [LikeOnDate]) VALUES (2, N'Aliza', CAST(0x693C0B00 AS Date))
go

Create table Interests
(
InterestID int primary key,
[Description] varchar(30)
)

GO
INSERT [dbo].[Interests] ([InterestID], [Description]) VALUES (10, N'Politics')
INSERT [dbo].[Interests] ([InterestID], [Description]) VALUES (11, N'Sports')
INSERT [dbo].[Interests] ([InterestID], [Description]) VALUES (12, N'Movies')
INSERT [dbo].[Interests] ([InterestID], [Description]) VALUES (13, N'Education')
INSERT [dbo].[Interests] ([InterestID], [Description]) VALUES (14, N'Video Games')

go

create table UserInterests
(UserName varchar(20)  Foreign key References Users(UserName),
InterestID int Foreign key References Interests(InterestID)
primary key (UserName, InterestID)
 )
 
 GO
INSERT [dbo].[UserInterests] ([UserName], [InterestID]) VALUES (N'Ali123', 10)
INSERT [dbo].[UserInterests] ([UserName], [InterestID]) VALUES (N'Ali123', 11)
INSERT [dbo].[UserInterests] ([UserName], [InterestID]) VALUES (N'Ali123', 13)
INSERT [dbo].[UserInterests] ([UserName], [InterestID]) VALUES (N'Ali123', 14)
INSERT [dbo].[UserInterests] ([UserName], [InterestID]) VALUES (N'Aliza', 10)
INSERT [dbo].[UserInterests] ([UserName], [InterestID]) VALUES (N'Aliza', 11)
INSERT [dbo].[UserInterests] ([UserName], [InterestID]) VALUES (N'Aliza', 13)
INSERT [dbo].[UserInterests] ([UserName], [InterestID]) VALUES (N'Aliza', 14)
INSERT [dbo].[UserInterests] ([UserName], [InterestID]) VALUES (N'ImranKhan', 10)
 
 go

 Create table Hashtags
 (HashtagID int primary key,
 Hashtag varchar(30))
 
 GO
INSERT [dbo].[Hashtags] ([HashtagID], [Hashtag]) VALUES (1, N'#Census')
INSERT [dbo].[Hashtags] ([HashtagID], [Hashtag]) VALUES (2, N'#ClassiqueMatin')
INSERT [dbo].[Hashtags] ([HashtagID], [Hashtag]) VALUES (3, N'#MasseCritique')
INSERT [dbo].[Hashtags] ([HashtagID], [Hashtag]) VALUES (4, N'#piratage')
INSERT [dbo].[Hashtags] ([HashtagID], [Hashtag]) VALUES (5, N'#DrugMovies')

GO

Select * from Following
Select * from Hashtags
Select * from Interests
Select * from Tweets
Select * from UserInterests
Select * from Users

--Task1
select FollowedUserName,Count(FollowedUserName) as Followers from [Following] group by FollowedUserName having Count(FollowedUserName) =(
select max(myCount) from (select FollowedUserName,count(FollowerUserName) myCount from [Following] group by FollowedUserName)[Following]) 

--Task2
select top 1 FollowedUserName,Count(FollowedUserName) as Followers from [Following] group by FollowedUserName having Count(FollowedUserName) <(
select max(myCount) from (select FollowedUserName,count(FollowerUserName) myCount from [Following] group by FollowedUserName)[Following]) 

--Task3
select UserName from Users where UserName <> all
(select UserName from Tweets)

--Task4
select username,Hashtag,count(Hashtag) as NumberOfHastags from Tweets 
join Hashtags on Tweets.Text
like CONCAT('%',Hashtag,'%') group by Hashtag, UserName

--Task5
select * from Users where UserName in(
select UserName from Tweets where [Text] not Like '%#Census%')

--Task6
select UserName from Users except select FollowedUserName from Following

--Task7
select UserName from Users where not exists
(select Following.FollowedUserName from Following where Users.UserName=FollowedUserName)

--Task8
--Most Common
select [Description] from Interests where InterestID =(
select top 1 InterestID from UserInterests group by InterestID order by count(InterestID) desc)

--Least Common
select [Description] from Interests where InterestID =(
select top 1 InterestID from UserInterests group by InterestID order by count(InterestID) asc)

--Task9
select Country,count(Country) as tweets_per_country from Tweets
join Users on Users.UserName=Tweets.UserName 
group by Country order by Country desc

--Task10
Select UserName,COUNT(userName) myCount from Tweets group by UserName having COUNT(userName) > (
select avg(myCount) from (Select COUNT(userName) myCount from Tweets group by UserName) Tweets)

--Task11
select Distinct FollowedUserName from [Following] where FollowerUserName in(
select userName from [Users] where userName in(
select FollowerUserName from [Following]) and Country='Pakistan')