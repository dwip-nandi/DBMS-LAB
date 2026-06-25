-- ------- create a tregger
CREATE TRIGGER trg_after_item_insert
ON item
AFTER INSERT
AS
BEGIN
    PRINT 'A new row has been inserted into the item table!';
    
    -- Alternatively, you can use RAISERROR for a more visible message
    RAISERROR ('New item inserted successfully!', 10, 1);
END;

-------------
CREATE TRIGGER item_delete
ON item AFTER DELETE
AS
BEGIN 
  PRINT 'one item deleted';
END


------
CREATE TRIGGER trg_update_item ON Transactions FOR INSERT
AS
BEGIN
    DECLARE @item_id char(6), @tranamount int, @tran_type char(1)
    
    -- INSERTED টেবিল থেকে সদ্য ইনপুট দেওয়া ডাটা ভেরিয়েবলে নেওয়া হচ্ছে
    SELECT @item_id=item_id, @tranamount=tran_quantity, @tran_type=tran_type FROM INSERTED
    
    -- শর্ত চেক করা হচ্ছে: ট্রানজেকশন টাইপ কি 'S' (Sales/বিক্রি)?
    IF (@tran_type = 'S')
    BEGIN
        -- বিক্রি হলে স্টক (item_qoh) থেকে পরিমাণ বিয়োগ হবে
        UPDATE Items SET item_qoh = item_qoh - @tranamount WHERE item_id = @item_id
    END
    ELSE
    BEGIN
        -- অন্যথায় (ক্রয় বা Purchase হলে) স্টকের সাথে পরিমাণ যোগ হবে
        UPDATE Items SET item_qoh = item_qoh + @tranamount WHERE item_id = @item_id
    END
END

---------task
CREATE TRIGGER trg_update_customer ON Transactions FOR INSERT
AS
BEGIN
    DECLARE @c_id char(6), @qty int, @type char(1)
    
    -- INSERTED টেবিল থেকে প্রয়োজনীয় ডাটা ভেরিয়েবলে রাখছি
    SELECT @c_id = cust_id, @qty = tran_quantity, @type = tran_type FROM INSERTED;
    
    IF (@type = 'S') -- যদি সেলস বা বিক্রি হয়
    BEGIN
        UPDATE CustomerAndSuppliers 
        SET sales_amnt = sales_amnt + @qty 
        WHERE cust_id = @c_id;
    END
    ELSE -- অন্যথায় যদি পারচেজ বা ক্রয় হয়
    BEGIN
        UPDATE CustomerAndSuppliers 
        SET proc_amnt = proc_amnt + @qty 
        WHERE cust_id = @c_id;
    END
END; 