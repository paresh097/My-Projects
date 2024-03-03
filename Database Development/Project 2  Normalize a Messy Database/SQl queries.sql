--PART 1 :

----1. finding how many customer is present in table who placed orders
	SELECT COUNT(DISTINCT CustomerName ) AS Total_customername FROM Messy

--2.in the table,each customer is associated with their order id with multiple time so if we distinct orderno only where customername column has null entry then
				--we will get the total number of customer where customername is null
	
	SELECT COUNT(DISTINCT OrderNo) FROM Messy WHERE CustomerName IS NULL
	--null customer is 104 so the total number of customer is 104+5108 =  5212
	--one query that find total customer present in table using isnull function
		SELECT COUNT(DISTINCT(ISNULL(CustomerName,OrderNo))) As all_customer from Messy 

-- 3. Summerizing non null customer like total customer, total order, avg order per customer
	SELECT COUNT(*) AS TOTAL_NN_CUS,SUM(CT.Count_Order) AS TOTAL_ORDER, CAST(SUM(CT.Count_Order) AS float)/CAST(COUNT(*) AS float) AS AVG_ORDER_PER_CUS
	FROM (SELECT CustomerName,COUNT(OrderNo) AS Count_Order FROM Messy 
	GROUP BY CustomerName HAVING CustomerName IS NOT NULL) AS CT

-- 4. Counting Unique Customer in customername inculding null( the null customer consider as individual by orderno)

	SELECT COUNT(DISTINCT(ISNULL(CustomerName,OrderNo))) As all_customer from Messy

-- 5. Fetching which Product Purchesed most among all customer
	SELECT TOP(1) ProductID,COUNT(OrderNo) AS NUM_ORDER_PER_PRODCUT  FROM Messy GROUP BY ProductID
	ORDER BY NUM_ORDER_PER_PRODCUT DESC
	

--6. Products with it is price

	 SELECT ProductID,LineItemPrice FROM Messy
	 GROUP BY ProductID,LineItemPrice
	 HAVING LineItemPrice IS NOT NULL
	 ORDER BY LineItemPrice

 -- 7.checking how many promocode is related with Discountappliedabs
	SELECT DISTINCT PromoCode FROM Messy WHERE DiscountAppliedAbs IS NOT NULL

-- 8. grouping sold product by saledate
	SELECT sale_date,COUNT(ProductID) AS NUM_SOLD_PRO_BY_DATE
	FROM (SELECT ProductID ,(CASE WHEN SaleDate IS NOT NULL THEN SUBSTRING(SaleDate,1,8) END) AS sale_date FROM Messy) AS SD --trimmed saledate to get only date,not time
	GROUP BY sale_date ORDER BY NUM_SOLD_PRO_BY_DATE DESC

-- 9. Checking does repeatcustomer column has valid information or not ?
		-- selecting only those data where repeatcustomer = "no"
		SELECT CT.CustomerName,COUNT(CT.OrderNo) AS COUNT_ORDER_BY_CUSTOMER,CT.RepeatCustomer			--Counting order placed by Customer from CT table
		FROM (SELECT DISTINCT OrderNo,CustomerName,RepeatCustomer FROM Messy WHERE CustomerName IS NOT NULL AND RepeatCustomer = 'No') AS CT -- the CT table contain unique orderno. where customer name is not null and repeat customer is no
		GROUP BY CT.CustomerName,CT.RepeatCustomer   ---  grouping CT table by custermername and repeatcustomer
		HAVING COUNT(CT.OrderNo)>1 -- sorting table by count order in desc order

--- result: there are 155 customer who placed 2 times order but the entery is still no in repeatcustomer
		--  Wrong information in repeatcustomer	field
 
 --10.Find the number of non repeated customers except one null 
	SELECT COUNT(DISTINCT CustomerName) FROM Messy WHERE CustomerName IS NOT NULL -- total non-repeated and non null-customer 5108

		-- orderno with no repeat customer is new customer right?
		--so if repeatcustomer column has valid information then count of distinct orderno with no repeatcustomer should be 5108
	
