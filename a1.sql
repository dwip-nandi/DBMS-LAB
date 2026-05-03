--------------1-------
SELECT * FROM SYSOBJECTS   -- seen tha all info of the database
SELECT * FROM SYSOBJECTS WHERE XTYPE ='U' --- seen the all tables of the database -- show all column
SELECT NAME FROM SYSOBJECTS WHERE XTYPE ='U' --- seen the all tables of the database  -- show only "name" column
SELECT name,id FROM SYSOBJECTS WHERE XTYPE ='U' --- seen the all tables of the database  -- show only "name"and "id" columns

------------2----------
SELECT * FROM <TABLENAME> -- show all column in a table
SELECT column_name FROM <TABLENAME> -- show addressing column in a table
SELECT <COLUMNNAME1>, <COLUMNNAME2> FROM AUTHORS --- if want to see multiple column
SELECT * FROM AUTHORS WHERE <COLUMNNAME> <CONDITION>  -- seen the my conditionaly
SELECT * from authors where state='CA' -----show data from the state of CA
SELECT * from authors where state='CA' and city='Oakland' ----execute multiple condition
-- task1---> 
SELECT title from titles Where ytd_sales>8000
--task2--->
SELECT title from titles where royalty>=12 and royalty<=24

-------------------3--------------
SELECT * FROM table_name ORDER BY column_name(which column use sorting) DESC ---- decreasing odred data from table
SELECT * FROM table_name ORDER BY column_name(which column use sorting) ASC  ---- inceassing order data from table
SELECT * FROM TITLES ORDER BY column1, column2 DESC ----- use order multiple columen

----------------4--------------
SELECT MAX(PRICE) FROM TITLES ---- show maximum value
SELECT MIN(PRICE) FROM TITLES ---- show minimum value
SELECT AVG(PRICE) FROM TITLES ---- show average value
SELECT SUM(PRICE) FROM TITLES ---- show total value
SELECT COUNT(*) FROM TITLES   ---- total no of elements or records

---------------5---------------


