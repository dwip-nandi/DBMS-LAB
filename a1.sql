--------------1-------
SELECT * FROM SYSOBJECTS   -- seen tha all info of the database
SELECT * FROM SYSOBJECTS WHERE XTYPE ='U' --- seen the all tables of the database -- show all column
SELECT NAME FROM SYSOBJECTS WHERE XTYPE ='U' --- seen the all tables of the database  -- show only "name" column
SELECT name,id FROM SYSOBJECTS WHERE XTYPE ='U' --- seen the all tables of the database  -- show only "name"and "id" columns

------------2----------