-- 11. Find the total unique orderNo when customer are not null along with they are not repeated customers
		SELECT COUNT(DISTINCT OrderNo) FROM Messy WHERE CustomerName IS NOT NULL AND RepeatCustomer = 'no'

		--but the result showing 5263. which greater than 5108 means there are some customer who placed order more than two times
		-- and entery is still no in repeatcustomer. that mean repeatcustomer have wrong information


-- 12. customer details who has purchesed highest amount on product

	SELECT TOP(1) CustomerName,SUM(TotalSalePrice) AS Total_Purchesed_Amount,COUNT(ProductID) AS Total_Purchesed_Product
	FROM Messy 
	WHERE CustomerName IS NOT NULL
	GROUP BY CustomerName
	ORDER BY Total_Purchesed_Amount DESC

-13 Find the total records which have Customer name to null and productTags to tools
Select count(*) from
(SELECT  [OrderNo]
      ,[SaleDate]
      ,[ProductID],
	  [productTags]
      FROM [Messy].[dbo].[Messy]	  where  productTags= 'Tools' AND CustomerName is null) as find

--14  Find the records which have the count of total records along with those have productTags to null
select count(productID)  as total_orderID, 
(select COUNT(ProductID)
from [Messy].[dbo].[Messy] where ProductTags is not null) as total_orderID_nn_pID
from [Messy].[dbo].[Messy]

--15Find customers who have got discount
SELECT CustomerName,
       CustomerPhoneNo,
       CASE WHEN PromoCode = 'STAFFDISC' OR PromoCode = 'DISCOUNT10'  THEN 'Qualified'
       ELSE 'Sorry' END AS condition
  FROM Messy.dbo.Messy    
  where CustomerName is not null group by CustomerName, CustomerPhoneNo,PromoCode;

--16 we can get howmany orders on the same date we get
	SELECT COUNT(DISTINCT(OrderNo)) as total_orders, 
	COUNT(Distinct(SaleDate)) as total_dates, 
	COUNT(DISTINCT(OrderNo))-COUNT(DISTINCT(SaleDate)) as orders_on_same_date  
	from Messy

----17 find the disctinct customers who are new and old
SELECT distinct CustomerName, 
       RepeatCustomer,
       CASE WHEN RepeatCustomer = 'True' THEN 'Old Customer'
            ELSE 'Old' END AS condition
  FROM Messy;

--18 customername who are not repated and we grouped them by sales_date
	SELECT CustomerName,COUNT(SaleDate) AS sales_date ,RepeatCustomer			
	FROM (SELECT  SaleDate,CustomerName,RepeatCustomer FROM Messy WHERE CustomerName IS  not NULL AND RepeatCustomer = 'No')  as summary
	GROUP BY CustomerName, RepeatCustomer 

--19 Customers who are living at street starts with IP4

	select CustomerName,CustomerEmail,CustomerAddress5  
	from Messy.dbo.Messy 
	where CustomerAddress5 like 'IP4%' 
	group by CustomerName,CustomerEmail,CustomerAddress5

--20 Customers name with total order per them and they got the discount or not, we translet null to 0
	select CustomerName,count(OrderNo) as total_order, COALESCE(DiscountAppliedAbs,0),COALESCE(DiscountAppliedPc,0) as got_one_discount  
	from Messy.dbo.Messy  
	where LineItemPrice is not null and CustomerName is not null
	group by  CustomerName,DiscountAppliedAbs,DiscountAppliedPc

--21. howmany null Customer who purchesed without  promocode
 SELECT count(CustomerName) 
 FROM Messy 
 WHERE CustomerName is null and  PromoCode IS NULL

 
-- 22. Fins the customer name who are living in which city
    SELECT CustomerName,
     CASE WHEN CustomerAddress5 = 'OX8 4KX'  THEN 'Caithness'
      WHEN CustomerAddress5='IP4 2SE'    THEN 'Hampshire'
      ELSE 'Other city' END AS condition
  FROM Messy.dbo.Messy where CustomerName is not null and CustomerAddress5 is not null  group by CustomerName,CustomerAddress5;


