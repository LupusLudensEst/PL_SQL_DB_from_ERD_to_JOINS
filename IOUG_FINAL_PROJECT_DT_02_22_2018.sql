/*
IOUG Oracle Database Design Final Project
Topic: Historic person information matrix
Started: 02/19/2018
Author: Gurov Viacheslav, ID #0617503629, ATC, Florida

INTRODUCTION
	This work provides a great way to look through the life of every interesting for user-researcher historic person. That was inspired by one of the greatest leaders of last time- Sir Winston Churchill. This model helps build an information matrix to keep track of the whole life and achievements of historic person in all meaningful aspects. 

Target Audience
	These could be all interested- starting from young persons, students and till researching organizations.

Executive Summary
	This tool offers comprehensive description of historic person life.

Study Draft:

I
Entity: HISTORIC PERSON
Attributes: #Id, *Date of birth, *Date of death, oMiscellanea
II
Entity: LIFE EVENT
Attributes: #Id, *Name, *Year, *Meaning, oMiscellanea
III
Entity: PEDIGREE
Attributes: #Id, *Date of birth, *Name, *Relationship, oMiscellanea
IV
Entity: BOOK
Attributes: #Id, *Title, *Author, *Year, *ISBN, oMiscellanea
V
Entity:     ARTEFACT
Attributes: #Id, *Name, *Year, oMiscellanea

Total: V (Five) entities.

Rules, constraints, assumptions:

The entities grant names for soft boxes and define the structure:
1. HISTORIC PERSON. The instance of that could be every interesting historic person. As in our sample case-Sir Winston Churchill;
2. EVENT. The instance of that in our case could be: birth, death, enrollment into Royal Military College (now Academy) Sand Hurst, etc.;
3. PEDIGREE. The instance of that in our case could be relativies: from siblings and cousins till great great grandparents;
4. BOOK. The instance of that in our case could be every of forty-three books written by Churchill himself that filled seventy-two volumes. And all books written by others authors devoted to him and events which he was involved in;
5. ARTEFACT. The instance of that in our case could be art painting, pottery, scientific invention, whatever else, created by our historic person.


The entities relationships are:

HISTORIC PERSON in the central entity soft box relates to the subordinated soft boxes by the relationship lines of different cardinality(*) status. Dotted single lines at the central entity soft box and crow’s feet solid lines at the subordinated soft boxes sides.
For example: HISTORIC PERSON may have PEDIGREE or not, many relativies or not. But the instance of entity PEDIGREE, say parent, to be considered- must have HISTORIC PERSON as a child. I.e. optionality(o) at the HISTORIC PERSON side and cardinality(*) at the subordinated entities sides.
	The user of our database has convenient tool to get access to different aspects of interesting historic person’s life and as a researcher has a chance to add and delete new and existing fact about that person to and in database, implementing CRUD principle- create, read, update and delete.


Constraints:
All data here should possess the whole combination of attributes. I.e. the data, for example ATREFACT and EVENT without date and name of event or/and creation should not be entered and should to be considered as not authentic.

Tables:

I

HISTORIC PERSONS(HPN)
Key Type	Optionality	Column Name
pk	*	id
 	*	name
 	*	dob
 	*	dod
 	o	mca


II

LIFE EVENTS(LET)
Key Type	Optionality	Column Name
pk	*	id
 	*	name
 	*	year
 	*	mag
 	o	mca

III

PEDIGREE(PDE)
Key Type	Optionality	Column Name
pk	*	id
 	*	name
 	*	dob
 	*	dod
 	*	rlp
 	o	mca

IV

BOOKS(BOK)
Key Type	Optionality	Column Name
pk	*	id
	*	tte
	*	aur
	*	year
	*	isbn
	o	mca


V

ARTEFACTS(ATT)
Key Type	Optionality	Column Name
pk	*	id
 	*	name
 	*	year
 	o	mca
*/

--PL SQL Code creating the all mentioned tables and inserting data into them.

--
create table HISTORIC_PERSONS(
id number(8) not null,
name varchar2(40) not null,
dob date,
dod date,
mca varchar2(400),
constraint  HISTORIC_PERSONS_PK primary key (id)
);

create sequence seq_HISTORIC_PERSONS
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 20;

insert into HISTORIC_PERSONS(id, name, dob, dod, mca)
values(seq_HISTORIC_PERSONS.nextval, 'Winston Leonard Spencer Churchill', DATE '1874-11-30', DATE '1965-01-24', 'My ideal and cumir.');

select * from HISTORIC_PERSONS;
--

create table LIFE_EVENTS(
id  number(8) not null,
name varchar2(40) not null,
year date,
meaning varchar2(400),
mca varchar2(100),
constraint LIFE_EVENTS_PK primary key(id)
);

create sequence seq_LIFE_EVENTS
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 20;

