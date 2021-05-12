show databases;
create database Order_processing;
use Order_processing;
create table Customer(cust_no int, cname varchar(20), city varchar(20), primary key (cust_no));
create table orders(order_no int, odate date, cust_no int, ordAmt int, primary key(order_no),
foreign key(cust_no) references customer(cust_no) on delete cascade);
create table items(item_no int, price int, primary key(item_no));
create table order_item(order_no int,item_no int, quantity int, 
foreign key(order_no) references orders(order_no),
foreign key(item_no) references items(item_no) on delete set null);
create table wrhouse(wr_no int, city varchar(20), primary key(wr_no));
create table shipment(order_no int, wr_no int, odate date, primary key(order_no),
foreign key(wr_no) references wrhouse(wr_no) on delete cascade);

insert into customer values(771, "PUSHPA K", "BANGALORE");
insert into customer values(772 ,"SUMAN", "MUMBAI");
insert into customer values(773," SOURAV", "CALICUT");
insert into customer values(774," LAILA", "HYDERABAD");
insert into customer values(775," FAIZAL", "BANGALORE");
insert into orders values(111, STR_TO_DATE('22-01-02', '%d-%m-%Y'), 771, 18000);
insert into orders values(112, STR_TO_DATE('30-07-02', '%d-%m-%Y'), 774, 6000);
insert into orders values(113, STR_TO_DATE('03-04-03', '%d-%m-%Y'), 775, 9000);
insert into orders values(114, STR_TO_DATE('03-11-03', '%d-%m-%Y'), 775, 29000);
insert into orders values(115, STR_TO_DATE('10-12-03', '%d-%m-%Y'), 773, 29000);
insert into orders values(116, STR_TO_DATE('19-08-04', '%d-%m-%Y'), 772, 56000);
insert into orders values(117, STR_TO_DATE('10-09-04', '%d-%m-%Y'), 771, 20000);
insert into orders values(118, STR_TO_DATE('20-11-04', '%d-%m-%Y'), 775, 29000);
insert into orders values(119, STR_TO_DATE('13-02-05', '%d-%m-%Y'), 774, 29000);
insert into orders values(120, STR_TO_DATE('10-13-05', '%m-%d-%Y'), 775, 29000);
insert into items values(5001, 503);
insert into items values(5002, 750);
insert into items values(5003, 150);
insert into items values(5004, 600);
insert into items values(5005, 890);
insert into order_item values(111, 5001, 50);
insert into order_item values(112, 5003, 20);
insert into order_item values(113, 5002, 50);
insert into order_item values(114, 5005, 60);
insert into order_item values(115, 5004, 90);
insert into order_item values(116, 5001, 10);
insert into order_item values(117, 5003, 80);
insert into order_item values(118, 5005, 50);
insert into order_item values(119, 5002, 10);
insert into order_item values(120, 5004, 45);
insert into wrhouse values(1, "Delhi");
insert into wrhouse values(2, "Bombay");
insert into wrhouse values(3, "Chennai");
insert into wrhouse values(7, "Bombay");
insert into wrhouse values(5, "Bangalore");
insert into wrhouse values(4, "Bangalore");
insert into wrhouse values(6, "Delhi");
insert into wrhouse values(8, "Chennai");
insert into wrhouse values(9, "Delhi");
insert into wrhouse values(10, "Bangalore");
insert into shipment values(111, 1, STR_TO_DATE('10-02-02', '%d-%m-%Y'));
insert into shipment values(112, 5, STR_TO_DATE('10-09-02', '%d-%m-%Y'));
insert into shipment values(113, 8, STR_TO_DATE('10-02-03', '%d-%m-%Y'));
insert into shipment values(114, 3, STR_TO_DATE('10-12-03', '%d-%m-%Y'));
insert into shipment values(115, 9, STR_TO_DATE('19-01-04', '%d-%m-%Y'));
insert into shipment values(116, 1, STR_TO_DATE('20-09-04', '%d-%m-%Y'));
insert into shipment values(117, 5, STR_TO_DATE('10-09-04', '%d-%m-%Y'));
insert into shipment values(118, 7, STR_TO_DATE('30-11-04', '%d-%m-%Y'));
insert into shipment values(119, 7, STR_TO_DATE('30-04-05', '%d-%m-%Y'));
insert into shipment values(120, 6, STR_TO_DATE('21-12-05', '%d-%m-%Y'));

select order_no from shipment where wr_no = 1;

delete from items where item_no = 5005;
select * from order_item;

SELECT C.CNAME,COUNT(O.ORDER_no) AS TOTALORDERS,AVG(O.ORdAMt) AS AVG_ORDER_AMT FROM CUSTOMER C,ORDERS O WHERE C.CUST_no=O.CUST_no GROUP BY O.CUST_no;