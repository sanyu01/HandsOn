create table Booking(
booking_id numeric(4),
booking_date date,
room_no numeric(3),
guest_id numeric(4),
occupants int,
room_type_requested varchar(10),
nights int,
arrival_time time(0))

insert into Booking values(5001,'2016-11-03',101,1027,1,'single',7,'13:00')
insert into Booking values(5002,'2016-11-03',102,1179,1,'double',2,'18:00')
insert into Booking values(5003,'2016-11-03',103,1106,2,'double',2,'21:00')
insert into Booking values(5004,'2016-11-03',104,1238,1,'double',3,'22:00')

select * from Booking

create table table_room(
id numeric(4),
room_type varchar(10),
max_occupancy int
)

insert into table_room values(101,'single',1)
insert into table_room values(102,'double',2)
insert into table_room values(103,'double',2)
insert into table_room values(104,'double',2)
insert into table_room values(105,'family',3)

select * from table_room

create table table_rate(
room_type varchar(10),
occupancy int,
amount int,
)

insert into table_rate values('double',1,56)
insert into table_rate values('double',2,72)
insert into table_rate values('family',1,56)
insert into table_rate values('family',2,72)
insert into table_rate values('family',3,84)
insert into table_rate values('single',1,48)
insert into table_rate values('twin',1,50)
insert into table_rate values('twin',2,72)

select * from table_rate

/*Easy*/
/* Q1 */
SELECT booking_date,nights
FROM booking
WHERE guest_id = 1183

/* Q2 */
SELECT arrival_time, first_name, last_name
FROM booking
JOIN guest
ON booking.guest_id = guest.id
WHERE booking_date = "2016-11-05"
ORDER BY arrival_time;

/* Q3 */
SELECT booking_id,room_type_requested,occupants,amount
FROM booking a
JOIN rate b
ON a.room_type_requested = b.room_type AND a.occupants = b.occupancy
WHERE booking_id in (5152,5165,5154,5295);

/* Q4 */
SELECT
	guest.first_name,
	guest.last_name,
	guest.address
FROM
	guest
	JOIN
		booking
		ON (booking.guest_id = guest.id)
WHERE
	booking.room_no = 101
	AND booking.booking_date = '2016-12-03';

--Medium
/* Q5 */
SELECT guest_id,count(nights), sum(nights)
FROM booking
WHERE guest_id in (1185,1270)
GROUP BY guest_id; 


/* Medium */
/* Q6 */
SELECT SUM(nights*amount)
FROM booking a
JOIN guest b
  ON a.guest_id = b.id
JOIN rate c
  ON a.room_type_requested = c.room_type AND occupants = occupancy
WHERE b.first_name = "Ruth" AND b.last_name = "Cadbury";

/* Q7 --> the answer maybe wrong from sqlzoo --> this is what I think is correct*/
SELECT nights*rate.amount + ex.amount 
FROM booking b
JOIN rate
ON room_type_requested = room_type AND occupants = occupancy
JOIN 
    (SELECT booking_id,SUM(amount) as amount 
     FROM extra 
     WHERE booking_id = 5128 
     GROUP BY booking_id) as ex
ON ex.booking_id = b.booking_id
WHERE b.booking_id = 5128; 

/* Q8 */
SELECT last_name,first_name, address, SUM(nights)
FROM 
    (SELECT last_name,first_name,address,COALESCE(nights,NULL,0) as nights
    FROM booking
    RIGHT JOIN guest
    ON guest.id = booking.guest_id
    WHERE address LIKE "Edinburgh%") as a
GROUP BY a.last_name,a.first_name;


/* Q9 */
SELECT booking_date, COUNT(arrival_time)
FROM booking
WHERE booking_date BETWEEN "2016-11-25" AND "2016-12-01"
GROUP BY booking_date;

/* Q10 */
SELECT           
	SUM(occupants)
FROM
	booking
WHERE
	booking_date <= '2016-11-21'
	AND DATE_ADD(booking_date, INTERVAL nights DAY) > '2016-11-21';


