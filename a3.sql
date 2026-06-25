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

-- task1
CREATE PROC sp_GetCategoryReport
AS
BEGIN
    SELECT 
        item_category AS [Category], 
        COUNT(item_id) AS [Total number of items], 
        AVG(item_price) AS [Average Price]
    FROM 
        Item
    GROUP BY 
        item_category;
END;


-- task2
CREATE PROC sp_GetCheaperItems
    @category VARCHAR(10),  -- প্রথম ইনপুট: ক্যাটাগরির নাম
    @price_val FLOAT        -- দ্বিতীয় ইনপুট: দামের মান
AS
BEGIN
    SELECT * FROM Item
    WHERE item_category = @category 
      AND item_price < @price_val;
END;

-- উদাহরণ: 'Software' ক্যাটাগরির ৫০০ টাকার কম দামি আইটেমগুলো দেখতে চাইলে
EXEC sp_GetCheaperItems 'Software', 500;

---task3
CREATE PROC sp_IncreaseCategoryPrice
    @category VARCHAR(10),       -- প্রথম ইনপুট: ক্যাটাগরির নাম
    @desired_avg FLOAT           -- দ্বিতীয় ইনপুট: কাঙ্ক্ষিত গড় দাম
AS
BEGIN
    DECLARE @current_avg FLOAT
    
    -- লুপ চালানোর সুবিধার্থে প্রথমে ওই ক্যাটাগরির বর্তমান গড় দাম বের করে নিচ্ছি
    SELECT @current_avg = AVG(item_price) FROM Item WHERE item_category = @category;
    
    -- লুপ সেকশন: যতক্ষণ বর্তমান গড় দাম কাঙ্ক্ষিত মানের চেয়ে কম থাকবে, লুপ চলবে
    WHILE @current_avg < @desired_avg
    BEGIN
        -- ওই নির্দিষ্ট ক্যাটাগরির প্রতিটি আইটেমের দাম ১০% বাড়িয়ে আপডেট করা হচ্ছে
        UPDATE Item 
        SET item_price = item_price + (0.1 * item_price) 
        WHERE item_category = @category;
        
        -- দাম বাড়ানোর পর নতুন গড় দাম কত হলো তা পুনরায় হিসাব করে ভেরিয়েবলে রাখছি
        SELECT @current_avg = AVG(item_price) FROM Item WHERE item_category = @category;
    END
END;

-- উদাহরণ: 'Books' ক্যাটাগরির আইটেমগুলোর গড় দাম বাড়িয়ে ৫০০ টাকা পর্যন্ত নিতে চাইলে:
EXEC sp_IncreaseCategoryPrice 'Books', 500;