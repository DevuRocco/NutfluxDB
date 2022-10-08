-- Nutflux Project
-- 21200390
-- Devanshu Aggarwal

-- Delete Nutflux database if necessary
DROP DATABASE IF EXISTS Nutflux;

-- Create Nutflux database

CREATE DATABASE Nutflux;

-- Use Nutflux database

USE Nutflux;

-- Dropping old tables

-- DROP TABLE IF EXISTS Title_ratings;
-- DROP TABLE IF EXISTS Title_Aliases;
-- DROP TABLE IF EXISTS user_profile;
-- DROP TABLE IF EXISTS user_type;
-- DROP TABLE IF EXISTS user_info;
-- DROP TABLE IF EXISTS Episode_of_title;
-- DROP TABLE IF EXISTS T_genres;
-- DROP TABLE IF EXISTS name_works;
-- DROP TABLE IF EXISTS known_role;
-- DROP TABLE IF EXISTS famous_for;
-- DROP TABLE IF EXISTS Director_names;
-- DROP TABLE IF EXISTS Writer_names;
-- DROP TABLE IF EXISTS Production_House;
-- DROP TABLE IF EXISTS crew_details;
-- DROP TABLE IF EXISTS Names_Nutflux;
-- DROP TABLE IF EXISTS Nutflux_relations;
-- DROP TABLE IF EXISTS awards;
-- DROP TABLE IF EXISTS Nutflux_Titles;

-- Create tables only

CREATE TABLE Nutflux_Titles (
  title_id VARCHAR(255) NOT NULL, -- Primary Key
  title_type VARCHAR(50), -- movie,series,documentary etc
  start_year INTEGER,  -- release year in case of movie. 
  end_year INTEGER, 
  primary_title TEXT, -- money heist
  original_title TEXT, -- mostly long type i.e la casa de papel
  is_adult BOOLEAN, --  0: non-adult title; 1: adult title
  runtime_total INTEGER, -- minutes
  PRIMARY KEY (title_id)
);

CREATE TABLE Title_ratings (
  title_id VARCHAR(255) NOT NULL, -- Primary Key
  avg_ratings FLOAT,
  no_of_ratings  INTEGER, -- total number of ratings
  PRIMARY KEY (title_id)
);

CREATE TABLE Title_Aliases (
  title_id VARCHAR(255) NOT NULL, -- primary key
  sequence_no INTEGER NOT NULL, -- primary key
  language CHAR(24),
  is_original_title  BOOLEAN, -- 0: non-original title; 1: original title
  new_title TEXT NOT NULL,
  region CHAR(24),
  PRIMARY KEY (title_id,sequence_no)
); 

CREATE TABLE user_info (
  user_id VARCHAR(255) NOT NULL, -- Primary Key
  user_name VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  PRIMARY KEY (user_id)
);

-- no primary key as single user can like multiple titles
CREATE TABLE user_profile (
  user_id VARCHAR(255) NOT NULL, -- Primary Key
  favourite_title VARCHAR(255) NOT NULL, -- liked title
  rating_given INTEGER NOT NULL
);

CREATE TABLE user_type (
  user_id VARCHAR(255) NOT NULL, -- Primary Key
  type VARCHAR(255) NOT NULL,
  PRIMARY KEY (user_id)
);

CREATE TABLE Episode_of_title (
  episode_title_id VARCHAR(255) NOT NULL,
  parent_title_id VARCHAR(255) NOT NULL, -- title_id of Nutflux_Titles
  season_number INTEGER,
  episode_number INTEGER,
  PRIMARY KEY (episode_title_id,parent_title_id)
);

-- no primary key as single title can be in multiple genre like comedy and horror
CREATE TABLE T_genres (
  title_id VARCHAR(255) NOT NULL, 
  genre VARCHAR(255) NOT NULL
);

-- for actors/people dir,writer etc

CREATE TABLE Names_Nutflux (
  name VARCHAR(255) NOT NULL, -- Primary Key original name of person
  name_common VARCHAR(255) NOT NULL, -- the common name
  birth_year SMALLINT, 
  death_year SMALLINT,
  sex VARCHAR(25),
  PRIMARY KEY (name)
);

CREATE TABLE name_works (
  name VARCHAR(255) NOT NULL, 
  profession VARCHAR(255) NOT NULL,
  born_country VARCHAR(255) NOT NULL,
  nationality VARCHAR(255) NOT NULL
);

CREATE TABLE known_role (
  title_id VARCHAR(255) NOT NULL, -- Primary Key from Nutflux_Titles
  name VARCHAR(255) NOT NULL, -- Primary Key from Names_Nutflux
  role_name TEXT NOT NULL ,-- role played for Nutflux_Titles string
  PRIMARY KEY (title_id,name)
);

CREATE TABLE famous_for (
  title_id VARCHAR(255) NOT NULL, -- no primary key as a title can have multiple famous personalities
  name VARCHAR(255) NOT NULL
);

CREATE TABLE Director_names (
  title_id VARCHAR(255) NOT NULL, -- no primary key as it can have multiple directors
  name VARCHAR(255) NOT NULL
);

CREATE TABLE Writer_names (
  title_id VARCHAR(255) NOT NULL, -- no primary key as it can have multiple writers
  name VARCHAR(255) NOT NULL
);

CREATE TABLE Production_House (
  title_id VARCHAR(255) NOT NULL, -- no primary key as it can have multiple production houses to secure funding
  production_name VARCHAR(255) NOT NULL
);

CREATE TABLE crew_details (
  title_id VARCHAR(255) NOT NULL, -- no primary key as a person can have multiple jobs in a movie
  category  VARCHAR(255), -- i.e producer, editor, composer
  job TEXT, -- if applicable , i.e in editor sound or video
  name VARCHAR(255) NOT NULL
);

CREATE TABLE Nutflux_relations (
  name_one VARCHAR(255) NOT NULL, -- Primary Key
  name_two VARCHAR(255) NOT NULL, -- Primary key  
  relation VARCHAR(255) NOT NULL,  -- type of relation married, affair, divorced
  relation_start_year SMALLINT, -- start year of relation
  relation_end_year SMALLINT, -- if applicable eg end year
  PRIMARY KEY (name_one,name_two)
);

CREATE TABLE awards (
  name VARCHAR(255), -- name from names_nutflux can be null for best title awards
  title_id VARCHAR(255) NOT NULL, -- title_id from nutflux_titles
  award_type VARCHAR(255) NOT NULL,  -- type of award grammy, oscar
  award_category VARCHAR(255) NOT NULL, -- ie acting, music
  award_for VARCHAR(255) NOT NULL, -- best actor, best supporting role, background music etc
  award_year SMALLINT, -- year of award
  won_or_nomination VARCHAR(255) NOT NULL -- won or nomination
);

-- foreign key constaints

-- if you find any issues with foreign key please run below
-- Disable foreign key  

-- SET foreign_key_checks = 0;

ALTER TABLE Production_House
ADD CONSTRAINT Production_House_title_id_fkey FOREIGN KEY (title_id) REFERENCES Nutflux_Titles(title_id);

ALTER TABLE name_works
ADD CONSTRAINT name_works_name_fkey FOREIGN KEY (name) REFERENCES Names_Nutflux(name);

ALTER TABLE famous_for
ADD CONSTRAINT famous_for_name_fkey FOREIGN KEY (name) REFERENCES Names_Nutflux(name);

ALTER TABLE famous_for
ADD CONSTRAINT famous_for_title_id_fkey FOREIGN KEY (title_id) REFERENCES Nutflux_Titles(title_id);

ALTER TABLE Title_ratings
ADD CONSTRAINT Title_ratings_title_id_fkey FOREIGN KEY (title_id) REFERENCES Nutflux_Titles(title_id);
 
ALTER TABLE Title_Aliases
ADD CONSTRAINT Title_Aliases_title_id_fkey FOREIGN KEY (title_id) REFERENCES Nutflux_Titles(title_id);

ALTER TABLE Episode_of_title
ADD CONSTRAINT Episode_of_title_show_episode_id_fkey FOREIGN KEY (episode_title_id) REFERENCES Nutflux_Titles(title_id);

ALTER TABLE Episode_of_title
ADD CONSTRAINT Episode_of_title_show_title_id_fkey FOREIGN KEY (parent_title_id) REFERENCES Nutflux_Titles(title_id);

ALTER TABLE crew_details
ADD CONSTRAINT crew_details_name_fkey FOREIGN KEY (name) REFERENCES Names_Nutflux(name);

ALTER TABLE crew_details
ADD CONSTRAINT crew_details_title_id_fkey FOREIGN KEY (title_id) REFERENCES Nutflux_Titles(title_id);

ALTER TABLE known_role
ADD CONSTRAINT known_role_title_id_fkey FOREIGN KEY (title_id) REFERENCES Nutflux_Titles(title_id);

ALTER TABLE known_role
ADD CONSTRAINT known_role_name_fkey FOREIGN KEY (name) REFERENCES Names_Nutflux(name);

ALTER TABLE Director_names
ADD CONSTRAINT Directors_title_id_fkey FOREIGN KEY (title_id) REFERENCES Nutflux_Titles(title_id);

ALTER TABLE Writer_names
ADD CONSTRAINT Writer_names_title_id_fkey FOREIGN KEY (title_id) REFERENCES Nutflux_Titles(title_id);

ALTER TABLE Director_names
ADD CONSTRAINT Directors_name_fkey FOREIGN KEY (name) REFERENCES Names_Nutflux(name);

ALTER TABLE Writer_names
ADD CONSTRAINT Writer_names_name_fkey FOREIGN KEY (name) REFERENCES Names_Nutflux(name);

ALTER TABLE Nutflux_relations
ADD CONSTRAINT Nutflux_relations_nameone FOREIGN KEY (name_one) REFERENCES Names_Nutflux(name);

ALTER TABLE Nutflux_relations
ADD CONSTRAINT Nutflux_relations_nametwo FOREIGN KEY (name_two) REFERENCES Names_Nutflux(name);

ALTER TABLE awards
ADD CONSTRAINT awards_name FOREIGN KEY (name) REFERENCES Names_Nutflux(name);

ALTER TABLE awards
ADD CONSTRAINT awards_title_id FOREIGN KEY (title_id) REFERENCES Nutflux_Titles(title_id);

ALTER TABLE user_profile
ADD CONSTRAINT user_profile_title_id_fkey FOREIGN KEY (favourite_title) REFERENCES Nutflux_Titles(title_id);

ALTER TABLE user_profile
ADD CONSTRAINT user_profile_user_id_fkey FOREIGN KEY (user_id) REFERENCES user_info(user_id);

ALTER TABLE user_type
ADD CONSTRAINT user_type_user_id_fkey FOREIGN KEY (user_id) REFERENCES user_info(user_id);

ALTER TABLE T_genres
ADD CONSTRAINT genres_title_id_fkey FOREIGN KEY (title_id) REFERENCES Nutflux_Titles(title_id);

-- SET foreign_key_checks = 1;

-- INSERT QUERIES

insert into Nutflux_Titles values ('Nut000001','movie',2005,NULL,'Batman Begins','Batman Begins',1,140),('Nut000002','tvseries',2007,2019,'The Big Bang Theory','The Big Bang Theory',1,2540),('Nut000003','tvseries',2017,2021,'Money Heist','La casa de papel',1,972),('Nut000004','tvseries',1998,2005,'Friends','Friends',1,1152),('Nut000005','tvseries',2013,2016,'Narcos','Narcos Columbia',1,479),('Nut000006','tvseries',2019,2022,'Narcos','Narcos Mexico',1,534),('Nut000007','tvseries',2010,2019,'Suits','Suits',1,756),('Nut000008','tvseries',1989,1998,'The Seinfeld','The Seinfeld',0,731),('Nut000009','tvseries',2010,2012,'Peaky Blinders','Peaky Blinders',1,646),('Nut000010','movie',2021,Null,'No time to Die','No time to Die',1,145),('Nut000011','tvseries',1990,Null,"That '70s Show","That '70s Show",1,36500);
commit;

insert into Nutflux_Titles values ('Test000001','movie',2005,NULL,'Batman Begins','Batman Begins',1,140),('Test000002','tvseries',2007,2019,'The Big Bang Theory','The Big Bang Theory',1,2540);
commit;

insert into Title_ratings values ('Nut000001',8.4,14000000),('Nut000002',8.2,7800000),('Nut000003',8.2,4540000),('Nut000004',8.3,46000),('Nut000005',7.9,1260500),('Nut000006',8.7,474210),('Nut000007',7.7,419230),('Nut000008',6.2,2118723),('Nut000009',8.9,2140292),('Nut000010',7.5,876341),('Nut000011',8,9763411);
commit;

insert into Title_Aliases values ('Nut000001',1,'English',1,'Batman Begins','USA'),('Nut000002',1,'English',1,'The Big Bang Theory','US'),('Nut000003',1,'Spanish',1,'La casa de papel','Spain'),('Nut000004',1,'English',1,'Friends','USA'),('Nut000005',1,'Columbian',0,'Narcos','Mexico'),('Nut000006',1,'English',1,'Narcos Mexico','Mexico'),('Nut000007',1,'English',1,'Suits','UK'),('Nut000008',1,'English',1,'The Seinfeld','USA'),('Nut000009',1,'English',1,'Peaky Blinders','UK'),('Nut000010',1,'English',1,'No time to Die','UK'),('Nut000011',1,'English',1,"That '70s Show",'USA');
commit;

-- 10 rows
insert into t_genres values ('Nut000001','action'),('Nut000001','crime'),('Nut000001','drama'),('Nut000002','comedy'),('Nut000002','romance'),('Nut000003','action'),('Nut000003','crime'),('Nut000003','drama'),('Nut000003','mystery'),('Nut000003','thriller'),('Nut000011','romcom');
commit;


-- for names/crew
-- 10 rows
insert into Names_Nutflux values ('Christian Bale','Christian Bale',1974,NULL,'Male'),('Christopher Nolan','Nolan',1970,NULL,'Male'),('Morgan Freeman','Morgan Freeman',1937,NULL,'Male'),('Michael Caine','Michael Caine',1933,NULL,'Male'),('Jim Parsons','Jim',1973,NULL,'Male'),('Kunal Nayyar','Nayyar',1981,NULL,'Male'),('Mayim Bialik','Mayim Bialik',1975,NULL,'Female'),('Kaley Cuoco','Kaley Cuoco',1985,NULL,'Female'),('Alvaro Morte','Alvaro',1975,NULL,'Male'),('Alex Pina','Alex Pina',1980,NULL,'Male'),('Wally Pfister','Wally Pfister',1975,NULL,'Male'),('Mila Kunis','Mila Kunis',1984,NULL,'Female'),('Ashton Kutcher','Ashton Kutcher',1985,NULL,'Male'),('Johnny Galecki','Johnny Galecki',1985,NULL,'Male'),('Ltziar Ituno','Ltziar Ituno',1985,NULL,'Male'),('Chuck Lorre','Chuck Lorre',1994,NULL,'Male'),('Bill Prady','Bill Prady',1970,NULL,'Male'),('Laurie','Laurie',1993,NULL,'Female'),('Bob Kane','Bob Kane',1991,NULL,'Male'),('Manel Santisteban','Manel Santisteban',1981,NULL,'Male'),('David S Goyer','David S Goyer',1989,NULL,'Male'),('Javier Gomez','Javier Gomez',1988,NULL,'Male'),('David Barrocal','David Barrocal',1980,NULL,'Male');
commit;