--23 customers whos email id has adreess of ORG
   select CustomerName, CustomerEmail 
   from Messy where CustomerEmail like '%.org' 
   group by CustomerName, CustomerEmail


--24 we have only fetch the record of those who got the discount and also how much 
   select CustomerName, TotalSalePrice,NewTotalSalePrice, (TotalSalePrice - NewTotalSalePrice) as discounted_amount from  Messy 
   where NewTotalSalePrice < TotalSalePrice and CustomerName is not null group by CustomerName, TotalSalePrice,NewTotalSalePrice
   order by discounted_amount 

--25 find customername with their total order with they got discount or not???
	select CustomerName,count(OrderNo),
	case when (NewTotalSalePrice < TotalSalePrice) then 'you got discount'
	else 'you did not get' end as conditon   
	from Messy.dbo.Messy where CustomerName is not null group by CustomerName,NewTotalSalePrice,TotalSalePrice

--26 select custermername  where RepeatCustomer is No with line iten price>500 then print is it or not??
	
	SELECT CustomerName,
    CASE WHEN LineItemPrice >500 and RepeatCustomer = 'No'    THEN 'Price more than 500'
    ELSE 'Order is not' END AS condition
    FROM Messy.dbo.Messy    
  where CustomerName is not null group by CustomerName,LineItemPrice,RepeatCustomer;

--27  Grouping Total sale made by a day
	SELECT sale_date,SUM(NewTotalSalePrice) AS TotalSalePrice
	FROM (SELECT NewTotalSalePrice,(CASE WHEN SaleDate IS NOT NULL THEN SUBSTRING(SaleDate,1,8) END) AS sale_date FROM Messy) AS SD
	GROUP BY sale_date

--28  List the data where producttags are null with unique orderno
	select * from Messy where ProductTags is Null
	select count(distinct(OrderNo)) from Messy where ProductTags is Null
	select count(distinct(OrderNo)) from Messy where ProductTags is not Null

--29 List important data where DiscountAppliedPc is not null or DiscountAppliedAbs is not null
	select OrderNo,ProductID,ProductDescription,LineItemPrice,TotalSalePrice,
	NewTotalSalePrice,DiscountAppliedPc,DiscountAppliedAbs
	from Messy where DiscountAppliedPc is not null or DiscountAppliedAbs is not null


--30	finding the custermername who are unique along with their total count and also they are repated customer.
    SELECT find.CustomerName,COUNT(find.OrderNo) AS COUNT_ORDER_BY_CUSTOMER,find.RepeatCustomer			--Counting order placed by Customer from find table
		FROM (SELECT DISTINCT OrderNo,CustomerName,RepeatCustomer FROM Messy WHERE CustomerName IS NOT NULL AND RepeatCustomer = 'Yes') AS find -- the find table contain unique orderno. where customer name is not null and repeat customer is no
		GROUP BY find.CustomerName,find.RepeatCustomer   ---  grouping find table by custermername and repeatcustomer
		HAVING COUNT(find.OrderNo)>1 -- sorting table by count order in desc order

--31 List all the data where CustomerEmail is .org
	select *  from Messy where CustomerEmail  like '%.org'
	select count(*)  from Messy where CustomerEmail  is Null

--32 unique orderno count, unique orderno count with repeatcustomer yes and no
	select count(distinct(OrderNo)) from Messy--6192
	select count(distinct(OrderNo)) from Messy where RepeatCustomer = 'No'--5367
	select count(distinct(OrderNo)) from Messy where RepeatCustomer = 'Yes'--825


--33 List all the data where TotalSalePrice is in ranege of 1500 to 1600
	select * from Messy where TotalSalePrice  between '1500' and '1600'

