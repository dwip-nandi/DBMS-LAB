-- create stored procedure
CREATE PROC showTitleAndAuthor
AS
BEGIN
  SELECT "Authors Last Name"=au_lname FROM authors 
     WHERE au_id in( SELECT au_id FROM titleauthor WHERE title_id='BU1032')
END

-- execute store procedure
EXEC showTitleAndAuthor;

-- if want to update or modified
ALTER PROC abcd
AS
BEGIN
  SELECT "AUTOR LAST NAMe"=au_lname, "contarct"=contract FROM authors

END
-- drop any stored procedured
DROP PROC abcd;

-- -------  parametarized stored procedure

ALTER PROC showTitleAndAuthor @title varchar(20)
AS
BEGIN
  SELECT "Authors Last Name"=au_lname FROM authors 
     WHERE au_id in( SELECT au_id FROM titleauthor WHERE title_id=@title)
END
EXEC showTitleAndAuthor 'BU1032';

-------update value statement
CREATE PROC update_price @titleid char(15)
AS
BEGIN
  DECLARE @price MONEY
  SELECT @price = price FROM titles WHERE title_id=@titleid
  SET @price = @price+0.1*@price
  IF @price<=20
    UPDATE titles SET price=@price WHERE title_id=@titleid

END

EXEC update_price 'MC3021';


------------ loop statement
ALTER PROC update_price @titleid char(15)
AS
BEGIN
  DECLARE @price MONEY
  
  -- প্রথমে বইয়ের বর্তমান দাম এনে ভেরিয়েবলে রাখছি
  SELECT @price = price FROM titles WHERE title_id=@titleid
  
  -- লুপ সেকশন: যতক্ষণ ১০% বাড়ানোর পর দাম ২০ বা তার কম থাকবে, লুপ চলবে
  WHILE (@price + (0.1 * @price)) <= 20
  BEGIN
    -- দাম ১০% বাড়ানো হচ্ছে
    SET @price = @price + (0.1 * @price)
    
    -- টেবিলের দামটি আপডেট করা হচ্ছে
    UPDATE titles SET price = @price WHERE title_id = @titleid
  END
END

EXEC update_price 'MC3021';