insert into name_works values ('Mayim Bialik','Nuero-Scientist','USA','USA'),('Kunal Nayyar','MBA','India','USA'),('Jim Parsons','Theatre','USA','USA'),('Christian Bale','Teacher','USA','USA'),('Christopher Nolan','Writer','French','USA'),('Morgan Freeman','Actor','USA','USA'),('Michael Caine','Classical','USA','USA'),('Kaley Cuoco','Modeling','Ireland','USA'),('Alvaro Morte','Producer','Spain','Spanish'),('Alex Pina','Business','Spain','Spanish');
commit;

insert into known_role values ('Nut000001','Christian Bale','Batman'),('Nut000001','Morgan Freeman','Lucius Fox'),('Nut000001','Michael Caine','Alfred'),('Nut000002','Jim Parsons','Sheldon Cooper'),('Nut000002','Kunal Nayyar','Rajesh Koothrappalli'),('Nut000002','Mayim Bialik','Amy Farrah Fowler'),('Nut000002','Kaley Cuoco','Penny'),('Nut000002','Johnny Galecki','Leonard Hofstadter'),('Nut000003','Alvaro Morte','Professor'),('Nut000003','Ltziar Ituno','Rauel');
commit;

insert into famous_for values ('Nut000001','Christian Bale'),('Nut000001','Morgan Freeman'),('Nut000001','Michael Caine'),('Nut000002','Jim Parsons'),('Nut000002','Kunal Nayyar'),('Nut000002','Mayim Bialik'),('Nut000002','Kaley Cuoco'),('Nut000002','Johnny Galecki'),('Nut000003','Alvaro Morte'),('Nut000003','Ltziar Ituno');
commit;

insert into Director_names values ('Nut000001','Christopher Nolan'),('Nut000003','Alex Pina'),('Nut000002','Chuck Lorre'),('Nut000002','Bill Prady'),('Nut000002','Jim Parsons'),('Nut000002','Kaley Cuoco'),('Nut000002','Laurie'),('Nut000003','Alvaro Morte'),('Nut000001','Christian Bale'),('Nut000001','Johnny Galecki');
commit;


insert into Writer_names values ('Nut000001','Bob Kane'),('Nut000003','Alex Pina'),('Nut000002','Chuck Lorre'),('Nut000002','Bill Prady'),('Nut000003','Alex Pina'),('Nut000003','Manel Santisteban'),('Nut000001','David S Goyer'),('Nut000001','Christopher Nolan'),('Nut000003','Javier Gomez'),('Nut000003','David Barrocal');
commit;


insert into crew_details values ('Nut000001','director',NULL,'Christopher Nolan'),
('Nut000001','actor',NULL,'Christian Bale'),('Nut000001','actor',NULL,'Morgan Freeman'),('Nut000001','actor',NULL,'Michael Caine'),('Nut000002','actor','lead role','Jim Parsons'),('Nut000002','actor',NULL,'Kunal Nayyar'),('Nut000002','actress',NULL,'Mayim Bialik'),('Nut000002','actress','lead','Kaley Cuoco'),('Nut000002','actor',NULL,'Johnny Galecki'),('Nut000003','actor',NULL,'Alvaro Morte'),('Nut000003','actress',NULL,'Ltziar Ituno'),('Nut000011','actor',NULL,'Ashton Kutcher'),('Nut000011','actress',NULL,'Mila Kunis');
commit;
-- Relationship /demo/ fake data

insert into Nutflux_relations values ('Jim Parsons','Mayim Bialik','Married',2017,NULL),('Jim Parsons','Kaley Cuoco','Married',2015,2016), ('Jim Parsons','Ltziar Ituno','Girlfriend',2012,2015),('Christopher Nolan','Ltziar Ituno','Married',2010,NULL), ('Alvaro Morte','Kaley Cuoco','Married',2015,2016), ('Kunal Nayyar','Ltziar Ituno','Married',2017,2021), ('Michael Caine','Ltziar Ituno','Girlfriend',2001,2004),('Alex Pina','Ltziar Ituno','Girlfriend',2019,2022),('Morgan Freeman','Christian Bale','Married',2020,NULL),('Kunal Nayyar','Mayim Bialik','Girlfriend',2020,NULL),('Ashton Kutcher','Mila Kunis','Married',2001,NULL);

commit;

-- Awards

insert into awards values ('Christian Bale','Nut000001','Saturn','Acting','Best Actor',2006,'Won'),
('Christopher Nolan','Nut000001','Saturn','Writer','Best Writing',2006,'Won'),('Jim Parsons','Nut000002','Emmy','Acting','Lead Actor',2014,'Won'),('Jim Parsons','Nut000002','Emmy','Acting','Lead Actor',2013,'Won'),('Jim Parsons','Nut000002','Emmy','Acting','Lead Actor',2012,'Nominee'),('Jim Parsons','Nut000002','Emmy','Acting','Lead Actor',2011,'Won'),('Jim Parsons','Nut000002','Emmy','Acting','Lead Actor',2010,'Won'),('Jim Parsons','Nut000002','AFI USA','TV Program','Tv Series',2010,'Won'),('Mayim Bialik','Nut000002','Critics Choice','Acting','Lead Actress',2016,'Won'),('Wally Pfister','Nut000001','Oscar','Cinematography','Best Achievement',2006,'Nominee');
insert into awards values ('David Barrocal','Nut000005','Grammy','Acting','Best Actor',2010,'Nominee');

commit;

insert into nutflux_Titles values ('got000001','tvseries',2011,2019,'game of thrones','game of thrones',1,4336);
insert into nutflux_Titles values ('got000002','tvepisode',2011,2011,'Winter Is Coming','Winter Is Coming',1,60);
insert into nutflux_Titles values ('got000003','tvepisode',2011,2011,'The Kingsroad','The Kingsroad',1,60);
insert into nutflux_Titles values ('got000004','tvepisode',2011,2011,'Lord Snow','Lord Snow',1,60);
insert into nutflux_Titles values ('got000005','tvepisode',2011,2011,'Cripples, Bastards, and Broken Things','Cripples, Bastards, and Broken Things',1,60);
insert into nutflux_Titles values ('got000006','tvepisode',2011,2011,'The Wolf and the Lion','The Wolf and the Lion',1,60);
insert into nutflux_Titles values ('got000007','tvepisode',2011,2011,'A Golden Crown','A Golden Crown',1,60);
insert into nutflux_Titles values ('got000008','tvepisode',2011,2011,'You Win or You Die','You Win or You Die',1,60);
insert into nutflux_Titles values ('got000009','tvepisode',2011,2011,'The Pointy End','The Pointy End',1,60);
insert into nutflux_Titles values ('got0000010','tvepisode',2011,2011,'Baelor','Baelor',1,60);
insert into nutflux_Titles values ('got0000011','tvepisode',2011,2011,'Fire and Blood','Fire and Blood',1,60);
insert into nutflux_Titles values ('got0000012','tvepisode',2012,2012,'The North Remembers','The North Remembers',1,60);
insert into nutflux_Titles values ('got0000013','tvepisode',2012,2012,'The Night Lands','The Night Lands',1,60);
insert into nutflux_Titles values ('got0000014','tvepisode',2012,2012,'What Is Dead May Never Die','What Is Dead May Never Die',1,60);
insert into nutflux_Titles values ('got0000015','tvepisode',2012,2012,'Garden of Bones','Garden of Bones',1,60);
insert into nutflux_Titles values ('got0000016','tvepisode',2012,2012,'The Ghost of Harrenhal','The Ghost of Harrenhal',1,60);
insert into nutflux_Titles values ('got0000017','tvepisode',2012,2012,'The Old Gods and the New','The Old Gods and the New',1,60);
insert into nutflux_Titles values ('got0000018','tvepisode',2012,2012,'A Man Without Honor','A Man Without Honor',1,60);
insert into nutflux_Titles values ('got0000019','tvepisode',2012,2012,'The Prince of Winterfell','The Prince of Winterfell',1,60);
insert into nutflux_Titles values ('got0000020','tvepisode',2012,2012,'Blackwater','Blackwater',1,60);
insert into nutflux_Titles values ('got0000021','tvepisode',2012,2012,'Valar Morghulis','Valar Morghulis',1,60);
insert into nutflux_Titles values ('got0000022','tvepisode',2013,2013,'Valar Dohaeris','Valar Dohaeris',1,60);
insert into nutflux_Titles values ('got0000023','tvepisode',2013,2013,'Dark Wings, Dark Words','Dark Wings, Dark Words',1,60);
insert into nutflux_Titles values ('got0000024','tvepisode',2013,2013,'Walk of Punishment','Walk of Punishment',1,60);
insert into nutflux_Titles values ('got0000025','tvepisode',2013,2013,'And Now His Watch Is Ended','And Now His Watch Is Ended',1,60);
insert into nutflux_Titles values ('got0000026','tvepisode',2013,2013,'Kissed by Fire','Kissed by Fire',1,60);
insert into nutflux_Titles values ('got0000027','tvepisode',2013,2013,'The Climb','The Climb',1,60);
insert into nutflux_Titles values ('got0000028','tvepisode',2013,2013,'The Bear and the Maiden Fair','The Bear and the Maiden Fair',1,60);
insert into nutflux_Titles values ('got0000029','tvepisode',2013,2013,'Second Sons','Second Sons',1,60);
insert into nutflux_Titles values ('got0000030','tvepisode',2013,2013,'The Rains of Castamere','The Rains of Castamere',1,60);
insert into nutflux_Titles values ('got0000031','tvepisode',2013,2013,'Mhysa','Mhysa',1,60);
insert into nutflux_Titles values ('got0000032','tvepisode',2014,2014,'Two Swords','Two Swords',1,60);
insert into nutflux_Titles values ('got0000033','tvepisode',2014,2014,'The Lion and the Rose','The Lion and the Rose',1,60);
insert into nutflux_Titles values ('got0000034','tvepisode',2014,2014,'Breaker of Chains','Breaker of Chains',1,60);
insert into nutflux_Titles values ('got0000035','tvepisode',2014,2014,'Oathkeeper','Oathkeeper',1,60);
insert into nutflux_Titles values ('got0000036','tvepisode',2014,2014,'First of His Name','First of His Name',1,60);
insert into nutflux_Titles values ('got0000037','tvepisode',2014,2014,'The Laws of Gods and Men','The Laws of Gods and Men',1,60);
insert into nutflux_Titles values ('got0000038','tvepisode',2014,2014,'Mockingbird','Mockingbird',1,60);
insert into nutflux_Titles values ('got0000039','tvepisode',2014,2014,'The Mountain and the Viper','The Mountain and the Viper',1,60);
insert into nutflux_Titles values ('got0000040','tvepisode',2014,2014,'The Watchers on the Wall','The Watchers on the Wall',1,60);
insert into nutflux_Titles values ('got0000041','tvepisode',2014,2014,'The Children','The Children',1,60);
insert into nutflux_Titles values ('got0000042','tvepisode',2015,2015,'The Wars to Come','The Wars to Come',1,60);
insert into nutflux_Titles values ('got0000043','tvepisode',2015,2015,'The House of Black and White','The House of Black and White',1,60);
insert into nutflux_Titles values ('got0000044','tvepisode',2015,2015,'High Sparrow','High Sparrow',1,60);
insert into nutflux_Titles values ('got0000045','tvepisode',2015,2015,'Sons of the Harpy','Sons of the Harpy',1,60);
insert into nutflux_Titles values ('got0000046','tvepisode',2015,2015,'Kill the Boy','Kill the Boy',1,60);
insert into nutflux_Titles values ('got0000047','tvepisode',2015,2015,'Unbowed, Unbent, Unbroken','Unbowed, Unbent, Unbroken',1,60);
insert into nutflux_Titles values ('got0000048','tvepisode',2015,2015,'The Gift','The Gift',1,60);
insert into nutflux_Titles values ('got0000049','tvepisode',2015,2015,'Hardhome','Hardhome',1,60);
insert into nutflux_Titles values ('got0000050','tvepisode',2015,2015,'The Dance of Dragons','The Dance of Dragons',1,60);
insert into nutflux_Titles values ('got0000051','tvepisode',2015,2015,"Mother's Mercy","Mother's Mercy",1,60);
insert into nutflux_Titles values ('got0000052','tvepisode',2015,2015,'The Red Woman','The Red Woman',1,60);
insert into nutflux_Titles values ('got0000053','tvepisode',2016,2016,'Home','Home',1,60);
insert into nutflux_Titles values ('got0000054','tvepisode',2016,2016,'Oathbreaker','Oathbreaker',1,60);
insert into nutflux_Titles values ('got0000055','tvepisode',2016,2016,'Book of the Stranger','Book of the Stranger',1,60);
insert into nutflux_Titles values ('got0000056','tvepisode',2016,2016,'The Door','The Door',1,60);
insert into nutflux_Titles values ('got0000057','tvepisode',2016,2016,'Blood of My Blood','Blood of My Blood',1,60);
insert into nutflux_Titles values ('got0000058','tvepisode',2016,2016,'The Broken Man','The Broken Man',1,60);
insert into nutflux_Titles values ('got0000059','tvepisode',2016,2016,'No One','No One',1,60);
insert into nutflux_Titles values ('got0000060','tvepisode',2016,2016,'Battle of the Bastards','Battle of the Bastards',1,60);
insert into nutflux_Titles values ('got0000061','tvepisode',2016,2016,'The Winds of Winter','The Winds of Winter',1,60);
insert into nutflux_Titles values ('got0000062','tvepisode',2017,2017,'Dragonstone','Dragonstone',1,60);
insert into nutflux_Titles values ('got0000063','tvepisode',2017,2017,'Stormborn','Stormborn',1,60);
insert into nutflux_Titles values ('got0000064','tvepisode',2017,2017,"The Queen's Justice","The Queen's Justice",1,60);
insert into nutflux_Titles values ('got0000065','tvepisode',2017,2017,'The Spoils of War','The Spoils of War',1,60);
insert into nutflux_Titles values ('got0000066','tvepisode',2017,2017,'Eastwatch','Eastwatch',1,60);
insert into nutflux_Titles values ('got0000067','tvepisode',2017,2017,'Beyond the Wall','Beyond the Wall',1,60);
insert into nutflux_Titles values ('got0000068','tvepisode',2017,2017,'The Dragon and the Wolf','The Dragon and the Wolf',1,60);
insert into nutflux_Titles values ('got0000069','tvepisode',2019,2019,'Winterfell','Winterfell',1,60);
insert into nutflux_Titles values ('got0000070','tvepisode',2019,2019,'A Knight of the Seven Kingdoms','A Knight of the Seven Kingdoms',1,60);
insert into nutflux_Titles values ('got0000071','tvepisode',2019,2019,'The Long Night','The Long Night',1,60);
insert into nutflux_Titles values ('got0000072','tvepisode',2019,2019,'The Last of the Starks','The Last of the Starks',1,60);
insert into nutflux_Titles values ('got0000073','tvepisode',2019,2019,'The Bells','The Bells',1,60);
insert into nutflux_Titles values ('got0000074','tvepisode',2019,2019,'The Iron Throne','The Iron Throne',1,60);