--34 List the important data where TotalSalePrice and NewTotalSalePrice is same
	select OrderNo,ProductID,ProductDescription,LineItemPrice,TotalSalePrice,NewTotalSalePrice
	from Messy where TotalSalePrice=NewTotalSalePrice

--35 List all the data where  CustomerAddress1  contain string 423 Fabien and RepeatCustomer is 'Yes'
	select * from Messy where CustomerAddress1  like '%423 Fabien%' and RepeatCustomer = 'Yes'

--36 List all the data where CustomerAddress4 or CustomerAddress3 is not empty
	select * from Messy where CustomerAddress4 != '' 
	select * from Messy where CustomerAddress3 != ''

--37 Product is not empty
  	 SELECT [ProductID]
     FROM [messy].[dbo].[Messy]
     WHERE [ProductID] IS NOT NULL

--38 Total colums in messy
	   SELECT COUNT(*) AS "TOTALCOLUMS"
	   FROM [messy].[dbo].[Messy]

--39 Number of rows in Total sale price  less than 1500 
     SELECT COUNT(*) AS "Number of rows"
     from [messy].[dbo].[Messy] 
     WHERE [TotalSalePrice] > 1500;


--40 Product tag  and customer name is null
     SELECT COUNT(ProductTags)
     FROM [messy].[dbo].[Messy]
     WHERE ProductTags IS NULL AND CustomerName IS NULL

--41 Customer email ends with .com
     SELECT [OrderNo],[CustomerEmail]
      FROM [messy].[dbo].[Messy] 
     where CustomerEmail like '%com'

--42 List rows with sale date not in year 2015
     SELECT COUNT(*) 
     FROM [messy].[dbo].[Messy]
     WHERE [SaleDate] not like  '201508%'

--43 Group Product Description and total sale price and arrange total sale price in asscending 
     SELECT [ProductDescription],[TotalSalePrice]
     FROM [messy].[dbo].[Messy]
     GROUP BY  [ProductDescription],[TotalSalePrice]
     ORDER BY [TotalSalePrice]


--44 product tags showing Clearance item and Product Description is empty 
    SELECT COUNT(*)
    (SELECT  [OrderNo],[SaleDate],[ProductID],[ProductDescription],[ProductTags]
    FROM [messy].[dbo].[Messy]
    WHERE ProductTags= 'Clearance' AND ProductDescription is NUll)


--45 Total sale price is not equal to new total sale price 
    SELECT *
   FROM [messy].[dbo].[Messy]
   WHERE TotalSalePrice != NewTotalSalePrice

 
 --46 where customer ordered without a customer name 

     SELECT *

     FROM [messy].[dbo].[Messy]
     WHERE CustomerName =('') 

  
--47 Show  Highest total sale price 
    select *
   FROM [messy].[dbo].[Messy]
   where TotalSalePrice =(SELECT MAX(TotalSalePrice) from messy);


--48  Distinct order 
   SELECT count(distinct(OrderNo)) from messy 
   SELECT count(distinct(OrderNo)) from messy where CustomerAddress1 = 'No'
   SELECT count(distinct(OrderNo)) from messy where CustomerAddress2 IS NULL
   SELECT count(distinct(OrderNo)) from messy where CustomerAddress3 = 'No'
   SELECT count(distinct(OrderNo)) from messy where CustomerAddress4 = 'Yes'
   SELECT count(distinct(OrderNo)) from messy where CustomerAddress5 IS NULL
   
