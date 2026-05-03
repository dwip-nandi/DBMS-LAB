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