insert into title_ratings values ('got000001',9.2,3650000);
insert into title_ratings values ('got000002',9,50000);
insert into title_ratings values ('got000003',9,50000);
insert into title_ratings values ('got000004',9,50000);
insert into title_ratings values ('got000005',9,50000);
insert into title_ratings values ('got000006',9,50000);
insert into title_ratings values ('got000007',9,50000);
insert into title_ratings values ('got000008',9,50000);
insert into title_ratings values ('got000009',9,50000);
insert into title_ratings values ('got0000010',9,50000);
insert into title_ratings values ('got0000011',8.9,50000);
insert into title_ratings values ('got0000012',8.9,50000);
insert into title_ratings values ('got0000013',8.9,50000);
insert into title_ratings values ('got0000014',8.9,50000);
insert into title_ratings values ('got0000015',8.9,50000);
insert into title_ratings values ('got0000016',8.9,50000);
insert into title_ratings values ('got0000017',8.9,50000);
insert into title_ratings values ('got0000018',8.9,50000);
insert into title_ratings values ('got0000019',9.6,50000);
insert into title_ratings values ('got0000020',9.6,50000);
insert into title_ratings values ('got0000021',9.6,50000);
insert into title_ratings values ('got0000022',9.6,50000);
insert into title_ratings values ('got0000023',9.6,50000);
insert into title_ratings values ('got0000024',9.6,50000);
insert into title_ratings values ('got0000025',9.6,50000);
insert into title_ratings values ('got0000026',9.6,50000);
insert into title_ratings values ('got0000027',9.6,50000);
insert into title_ratings values ('got0000028',9.6,50000);
insert into title_ratings values ('got0000029',9.6,50000);
insert into title_ratings values ('got0000030',10,50000);
insert into title_ratings values ('got0000031',10,50000);
insert into title_ratings values ('got0000032',10,50000);
insert into title_ratings values ('got0000033',10,50000);
insert into title_ratings values ('got0000034',10,50000);
insert into title_ratings values ('got0000035',10,50000);
insert into title_ratings values ('got0000036',9.4,50000);
insert into title_ratings values ('got0000037',9.4,50000);
insert into title_ratings values ('got0000038',9.4,50000);
insert into title_ratings values ('got0000039',9.4,50000);
insert into title_ratings values ('got0000040',9.4,50000);
insert into title_ratings values ('got0000041',9.4,50000);
insert into title_ratings values ('got0000042',9.4,50000);
insert into title_ratings values ('got0000043',9.4,50000);
insert into title_ratings values ('got0000044',9.4,50000);
insert into title_ratings values ('got0000045',9.4,50000);
insert into title_ratings values ('got0000046',9.4,50000);
insert into title_ratings values ('got0000047',9.4,50000);
insert into title_ratings values ('got0000048',9.4,50000);
insert into title_ratings values ('got0000049',9.4,50000);
insert into title_ratings values ('got0000050',9.1,50000);
insert into title_ratings values ('got0000051',9.1,50000);
insert into title_ratings values ('got0000052',9.1,50000);
insert into title_ratings values ('got0000053',9.1,50000);
insert into title_ratings values ('got0000054',9.1,50000);
insert into title_ratings values ('got0000055',9.1,50000);
insert into title_ratings values ('got0000056',9.1,50000);
insert into title_ratings values ('got0000057',9.1,50000);
insert into title_ratings values ('got0000058',9.1,50000);
insert into title_ratings values ('got0000059',9.1,50000);
insert into title_ratings values ('got0000060',9.1,50000);
insert into title_ratings values ('got0000061',9.1,50000);
insert into title_ratings values ('got0000062',9.1,50000);
insert into title_ratings values ('got0000063',9.1,50000);
insert into title_ratings values ('got0000064',9.1,50000);
insert into title_ratings values ('got0000065',9.1,50000);
insert into title_ratings values ('got0000066',9.1,50000);
insert into title_ratings values ('got0000067',9.1,50000);
insert into title_ratings values ('got0000068',9.1,50000);
insert into title_ratings values ('got0000069',9.1,50000);
insert into title_ratings values ('got0000070',9.1,50000);
insert into title_ratings values ('got0000071',9.1,50000);
insert into title_ratings values ('got0000072',9.1,50000);
insert into title_ratings values ('got0000073',9.1,50000);
insert into title_ratings values ('got0000074',9.1,50000);

insert into Episode_of_title values ('got000002','got000001',1,1);
insert into Episode_of_title values ('got000003','got000001',1,2);
insert into Episode_of_title values ('got000004','got000001',1,3);
insert into Episode_of_title values ('got000005','got000001',1,4);
insert into Episode_of_title values ('got000006','got000001',1,5);
insert into Episode_of_title values ('got000007','got000001',1,6);
insert into Episode_of_title values ('got000008','got000001',1,7);
insert into Episode_of_title values ('got000009','got000001',1,8);
insert into Episode_of_title values ('got0000010','got000001',1,10);
insert into Episode_of_title values ('got0000011','got000001',1,9);
insert into Episode_of_title values ('got0000012','got000001',2,1);
insert into Episode_of_title values ('got0000013','got000001',2,2);
insert into Episode_of_title values ('got0000014','got000001',2,4);
insert into Episode_of_title values ('got0000015','got000001',2,3);
insert into Episode_of_title values ('got0000016','got000001',2,5);
insert into Episode_of_title values ('got0000017','got000001',2,9);
insert into Episode_of_title values ('got0000018','got000001',2,6);
insert into Episode_of_title values ('got0000019','got000001',2,7);
insert into Episode_of_title values ('got0000020','got000001',2,8);
insert into Episode_of_title values ('got0000021','got000001',2,10);
insert into Episode_of_title values ('got0000022','got000001',3,2);
insert into Episode_of_title values ('got0000023','got000001',3,1);
insert into Episode_of_title values ('got0000024','got000001',3,9);
insert into Episode_of_title values ('got0000025','got000001',3,5);
insert into Episode_of_title values ('got0000026','got000001',3,10);
insert into Episode_of_title values ('got0000027','got000001',3,4);
insert into Episode_of_title values ('got0000028','got000001',3,3);
insert into Episode_of_title values ('got0000029','got000001',3,8);
insert into Episode_of_title values ('got0000030','got000001',3,6);
insert into Episode_of_title values ('got0000031','got000001',3,7);
insert into Episode_of_title values ('got0000032','got000001',4,1);
insert into Episode_of_title values ('got0000033','got000001',4,2);
insert into Episode_of_title values ('got0000034','got000001',4,3);
insert into Episode_of_title values ('got0000035','got000001',4,4);
insert into Episode_of_title values ('got0000036','got000001',4,8);
insert into Episode_of_title values ('got0000037','got000001',4,5);
insert into Episode_of_title values ('got0000038','got000001',4,9);
insert into Episode_of_title values ('got0000039','got000001',4,10);
insert into Episode_of_title values ('got0000040','got000001',4,7);
insert into Episode_of_title values ('got0000041','got000001',4,6);
insert into Episode_of_title values ('got0000042','got000001',5,1);
insert into Episode_of_title values ('got0000043','got000001',6,1);
insert into Episode_of_title values ('got0000044','got000001',5,2);
insert into Episode_of_title values ('got0000045','got000001',5,9);
insert into Episode_of_title values ('got0000046','got000001',5,3);
insert into Episode_of_title values ('got0000047','got000001',5,4);
insert into Episode_of_title values ('got0000048','got000001',5,5);
insert into Episode_of_title values ('got0000049','got000001',5,6);
insert into Episode_of_title values ('got0000050','got000001',5,7);
insert into Episode_of_title values ('got0000051','got000001',5,8);
insert into Episode_of_title values ('got0000052','got000001',5,10);
insert into Episode_of_title values ('got0000053','got000001',6,2);
insert into Episode_of_title values ('got0000054','got000001',6,3);
insert into Episode_of_title values ('got0000055','got000001',6,4);
insert into Episode_of_title values ('got0000056','got000001',6,5);
insert into Episode_of_title values ('got0000057','got000001',6,6);
insert into Episode_of_title values ('got0000058','got000001',6,7);
insert into Episode_of_title values ('got0000059','got000001',6,8);
insert into Episode_of_title values ('got0000060','got000001',6,9);
insert into Episode_of_title values ('got0000061','got000001',6,10);
insert into Episode_of_title values ('got0000062','got000001',7,1);
insert into Episode_of_title values ('got0000063','got000001',7,2);
insert into Episode_of_title values ('got0000064','got000001',7,3);
insert into Episode_of_title values ('got0000065','got000001',7,4);
insert into Episode_of_title values ('got0000066','got000001',7,5);
insert into Episode_of_title values ('got0000067','got000001',7,6);
insert into Episode_of_title values ('got0000068','got000001',7,7);
insert into Episode_of_title values ('got0000069','got000001',8,1);
insert into Episode_of_title values ('got0000070','got000001',8,2);
insert into Episode_of_title values ('got0000071','got000001',8,3);
insert into Episode_of_title values ('got0000072','got000001',8,4);
insert into Episode_of_title values ('got0000073','got000001',8,5);
insert into Episode_of_title values ('got0000074','got000001',8,6);

insert into t_genres values ('got000001','fantasy');
insert into t_genres values ('got000002','fantasy');
insert into t_genres values ('got000003','fantasy');
insert into t_genres values ('got000004','fantasy');
insert into t_genres values ('got000005','fantasy');
insert into t_genres values ('got000006','fantasy');
insert into t_genres values ('got000007','fantasy');
insert into t_genres values ('got000008','fantasy');
insert into t_genres values ('got000009','fantasy');
insert into t_genres values ('got0000010','fantasy');
insert into t_genres values ('got0000011','fantasy');
insert into t_genres values ('got0000012','fantasy');
insert into t_genres values ('got0000013','fantasy');
insert into t_genres values ('got0000014','fantasy');
insert into t_genres values ('got0000015','fantasy');
insert into t_genres values ('got0000016','fantasy');
insert into t_genres values ('got0000017','fantasy');
insert into t_genres values ('got0000018','fantasy');
insert into t_genres values ('got0000019','fantasy');
insert into t_genres values ('got0000020','fantasy');
insert into t_genres values ('got0000021','fantasy');
insert into t_genres values ('got0000022','fantasy');
insert into t_genres values ('got0000023','fantasy');
insert into t_genres values ('got0000024','fantasy');
insert into t_genres values ('got0000025','fantasy');
insert into t_genres values ('got0000026','fantasy');
insert into t_genres values ('got0000027','fantasy');
insert into t_genres values ('got0000028','fantasy');
insert into t_genres values ('got0000029','fantasy');
insert into t_genres values ('got0000030','fantasy');
insert into t_genres values ('got0000031','fantasy');
insert into t_genres values ('got0000032','fantasy');
insert into t_genres values ('got0000033','fantasy');
insert into t_genres values ('got0000034','fantasy');
insert into t_genres values ('got0000035','fantasy');
insert into t_genres values ('got0000036','fantasy');
insert into t_genres values ('got0000037','fantasy');
insert into t_genres values ('got0000038','fantasy');
insert into t_genres values ('got0000039','fantasy');
insert into t_genres values ('got0000040','fantasy');
insert into t_genres values ('got0000041','fantasy');
insert into t_genres values ('got0000042','fantasy');
insert into t_genres values ('got0000043','fantasy');
insert into t_genres values ('got0000044','fantasy');
insert into t_genres values ('got0000045','fantasy');
insert into t_genres values ('got0000046','fantasy');
insert into t_genres values ('got0000047','fantasy');
insert into t_genres values ('got0000048','fantasy');
insert into t_genres values ('got0000049','fantasy');
insert into t_genres values ('got0000050','fantasy');
insert into t_genres values ('got0000051','fantasy');
insert into t_genres values ('got0000052','fantasy');
insert into t_genres values ('got0000053','fantasy');
insert into t_genres values ('got0000054','fantasy');
insert into t_genres values ('got0000055','fantasy');
insert into t_genres values ('got0000056','fantasy');
insert into t_genres values ('got0000057','fantasy');
insert into t_genres values ('got0000058','fantasy');
insert into t_genres values ('got0000059','fantasy');
insert into t_genres values ('got0000060','fantasy');
insert into t_genres values ('got0000061','fantasy');
insert into t_genres values ('got0000062','fantasy');
insert into t_genres values ('got0000063','fantasy');
insert into t_genres values ('got0000064','fantasy');
insert into t_genres values ('got0000065','fantasy');
insert into t_genres values ('got0000066','fantasy');
insert into t_genres values ('got0000067','fantasy');
insert into t_genres values ('got0000068','fantasy');
insert into t_genres values ('got0000069','fantasy');
insert into t_genres values ('got0000070','fantasy');
insert into t_genres values ('got0000071','fantasy');
insert into t_genres values ('got0000072','fantasy');
insert into t_genres values ('got0000073','fantasy');
insert into t_genres values ('got0000074','fantasy');

insert into Names_Nutflux values ('Peter Dinklage','Peter Dinklage',1969,NULL,'Male');
insert into Names_Nutflux values ('Emilia Clarke','Emilia Clarke',1970,NULL,'Female');
insert into Names_Nutflux values ('Lena Headey','Lena Headey',1971,NULL,'Female');
insert into Names_Nutflux values ('Kit Harington','Kit Harington',1972,NULL,'Male');
insert into Names_Nutflux values ('Maisie Williams','Maisie Williams',1973,NULL,'Female');
insert into Names_Nutflux values ('Nikolaj Coster-Waldau','Nikolaj Coster-Waldau',1974,NULL,'Male');
insert into Names_Nutflux values ('Sophie Turner','Sophie Turner',1975,NULL,'Female');
insert into Names_Nutflux values ('Carice van Houten','Carice van Houten',1976,NULL,'Female');
insert into Names_Nutflux values ('Max von Sydow','Max von Sydow',1977,NULL,'Male');
insert into Names_Nutflux values ('Diana Rigg','Diana Rigg',1978,NULL,'Female');
insert into Names_Nutflux values ('Rose Leslie','Rose Leslie',1978,NULL,'Female');

insert into name_works values ('Peter Dinklage','Artist','USA','American');
insert into name_works values ('Emilia Clarke','Artist','USA','American');
insert into name_works values ('Lena Headey','Artist','USA','American');
insert into name_works values ('Kit Harington','Artist','USA','American');
insert into name_works values ('Maisie Williams','Artist','USA','American');
insert into name_works values ('Nikolaj Coster-Waldau','Artist','USA','American');
insert into name_works values ('Sophie Turner','Artist','USA','American');
insert into name_works values ('Carice van Houten','Artist','USA','American');
insert into name_works values ('Max von Sydow','Artist','USA','American');
insert into name_works values ('Diana Rigg','Artist','USA','American');
insert into name_works values ('Rose Leslie','Artist','USA','American');

insert into known_role values ('got000001','Peter Dinklage','Tyrion Lannister');
insert into known_role values ('got000001','Emilia Clarke','Daenerys Targaryen');
insert into known_role values ('got000001','Lena Headey','Cersei Lannister');
insert into known_role values ('got000001','Kit Harington','Jon Snow');
insert into known_role values ('got000001','Maisie Williams','Arya Stark');
insert into known_role values ('got000001','Nikolaj Coster-Waldau','Jaime Lannister');
insert into known_role values ('got000001','Sophie Turner','Sansa Stark');
insert into known_role values ('got000001','Carice van Houten','Melisandre');
insert into known_role values ('got000001','Max von Sydow','Three-eyed Raven');
insert into known_role values ('got000001','Diana Rigg','Olenna Tyrell');
insert into known_role values ('got000001','Rose Leslie','Ygritte');