insert into LIFE_EVENTS(id, name, year, meaning, mca)
values(seq_LIFE_EVENTS.nextval, 'Birth', DATE '1874-11-30', 'Winston Leonard Spencer Churchill - is future British leader during WW2 was born', 'See google' );

insert into LIFE_EVENTS(id, name, year, meaning, mca)
values(seq_LIFE_EVENTS.nextval, 'Schooling', DATE '1882-01-01', 'Schooling 1882-1888. Winston attended St. George’s School, Ascot, from 1882
through 1884.', 'See google' );

select * from LIFE_EVENTS order by id;

drop table LIFE_EVENTS purge;

drop sequence seq_LIFE_EVENTS;

delete * from life_events where NAME = 'Schooling';

UPDATE LIFE_EVENTS SET ID = '2' WHERE ID = '21';
--

create table PEDIGREE(
id number(8) not null,
name varchar2(40) not null,
dob date,
dod date,
relationship varchar2(100),
mca varchar2(100),
constraint PEDIGREE_PK primary key(id)
);

create sequence seq_PEDIGREE
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 20;

insert into PEDIGREE(id, name, dob, dod, relationship, mca)
values(seq_PEDIGREE.nextval, 'John Churchill 1st Duke of Marlborough', DATE '1650-01-01', DATE '1772-01-01', '7 generations back grandfather', 'See columns before');

insert into PEDIGREE(id, name, dob, dod, relationship, mca)
values(seq_PEDIGREE.nextval, 'Charles 3rd Duke of Marlborough', DATE '1706-01-01', DATE '1758-01-01', '6 generations back grandfather', 'See columns before');

insert into PEDIGREE(id, name, dob, dod, relationship, mca)
values(seq_PEDIGREE.nextval, 'George 4th Duke of Marlborough', DATE '1739-01-01', DATE '1817-01-01', '5 generations back grandfather', 'See columns before');

select * from PEDIGREE order by id;

drop table PEDIGREE purge;

drop sequence seq_PEDIGREE;

delete * from PEDIGREE where id = 21;
--

create table BOOKS(
id number(8) not null,
title varchar(100) not null,
author varchar2(100) not null,
year date,
isbn varchar2(50),
mca varchar2(100),
constraint BOOKS_PK primary key(id)
);

create sequence seq_BOOKS
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 20;

insert into BOOKS(id, title, author, year, isbn, mca)
values(seq_BOOKS.nextval, 'The Story of the Malakand Field Force', 'Winston Churchill', DATE '1898-01-01', 'ISBN 10: 074930197X ISBN 13: 9780749301972', 'See columns before');

select * from BOOKS order by id;

drop table BOOKS purge;

drop sequence seq_BOOKS;

delete * from BOOKS where title = 'The Story of the Malakand Field Force';
--

create table ARTEFACTS(
id number(8) not null,
name varchar2(100),
year date,
mca varchar2(500),
constraint ARTEFACTS_PK primary key(id)
);

create sequence seq_ARTEFACTS
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 20;

insert into ARTEFACTS(id, name, year, mca)
values(seq_ARTEFACTS.nextval, 'USA citizenship', DATE '1965-01-24', 'In June of 1963, President John F. Kennedy
made Winston Churchill an honorary citizen of
the United States, a very rare honor. A year and
a half later, Winston Churchill died on the morning
of January 24, 1965, surrounded by family
members. According to his family, Churchill had
predicted that he would die on the anniversary of
his father’s death. This became reality when
Winston Churchill died seventy years to the day
after his father Lord Randolph passed away.
');

select * from ARTEFACTS order by id;

drop table ARTEFACTS purge;

drop sequence seq_ARTEFACTS;

--

select * from HISTORIC_PERSONS h
left join LIFE_EVENTS l
on h.id = l.id order by h.id;

select * from HISTORIC_PERSONS h
left join LIFE_EVENTS l
on h.id = l.id 
where h.name is null
order by h.id;

select * from HISTORIC_PERSONS h
left join LIFE_EVENTS l
on h.id = l.id 
where h.name is not null
order by h.id;

select * from HISTORIC_PERSONS h
right join LIFE_EVENTS l
on h.id = l.id 
order by h.id;

select * from HISTORIC_PERSONS h
right join LIFE_EVENTS l
on h.id != l.id 
order by h.id;

select * from HISTORIC_PERSONS h
right join LIFE_EVENTS l
on h.id = l.id 
where h.name is null
order by h.id;


select * from HISTORIC_PERSONS h
right join LIFE_EVENTS l
on h.id = l.id 
where h.name is not null
order by h.id;


select * from HISTORIC_PERSONS h
full outer join LIFE_EVENTS l
on h.id = l.id 
where h.name is null
order by h.id;

select * from HISTORIC_PERSONS h
full outer join LIFE_EVENTS l
on h.id = l.id 
where h.name is not null
order by h.id;
select * from HISTORIC_PERSONS h
inner join LIFE_EVENTS l
on h.id = l.id 
where h.name is not null
order by h.id;

