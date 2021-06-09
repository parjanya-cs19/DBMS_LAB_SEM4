CREATE SCHEMA PIZZA;
USE PIZZA;
/* Query 1 
Create the above tables by properly specifying the primary keys and the foreign keys.*/
create table pizzat(pid int,pname varchar(30),quality int,address varchar(30),primary key(pid));
create table store(sid int,sname varchar(30),phone varchar(20),quality_rating varchar(20),primary key(sid));
create table soldby(pid int,sid int,price float,foreign key(pid) references pizzat(pid) on delete cascade on update cascade,foreign key(sid) references store(sid) on delete cascade on update cascade);

/* Query 2 
Enter at least five tuples for each relation.*/
insert into pizzat(pid,pname,quality,address) values (1,"Veggie",9,"Surat"),
													(2,"Mushroom",7,"Baroda"),
													(3,"Cheesy",10,"Mumbai"),
													(4,"Corn",8,"Rajkot");
                                                     
insert into store(sid,sname,phone,quality_rating) values(1,"Mahaveer","9876543210","Good"),
                                                        (2,"Bay Leaf","6543210987","Excellent"),
                                                        (3,"TGB","3219876540","Average"),
                                                         (4,"Lords","7894561230","Average");
                                                                    
insert into soldby(pid,sid,price) VALUES (1,1, 90),
				                         (1,2, 100),
							             (1,3, 110),
							             (1,4, 80),
							             (2,2, 120),
							             (2,3, 100),
							             (2,4, 120),
									     (3,3, 130),
						                 (3,4, 140),
                                         (4,1, 80),
                                         (4,2, 40),
                                         (4,3, 80),
                                         (4,4, 60);
						                 

/* Query 3 
Find the names of all stores that sell both veggie and cheese pizzas.*/
select s.sname from store s, soldby so, pizzat p 
where s.sid = so.sid and so.pid = p.pid and p.pname = 'Veggie' or p.pname='Cheesy';

/* Query 4 
Find the name and phone numbers of all stores that sell Good or excellent veggie pizza
under 100.*/
select s.sname,s.phone from store s,soldby so,pizzat p where s.sid=so.sid and so.pid=p.pid and s.quality_rating in("Good","Excellent") and so.price<100 and p.pname="Veggie";
select * from pizzat;
select * from store;
/* Query 5 
Demonstrate how you update the price of a vegcheese pizza by 10%*/
select * from soldby;
update soldby set price=price+price*0.1 where pid in (select pid from pizzat where pname="Cheesy");

/* Query 6 
List the stores whose average price for pizza is higher than the overall average prize.*/
select s.sname from store s,soldby so where s.sid=so.sid group by s.sid having avg(so.price)>(select avg(price) from soldby);

/* Query 7 
Create a View which contains(Pname,Totalprice,Avgprice) for each pizza sold .*/
create view pizzaview (pname,totalprice,avgprice) as select p.pname,sum(so.price),avg(so.price) from pizzat p,soldby so where p.pid=so.pid group by p.pid;
select * from pizzaview;
