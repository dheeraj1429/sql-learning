show databases;
use sql_type;
show tables;

-- query
select * from books where id=3 and createdById=1;
select * from books where id >= 1;
select * from books where id <= 1;
select * from books where id<>3;
select * from books where id != 3;
SELECT * FROM Customers where Country="Mexico" And CustomerID>=50 And CustomerName<>"Pericles Comidas clásicas";
SELECT * FROM Customers Where CustomerName="Alfreds Futterkiste" OR CustomerName="Antonio Moreno Taquería";
SELECT * FROM Customers WHERE NOT Country="Germany";
SELECT * FROM Products WHERE Price BETWEEN 10 AND 30;
SELECT * FROM Products WHERE Price NOT BETWEEN 10 AND 30;
SELECT * from Products WHERE Price < 10 OR Price > 20;
SELECT * from Products ORDER BY Price ASC;
SELECT * from Products ORDER BY Price DESC;
SELECT * FROM Products ORDER BY Price ASC;
SELECT * FROM Products ORDER BY Price,Unit;
SELECT * FROM Customers WHERE Country BETWEEN "Sweden" AND "UK";
SELECT * FROM Customers WHERE CustomerId IN (4,5,6) AND CustomerName IN ("Around the Horn", "Berglunds snabbköp")
SELECT * FROM Products WHERE ProductName LIKE "C%";
SELECT * FROM Products WHERE ProductName LIKE "%a";
SELECT * FROM Products WHERE ProductName LIKE "I%a";
SELECT * FROM Products WHERE ProductName LIKE "U_";
SELECT * FROM Products WHERE ProductName LIKE "_K";
SELECT * FROM Products WHERE ProductName LIKE "U__";
SELECT * FROM Products WHERE ProductName LIKE "__A";
SELECT ProductID AS ID,ProductName AS Name FROM Products;
SELECT * FROM Products LIMIT 20;
SELECT * FROM Products LIMIT 2 OFFSET 3;
SELECT * FROM Products WHERE Price BETWEEN 10 AND 12 LIMIT 2 OFFSET 2;

-- Multiple lines
SELECT * FROM Products 
WHERE Price BETWEEN 10 AND 12 
LIMIT 2 OFFSET 2;

SELECT UPPER(CategoryName) AS CategoryName FROM Categories;
SELECT UPPER(CategoryName) AS CategoryName,CategoryID,Description FROM Categories;
SELECT LOWER(CategoryName) AS CategoryName,CategoryID,Description FROM Categories;
SELECT LOWER(CategoryName) AS CategoryName,LENGTH(CategoryName) AS CategoryNameAndLength FROM Categories;
SELECT * FROM Categories WHERE LENGTH(CategoryName)>=10;
SELECT SUBSTR(CategoryName,0, 3) AS subStr FROM Categories
select concat(CustomerName, ContactName) from Customers;
select concat(CustomerName, ContactName) as concatNames from Customers;
SELECT upper(concat(LastName, ' ', FirstName)) as concatAndUpperCase FROM Employees;
SELECT length(upper(concat(LastName, ' ', FirstName))) as concatAndUpperCase FROM Employees;
SELECT CustomerName,length(trim(CustomerName)) as lengthOfName FROM Customers where CustomerID = 1

SELECT Price, abs(Price) FROM Products;
SELECT Price, round(Price) FROM Products;
SELECT Price, floor(Price) FROM Products;

insert into Products
values(78, "I phone", 10, 1, "10 boxes x 20 bags", 100000.0)
Select Price, mod(Price, 2) as modePrice from Products;
Select greatest(1,2,3,1,100,20,300,890)
Select least(1,2,3,1,100,20,300,890)
select truncate(10.9909, 1)
select truncate(19.9909, -1)
select power(3,4)
select sqrt(3)

-- Date
select current_date()
select curdate()
select current_time()
select curtime()
select year('2000-12-23')
select month('2000-12-23')
select day('2000-12-23')
select dayname('2000-12-23')
SELECT * FROM Orders WHERE month(OrderDate)=5
SELECT * FROM Orders WHERE monthname(OrderDate)="May"