insert into Production_House values ('got000001','HBO');
insert into Production_House values ('got000002','HBO');
insert into Production_House values ('got000003','HBO');
insert into Production_House values ('got000004','HBO');
insert into Production_House values ('got000005','HBO');
insert into Production_House values ('got000006','HBO');
insert into Production_House values ('got000007','HBO');
insert into Production_House values ('got000008','HBO');
insert into Production_House values ('got000009','HBO');
insert into Production_House values ('got0000010','HBO');
insert into Production_House values ('got0000011','HBO');
insert into Production_House values ('got0000012','HBO');
insert into Production_House values ('got0000013','HBO');
insert into Production_House values ('got0000014','HBO');
insert into Production_House values ('got0000015','HBO');
insert into Production_House values ('got0000016','HBO');
insert into Production_House values ('got0000017','HBO');
insert into Production_House values ('got0000018','HBO');
insert into Production_House values ('got0000019','HBO');
insert into Production_House values ('got0000020','HBO');
insert into Production_House values ('got0000021','HBO');
insert into Production_House values ('got0000022','HBO');
insert into Production_House values ('got0000023','HBO');
insert into Production_House values ('got0000024','HBO');
insert into Production_House values ('got0000025','HBO');
insert into Production_House values ('got0000026','HBO');
insert into Production_House values ('got0000027','HBO');
insert into Production_House values ('got0000028','HBO');
insert into Production_House values ('got0000029','HBO');
insert into Production_House values ('got0000030','HBO');
insert into Production_House values ('got0000031','HBO');
insert into Production_House values ('got0000032','HBO');
insert into Production_House values ('got0000033','HBO');
insert into Production_House values ('got0000034','HBO');
insert into Production_House values ('got0000035','HBO');
insert into Production_House values ('got0000036','HBO');
insert into Production_House values ('got0000037','HBO');
insert into Production_House values ('got0000038','HBO');
insert into Production_House values ('got0000039','HBO');
insert into Production_House values ('got0000040','HBO');
insert into Production_House values ('got0000041','HBO');
insert into Production_House values ('got0000042','HBO');
insert into Production_House values ('got0000043','HBO');
insert into Production_House values ('got0000044','HBO');
insert into Production_House values ('got0000045','HBO');
insert into Production_House values ('got0000046','HBO');
insert into Production_House values ('got0000047','HBO');
insert into Production_House values ('got0000048','HBO');
insert into Production_House values ('got0000049','HBO');
insert into Production_House values ('got0000050','HBO');
insert into Production_House values ('got0000051','HBO');
insert into Production_House values ('got0000052','HBO');
insert into Production_House values ('got0000053','HBO');
insert into Production_House values ('got0000054','HBO');
insert into Production_House values ('got0000055','HBO');
insert into Production_House values ('got0000056','HBO');
insert into Production_House values ('got0000057','HBO');
insert into Production_House values ('got0000058','HBO');
insert into Production_House values ('got0000059','HBO');
insert into Production_House values ('got0000060','HBO');
insert into Production_House values ('got0000061','HBO');
insert into Production_House values ('got0000062','HBO');
insert into Production_House values ('got0000063','HBO');
insert into Production_House values ('got0000064','HBO');
insert into Production_House values ('got0000065','HBO');
insert into Production_House values ('got0000066','HBO');
insert into Production_House values ('got0000067','HBO');
insert into Production_House values ('got0000068','HBO');
insert into Production_House values ('got0000069','HBO');
insert into Production_House values ('got0000070','HBO');
insert into Production_House values ('got0000071','HBO');
insert into Production_House values ('got0000072','HBO');
insert into Production_House values ('got0000073','HBO');
insert into Production_House values ('got0000074','HBO');
insert into Production_House values ('Nut000001','Warner Bros');
insert into Production_House values ('Nut000002','Paramount');
insert into Production_House values ('Nut000003','20th Century Studios');
insert into Production_House values ('Nut000004','Universal Pictures');
insert into Production_House values ('Nut000005','Warner Bros');
insert into Production_House values ('Nut000006','Paramount');
insert into Production_House values ('Nut000007','20th Century Studios');
insert into Production_House values ('Nut000008','Universal Pictures');
insert into Production_House values ('Nut000009','20th Century Studios');
insert into Production_House values ('Nut000010','Universal Pictures');

insert into crew_details values ('got000001','actor','Supporting Actor','Peter Dinklage');
insert into crew_details values ('got000001','actor','Lead Actress','Emilia Clarke');
insert into crew_details values ('got000001','actor','Supporting Actress','Lena Headey');
insert into crew_details values ('got000001','actor','Lead Actor','Kit Harington');
insert into crew_details values ('got000001','actor','Supporting Actress','Maisie Williams');
insert into crew_details values ('got000001','actor','Supporting Actor','Nikolaj Coster-Waldau');
insert into crew_details values ('got000001','actor','Supporting Actress','Sophie Turner');
insert into crew_details values ('got000001','actor','Guest Actress','Carice van Houten');
insert into crew_details values ('got000001','actor','Guest Actor','Max von Sydow');
insert into crew_details values ('got000001','actor','Guest Actress','Diana Rigg');
insert into crew_details values ('got000001','actor','Guest Actress','Rose Leslie');

insert into Nutflux_relations values ('Kit Harington','Rose Leslie','Married',2012,NULL);

insert into awards values ('Peter Dinklage','got000001','Emmy','Acting','Best Actor',2019,'Won');
insert into awards values ('Emilia Clarke','got000001','Emmy','Acting','Best Actor',2019,'Nominated');
insert into awards values ('Lena Headey','got000001','Emmy','Acting','Best Actor',2019,'Nominated');
insert into awards values ('Kit Harington','got000001','Emmy','Acting','Best Actor',2019,'Nominated');
insert into awards values ('Maisie Williams','got000001','Emmy','Acting','Best Actor',2019,'Nominated');
insert into awards values ('Nikolaj Coster-Waldau','got000001','Emmy','Acting','Best Actor',2019,'Nominated');
insert into awards values ('Sophie Turner','got000001','Emmy','Acting','Best Actor',2019,'Nominated');
insert into awards values ('Carice van Houten','got000001','Emmy','Acting','Best Actor',2019,'Nominated');
insert into awards values ('Max von Sydow','got000001','Emmy','Acting','Best Actor',2019,'Nominated');
insert into awards values ('Diana Rigg','got000001','Emmy','Acting','Best Actor',2019,'Nominated');

insert into user_info values ('user00001','A','aaa');
insert into user_info values ('user00002','B','bbb');
insert into user_info values ('user00003','C','ccc');
insert into user_info values ('user00004','D','ddd');
insert into user_info values ('user00005','E','eee');
insert into user_info values ('user00006','F','fff');
insert into user_info values ('user00007','G','ggg');
insert into user_info values ('user00008','H','hhh');
insert into user_info values ('user00009','I','iii');
insert into user_info values ('user00010','J','jjj');
insert into user_info values ('test00007','G','ggg');
insert into user_info values ('test00008','H','hhh');
insert into user_info values ('test00009','I','iii');
insert into user_info values ('test00010','J','jjj');
insert into user_type values ('user00001','Standard');
insert into user_type values ('user00002','Power');
insert into user_type values ('user00003','Standard');
insert into user_type values ('user00004','Power');
insert into user_type values ('user00005','Standard');
insert into user_type values ('user00006','Power');
insert into user_type values ('user00007','Standard');
insert into user_type values ('user00008','Power');
insert into user_type values ('user00009','Standard');
insert into user_type values ('user00010','Power');
insert into user_profile values ('user00001','got000001',9);
insert into user_profile values ('user00002','got000001',10);
insert into user_profile values ('user00003','got000001',7);
insert into user_profile values ('user00004','got000001',8);
insert into user_profile values ('user00005','got000001',9);
insert into user_profile values ('user00006','got000001',9);
insert into user_profile values ('user00007','got000001',9);
insert into user_profile values ('user00008','got000001',9);
insert into user_profile values ('user00009','got000001',9);
insert into user_profile values ('user00010','got000001',9);

insert into nutflux_Titles values ('Nut000012','movie',2015,NULL,'Spectre','Spectre',1,150);
insert into nutflux_Titles values ('Nut000013','movie',2012,NULL,'Skyfall','Skyfall',1,150);
insert into nutflux_Titles values ('Nut000014','movie',2008,NULL,'Quantum of Solace','Quantum of Solace',1,150);
insert into nutflux_Titles values ('Nut000015','movie',2006,NULL,'Casino Royale','Casino Royale',1,150);
insert into nutflux_Titles values ('Nut000016','movie',2002,NULL,'Die Another Day','Die Another Day',1,150);
insert into nutflux_Titles values ('Nut000017','movie',1999,NULL,'The world is not enough','The world is not enough',1,150);
insert into nutflux_Titles values ('Nut000018','movie',1997,NULL,'Tomorrow Never Dies','Tomorrow Never Dies',0,150);
insert into nutflux_Titles values ('Nut000019','movie',1995,NULL,'Goldeneye','Goldeneye',1,150);
insert into nutflux_Titles values ('Nut000020','movie',1989,NULL,'License to Kill','License to Kill',1,150);
insert into nutflux_Titles values ('Nut000021','movie',1987,NULL,'The Living Daylights','The Living Daylights',1,150);
insert into nutflux_Titles values ('Nut000022','movie',1985,NULL,'A view to a Kill','A view to a Kill',0,150);
insert into nutflux_Titles values ('Nut000023','movie',1983,NULL,'Never Say Never Again','Never Say Never Again',1,150);
insert into nutflux_Titles values ('Nut000024','movie',1983,NULL,'Octopussy','Octopussy',1,150);
insert into nutflux_Titles values ('Nut000025','movie',1981,NULL,'For your eyes only','For your eyes only',1,150);
insert into nutflux_Titles values ('Nut000026','movie',1979,NULL,'Moonraker','Moonraker',1,150);
insert into nutflux_Titles values ('Nut000027','movie',1977,NULL,'The spy who loved me','The spy who loved me',0,150);
insert into nutflux_Titles values ('Nut000028','movie',1974,NULL,'The man with the golden Gun','The man with the golden Gun',1,150);
insert into nutflux_Titles values ('Nut000029','movie',1973,NULL,'Live and let die','Live and let die',0,150);
insert into nutflux_Titles values ('Nut000030','movie',1971,NULL,'Diamondas are forever','Diamondas are forever',1,150);
insert into nutflux_Titles values ('Nut000031','movie',1969,NULL,'On her Majestys Secret Service','On her Majestys Secret Service',0,150);
insert into nutflux_Titles values ('Nut000032','movie',1967,NULL,'You Only Live Twice','You Only Live Twice',1,150);
insert into nutflux_Titles values ('Nut000033','movie',1967,NULL,'Casino Royale','Casino Royale',1,150);
insert into nutflux_Titles values ('Nut000034','movie',1965,NULL,'ThunderBall','ThunderBall',1,150);
insert into nutflux_Titles values ('Nut000035','movie',1964,NULL,'GoldFinger','GoldFinger',1,150);
insert into nutflux_Titles values ('Nut000036','movie',1964,NULL,'From Russia With Love','From Russia With Love',1,150);
insert into nutflux_Titles values ('Nut000037','movie',1964,NULL,'Dr No.','Dr No.',0,150);
insert into nutflux_Titles values ('Nut000038','movie',2012,NULL,'Argo','Argo',1,150);
insert into nutflux_Titles values ('Nut000039','movie',2010,NULL,'The Town','The Town',0,150);
insert into nutflux_Titles values ('Nut000040','movie',1984,NULL,'Dune','Dune',1,150);
insert into nutflux_Titles values ('Nut000041','movie',2021,NULL,'Dune','Dune',1,150);
insert into nutflux_Titles values ('Nut000042','movie',2015,NULL,'The Martian','The Martian',0,150);
insert into nutflux_Titles values ('Nut000043','movie',1997,NULL,'Good Will Hunting','Good Will Hunting',1,150);
insert into nutflux_Titles values ('Nut000044','movie',2017,NULL,'Justice League','Justice League',0,150);
insert into nutflux_Titles values ('Nut000045','movie',2016,NULL,'Suicide Squad','Suicide Squad',0,150);
insert into nutflux_Titles values ('Nut000046','movie',2019,NULL,'The Joker','The Joker',0,150);
insert into nutflux_Titles values ('Nut000047','movie',1990,NULL,'Total Recall','Total Recall',1,150);
insert into nutflux_Titles values ('Nut000048','movie',2002,NULL,'Spider-Man','Spider-Man',1,150);
insert into nutflux_Titles values ('Nut000049','movie',2004,NULL,'Spider-Man 2','Spider-Man 2',1,150);
insert into nutflux_Titles values ('Nut000050','movie',2007,NULL,'Spider-Man 3','Spider-Man 3',1,150);
insert into nutflux_Titles values ('Nut000051','movie',2012,NULL,'The Amazing Spider-Man','The Amazing Spider-Man',0,150);
insert into nutflux_Titles values ('Nut000052','movie',2014,NULL,'The Amazing Spider-Man 2','The Amazing Spider-Man 2',0,150);
insert into nutflux_Titles values ('Nut000053','movie',2017,NULL,'Spider-Man: Homecoming','Spider-Man: Homecoming',0,150);
insert into nutflux_Titles values ('Nut000054','movie',2019,NULL,'Spider-Man: Far From Home','Spider-Man: Far From Home',0,150);
insert into nutflux_Titles values ('Nut000055','movie',1999,NULL,'Eyes wide shut','Eyes wide shut',0,150);
insert into nutflux_Titles values ('Nut000056','movie',1963,NULL,'Cleopatra','Cleopatra',1,150);
insert into nutflux_Titles values ('Nut000057','movie',2005,NULL,'Mr And Mrs Smith','Mr And Mrs Smith',1,150);
insert into nutflux_Titles values ('Nut000058','movie',1946,NULL,'The Big Sleep','The Big Sleep',1,150);
insert into nutflux_Titles values ('Nut000059','movie',2012,NULL,'Total Recall','Total Recall',1,150);
insert into nutflux_Titles values ('Nut000060','movie',2003,NULL,'Daredevil','Daredevil',1,150);
insert into nutflux_Titles values ('Nut000061','movie',1990,NULL,'Goodfellas','Goodfellas',1,150);
insert into nutflux_Titles values ('Nut000062','movie',2007,NULL,'Sweeney Todd: The Demon Barber of Fleet Stree','Sweeney Todd: The Demon Barber of Fleet Stree',0,150);
insert into nutflux_Titles values ('Nut000063','movie',2010,NULL,'Alice in Wonderland','Alice in Wonderland',0,150);
insert into nutflux_Titles values ('Nut000064','movie',1980,NULL,'Raging Bull','Raging Bull',0,150);

