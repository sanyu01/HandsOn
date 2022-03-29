Create table Salesman(
Salesman_Id numeric(5),
Name varchar(30),
city varchar(15),
Commision decimal(5,2))

select * from Salesman

insert into Salesman values(5001,'James Hoog','New York','0.15')
insert into Salesman values(5002,'Nail Knite','Paris','0.13')
insert into Salesman values(5005,'Pit Alex','London','0.11')
insert into Salesman values(5006,'Mc Lyon','Paris','0.14')
insert into Salesman values(5007,'Paul Adam','Rome','0.13')
insert into Salesman values(5003,'Lauson Hen','San Jose','0.12')

Create table Orders(
Ord_No numeric(5),
Purch_Amt decimal(8,2),
Ord_date date,
Customer_Id numeric(5),
Salesman_Id numeric(5))

select * from Orders

drop table Orders

insert into Orders values(70001,'150.5','2012-10-05',3005,5002)
insert into Orders values(70009,'270.65','2012-09-10',3001,5005)
insert into Orders values(70002,'65.26','2012-10-05',3002,5001)
insert into Orders values(70004,'110.5','2012-08-17',3009,5003)
insert into Orders values(70007,'948.5','2012-09-10',3005,5002)
insert into Orders values(70005,'2400.6','2012-07-27',3007,5001)
insert into Orders values(70008,'5760','2012-09-10',3002,5001)
insert into Orders values(70010,'1983.43','2012-10-10',3004,5006)
insert into Orders values(70003,'2480.4','2012-10-10',3009,5003)
insert into Orders values(70012,'250.45','2012-06-27',3008,5002)
insert into Orders values(70011,'75.29','2012-08-17',3003,5007)
insert into Orders values(70013,'3045.6','2012-04-25',3002,5001)

create table Customer(
Customer_Id numeric(5),
Cust_Name varchar(30),
City varchar(15),
Grade numeric(3),
Salesman_Id numeric(5))

select * from Customer

insert into Customer values(3002,'Nick Rimado','New York',100,5001)
insert into Customer values(3007,'Brad Davis','New York',200,5001)
insert into Customer values(3005,'Graham Zusi','California',200,5002)
insert into Customer values(3008,'Julian Green','London',300,5002)
insert into Customer values(3004,'Fabian Johnson','Paris',300,5006)
insert into Customer values(3009,'Geoff Cameron','Berlin',100,5003)
insert into Customer values(3003,'Jozy Altidor','Moscow',200,5007)
insert into Customer(Customer_Id,Cust_Name,City,Salesman_Id) values(3001,'Brad Guzan','London',5001)

SELECT ord_date , salesman_id ord_no,purch_amt
From orders;

SELECT salesman_id,name,city,commision
FROM salesman
WHERE (commision > 0.10
AND commision < 0.12);

SELECT customer_id,MAX(purch_amt)
FROM orders
GROUP BY customer_id;

SELECT*
FROM orders
WHERE salesman_id IN
	(SELECT salesman_id
	FROM salesman
	WHERE city ='NEW YORK');

SELECT*
FROM salesman
WHERE salesman_id IN (
	SELECT DISTINCT salesman_id
	FROM customer a
	WHERE NOT EXISTS (
		SELECT * FROM customer b
		WHERE a.salesman_id=b.salesman_id
		AND a.cust_name<>b.cust_name));

SELECT customer_id,cust_name,city
FROM customer
WHERE EXISTS
	(SELECT*
	FROM customer
	WHERE city='London');

SELECT ord_date, SUM (purch_amt)
FROM orders a
GROUP BY ord_date
HAVING SUM (purch_amt) >
	(SELECT 1000.00 + MAX(purch_amt)
	FROM orders b
	WHERE a.ord_date = b.ord_date);

SELECT*
FROM orders a
WHERE purch_amt >=
	(SELECT AVG(purch_amt)FROM orders b
	where b.customer_id=a.customer_id);

SELECT salesman_id,name
FROM salesman a
WHERE 1<
	(SELECT COUNT(*)
	FROM customer
	WHERE salesman_id=a.salesman_id);

SELECT*
FROM orders
WHERE purch_amt>
	(SELECT AVG(purch_amt)
	FROM orders
	WHERE ord_date = '10/10/2012');

SELECT*
FROM orders
WHERE salesman_id = 
	(SELECT DISTINCT salesman_id
	FROM orders
	WHERE customer_id = 3007);

SELECT*
FROM orders
WHERE salesman_id IN
	(SELECT salesman_id
	FROM salesman
	WHERE city='London');

SELECT*
FROM orders
WHERE salesman_id=
	(SELECT salesman_id
	FROM salesman
	WHERE name ='Paul Adam');

SELECT a.cust_name,a.city,a.grade,
b.name AS "Salesman",b.city
FROM customer a
LEFT JOIN salesman b
ON a.salesman_id = b.salesman_id
order by a.customer_id;

SELECT a.cust_name AS "Customer Name",
a.city , b.name AS "Salesman",b.commision
FROM customer a
INNER JOIN salesman b
ON a.salesman_id=b.salesman_id
WHERE b.commision>.12;

SELECT a.ord_no,a.purch_amt,
b.cust_name,b.city
FROM orders a, customer b
WHERE a.customer_id=b.customer_id
AND a.purch_amt BETWEEN 500 AND 2000;

SELECT salesman.name AS "Salesman",
customer.cust_name, customer.city
FROM salesman,customer
WHERE salesman.city=customer.city;

SELECT salesman_id,MAX(purch_amt)
FROM orders
WHERE ord_date = '2012-08-17'
GROUP BY salesman_id;

SELECT customer_id,ord_date,MAX(purch_amt)
FROM orders
GROUP BY customer_id,ord_date;

SELECT COUNT (DISTINCT salesman_id)
FROM orders;


SELECT AVG (purch_amt)
FROM orders;


SELECT SUM (purch_amt)
FROM orders;

SELECT*
FROM customer
WHERE city = 'New York' AND grade>100;


SELECT ord_no, ord_date,purch_amt
FROM orders
WHERE salesman_id=5001;


SELECT name,city
FROM salesman
WHERE city= 'Paris';

SELECT DISTINCT salesman_id
From orders;