-- Aggrigate functions
SELECT Price, avg(Price) FROM Products;
SELECT max(Price) FROM Products;
SELECT sum(Price) FROM Products;
SELECT count(Price) FROM Products;
SELECT count(*) FROM Products;

use sql_type;

CREATE TABLE student(
	id int not null auto_increment,
    firstName varchar(55),
    lastName varchar(55),
    age int,
    primary key(id)
)

INSERT INTO student(firstName, lastName, age)
VALUES("dheeraj", "Rawat", 23);

UPDATE student SET age = 20 WHERE age >= 20;
DELETE FROM student WHERE id = 1;
SELECT Price, Price+1 As addOneMore FROM Products;
create table employees(
	id int not null auto_increment,
    name varchar(30),
    experience int,
    primary key(id)
)

insert into employees (name, experience)
values("Dheeraj singh rawat", 3)


-- Data types
/*
    there is three categories of data types
    string
    number
    date and time data types
*/


create table customer(
    cid int not null auto_increment primary key,
    cname varchar(30),
    cemail varchar(20),
)

create table orders(
    oid int not null auto_increment primary key,
    orderdate date,
    cid int,
    foreign key(cid) references customer(cid)
)

insert into customer(cname, cemail)
values('dheeraj', "@gmail.com");

insert into orders(orderdate, cid)
values('2000-12-23', 1)

select * from customer, orders where customer.cid = orders.cid
select * from customer join orders on customer.cid = orders.cid
select customer.cid,cname,orderdate from customer join orders where customer.cid = orders.cid
select * from customer left join orders on customer.cid = orders.cid;
select customer.cid, cname,orderdate from customer left join orders on customer.cid = orders.cid;
rename table auth to users;

-- Alter statements
alter table customer add place varchar(20);
alter table customer modify column place int; 
alter table customer rename column place to location;
alter table customer drop column location;


-- we want to create a book shop database. in this database we will create a 2 tables, one for the auther
-- and second for the books. auther can create multiple books but once book only is created by one auther.
-- auther table desc
-- name, description, place, email
-- book table desc
-- name, description, lang, createdBy ( auther ).

-- create database 
create database book_shop;
use book_shop;

-- auther table.
create table authers(
    id int not null auto_increment primary key,
    name varchar(32),
    description varchar(50),
    place varchar(50),
    email varchar(30)
)

-- create book table
create table books(
    id int not null auto_increment primary key,
    description varchar(50),
    lang varchar(3),
    createdBy int not null,
    foreign key(createdBy) references authers(id)
)

-- insert into authers table
insert into authers(name, description, place, email)
values("Dheeraj singh rawat", "some demo description", "New Delhi, Chirag Delhi, Delhi 110017","dheeraj123@gmail.com");

-- insert into books table
insert into books(description, lang, createdBy)
values("this is the my first book description", "ENG", 1)
values("this is the my second book description", "UK", 1)

select * from authers,books where authers.id = books.createdBy
select * from authers join books on authers.id = books.createdBy

delete from books where id = 3

-- return all the authers and the created books.
select * from authers left join books on authers.id = books.createdBy;
select * from authers right join books on authers.id = books.createdBy;

-- return all the books and creators.
select * from books left join authers on books.createdBy = authers.id;

SELECT COUNT(CustomerName) FROM Customers
SELECT Country, Count(Country) FROM Customers group by Country
SELECT SUM(Price), CategoryID FROM Products GROUP BY CategoryID;
SELECT SUM(Price) AS price_total, Price AS price FROM Products GROUP BY Price HAVING COUNT(price) >= 2
SELECT SUM(Price) AS price_total, Price AS price FROM Products GROUP BY Price HAVING COUNT(price) >= 2 ORDER BY price_total;
SELECT * FROM Products WHERE Price >= 10 GROUP BY CategoryID HAVING CategoryID >= 4 ORDER BY CategoryID