--49 To select the distinct customer who get any sort of discount
    SELECT DISTINCT CustomerName,
    CustomerPhoneNo,PromoCode,
    CASE WHEN PromoCode = 'STAFFDISC' OR PromoCode = 'DISCOUNT10' OR PromoCode='PROMO10' OR PromoCode='SPRING15' OR PromoCode='FIVEOFF' THEN 'Qualified for Discount'
    ELSE 'Sorry you are not eligible for discount' END AS condition
    FROM Messy.dbo.Messy    
    where CustomerName is not null and CustomerPhoneNo is not null group by CustomerName, CustomerPhoneNo,PromoCode; 


 --50 To filter which promocode is applied on on the totalsaleprice for example FIVEOFF and PROMO10
    SELECT CustomerName,TotalSalePrice,NewTotalSalePrice, 
    CASE WHEN (TotalSalePrice - NewTotalSalePrice) = '5' THEN 'The Promocode FIVEOFF is applied'
    WHEN (TotalSalePrice - NewTotalSalePrice)= '10' THEN 'The Promocode PROMO10 is applied'
	ELSE 'Different code is applied' END AS condition
    FROM Messy.dbo.Messy
    WHERE PromoCode is not null and CustomerName is not null group by CustomerName, TotalSalePrice,NewTotalSalePrice

--51 Find the customers whose final totalsaleprice's range betweeon 1000 and 1500
	SELECT DISTINCT OrderNo,CustomerName,ProductDescription,NewTotalSalePrice From Messy.dbo.Messy
	WHERE NewTotalSalePrice Between 1000 and 1500  ORDER BY NewTotalSalePrice

--52 Selecting customers whose ProductTags is Clearance and CustomerAddress5 is startswith H and Repeated customer is allowed.
	SELECT ProductTags,CustomerName,CustomerAddress5,NewTotalSalePrice FROM Messy.dbo.Messy
	WHERE ProductTags = 'Clearance' and CustomerAddress5 like 'H%' and RepeatCustomer = 'Yes'


--53 To find the customer who have bought just one item.
	SELECT ProductID,ProductDescription,CustomerName,LineItemPrice,TotalSalePrice FROM Messy.dbo.Messy WHERE LineItemPrice = TotalSalePrice


--54 Selecting the saledate which starts and ends with 2 and CustomerName,CustomerPhone,ProductTags is not null
	SELECT CustomerName,CustomerPhoneNo,SaleDate,TotalSalePrice FROM Messy.dbo.Messy WHERE SaleDate like '%2' and SaleDate like '2%' and ProductTags is  not null and CustomerName is not null and CustomerPhoneNo is not null
	group by CustomerName,TotalSalePrice,SaleDate,CustomerPhoneNo


--55 Selecting the TotalSalePrice that is not null and order by in Ascending order
	SELECT CustomerName,ProductDescription,ProductID,TotalSalePrice FROM Messy.dbo.Messy
	GROUP BY ProductID,TotalSalePrice,CustomerName,ProductDescription
	HAVING TotalSalePrice IS NOT NULL
	ORDER BY TotalSalePrice

--56 Selecting the DiscountAppliedPc field when it is 15 then it hsows SPRING15 is applied on total price else some other condition is applied
	SELECT CustomerName,PromoCode,DiscountAppliedPc,NewTotalSalePrice,
	CASE WHEN DiscountAppliedPc = '15' THEN 'SPRING15 % discount is applied'
	ELSE 'Other discount is applied'END as condition FROM Messy.dbo.Messy 
	Where DiscountAppliedPc is not null

--57 Selecting CustomerAddress starts with E and CustomerEmail ends with .com
	select CustomerName,CustomerEmail,CustomerAddress5  
	from Messy.dbo.Messy 
	where CustomerAddress5 like 'E%'  and CustomerEmail like '%.com'
	group by CustomerName,CustomerEmail,CustomerAddress5


--58 Selecting the ProductDescription is Fronkilax and LineItemPrice is equal to TotalSalePrice
	SELECT * FROM Messy.dbo.Messy Where ProductDescription='Frokilax' and LineItemPrice = TotalSalePrice

--59 Counting the NewTotalSalePrice which is greater 2000 and PromoCode is Promo10
	SELECT COUNT(*) AS "Number of rows"
    from [Messy].[dbo].[Messy] 
    WHERE [NewTotalSalePrice] > 2000 and PromoCode ='PROMO10'

--60 Selecting lowest sale Price
    select *    FROM Messy.dbo.Messy
    where TotalSalePrice =(SELECT MIN(TotalSalePrice) from Messy.dbo.Messy);







