use swiggy_DB;



SELECT *
  FROM [swiggy_DB].[dbo].[swiggy_orders$]
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  /* Cleaning   data in sql queries
*/

 select * 
from swiggy_orders$
where [Restaurant Name] is null
or city is null
or rating is null;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* remove  duplicates  */

select [State],
count(*) as duplicate_count 
from swiggy_orders$
group by State,City
having count(*) >1;



select State
,city
,[Restaurant Name]
,location
,category 
,[Dish Name]
,[Price (INR)]
,rating
,rating count
,feedback,count(*) as duplicate_count
from swiggy_orders$
group by state,city,[Restaurant Name],Location,Category,[Dish Name],[Price (INR)],Rating,[Rating Count],FEEDBACK
having count (*) > 1;


------------------------------------------------------------------------------------------------------------------------------------


with duplictesRows AS ( 
select *,
ROW_NUMBER()  over (
PARTITION BY [Restaurant Name] ,state

ORDER by [restaurant name] )as rn
from swiggy_orders$
)
select * from duplictesRows
where rn > 1;


----------------------------------------------------------------------------------------------------------------------


WITH CTE AS
(
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY City,
                            [Restaurant Name],
                            [Location],
                            [Category],
                            [Dish Name],
                            
                            [Rating],
                            [Rating Count]
               ORDER BY [Restaurant Name]
           ) AS rn
    FROM swiggy_orders$
)
SELECT *
FROM CTE
WHERE rn > 1;
----------------------------------------------------------------------------------------------------------------------------------------------------------/* aggregation
 ---AGGREGATION-----------------
 
 SELECT  City, avg(Rating)
  FROM [swiggy_DB].[dbo].[swiggy_orders$]
  group by City;

 -----------------------------------------------------------------------------------------------------------------------------


 

 select count (DISTINCT [Restaurant Name]) as total_restaurants
 from swiggy_orders$;



 select count (DISTINCT [City]) as total_citys
 from swiggy_orders$;

 select count (DISTINCT [State]) as total_states
 from swiggy_orders$


SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'swiggy_orders$';



-- Check NULL prices
SELECT *
FROM swiggy_orders$
WHERE [Price (INR)] IS NULL;

-- Check zero or negative prices
SELECT *
FROM swiggy_orders$
WHERE [Price (INR)] <= 0;

-- Check price range
SELECT
    MIN([Price (INR)]) AS Min_Price,
    MAX([Price (INR)]) AS Max_Price
FROM swiggy_orders$;

-- Check unusually high prices
SELECT *
FROM swiggy_orders$
WHERE [Price (INR)] < 2000;
-- Check NULL prices
SELECT *
FROM swiggy_orders$
WHERE [Price (INR)] IS NULL;

-----------------------------------------------------------------------------------------------------------------------






