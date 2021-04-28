create schema bookdealer_db;
use bookdealer_db;
create table author(authorid int(10), aname varchar(255), acity varchar(255), acountry varchar(255));
create table publisher(publisherid int(10), pname varchar(255), pcity varchar(255), pcountry varchar(255));
create table catalog(bookid int(10), title varchar(255), authorid int(10), publisherid int(10), categoryid int(10), price int(10));
create table category(categoryid int(255), cdescription varchar(255));
create table orderdetail(orderno int(10), bookid int(10), quantity int(10));
ALTER TABLE orderdetail
ADD PRIMARY KEY (orderno);
ALTER TABLE publisher
ADD PRIMARY KEY (publisherid);
ALTER TABLE category
ADD PRIMARY KEY (categoryid);
ALTER TABLE catalog
ADD PRIMARY KEY (bookid);
ALTER TABLE orderdetail
ADD FOREIGN KEY (bookid) REFERENCES catalog(bookid);
ALTER TABLE catalog
ADD FOREIGN KEY (publisherid) REFERENCES publisher(publisherid);
ALTER TABLE catalog
ADD FOREIGN KEY (categoryid) REFERENCES category(categoryid);
INSERT INTO author
VALUES ('1001', 'TERAS CHAN', 'CA', 'USA');
INSERT INTO author
VALUES ('1002', 'STEVENS', 'ZOMBI', 'UGANDA');
INSERT INTO author
VALUES ('1003', 'M MANO', 'CAIR', 'CANADA');
INSERT INTO author
VALUES ('1004', 'KARTHIK B. P.', 'NEW YORK', 'USA');
INSERT INTO author
VALUES ('1005', 'WILLIAM STALLINGS', 'LAS VEGAS', 'USA');
select * from author;
INSERT INTO publisher
VALUES ('1', 'PEARSON', 'NEW YORK', 'USA');
INSERT INTO publisher
VALUES ('2', 'EEE', 'NEW SOUTH VALES', 'USA');
INSERT INTO publisher
VALUES ('3', 'PHI', 'DELHI', 'INDIA');
INSERT INTO publisher
VALUES ('4', 'WILLEY', 'BERLIN', 'GERMANY');
INSERT INTO publisher
VALUES ('5', 'MGH', 'NEW YORK', 'USA');
select * from publisher;
INSERT INTO category
VALUES ('1001', 'COMPUTER SCIENCE');
INSERT INTO category
VALUES ('1002', 'ALGORITHM DESIGN');
INSERT INTO category
VALUES ('1003', 'ELECTRONICS');
INSERT INTO category
VALUES ('1004', 'PROGRAMMING');
INSERT INTO category
VALUES ('1005', 'OPERATING SYSTEM');
select * from category;
ALTER TABLE catalog
CHANGE pubyear pyear int(10);
INSERT INTO catalog
VALUES ('11', 'Unix System Prg', '1001', '1', '1001', '251');
UPDATE catalog
SET year = '2000'
WHERE bookid=11;
INSERT INTO catalog
VALUES ('12', 'Digital Signals', '1002', '2', '1003', '2001', '425');
INSERT INTO catalog
VALUES ('13', 'Logic Design', '1003', '3', '1002', '1999', '225');
INSERT INTO catalog
VALUES ('14', 'Server Prg', '1004', '4', '1004', '2001', '333');
INSERT INTO catalog
VALUES ('15', 'Linux OS', '1005', '5', '1005', '2003', '326');
INSERT INTO catalog
VALUES ('16', 'C++ Bible', '1005', '5', '1001', '2000', '526');
INSERT INTO catalog
VALUES ('17', 'COBOL Handbook', '1005', '4', '1001', '2000', '658');
select * from catalog;
INSERT INTO orderdetail
VALUES ('1', '11', '5');
INSERT INTO orderdetail
VALUES ('2', '12', '8');
INSERT INTO orderdetail
VALUES ('3', '13', '15');
INSERT INTO orderdetail
VALUES ('4', '14', '22');
INSERT INTO orderdetail
VALUES ('5', '15', '3');
select * from orderdetail;


select aname from AUTHOR;
select title,price from CATALOG where price<500;
select title,price from CATALOG where price between 400 and 500;
select title,pyear from catalog where pyear>2000;
select avg(price) from CATALOG;
select * from catalog order by price desc;
select aname,acountry from AUTHOR where acountry='USA';
select aname from AUTHOR where aname like 'W%';
select title,price,1.10*price as NEW_PRICE from CATALOG;
update CATALOG set price=100 where bookid=11;
select title,max(price) from CATALOG;

select title,price from CATALOG where price!=(select max(price)from CATALOG);

select count(aname),acountry from AUTHOR group by acountry;


select aname,title,price from AUTHOR join CATALOG
ON authorid=authorid where pyear>2000; 

update CATALOG set price=price*1.1 where publisherid=4;