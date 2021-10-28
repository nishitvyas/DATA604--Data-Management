/****** Script for SelectTopNRows command from SSMS  ******/
1.)
SELECT [orderid]
	  ,[orderdate]
      ,[custid]
      ,[empid]
  FROM [TSQLV4].[Sales].[Orders]
  WHERE [orderdate]> '05/31/2015' AND [orderdate]<'07/01/2015';

2.)
  SELECT [orderid]
		,([qty]*[unitprice]) as totalprice
  FROM [TSQLV4].[Sales].[OrderDetails]
    WHERE [qty]*[unitprice] > 10000
	ORDER BY [qty]*[unitprice];


3.)

SELECT TOP(3) [shipcountry],avg(freight) AS avgfreight
FROM [TSQLV4].[Sales].[Orders]
WHERE [orderdate]> '12/31/2014' AND [orderdate]<'01/01/2016'
GROUP BY [shipcountry]
ORDER BY avgfreight DESC;


4.)
SELECT DISTINCT E.empid, E.firstname, E.lastname
FROM [TSQLV4].[HR].[Employees] E, [TSQLV4].[Sales].[Orders] o
WHERE E.empid = o.empid
EXCEPT
SELECT DISTINCT E.empid, E.firstname, E.lastname
FROM [TSQLV4].[HR].[Employees] E, [TSQLV4].[Sales].[Orders] o
WHERE E.empid = o.empid AND o.orderdate >= '05/01/2016';

5.)
SELECT TOP(45) empid, firstname, lastname, n
FROM [TSQLV4].[HR].[Employees] E, [TSQLV4].[dbo].[Nums] N
WHERE E.empid=E.empid 
ORDER BY n, empid ASC;

7.)
SELECT * INTO [TSQLV4].[Sales].[Orders14To16]
FROM [TSQLV4].[Sales].[Orders]
WHERE orderdate BETWEEN '12/31/2013' AND '01/01/2017';

SELECT * FROM [TSQLV4].[Sales].[Orders14To16];


8.)
ALTER TABLE [TSQLV4].[Sales].[Orders14To16]
ADD FiscalMonth int;
ALTER TABLE [TSQLV4].[Sales].[Orders14To16]
ADD FiscalYear int;

ALTER TABLE [TSQLV4].[Sales].[Orders14To16]
DROP COLUMN FiscalYear, FiscalMonth

INSERT INTO [TSQLV4].[Sales].[Orders14To16](FiscalYear, FiscalMonth)
VALUES(SELECT DATEPART(yy, orderdate) as FiscalYear, DATEPART(mm, orderdate) as FiscalMonth
FROM [TSQLV4].[Sales].[Orders14To16] o
WHERE o.orderid = o.orderid);
----------------------------------------------------------------------------------------------------------
INSERT INTO [TSQLV4].[Sales].[Orders14To16](FiscalYear1, FiscalMonth1)
VALUES(SELECT DATEPART(yy, orderdate), DATEPART(mm, orderdate))
FROM [TSQLV4].[Sales].[Orders14To16] o
WHERE o.orderid = o.orderid);
-------------------------------------------------------------------------------------------
UPDATE [TSQLV4].[Sales].[Orders14To16] 
SET FiscalYear = SELECT DATEPART(yy, orderdate) FROM [TSQLV4].[Sales].[Orders14To16];


SET FiscalMonth = (SELECT DATEPART(mm, orderdate) FROM [TSQLV4].[Sales].[Orders14To16]);


SELECT DATEPART(yy, orderdate) as FiscalYear, DATEPART(mm, orderdate) as FiscalMonth
FROM [TSQLV4].[Sales].[Orders14To16]
--------------------------------------------------------------------------------------------------------
CASE month
	WHEN month>9 THEN year=year+1
	WHEN month<=9 THEN year=year
END AS FiscalYear
FROM [TSQLV4].[Sales].[Orders14To16]


--------------------------------------------------------------------------
SELECT DATEPART(yy, orderdate) as FiscalYear, DATEPART(mm, orderdate) as FiscalMonth
FROM [TSQLV4].[Sales].[Orders14To16]
SELECT 
CASE
	WHEN FiscalMonth > 9 THEN FiscalYear=FiscalYear + 1
	WHEN FiscalMonth <= 9 THEN FiscalYear=FiscalYear
END

SELECT * FROM [TSQLV4].[Sales].[Orders14To16]

---------------------------------FINAL---------------------------------------------
---------------------------------COLUMN CREATION---------------------------------------------
ALTER TABLE [TSQLV4].[Sales].[Orders14To16]
ADD FiscalYear int;
------------------------------FOR VALUES----------------------------------------------------
UPDATE [TSQLV4].[Sales].[Orders14To16]
SET FiscalYear = CASE	
	WHEN MONTH(orderdate) IN (10,11,12) THEN YEAR(orderdate)+1
	ELSE YEAR(orderdate)
	END;
--------------------------------END---------------------------------------------------

SELECT * FROM [TSQLV4].[Sales].[Orders14To16] 
WHERE orderdate='02/12/2016';
SELECT * FROM [TSQLV4].[Sales].[Customers];
9.)
SELECT C.custid, C.companyname, CASE 
WHEN orderdate = '02/12/2016' THEN 'Yes'
ELSE 'No'
END AS HasOrderOn20160212
FROM [TSQLV4].[Sales].[Customers] C, [TSQLV4].[Sales].[Orders14To16] O
WHERE C.custid = O.custid;