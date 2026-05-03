---------------1--------------
--task1-----
--i
SELECT titles.title, authors.au_fname, authors.au_lname 
FROM titles 
INNER JOIN titleauthor ON titles.title_id = titleauthor.title_id
INNER JOIN authors ON titleauthor.au_id = authors.au_id;

--ii
SELECT titles.title, authors.au_fname, authors.au_lname, publishers.pub_name
FROM titles
INNER JOIN titleauthor ON titles.title_id = titleauthor.title_id
INNER JOIN authors ON titleauthor.au_id = authors.au_id
INNER JOIN publishers ON titles.pub_id = publishers.pub_id;

----------------2----------------
--task2-----
--iii
SELECT authors.au_fname, authors.au_lname, authors.city, publishers.pub_name, publishers.city
FROM authors, publishers
WHERE authors.city = publishers.city;

-------------------3----------------
---task3---
--iv
SELECT au_fname, au_lname 
FROM authors 
WHERE au_id IN (
    SELECT au_id 
    FROM titleauthor 
    WHERE title_id IN (
        SELECT title_id 
        FROM titles 
        WHERE royalty = (SELECT MAX(royalty) FROM titles)
    )
)

---------------4---------
---- create table ----------
CREATE TABLE CustomersAndSuppliers(
     cust_id char(6) PRIMARY KEY CHECK(cust_id like '[CS][0-9][0-9][0-9][0-9][0-9]'),
     cust_fnamee char(15) NOT NULL,
     cust_lname  varchar(15),
     cust_address text,
     cust_telno char(12) CHECK (cust_telno LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
     cust_city char(12) default 'RAJSHAHI',
     sales_amnt money check (sales_amnt>=0),
     proc_amnt money check (proc_amnt>=0)
);


------------------5----------
-------create table
CREATE TABLE Item (
    item_id CHAR(6) PRIMARY KEY CHECK (item_id LIKE 'P[0-9][0-9][0-9][0-9][0-9]'),
    item_name CHARACTER(12),
    item_category CHARACTER(10),
    item_price FLOAT(12) CHECK (item_price >= 0),
    item_qoh INTEGER CHECK (item_qoh >= 0),
    item_last_sold DATE DEFAULT GETDATE()
);

CREATE TABLE Transactions (
    tran_id CHARACTER(10) PRIMARY KEY CHECK (tran_id LIKE 'T[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    item_id CHARACTER(6) FOREIGN KEY REFERENCES Item(item_id),
    cust_id CHARACTER(5), -- এখানে কাস্টমার টেবিলের রেফারেন্স দেওয়া লাগবে
    tran_type CHARACTER(1) CHECK (tran_type IN ('S', 'O')),
    tran_quantity INTEGER CHECK (tran_quantity > 0),
    tran_date DATETIME DEFAULT GETDATE()
);