insert into Title_ratings values ('Nut000012',7.1,100000);
insert into Title_ratings values ('Nut000013',7.2,100000);
insert into Title_ratings values ('Nut000014',7.3,100000);
insert into Title_ratings values ('Nut000015',7.4,100000);
insert into Title_ratings values ('Nut000016',7.5,100000);
insert into Title_ratings values ('Nut000017',7.6,100000);
insert into Title_ratings values ('Nut000018',7.7,100000);
insert into Title_ratings values ('Nut000019',7.8,100000);
insert into Title_ratings values ('Nut000020',7.9,100000);
insert into Title_ratings values ('Nut000021',8,100000);
insert into Title_ratings values ('Nut000022',8.1,100000);
insert into Title_ratings values ('Nut000023',8.2,100000);
insert into Title_ratings values ('Nut000024',8.3,100000);
insert into Title_ratings values ('Nut000025',8.4,100000);
insert into Title_ratings values ('Nut000026',8.49999999999999,100000);
insert into Title_ratings values ('Nut000027',8.59999999999999,100000);
insert into Title_ratings values ('Nut000028',8.69999999999999,100000);
insert into Title_ratings values ('Nut000029',8.79999999999999,100000);
insert into Title_ratings values ('Nut000030',8.89999999999999,100000);
insert into Title_ratings values ('Nut000031',8.99999999999999,100000);
insert into Title_ratings values ('Nut000032',9.09999999999999,100000);
insert into Title_ratings values ('Nut000033',9.19999999999999,100000);
insert into Title_ratings values ('Nut000034',9.29999999999999,100000);
insert into Title_ratings values ('Nut000035',9.39999999999999,100000);
insert into Title_ratings values ('Nut000036',9.49999999999999,100000);
insert into Title_ratings values ('Nut000037',9.59999999999999,100000);
insert into Title_ratings values ('Nut000038',9.69999999999999,100000);
insert into Title_ratings values ('Nut000039',9.79999999999999,100000);
insert into Title_ratings values ('Nut000040',9.89999999999999,100000);
insert into Title_ratings values ('Nut000041',9.99999999999999,100000);
insert into Title_ratings values ('Nut000042',8,100000);
insert into Title_ratings values ('Nut000043',8.1,100000);
insert into Title_ratings values ('Nut000044',8.2,100000);
insert into Title_ratings values ('Nut000045',8.3,100000);
insert into Title_ratings values ('Nut000046',8.4,100000);
insert into Title_ratings values ('Nut000047',8.5,100000);
insert into Title_ratings values ('Nut000048',8.6,100000);
insert into Title_ratings values ('Nut000049',8.7,100000);
insert into Title_ratings values ('Nut000050',8.8,100000);
insert into Title_ratings values ('Nut000051',8.9,100000);
insert into Title_ratings values ('Nut000052',9,100000);
insert into Title_ratings values ('Nut000053',9.1,100000);
insert into Title_ratings values ('Nut000054',9.2,100000);
insert into Title_ratings values ('Nut000055',9.3,100000);
insert into Title_ratings values ('Nut000056',9.4,100000);
insert into Title_ratings values ('Nut000057',9.49999999999999,100000);
insert into Title_ratings values ('Nut000058',9.59999999999999,100000);
insert into Title_ratings values ('Nut000059',9.69999999999999,100000);
insert into Title_ratings values ('Nut000060',9.79999999999999,100000);
insert into Title_ratings values ('Nut000061',9.89999999999999,100000);
insert into Title_ratings values ('Nut000062',9.1,100000);
insert into Title_ratings values ('Nut000063',9.1,100000);
insert into Title_ratings values ('Nut000064',9.1,100000);

insert into T_genres values ('Nut000012','romcom');
insert into T_genres values ('Nut000013','spy');
insert into T_genres values ('Nut000014','thriller');
insert into T_genres values ('Nut000015','mystery');
insert into T_genres values ('Nut000016','fantasy');
insert into T_genres values ('Nut000017','comedy');
insert into T_genres values ('Nut000018','scifi');
insert into T_genres values ('Nut000019','superhero');
insert into T_genres values ('Nut000020','villain');
insert into T_genres values ('Nut000021','romcom');
insert into T_genres values ('Nut000022','spy');
insert into T_genres values ('Nut000023','thriller');
insert into T_genres values ('Nut000024','mystery');
insert into T_genres values ('Nut000025','fantasy');
insert into T_genres values ('Nut000026','comedy');
insert into T_genres values ('Nut000027','scifi');
insert into T_genres values ('Nut000028','superhero');
insert into T_genres values ('Nut000029','villain');
insert into T_genres values ('Nut000030','detective');
insert into T_genres values ('Nut000031','romcom');
insert into T_genres values ('Nut000032','spy');
insert into T_genres values ('Nut000033','thriller');
insert into T_genres values ('Nut000034','mystery');
insert into T_genres values ('Nut000035','fantasy');
insert into T_genres values ('Nut000036','comedy');
insert into T_genres values ('Nut000037','scifi');
insert into T_genres values ('Nut000038','superhero');
insert into T_genres values ('Nut000039','villain');
insert into T_genres values ('Nut000040','detective');
insert into T_genres values ('Nut000041','romcom');
insert into T_genres values ('Nut000042','spy');
insert into T_genres values ('Nut000043','thriller');
insert into T_genres values ('Nut000044','mystery');
insert into T_genres values ('Nut000045','fantasy');
insert into T_genres values ('Nut000046','comedy');
insert into T_genres values ('Nut000047','scifi');
insert into T_genres values ('Nut000048','superhero');
insert into T_genres values ('Nut000049','villain');
insert into T_genres values ('Nut000050','detective');
insert into T_genres values ('Nut000051','romcom');
insert into T_genres values ('Nut000052','spy');
insert into T_genres values ('Nut000053','thriller');
insert into T_genres values ('Nut000054','mystery');
insert into T_genres values ('Nut000055','fantasy');
insert into T_genres values ('Nut000056','comedy');
insert into T_genres values ('Nut000057','scifi');
insert into T_genres values ('Nut000058','superhero');
insert into T_genres values ('Nut000059','villain');
insert into T_genres values ('Nut000060','detective');
insert into T_genres values ('Nut000061','romcom');
insert into T_genres values ('Nut000062','spy');
insert into T_genres values ('Nut000063','thriller');
insert into T_genres values ('Nut000064','mystery');
insert into T_genres values ('Nut000012','detective');
insert into T_genres values ('Nut000013','detective');
insert into T_genres values ('Nut000014','romcom');
insert into T_genres values ('Nut000015','spy');
insert into T_genres values ('Nut000016','thriller');
insert into T_genres values ('Nut000017','detective');
insert into T_genres values ('Nut000018','romcom');
insert into T_genres values ('Nut000019','spy');
insert into T_genres values ('Nut000020','thriller');
insert into T_genres values ('Nut000021','mystery');
insert into T_genres values ('Nut000022','detective');
insert into T_genres values ('Nut000023','romcom');
insert into T_genres values ('Nut000024','spy');
insert into T_genres values ('Nut000025','thriller');
insert into T_genres values ('Nut000026','mystery');
insert into T_genres values ('Nut000027','detective');
insert into T_genres values ('Nut000028','romcom');
insert into T_genres values ('Nut000029','spy');
insert into T_genres values ('Nut000030','thriller');
insert into T_genres values ('Nut000031','mystery');
insert into T_genres values ('Nut000032','detective');
insert into T_genres values ('Nut000033','romcom');
insert into T_genres values ('Nut000034','spy');
insert into T_genres values ('Nut000035','thriller');
insert into T_genres values ('Nut000036','mystery');
insert into T_genres values ('Nut000037','detective');
insert into T_genres values ('Nut000038','romcom');
insert into T_genres values ('Nut000039','spy');
insert into T_genres values ('Nut000040','thriller');
insert into T_genres values ('Nut000041','mystery');
insert into T_genres values ('Nut000042','detective');
insert into T_genres values ('Nut000043','romcom');
insert into T_genres values ('Nut000044','spy');
insert into T_genres values ('Nut000045','thriller');
insert into T_genres values ('Nut000046','mystery');
insert into T_genres values ('Nut000047','detective');
insert into T_genres values ('Nut000048','romcom');
insert into T_genres values ('Nut000049','spy');
insert into T_genres values ('Nut000050','thriller');
insert into T_genres values ('Nut000051','mystery');
insert into T_genres values ('Nut000052','detective');
insert into T_genres values ('Nut000053','romcom');
insert into T_genres values ('Nut000054','spy');
insert into T_genres values ('Nut000055','thriller');
insert into T_genres values ('Nut000056','mystery');
insert into T_genres values ('Nut000057','detective');
insert into T_genres values ('Nut000058','romcom');
insert into T_genres values ('Nut000059','detective');
insert into T_genres values ('Nut000060','romcom');
insert into T_genres values ('Nut000061','detective');
insert into T_genres values ('Nut000062','romcom');
insert into T_genres values ('Nut000063','spy');
insert into T_genres values ('Nut000064','thriller');

insert into Names_Nutflux values ('Pierce Brosnan','Pierce Brosnan',1979,NULL,'Male');
insert into Names_Nutflux values ('Timothy Dalton','Timothy Dalton',1980,NULL,'Male');
insert into Names_Nutflux values ('Sean Connery','Sean Connery',1981,NULL,'Male');
insert into Names_Nutflux values ('Roger Moore','Roger Moore',1982,NULL,'Male');
insert into Names_Nutflux values ('George Lazenby','George Lazenby',1983,NULL,'Male');
insert into Names_Nutflux values ('David Niven','David Niven',1984,NULL,'Male');
insert into Names_Nutflux values ('Ben Affleck','Ben Affleck',1985,NULL,'Male');
insert into Names_Nutflux values ('Kyle MacLachlan','Kyle MacLachlan',1986,NULL,'Male');
insert into Names_Nutflux values ('Timothee Chalamet','Timothee Chalamet',1987,NULL,'Female');
insert into Names_Nutflux values ('Matt Damon','Matt Damon',1988,NULL,'Male');
insert into Names_Nutflux values ('Will Smith','Will Smith',1989,NULL,'Male');
insert into Names_Nutflux values ('Jaoquin Phoenix','Jaoquin Phoenix',1990,NULL,'Male');
insert into Names_Nutflux values ('Arnold Schwarzenegger','Arnold Schwarzenegger',1991,NULL,'Male');
insert into Names_Nutflux values ('Tobey Maguire','Tobey Maguire',1992,NULL,'Male');
insert into Names_Nutflux values ('Andrew Garfield','Andrew Garfield',1993,NULL,'Male');
insert into Names_Nutflux values ('Tom Holland','Tom Holland',1994,NULL,'Male');
insert into Names_Nutflux values ('Tom Cruise','Tom Cruise',1995,NULL,'Male');
insert into Names_Nutflux values ('Nicole Kidman','Nicole Kidman',1996,NULL,'Male');
insert into Names_Nutflux values ('Richard Burton','Richard Burton',1997,NULL,'Male');
insert into Names_Nutflux values ('Elizabeth Taylor','Elizabeth Taylor',1998,NULL,'Female');
insert into Names_Nutflux values ('Brad Pitt','Brad Pitt',1999,NULL,'Male');
insert into Names_Nutflux values ('Angelina Jolie','Angelina Jolie',2000,NULL,'Female');
insert into Names_Nutflux values ('Humphrey Bogart','Humphrey Bogart',2001,NULL,'Male');
insert into Names_Nutflux values ('Lauren Bacall','Lauren Bacall',2002,NULL,'Female');
insert into Names_Nutflux values ('Colin Farrell','Colin Farrell',2003,NULL,'Male');
insert into Names_Nutflux values ('Jennifer Garner','Jennifer Garner',2004,NULL,'Female');
insert into Names_Nutflux values ('Johnny Depp','Johnny Depp',2005,NULL,'Male');
insert into Names_Nutflux values ('Robert De Niro','Robert De Niro',2006,NULL,'Male');
insert into Names_Nutflux values ('Helena Bonham Carter','Helena Bonham Carter',2007,NULL,'Female');
insert into Names_Nutflux values ('Sam Mendes','Sam Mendes',2007,NULL,'Male');
insert into Names_Nutflux values ('Marc Foster','Marc Foster',2007,NULL,'Male');
insert into Names_Nutflux values ('Martin Campbell','Martin Campbell',2007,NULL,'Male');
insert into Names_Nutflux values ('Lee Tamahori','Lee Tamahori',2007,NULL,'Male');
insert into Names_Nutflux values ('Michael Apted','Michael Apted',2007,NULL,'Male');
insert into Names_Nutflux values ('Roger Spottiswoode','Roger Spottiswoode',2007,NULL,'Male');
insert into Names_Nutflux values ('John Glen','John Glen',2007,NULL,'Male');
insert into Names_Nutflux values ('Irvin Kershner','Irvin Kershner',2007,NULL,'Male');
insert into Names_Nutflux values ('Lewis Gilbert','Lewis Gilbert',2007,NULL,'Male');
insert into Names_Nutflux values ('Guy Hamilton','Guy Hamilton',2007,NULL,'Male');
insert into Names_Nutflux values ('Peter R. Hunt','Peter R. Hunt',2007,NULL,'Male');
insert into Names_Nutflux values ('John Huston','John Huston',2007,NULL,'Male');
insert into Names_Nutflux values ('Terence Young','Terence Young',2007,NULL,'Male');
insert into Names_Nutflux values ('David Lynch','David Lynch',2007,NULL,'Male');
insert into Names_Nutflux values ('Denis Villeneuve','Denis Villeneuve',2007,NULL,'Male');
insert into Names_Nutflux values ('Ridley Scott','Ridley Scott',2007,NULL,'Male');
insert into Names_Nutflux values ('Gus Van Sant','Gus Van Sant',2007,NULL,'Male');
insert into Names_Nutflux values ('Zack Snyder','Zack Snyder',2007,NULL,'Male');
insert into Names_Nutflux values ('David Ayer','David Ayer',2007,NULL,'Male');
insert into Names_Nutflux values ('Todd Phillips','Todd Phillips',2007,NULL,'Male');
insert into Names_Nutflux values ('Paul Verhoeven','Paul Verhoeven',2007,NULL,'Male');
insert into Names_Nutflux values ('Sam Raimi','Sam Raimi',2007,NULL,'Male');
insert into Names_Nutflux values ('Marc Webb','Marc Webb',2007,NULL,'Male');
insert into Names_Nutflux values ('Jon Watts','Jon Watts',2007,NULL,'Male');
insert into Names_Nutflux values ('Stanley Kubrick','Stanley Kubrick',2007,NULL,'Male');
insert into Names_Nutflux values ('Joseph L. Mankiewicz','Joseph L. Mankiewicz',2007,NULL,'Male');
insert into Names_Nutflux values ('Doug Liman','Doug Liman',2007,NULL,'Male');
insert into Names_Nutflux values ('Howard Hawks','Howard Hawks',2007,NULL,'Male');
insert into Names_Nutflux values ('Len Wisesman','Len Wisesman',2007,NULL,'Male');
insert into Names_Nutflux values ('Mark Steven Johnson','Mark Steven Johnson',2007,NULL,'Male');
insert into Names_Nutflux values ('Tim Burton','Tim Burton',2007,NULL,'Male');
insert into Names_Nutflux values ('Martin Scorsese','Martin Scorsese',2007,NULL,'Male');

