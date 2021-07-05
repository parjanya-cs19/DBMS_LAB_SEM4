create database airline;
use airline;
CREATE TABLE flights(flno Int,`from` Varchar(20),`to` Varchar(20),distance INT,departs time,arrives time,price Int,
PRIMARY KEY(flno) );
CREATE TABLE aircraft(aid INT,aname VARCHAR(20),cruisingrange INT,
PRIMARY KEY (aid) );
CREATE TABLE employees(eid INT,ename Varchar(20),salary INT,
PRIMARY KEY (eid) );
CREATE TABLE certified(eid INT,aid INT,
PRIMARY KEY (eid,aid),
FOREIGN KEY (eid) REFERENCES employees (eid),     
FOREIGN KEY (aid) REFERENCES aircraft (aid) );

show tables;

INSERT INTO flights (flno,`from`,`to`,distance,departs,arrives,price) VALUES (1,'Bangalore','Chennai',360,'08:45','10:00',10000),
														(2,'Bangalore','Delhi',1700,'12:15','15:00',37000),
														(3,'Bangalore','Kolkata',1500,'15:15','05:25',30000),
														(4,'Mumbai','Delhi',1200,'10:30','12:30',28000),
														(5,'Bangalore','New york',14000,'05:45','02:30',90000),
														(6,'Delhi','Chicago',12000,'10:00','05:45',95000),
														(7,'Bangalore','Frankfurt',15000,'12:00','06:30',98000), 
														(8,'Madison','New york',1500,'10:15','14:25',30000);
SELECT * FROM flights;

INSERT INTO aircraft (aid,aname,cruisingrange) values 
        (1,'Airbus 380',1000),
        (2,'Boeing 737',4000),
        (3,'Lockheed',5500),
        (4,'Airbus A220',9500), 
        (5,'Boeing 747',800),
        (6,'Douglas DC3',900);
        
SELECT * FROM aircraft;

INSERT INTO employees (eid,ename,salary) VALUES
(1,'Zoya',95000),
(2,'Akshay',65000),
(3,'Niveditha',70000),
(4,'Safan',45000),
(5,'Peter',95000),
(6,'Nayan',100000), 
(7,'Ajay',50000);

SELECT * FROM employees;

INSERT INTO certified (eid,aid) VALUES
(1,1),
(1,3),
(1,4),
(5,4),
(5,3),
(1,2),
 (2,6),
(2,5),
(4,5),
(6,4),
(6,3),
(3,6),
(3,2);

SELECT * FROM certified;


#i. Find the names of aircraft such that all pilots certified to operate them have salaries more than Rs.80,000.
SELECT DISTINCT A.aname FROM Aircraft A WHERE A.Aid IN (SELECT C.aid FROM Certified C, Employees E WHERE C.eid = E.eid AND NOT EXISTS 
( SELECT * FROM Employees E1
WHERE E1.eid = E.eid AND E1.salary < 80000 ));

#ii. For each pilot who is certified for more than three aircrafts, find the eid and the maximum cruising range of the aircraft for which she or he is certified.
SELECT C.eid, MAX(A.cruisingrange) FROM Certified C, Aircraft A WHERE C.aid = A.aid GROUP BY C.eid HAVING COUNT(*) > 3;

#iii. Find the names of pilots whose salary is less than the price of the cheapest route from Bengaluru toFrankfurt.
SELECT DISTINCT e.ename FROM employees e WHERE e.salary< (SELECT MIN(f.price) FROM flights f WHERE f.from='Bangalore' AND f.to='Frankfurt');

#iv. For all aircraft with cruising range over 1000 Kms, find the name of the aircraft and the average salary of all pilots certified for this aircraft. 
SELECT a.aid,a.aname,AVG(e.salary) FROM aircraft a,certified c,employees e WHERE a.aid=c.aid AND c.eid=e.eid AND a.cruisingrange>1000
GROUP BY a.aid,a.aname;
   
#v. Find the names of pilots certified for some Boeing aircraft. 
SELECT distinct e.ename FROM employees e,aircraft a,certified c
WHERE e.eid=c.eid AND c.aid=a.aid AND a.aname like 'Boeing%';

#vi. Find the aids of all aircraft that can be used on routes from Bengaluru to New Delhi. 
SELECT a.aid FROM aircraft a WHERE a.cruisingrange> (SELECT MIN(f.distance) FROM flights f
WHERE f.from='Bangalore' AND f.to='Delhi');

#vii. A customer wants to travel from Madison to New York with no more than two changes of flight. List the choice of departure times from Madison if the customer wants to arrive in New York by 6 p.m. 
SELECT F.departs FROM Flights F WHERE F.flno IN (  SELECT F0.flno FROM Flights F0 WHERE F0.from = 'Madison' AND F0.to = 'New york' AND F0.arrives < '18:00' );

#viii. Print the name and salary of every non-pilot whose salary is more than the average salary for pilots.0
SELECT E.ename, E.salary FROM Employees E WHERE E.eid NOT IN ( SELECT DISTINCT C.eid FROM Certified C ) AND E.salary > ( SELECT AVG (E1.salary)
FROM Employees E1 WHERE E1.eid IN ( SELECT DISTINCT C1.eid FROM Certified C1 ) );
commit;