---------------1--------------
--task1-----
SELECT titles.title, authors.au_fname, authors.au_lname 
FROM titles 
INNER JOIN titleauthor ON titles.title_id = titleauthor.title_id
INNER JOIN authors ON titleauthor.au_id = authors.au_id;

--task2-------
SELECT titles.title, authors.au_fname, authors.au_lname, publishers.pub_name
FROM titles
INNER JOIN titleauthor ON titles.title_id = titleauthor.title_id
INNER JOIN authors ON titleauthor.au_id = authors.au_id
INNER JOIN publishers ON titles.pub_id = publishers.pub_id;