insert into known_role values ('Nut000012','Pierce Brosnan','james bond');
insert into known_role values ('Nut000013','Timothy Dalton','james bond');
insert into known_role values ('Nut000014','Sean Connery','james bond');
insert into known_role values ('Nut000015','Roger Moore','james bond');
insert into known_role values ('Nut000016','George Lazenby','james bond');
insert into known_role values ('Nut000017','David Niven','james bond');
insert into known_role values ('Nut000018','Ben Affleck','james bond');
insert into known_role values ('Nut000019','Kyle MacLachlan','james bond');
insert into known_role values ('Nut000020','Timothee Chalamet','james bond');
insert into known_role values ('Nut000021','Matt Damon','james bond');
insert into known_role values ('Nut000022','Will Smith','james bond');
insert into known_role values ('Nut000023','Jaoquin Phoenix','james bond');
insert into known_role values ('Nut000024','Arnold Schwarzenegger','james bond');
insert into known_role values ('Nut000025','Tobey Maguire','james bond');
insert into known_role values ('Nut000026','Andrew Garfield','james bond');
insert into known_role values ('Nut000027','Tom Holland','james bond');
insert into known_role values ('Nut000028','Tom Cruise','spiderman');
insert into known_role values ('Nut000029','Nicole Kidman','spiderman');
insert into known_role values ('Nut000030','Richard Burton','spiderman');
insert into known_role values ('Nut000031','Elizabeth Taylor','spiderman');
insert into known_role values ('Nut000032','Brad Pitt','spiderman');
insert into known_role values ('Nut000033','Angelina Jolie','joker');
insert into known_role values ('Nut000034','Humphrey Bogart','joker');
insert into known_role values ('Nut000035','Lauren Bacall','joker');
insert into known_role values ('Nut000036','Colin Farrell','joker');
insert into known_role values ('Nut000037','Jennifer Garner','joker');
insert into known_role values ('Nut000038','Johnny Depp','joker');
insert into known_role values ('Nut000039','Robert De Niro','flucke');
insert into known_role values ('Nut000040','Helena Bonham Carter','flucke');
insert into known_role values ('Nut000041','Pierce Brosnan','flucke');
insert into known_role values ('Nut000042','Timothy Dalton','flucke');
insert into known_role values ('Nut000043','Sean Connery','flucke');
insert into known_role values ('Nut000044','Roger Moore','flucke');
insert into known_role values ('Nut000045','George Lazenby','flucke');
insert into known_role values ('Nut000046','David Niven','flucke');
insert into known_role values ('Nut000047','Ben Affleck','flucke');
insert into known_role values ('Nut000048','Kyle MacLachlan','flucke');
insert into known_role values ('Nut000049','Timothee Chalamet','cheatpat');
insert into known_role values ('Nut000050','Matt Damon','cheatpat');
insert into known_role values ('Nut000051','Will Smith','cheatpat');
insert into known_role values ('Nut000052','Jaoquin Phoenix','cheatpat');
insert into known_role values ('Nut000053','Arnold Schwarzenegger','cheatpat');
insert into known_role values ('Nut000054','Tobey Maguire','rindo');
insert into known_role values ('Nut000055','Andrew Garfield','rindo');
insert into known_role values ('Nut000056','Tom Holland','rindo');
insert into known_role values ('Nut000057','Tom Cruise','rindo');
insert into known_role values ('Nut000058','Nicole Kidman','rindo');
insert into known_role values ('Nut000059','Richard Burton','rindo');
insert into known_role values ('Nut000060','Elizabeth Taylor','rindo');
insert into known_role values ('Nut000061','Brad Pitt','rindo');
insert into known_role values ('Nut000062','Angelina Jolie','rindo');
insert into known_role values ('Nut000063','Humphrey Bogart','rindo');
insert into known_role values ('Nut000064','Lauren Bacall','rindo');

insert into famous_for values ('Nut000012','Pierce Brosnan');
insert into famous_for values ('Nut000013','Timothy Dalton');
insert into famous_for values ('Nut000014','Sean Connery');
insert into famous_for values ('Nut000015','Roger Moore');
insert into famous_for values ('Nut000016','George Lazenby');
insert into famous_for values ('Nut000017','David Niven');
insert into famous_for values ('Nut000018','Ben Affleck');
insert into famous_for values ('Nut000019','Kyle MacLachlan');
insert into famous_for values ('Nut000020','Timothee Chalamet');
insert into famous_for values ('Nut000021','Matt Damon');
insert into famous_for values ('Nut000022','Will Smith');
insert into famous_for values ('Nut000023','Jaoquin Phoenix');
insert into famous_for values ('Nut000024','Arnold Schwarzenegger');
insert into famous_for values ('Nut000025','Tobey Maguire');
insert into famous_for values ('Nut000026','Andrew Garfield');
insert into famous_for values ('Nut000027','Tom Holland');
insert into famous_for values ('Nut000028','Tom Cruise');
insert into famous_for values ('Nut000029','Nicole Kidman');
insert into famous_for values ('Nut000030','Richard Burton');
insert into famous_for values ('Nut000031','Elizabeth Taylor');
insert into famous_for values ('Nut000032','Brad Pitt');
insert into famous_for values ('Nut000033','Angelina Jolie');
insert into famous_for values ('Nut000034','Humphrey Bogart');
insert into famous_for values ('Nut000035','Lauren Bacall');
insert into famous_for values ('Nut000036','Colin Farrell');
insert into famous_for values ('Nut000037','Jennifer Garner');
insert into famous_for values ('Nut000038','Johnny Depp');
insert into famous_for values ('Nut000039','Robert De Niro');
insert into famous_for values ('Nut000040','Helena Bonham Carter');
insert into famous_for values ('Nut000041','Pierce Brosnan');
insert into famous_for values ('Nut000042','Timothy Dalton');
insert into famous_for values ('Nut000043','Sean Connery');
insert into famous_for values ('Nut000044','Roger Moore');
insert into famous_for values ('Nut000045','George Lazenby');
insert into famous_for values ('Nut000046','David Niven');
insert into famous_for values ('Nut000047','Ben Affleck');
insert into famous_for values ('Nut000048','Kyle MacLachlan');
insert into famous_for values ('Nut000049','Timothee Chalamet');
insert into famous_for values ('Nut000050','Matt Damon');
insert into famous_for values ('Nut000051','Will Smith');
insert into famous_for values ('Nut000052','Jaoquin Phoenix');
insert into famous_for values ('Nut000053','Arnold Schwarzenegger');
insert into famous_for values ('Nut000054','Tobey Maguire');
insert into famous_for values ('Nut000055','Andrew Garfield');
insert into famous_for values ('Nut000056','Tom Holland');
insert into famous_for values ('Nut000057','Tom Cruise');
insert into famous_for values ('Nut000058','Nicole Kidman');
insert into famous_for values ('Nut000059','Richard Burton');
insert into famous_for values ('Nut000060','Elizabeth Taylor');
insert into famous_for values ('Nut000061','Brad Pitt');
insert into famous_for values ('Nut000062','Angelina Jolie');
insert into famous_for values ('Nut000063','Humphrey Bogart');
insert into famous_for values ('Nut000064','Lauren Bacall');

insert into awards values ('Pierce Brosnan','Nut000012','Oscar','Acting','Best Actor',2020,'Won');
insert into awards values ('Timothy Dalton','Nut000013','Oscar','Acting','Best Actor',2001,'Won');
insert into awards values ('Timothy Dalton','Nut000014','Oscar','Acting','Best Actor',2002,'Won');
insert into awards values ('Timothy Dalton','Nut000015','Oscar','Acting','Best Actor',2003,'Won');
insert into awards values ('George Lazenby','Nut000016','Oscar','Acting','Best Actor',2017,'Won');
insert into awards values ('David Niven','Nut000017','Oscar','Acting','Best Actor',2017,'Won');
insert into awards values ('Ben Affleck','Nut000018','Oscar','Acting','Best Actor',2017,'Won');
insert into awards values ('Kyle MacLachlan','Nut000019','Oscar','Acting','Best Actor',2017,'Won');
insert into awards values ('Timothee Chalamet','Nut000020','Oscar','Acting','Best Actor',2017,'Won');
insert into awards values ('Matt Damon','Nut000021','Oscar','Acting','Best Actor',2017,'Won');
insert into awards values ('Will Smith','Nut000022','Oscar','Acting','Best Actor',2017,'Won');
insert into awards values ('Jaoquin Phoenix','Nut000023','Oscar','Acting','Best Actor',2020,'Won');
insert into awards values ('Jaoquin Phoenix','Nut000024','Oscar','Acting','Best Actor',2021,'Won');
insert into awards values ('Jaoquin Phoenix','Nut000025','Oscar','Acting','Best Actor',2019,'Won');
insert into awards values ('Andrew Garfield','Nut000026','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Tom Holland','Nut000027','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Tom Cruise','Nut000028','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Nicole Kidman','Nut000029','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Richard Burton','Nut000030','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Elizabeth Taylor','Nut000031','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Brad Pitt','Nut000032','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Angelina Jolie','Nut000033','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Humphrey Bogart','Nut000034','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Lauren Bacall','Nut000035','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Colin Farrell','Nut000036','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Jennifer Garner','Nut000037','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Johnny Depp','Nut000038','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Robert De Niro','Nut000039','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Helena Bonham Carter','Nut000040','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Pierce Brosnan','Nut000041','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Timothy Dalton','Nut000042','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Sean Connery','Nut000043','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Roger Moore','Nut000044','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('George Lazenby','Nut000045','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('David Niven','Nut000046','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Ben Affleck','Nut000047','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Kyle MacLachlan','Nut000048','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Timothee Chalamet','Nut000049','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Matt Damon','Nut000050','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Will Smith','Nut000051','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Jaoquin Phoenix','Nut000052','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Arnold Schwarzenegger','Nut000053','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Tobey Maguire','Nut000054','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Andrew Garfield','Nut000055','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Tom Holland','Nut000056','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Tom Cruise','Nut000057','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Nicole Kidman','Nut000058','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Richard Burton','Nut000059','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Elizabeth Taylor','Nut000060','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Brad Pitt','Nut000061','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Angelina Jolie','Nut000062','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Humphrey Bogart','Nut000063','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Lauren Bacall','Nut000064','Oscar','Acting','Best Actor',2012,'Won');
insert into awards values ('Pierce Brosnan','Nut000063','Oscar','Acting','Best Actor',2021,'Won');
insert into awards values ('Pierce Brosnan','Nut000064','Oscar','Acting','Best Actor',2022,'Won');

insert into director_names values ('Nut000012','Sam Mendes');
insert into director_names values ('Nut000013','Marc Foster');
insert into director_names values ('Nut000014','Martin Campbell');
insert into director_names values ('Nut000015','Lee Tamahori');
insert into director_names values ('Nut000016','Michael Apted');
insert into director_names values ('Nut000017','Roger Spottiswoode');
insert into director_names values ('Nut000018','John Glen');
insert into director_names values ('Nut000019','Irvin Kershner');
insert into director_names values ('Nut000020','Lewis Gilbert');
insert into director_names values ('Nut000021','Guy Hamilton');
insert into director_names values ('Nut000022','Peter R. Hunt');
insert into director_names values ('Nut000023','John Huston');
insert into director_names values ('Nut000024','Terence Young');
insert into director_names values ('Nut000025','Ben Affleck');
insert into director_names values ('Nut000026','David Lynch');
insert into director_names values ('Nut000027','Denis Villeneuve');
insert into director_names values ('Nut000028','Ridley Scott');
insert into director_names values ('Nut000029','Gus Van Sant');
insert into director_names values ('Nut000030','Zack Snyder');
insert into director_names values ('Nut000031','David Ayer');
insert into director_names values ('Nut000032','Todd Phillips');
insert into director_names values ('Nut000033','Paul Verhoeven');
insert into director_names values ('Nut000034','Sam Raimi');
insert into director_names values ('Nut000035','Marc Webb');
insert into director_names values ('Nut000036','Jon Watts');
insert into director_names values ('Nut000037','Stanley Kubrick');
insert into director_names values ('Nut000038','Joseph L. Mankiewicz');
insert into director_names values ('Nut000039','Doug Liman');
insert into director_names values ('Nut000040','Howard Hawks');
insert into director_names values ('Nut000041','Len Wisesman');
insert into director_names values ('Nut000042','Mark Steven Johnson');
insert into director_names values ('Nut000043','Tim Burton');
insert into director_names values ('Nut000044','Martin Scorsese');
insert into director_names values ('Nut000045','Sam Mendes');
insert into director_names values ('Nut000046','Marc Foster');
insert into director_names values ('Nut000047','Martin Campbell');
insert into director_names values ('Nut000048','Lee Tamahori');
insert into director_names values ('Nut000049','Michael Apted');
insert into director_names values ('Nut000050','Roger Spottiswoode');
insert into director_names values ('Nut000051','John Glen');
insert into director_names values ('Nut000052','Irvin Kershner');
insert into director_names values ('Nut000053','Lewis Gilbert');
insert into director_names values ('Nut000054','Guy Hamilton');
insert into director_names values ('Nut000055','Peter R. Hunt');
insert into director_names values ('Nut000056','John Huston');
insert into director_names values ('Nut000057','Terence Young');
insert into director_names values ('Nut000058','Ben Affleck');
insert into director_names values ('Nut000059','David Lynch');
insert into director_names values ('Nut000060','Denis Villeneuve');
insert into director_names values ('Nut000061','Ridley Scott');
insert into director_names values ('Nut000062','Gus Van Sant');
insert into director_names values ('Nut000063','Zack Snyder');
insert into director_names values ('Nut000064','David Ayer');
insert into director_names values ('Nut000012','Todd Phillips');
insert into director_names values ('Nut000013','Paul Verhoeven');
insert into director_names values ('Nut000014','Sam Raimi');
insert into director_names values ('Nut000015','Marc Webb');
insert into director_names values ('Nut000016','Jon Watts');
insert into director_names values ('Nut000017','Stanley Kubrick');
insert into director_names values ('Nut000018','Joseph L. Mankiewicz');
insert into director_names values ('Nut000019','Doug Liman');
insert into director_names values ('Nut000020','Howard Hawks');
insert into director_names values ('Nut000021','Len Wisesman');
insert into director_names values ('Nut000022','Mark Steven Johnson');
insert into director_names values ('Nut000023','Tim Burton');
insert into director_names values ('Nut000024','Martin Scorsese');
insert into writer_names values ('Nut000025','Sam Mendes');
insert into writer_names values ('Nut000026','Marc Foster');
insert into writer_names values ('Nut000027','Martin Campbell');
insert into writer_names values ('Nut000028','Lee Tamahori');
insert into writer_names values ('Nut000029','Michael Apted');
insert into writer_names values ('Nut000030','Roger Spottiswoode');
insert into writer_names values ('Nut000031','John Glen');
insert into writer_names values ('Nut000032','Irvin Kershner');
insert into writer_names values ('Nut000033','Lewis Gilbert');
insert into writer_names values ('Nut000034','Guy Hamilton');
insert into writer_names values ('Nut000035','Peter R. Hunt');
insert into writer_names values ('Nut000036','John Huston');
insert into writer_names values ('Nut000037','Terence Young');
insert into writer_names values ('Nut000038','Ben Affleck');
insert into writer_names values ('Nut000039','David Lynch');
insert into writer_names values ('Nut000040','Denis Villeneuve');
insert into writer_names values ('Nut000041','Ridley Scott');
insert into writer_names values ('Nut000042','Gus Van Sant');
insert into writer_names values ('Nut000043','Zack Snyder');
insert into writer_names values ('Nut000044','David Ayer');
insert into writer_names values ('Nut000045','Todd Phillips');
insert into writer_names values ('Nut000046','Paul Verhoeven');
insert into writer_names values ('Nut000047','Sam Raimi');
insert into writer_names values ('Nut000048','Marc Webb');
insert into writer_names values ('Nut000049','Jon Watts');
insert into writer_names values ('Nut000050','Stanley Kubrick');
insert into writer_names values ('Nut000051','Joseph L. Mankiewicz');
insert into writer_names values ('Nut000052','Doug Liman');
insert into writer_names values ('Nut000053','Howard Hawks');
insert into writer_names values ('Nut000054','Len Wisesman');
insert into writer_names values ('Nut000055','Mark Steven Johnson');
insert into writer_names values ('Nut000056','Tim Burton');
insert into writer_names values ('Nut000057','Martin Scorsese');
insert into writer_names values ('Nut000058','Sam Mendes');
insert into writer_names values ('Nut000059','Marc Foster');
insert into writer_names values ('Nut000060','Martin Campbell');
insert into writer_names values ('Nut000061','Lee Tamahori');
insert into writer_names values ('Nut000062','Michael Apted');
insert into writer_names values ('Nut000063','Roger Spottiswoode');
insert into writer_names values ('Nut000064','John Glen');

insert into Production_House values ('Nut000011','HBO');
insert into Production_House values ('Nut000012','Warner Bros');
insert into Production_House values ('Nut000013','Paramount');
insert into Production_House values ('Nut000014','20th Century Studios');
insert into Production_House values ('Nut000015','Universal Pictures');
insert into Production_House values ('Nut000016','Warner Bros');
insert into Production_House values ('Nut000017','Paramount');
insert into Production_House values ('Nut000018','20th Century Studios');
insert into Production_House values ('Nut000019','Universal Pictures');
insert into Production_House values ('Nut000020','20th Century Studios');
insert into Production_House values ('Nut000021','Universal Pictures');
insert into Production_House values ('Nut000022','HBO');
insert into Production_House values ('Nut000023','Warner Bros');
insert into Production_House values ('Nut000024','Paramount');
insert into Production_House values ('Nut000025','20th Century Studios');
insert into Production_House values ('Nut000026','Universal Pictures');
insert into Production_House values ('Nut000027','Warner Bros');
insert into Production_House values ('Nut000028','Paramount');
insert into Production_House values ('Nut000029','20th Century Studios');
insert into Production_House values ('Nut000030','Universal Pictures');
insert into Production_House values ('Nut000031','20th Century Studios');
insert into Production_House values ('Nut000032','Universal Pictures');
insert into Production_House values ('Nut000033','HBO');
insert into Production_House values ('Nut000034','Warner Bros');
insert into Production_House values ('Nut000035','Paramount');
insert into Production_House values ('Nut000036','20th Century Studios');
insert into Production_House values ('Nut000037','Universal Pictures');
insert into Production_House values ('Nut000038','Warner Bros');
insert into Production_House values ('Nut000039','Paramount');
insert into Production_House values ('Nut000040','20th Century Studios');
insert into Production_House values ('Nut000041','Universal Pictures');
insert into Production_House values ('Nut000042','20th Century Studios');
insert into Production_House values ('Nut000043','Universal Pictures');
insert into Production_House values ('Nut000044','HBO');
insert into Production_House values ('Nut000045','Warner Bros');
insert into Production_House values ('Nut000046','Paramount');
insert into Production_House values ('Nut000047','20th Century Studios');
insert into Production_House values ('Nut000048','Universal Pictures');
insert into Production_House values ('Nut000049','Warner Bros');
insert into Production_House values ('Nut000050','Paramount');
insert into Production_House values ('Nut000051','20th Century Studios');
insert into Production_House values ('Nut000052','Universal Pictures');
insert into Production_House values ('Nut000053','20th Century Studios');
insert into Production_House values ('Nut000054','Universal Pictures');
insert into Production_House values ('Nut000055','HBO');
insert into Production_House values ('Nut000056','Warner Bros');
insert into Production_House values ('Nut000057','Paramount');
insert into Production_House values ('Nut000058','20th Century Studios');
insert into Production_House values ('Nut000059','Universal Pictures');
insert into Production_House values ('Nut000060','Warner Bros');
insert into Production_House values ('Nut000061','Paramount');
insert into Production_House values ('Nut000062','20th Century Studios');
insert into Production_House values ('Nut000063','Universal Pictures');
insert into Production_House values ('Nut000064','20th Century Studios');
insert into Production_House values ('Nut000012','Universal Pictures');
insert into Production_House values ('Nut000013','HBO');
insert into Production_House values ('Nut000014','Warner Bros');
insert into Production_House values ('Nut000015','Paramount');
insert into Production_House values ('Nut000016','20th Century Studios');
insert into Production_House values ('Nut000017','Universal Pictures');
insert into Production_House values ('Nut000018','Warner Bros');
insert into Production_House values ('Nut000019','Paramount');
insert into Production_House values ('Nut000020','20th Century Studios');
insert into Production_House values ('Nut000021','Universal Pictures');
insert into Production_House values ('Nut000022','20th Century Studios');
insert into Production_House values ('Nut000023','Universal Pictures');
insert into Production_House values ('Nut000024','HBO');
insert into Production_House values ('Nut000025','Warner Bros');
insert into Production_House values ('Nut000026','Paramount');
insert into Production_House values ('Nut000027','20th Century Studios');
insert into Production_House values ('Nut000028','Universal Pictures');
insert into Production_House values ('Nut000029','Warner Bros');
insert into Production_House values ('Nut000030','Paramount');
insert into Production_House values ('Nut000031','20th Century Studios');
insert into Production_House values ('Nut000032','Universal Pictures');
insert into Production_House values ('Nut000033','20th Century Studios');
insert into Production_House values ('Nut000034','Universal Pictures');
insert into Production_House values ('Nut000035','HBO');
insert into Production_House values ('Nut000036','Warner Bros');
insert into Production_House values ('Nut000037','Paramount');
insert into Production_House values ('Nut000038','20th Century Studios');
insert into Production_House values ('Nut000039','Universal Pictures');
insert into Production_House values ('Nut000040','Warner Bros');
insert into Production_House values ('Nut000041','Paramount');
insert into Production_House values ('Nut000042','20th Century Studios');
insert into Production_House values ('Nut000043','Universal Pictures');
insert into Production_House values ('Nut000044','20th Century Studios');
insert into Production_House values ('Nut000045','Universal Pictures');
insert into Production_House values ('Nut000046','HBO');
insert into Production_House values ('Nut000047','Warner Bros');
insert into Production_House values ('Nut000048','Paramount');
insert into Production_House values ('Nut000049','20th Century Studios');
insert into Production_House values ('Nut000050','Universal Pictures');
insert into Production_House values ('Nut000051','Warner Bros');
insert into Production_House values ('Nut000052','Paramount');
insert into Production_House values ('Nut000053','20th Century Studios');
insert into Production_House values ('Nut000054','Universal Pictures');
insert into Production_House values ('Nut000055','20th Century Studios');
insert into Production_House values ('Nut000056','Universal Pictures');
insert into Production_House values ('Nut000057','HBO');
insert into Production_House values ('Nut000058','Warner Bros');
insert into Production_House values ('Nut000059','Paramount');
insert into Production_House values ('Nut000060','20th Century Studios');
insert into Production_House values ('Nut000061','Universal Pictures');
insert into Production_House values ('Nut000062','Warner Bros');
insert into Production_House values ('Nut000063','Paramount');
insert into Production_House values ('Nut000064','20th Century Studios');

insert into crew_details values ('Nut000012','actor',NULL,'Pierce Brosnan');
insert into crew_details values ('Nut000013','actor',NULL,'Timothy Dalton');
insert into crew_details values ('Nut000014','actor',NULL,'Sean Connery');
insert into crew_details values ('Nut000015','actor',NULL,'Roger Moore');
insert into crew_details values ('Nut000016','actor',NULL,'George Lazenby');
insert into crew_details values ('Nut000017','actor',NULL,'David Niven');
insert into crew_details values ('Nut000018','actor',NULL,'Ben Affleck');
insert into crew_details values ('Nut000019','actor',NULL,'Kyle MacLachlan');
insert into crew_details values ('Nut000020','actor',NULL,'Timothee Chalamet');
insert into crew_details values ('Nut000021','actor',NULL,'Matt Damon');
insert into crew_details values ('Nut000022','actor',NULL,'Will Smith');
insert into crew_details values ('Nut000023','actor',NULL,'Jaoquin Phoenix');
insert into crew_details values ('Nut000024','actor',NULL,'Arnold Schwarzenegger');
insert into crew_details values ('Nut000025','actor',NULL,'Tobey Maguire');
insert into crew_details values ('Nut000026','actor',NULL,'Andrew Garfield');
insert into crew_details values ('Nut000027','actor',NULL,'Tom Holland');
insert into crew_details values ('Nut000028','actor',NULL,'Tom Cruise');
insert into crew_details values ('Nut000029','actor',NULL,'Nicole Kidman');
insert into crew_details values ('Nut000030','actor',NULL,'Richard Burton');
insert into crew_details values ('Nut000031','actor',NULL,'Elizabeth Taylor');
insert into crew_details values ('Nut000032','actor',NULL,'Brad Pitt');
insert into crew_details values ('Nut000033','actor',NULL,'Angelina Jolie');
insert into crew_details values ('Nut000034','actor',NULL,'Humphrey Bogart');
insert into crew_details values ('Nut000035','actor',NULL,'Lauren Bacall');
insert into crew_details values ('Nut000036','actor',NULL,'Colin Farrell');
insert into crew_details values ('Nut000037','actor',NULL,'Jennifer Garner');
insert into crew_details values ('Nut000038','actor',NULL,'Johnny Depp');
insert into crew_details values ('Nut000039','actor',NULL,'Robert De Niro');
insert into crew_details values ('Nut000040','actor',NULL,'Helena Bonham Carter');
insert into crew_details values ('Nut000041','actor',NULL,'Pierce Brosnan');
insert into crew_details values ('Nut000042','actor',NULL,'Timothy Dalton');
insert into crew_details values ('Nut000043','actor',NULL,'Sean Connery');
insert into crew_details values ('Nut000044','actor',NULL,'Roger Moore');
insert into crew_details values ('Nut000045','actor',NULL,'George Lazenby');
insert into crew_details values ('Nut000046','actor',NULL,'David Niven');
insert into crew_details values ('Nut000047','actor',NULL,'Ben Affleck');
insert into crew_details values ('Nut000048','actor',NULL,'Kyle MacLachlan');
insert into crew_details values ('Nut000049','actor',NULL,'Timothee Chalamet');
insert into crew_details values ('Nut000050','actor',NULL,'Matt Damon');
insert into crew_details values ('Nut000051','actor',NULL,'Will Smith');
insert into crew_details values ('Nut000052','actor',NULL,'Jaoquin Phoenix');
insert into crew_details values ('Nut000053','actor',NULL,'Arnold Schwarzenegger');
insert into crew_details values ('Nut000054','actor',NULL,'Tobey Maguire');
insert into crew_details values ('Nut000055','actor',NULL,'Andrew Garfield');
insert into crew_details values ('Nut000056','actor',NULL,'Tom Holland');
insert into crew_details values ('Nut000057','actor',NULL,'Tom Cruise');
insert into crew_details values ('Nut000058','actor',NULL,'Nicole Kidman');
insert into crew_details values ('Nut000059','actor',NULL,'Richard Burton');
insert into crew_details values ('Nut000060','actor',NULL,'Elizabeth Taylor');
insert into crew_details values ('Nut000061','actor',NULL,'Brad Pitt');
insert into crew_details values ('Nut000062','actor',NULL,'Angelina Jolie');
insert into crew_details values ('Nut000063','actor',NULL,'Humphrey Bogart');
insert into crew_details values ('Nut000064','actor',NULL,'Lauren Bacall');
insert into crew_details values ('Nut000012','director',NULL,'Sam Mendes');
insert into crew_details values ('Nut000013','director',NULL,'Marc Foster');
insert into crew_details values ('Nut000014','director',NULL,'Martin Campbell');
insert into crew_details values ('Nut000015','director',NULL,'Lee Tamahori');
insert into crew_details values ('Nut000016','director',NULL,'Michael Apted');
insert into crew_details values ('Nut000017','director',NULL,'Roger Spottiswoode');
insert into crew_details values ('Nut000018','director',NULL,'John Glen');
insert into crew_details values ('Nut000019','director',NULL,'Irvin Kershner');
insert into crew_details values ('Nut000020','director',NULL,'Lewis Gilbert');
insert into crew_details values ('Nut000021','director',NULL,'Guy Hamilton');
insert into crew_details values ('Nut000022','director',NULL,'Peter R. Hunt');
insert into crew_details values ('Nut000023','director',NULL,'John Huston');
insert into crew_details values ('Nut000024','director',NULL,'Terence Young');
insert into crew_details values ('Nut000025','director',NULL,'Ben Affleck');
insert into crew_details values ('Nut000026','director',NULL,'David Lynch');
insert into crew_details values ('Nut000027','director',NULL,'Denis Villeneuve');
insert into crew_details values ('Nut000028','director',NULL,'Ridley Scott');
insert into crew_details values ('Nut000029','director',NULL,'Gus Van Sant');
insert into crew_details values ('Nut000030','director',NULL,'Zack Snyder');
insert into crew_details values ('Nut000031','director',NULL,'David Ayer');
insert into crew_details values ('Nut000032','director',NULL,'Todd Phillips');
insert into crew_details values ('Nut000033','director',NULL,'Paul Verhoeven');
insert into crew_details values ('Nut000034','director',NULL,'Sam Raimi');
insert into crew_details values ('Nut000035','director',NULL,'Marc Webb');
insert into crew_details values ('Nut000036','director',NULL,'Jon Watts');
insert into crew_details values ('Nut000037','director',NULL,'Stanley Kubrick');
insert into crew_details values ('Nut000038','director',NULL,'Joseph L. Mankiewicz');
insert into crew_details values ('Nut000039','director',NULL,'Doug Liman');
insert into crew_details values ('Nut000040','director',NULL,'Howard Hawks');
insert into crew_details values ('Nut000041','director',NULL,'Len Wisesman');
insert into crew_details values ('Nut000042','director',NULL,'Mark Steven Johnson');
insert into crew_details values ('Nut000043','director',NULL,'Tim Burton');
insert into crew_details values ('Nut000044','director',NULL,'Martin Scorsese');
insert into crew_details values ('Nut000045','director',NULL,'Sam Mendes');
insert into crew_details values ('Nut000046','director',NULL,'Marc Foster');
insert into crew_details values ('Nut000047','director',NULL,'Martin Campbell');
insert into crew_details values ('Nut000048','director',NULL,'Lee Tamahori');
insert into crew_details values ('Nut000049','director',NULL,'Michael Apted');
insert into crew_details values ('Nut000050','director',NULL,'Roger Spottiswoode');
insert into crew_details values ('Nut000051','director',NULL,'John Glen');
insert into crew_details values ('Nut000052','director',NULL,'Irvin Kershner');
insert into crew_details values ('Nut000053','director',NULL,'Lewis Gilbert');
insert into crew_details values ('Nut000054','director',NULL,'Guy Hamilton');
insert into crew_details values ('Nut000055','director',NULL,'Peter R. Hunt');
insert into crew_details values ('Nut000056','director',NULL,'John Huston');
insert into crew_details values ('Nut000057','director',NULL,'Terence Young');
insert into crew_details values ('Nut000058','director',NULL,'Ben Affleck');
insert into crew_details values ('Nut000059','director',NULL,'David Lynch');
insert into crew_details values ('Nut000060','director',NULL,'Denis Villeneuve');
insert into crew_details values ('Nut000061','director',NULL,'Ridley Scott');
insert into crew_details values ('Nut000062','director',NULL,'Gus Van Sant');
insert into crew_details values ('Nut000063','director',NULL,'Zack Snyder');
insert into crew_details values ('Nut000064','director',NULL,'David Ayer');
insert into crew_details values ('Nut000012','writer',NULL,'Todd Phillips');
insert into crew_details values ('Nut000013','writer',NULL,'Paul Verhoeven');
insert into crew_details values ('Nut000014','writer',NULL,'Sam Raimi');
insert into crew_details values ('Nut000015','writer',NULL,'Marc Webb');
insert into crew_details values ('Nut000016','writer',NULL,'Jon Watts');
insert into crew_details values ('Nut000017','writer',NULL,'Stanley Kubrick');
insert into crew_details values ('Nut000018','writer',NULL,'Joseph L. Mankiewicz');
insert into crew_details values ('Nut000019','writer',NULL,'Doug Liman');
insert into crew_details values ('Nut000020','writer',NULL,'Howard Hawks');
insert into crew_details values ('Nut000021','writer',NULL,'Len Wisesman');
insert into crew_details values ('Nut000022','writer',NULL,'Mark Steven Johnson');
insert into crew_details values ('Nut000023','writer',NULL,'Tim Burton');
insert into crew_details values ('Nut000024','writer',NULL,'Martin Scorsese');
insert into crew_details values ('Nut000025','writer',NULL,'Sam Mendes');
insert into crew_details values ('Nut000026','writer',NULL,'Marc Foster');
insert into crew_details values ('Nut000027','writer',NULL,'Martin Campbell');
insert into crew_details values ('Nut000028','writer',NULL,'Lee Tamahori');
insert into crew_details values ('Nut000029','writer',NULL,'Michael Apted');
insert into crew_details values ('Nut000030','writer',NULL,'Roger Spottiswoode');
insert into crew_details values ('Nut000031','writer',NULL,'John Glen');
insert into crew_details values ('Nut000032','writer',NULL,'Irvin Kershner');
insert into crew_details values ('Nut000033','writer',NULL,'Lewis Gilbert');
insert into crew_details values ('Nut000034','writer',NULL,'Guy Hamilton');
insert into crew_details values ('Nut000035','writer',NULL,'Peter R. Hunt');
insert into crew_details values ('Nut000036','writer',NULL,'John Huston');
insert into crew_details values ('Nut000037','writer',NULL,'Terence Young');
insert into crew_details values ('Nut000038','writer',NULL,'Ben Affleck');
insert into crew_details values ('Nut000039','writer',NULL,'David Lynch');
insert into crew_details values ('Nut000040','writer',NULL,'Denis Villeneuve');
insert into crew_details values ('Nut000041','writer',NULL,'Ridley Scott');
insert into crew_details values ('Nut000042','writer',NULL,'Gus Van Sant');
insert into crew_details values ('Nut000043','writer',NULL,'Zack Snyder');
insert into crew_details values ('Nut000044','writer',NULL,'David Ayer');
insert into crew_details values ('Nut000045','writer',NULL,'Todd Phillips');
insert into crew_details values ('Nut000046','writer',NULL,'Paul Verhoeven');
insert into crew_details values ('Nut000047','writer',NULL,'Sam Raimi');
insert into crew_details values ('Nut000048','writer',NULL,'Marc Webb');
insert into crew_details values ('Nut000049','writer',NULL,'Jon Watts');
insert into crew_details values ('Nut000050','writer',NULL,'Stanley Kubrick');
insert into crew_details values ('Nut000051','writer',NULL,'Joseph L. Mankiewicz');
insert into crew_details values ('Nut000052','writer',NULL,'Doug Liman');
insert into crew_details values ('Nut000053','writer',NULL,'Howard Hawks');
insert into crew_details values ('Nut000054','writer',NULL,'Len Wisesman');
insert into crew_details values ('Nut000055','writer',NULL,'Mark Steven Johnson');
insert into crew_details values ('Nut000056','writer',NULL,'Tim Burton');
insert into crew_details values ('Nut000057','writer',NULL,'Martin Scorsese');
insert into crew_details values ('Nut000058','writer',NULL,'Sam Mendes');
insert into crew_details values ('Nut000059','writer',NULL,'Marc Foster');
insert into crew_details values ('Nut000060','writer',NULL,'Martin Campbell');
insert into crew_details values ('Nut000061','writer',NULL,'Lee Tamahori');
insert into crew_details values ('Nut000062','writer',NULL,'Michael Apted');
insert into crew_details values ('Nut000063','writer',NULL,'Roger Spottiswoode');
insert into crew_details values ('Nut000064','writer',NULL,'John Glen');

insert into Nutflux_relations values ('Pierce Brosnan','Emilia Clarke','Girlfriend',2012,NULL);
insert into Nutflux_relations values ('Timothy Dalton','Lena Headey','Girlfriend',2012,NULL);
insert into Nutflux_relations values ('Sean Connery','Maisie Williams','Girlfriend',2012,NULL);
insert into Nutflux_relations values ('Roger Moore','Sophie Turner','Girlfriend',2022,NULL);
insert into Nutflux_relations values ('George Lazenby','Carice van Houten','Girlfriend',2022,NULL);
insert into Nutflux_relations values ('David Niven','Diana Rigg','Girlfriend',2022,NULL);
insert into Nutflux_relations values ('Ben Affleck','Timothee Chalamet','Girlfriend',2022,NULL);
insert into Nutflux_relations values ('Kyle MacLachlan','Elizabeth Taylor','Girlfriend',2022,NULL);
insert into Nutflux_relations values ('Timothee Chalamet','Angelina Jolie','Girlfriend',2022,NULL);
insert into Nutflux_relations values ('Matt Damon','Lauren Bacall','Girlfriend',2022,NULL);
insert into Nutflux_relations values ('Will Smith','Jennifer Garner','Girlfriend',2022,NULL);
insert into Nutflux_relations values ('Will Smith','Helena Bonham Carter','Married',2022,NULL);

insert into crew_details values ('Nut000014','actor',NULL,'Pierce Brosnan');
insert into crew_details values ('Nut000014','actor',NULL,'Emilia Clarke');
insert into crew_details values ('Nut000022','actor',NULL,'Helena Bonham Carter');

-- PROCEDURAL ELEMENTS

-- DROP TRIGGER IF EXISTS title_after_delete;
-- DROP TRIGGER IF EXISTS user_after_delete;
-- DROP TRIGGER IF EXISTS relation_after_update;
-- DROP PROCEDURE IF EXISTS famous_character_details;
-- DROP PROCEDURE IF EXISTS get_movie_byrating;
-- DROP PROCEDURE IF EXISTS get_names_byage;
-- DROP PROCEDURE IF EXISTS fetch_titles_for_actor;


-- TRIGGER - AUDITING MOVIE TITLES  

create table titles_audit ( title_id varchar(255), deleted_date date, removed_by varchar(50));

DELIMITER //
CREATE TRIGGER title_after_delete AFTER DELETE ON Nutflux_Titles
FOR EACH ROW
BEGIN
DECLARE vUser varchar(50);
SELECT USER() into vUser;
INSERT into titles_audit (title_id,deleted_date,removed_by) VALUES (OLD.title_id,SYSDATE(),vUser);
END //
DELIMITER ;

-- TRIGGER - AUDITING USER INFO

create table user_audit ( user_id varchar(255), deleted_date date, removed_by varchar(50));

DELIMITER //
CREATE TRIGGER user_after_delete AFTER DELETE ON User_Info
FOR EACH ROW
BEGIN
DECLARE vUser varchar(50);
SELECT USER() into vUser;
INSERT into user_audit (user_id,deleted_date,removed_by) VALUES (OLD.user_id,SYSDATE(),vUser);
END //
DELIMITER ;

-- TRIGGER - AUDITING RELATION INFO  

create table relation_audit ( name_one varchar(255), name_two varchar(255), relation varchar(255), relation_start_year SMALLINT, relation_end_year SMALLINT, alter_date date, updated_by varchar(50));

DELIMITER //
CREATE TRIGGER relation_after_update AFTER UPDATE ON Nutflux_relations
FOR EACH ROW
BEGIN
DECLARE vUser varchar(50);
SELECT USER() into vUser;
INSERT into relation_audit (name_one, name_two, relation, relation_start_year, relation_end_year, alter_date, updated_by) VALUES (OLD.name_one, OLD.name_two, OLD.relation, OLD.relation_start_year, OLD.relation_end_year, SYSDATE(), vUser);
END //
DELIMITER ;


-- PROCEDURE - FETCH FAMOUS CHARACTERS INFO

DELIMITER //
CREATE PROCEDURE famous_character_details(IN role varchar(30))
BEGIN
    SELECT t.primary_title,n.name,r.role_name,g.genre FROM Nutflux_Titles t, known_role r, Names_Nutflux n, t_genres g where r.role_name = role and t.title_id=r.title_id and r.name=n.name and g.title_id= t.title_id;
END //
DELIMITER ;

-- PROCEDURE - FETCH MOVIES BY RATING

DELIMITER //
CREATE PROCEDURE get_movie_byrating(IN rating float)
BEGIN
    SELECT t.*,r.avg_ratings,g.genre FROM Nutflux_Titles t, Title_ratings r, T_genres g where r.avg_ratings >= rating and t.title_type = 'movie' and t.title_id = r.title_id and g.title_id = t.title_id;
END //
DELIMITER ;


-- PROCEDURE - FETCH PEOPLE BY AGE

DELIMITER //
CREATE PROCEDURE get_names_byage(IN age int)
BEGIN
    select * from Names_Nutflux where (YEAR(sysdate()) - birth_year) >= age;
END //
DELIMITER ;

-- PROCEDURE - FETCH TITLES BY ACTOR

DELIMITER //
CREATE PROCEDURE fetch_titles_for_actor(IN actor varchar(50))
BEGIN
    SELECT nn.name, nt.primary_title, tr.avg_ratings from crew_details cd join names_nutflux nn on nn.name = cd.name join nutflux_titles nt on nt.title_id = cd.title_id join Title_ratings tr on nt.title_id=tr.title_id where cd.category = 'actor' AND nn.name = actor;
END //
DELIMITER ;

-- PROCEDURE QUERIES

call famous_character_details('Batman');
call get_movie_byrating(9.8);
call get_names_byage(50);
call fetch_titles_for_actor('Morgan Freeman');

-- VIEWS

-- DROP VIEW IF EXISTS got_ratings;
-- DROP VIEW IF EXISTS top_chart_movies;
-- DROP VIEW IF EXISTS top_chart_actors;
-- DROP VIEW IF EXISTS famous_franchise;
-- DROP VIEW IF EXISTS consistent_awardees;
-- DROP VIEW IF EXISTS top_awarded_genres;


-- What were the names and average ratings of each episode of The Game of Thrones?
CREATE OR REPLACE VIEW got_ratings(primary_title,season_number,episode_number,average_rating)
AS SELECT NT1.primary_title, E.season_number, E.episode_number, R.avg_ratings
FROM Nutflux_Titles AS NT, Nutflux_Titles AS NT1, Episode_of_title AS E, Title_ratings AS R
WHERE NT.primary_title = 'game of thrones'
AND NT.title_type = 'tvseries'
AND NT.title_id = E.parent_title_id
AND NT1.title_type = 'tvepisode'
AND NT1.title_id = E.episode_title_id
AND NT1.title_id = R.title_id
ORDER BY E.season_number, E.episode_number;

-- What are the top 5 movies as determined by the average rating with the over 100,000 votes?
CREATE OR REPLACE VIEW top_chart_movies(title_id,primary_title,average_rating)
AS SELECT T.title_id, T.primary_title, R.avg_ratings
FROM Nutflux_Titles AS T, Title_ratings AS R
WHERE T.title_id = R.title_id
AND T.title_type = 'movie'
AND R.no_of_ratings > 100000
ORDER BY R.avg_ratings DESC
LIMIT 5;

-- Who are the top 3 actors who have made the most movies listed in the top movies
CREATE OR REPLACE VIEW top_chart_actors(name,Count)
AS SELECT H.name, COUNT(*) AS Count
FROM top_chart_movies tcm, Nutflux_Titles AS T, Names_Nutflux AS N, known_role AS H
WHERE tcm.title_id = T.title_id
AND T.title_id = H.title_id
AND N.name = H.name
GROUP BY H.name
ORDER BY Count DESC
LIMIT 3;

-- What are the most famous character franchises?
CREATE OR REPLACE VIEW famous_franchise
AS SELECT FI.primary_title, AR.role_name AS FRANCHISE_NAME 
FROM Nutflux_Titles FI JOIN known_role AR ON AR.title_id = FI.title_id where AR.role_name in (SELECT AR.role_name 
FROM Nutflux_Titles FI JOIN known_role AR ON AR.title_id = FI.title_id 
GROUP BY AR.role_name HAVING COUNT(*) > 3);

-- What are the top awarded genres?
CREATE OR REPLACE VIEW top_awarded_genres as 
select nt.primary_title, tg.genre, a.award_type, nn.name from Nutflux_Titles nt 
join T_genres tg on nt.title_id = tg.title_id join awards a on a.title_id = nt.title_id 
join Names_Nutflux nn on nn.name = a.name where tg.genre in (select tgg.genre from Nutflux_Titles nt 
join T_genres tgg on nt.title_id = tgg.title_id join awards a on a.title_id = nt.title_id 
join Names_Nutflux nn on nn.name = a.name group by tgg.genre order by count(*) desc);

-- VIEW QUERIES

SELECT * FROM got_ratings;

SELECT * FROM top_chart_movies;

SELECT * FROM top_chart_actors;

SELECT * FROM famous_franchise;

SELECT * FROM top_awarded_genres;


-- STANDARD USER QUERIES
-- USING DUNE MOVIE AS EXAMPLE FOR STANDARD USER

select * from nutflux_titles where primary_title = 'Dune';

select f.primary_title as film, fr.avg_ratings as IMDBRating
from Nutflux_Titles f
join Title_ratings fr
on f.title_id = fr.title_id
where f.primary_title = 'Dune';

select dn.name, nt.primary_title, nt.start_year from director_names dn join Nutflux_Titles nt on dn.title_id = nt.title_id join Names_Nutflux nn on nn.name = dn.name where nt.primary_title = 'Dune';

select dn.name, nt.primary_title, nt.start_year from writer_names dn join Nutflux_Titles nt on dn.title_id = nt.title_id join Names_Nutflux nn on nn.name = dn.name where nt.primary_title = 'Dune';

select * from Production_House dn join Nutflux_Titles nt on dn.title_id = nt.title_id where nt.primary_title = 'Dune';

select * from crew_details dn join Nutflux_Titles nt on dn.title_id = nt.title_id where nt.primary_title = 'Dune';


-- POWER USER QUERIES

-- TITLES WHICH DID NOT WIN ANY AWARD BUT GOT NOMINATED

select n.title_id,n.primary_title from Nutflux_Titles n, awards a where a.won_or_nomination not like 'won%' and a.title_id=n.title_id and n.title_id not in ( select title_id from awards where won_or_nomination like 'won%' group by title_id) group by n.title_id,n.primary_title ;

-- FETCH CONSISTENT AWARDEES

SELECT t.name, t.award_type, t.award_for from 
(select a.*, lead(a.award_year, 2) over (partition by a.name order by a.award_year) as year_2 from awards a join Names_Nutflux nn on nn.name = a.name where a.won_or_nomination = 'Won') t 
where year_2 = t.award_year + 2;

-- List all films starring two actors that were socially connected before the film was RELEASED.

select nr.name_one, nr.name_two, nr.relation, nr.relation_start_year, nt.start_year, nt.primary_title from nutflux_relations nr join crew_details cd on nr.name_one = cd.name join nutflux_titles nt on nt.title_id = cd.title_id where nr.relation_start_year < nt.start_year;

-- Which actors who have worked in The Batman have won an award?

select * from known_role kr join awards aa on aa.title_id = kr.title_id where kr.role_name = "Batman" and aa.won_or_nomination = "Won";


-- Which Oscar-winning actors have played superheroes

select nt.primary_title, tg.genre, aa.* from t_genres tg join awards aa on aa.title_id = tg.title_id join nutflux_titles nt on nt.title_id = tg.title_id where tg.genre = "superhero" and aa.won_or_nomination = "Won" and aa.award_type = "Oscar";




