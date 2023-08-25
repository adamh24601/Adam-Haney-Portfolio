SELECT [Year of Data], City, AVG(TotalHotelRevenue) as AverageRevenue, ChainSegment
	FROM [FL Hotel Data]
	GROUP BY [Year of Data], City, ChainSegment
	Having AVG(TotalHotelRevenue) is not null
	ORDER BY AverageRevenue DESC
-- Honing in On Average Hotel Revenue By City

SELECT City, AVG(TotalHotelRevenue) as AverageRevenue
	FROM [FL Hotel Data]
	GROUP BY City
	HAVING AVG(TotalHotelRevenue) is not null
	ORDER BY AverageRevenue DESC
--Now we look at Average Revenue by Chain Segment and Location

SELECT ChainSegment, AVG(TotalHotelRevenue) as AverageRevenue
	FROM [FL Hotel Data]
	WHERE ChainSegment is not null
	GROUP BY ChainSegment
	HAVING AVG(TotalHotelRevenue) is not null
	ORDER BY AverageRevenue DESC

SELECT Location, AVG(TotalHotelRevenue) as AverageRevenue
	FROM [FL Hotel Data]
	WHERE Location is not null
	GROUP BY Location
	HAVING AVG(TotalHotelRevenue) is not null
	ORDER BY AverageRevenue DESC

--Next, we can see if the Average Revenue of Hotels has increased or decreased over time
SELECT [Year of Data], AVG(TotalHotelRevenue) as AverageRevenue
	FROM [FL Hotel Data]
	GROUP BY [Year of Data]
	HAVING AVG(TotalHotelRevenue) is not null
	ORDER BY [Year of Data]

--Furthermore, we have another table containing Tripadvisor data on each hotel

SELECT *
FROM TripAdvisorFLData

--As the Property Ids align, we can join the two tables then run a CTE and find the Average Revenues and Ratings for each City

CREATE VIEW City_Averages AS
WITH TripAdvisor AS (
SELECT  h.PropertyID, h.[Year of Data], h.City, h.[TotalHotelRevenue], h.ChainSegment, t.[General Rating], t.Walkability
	FROM [FL Hotel Data] h JOIN TripAdvisorFLData t ON h.PropertyId = t.PropertyID
	WHERE t.[General Rating] is not null
	)

SELECT City, AVG(TotalHotelRevenue) as Average_Revenue, AVG([General Rating]) as General_Rating_Average, AVG(Walkability) as Average_Walkability
	FROM TripAdvisor
	GROUP BY City

--We have saved this as a view that we can then call to assess the various Averages and cities. Here we will look at our top revenue earners
SELECT* 
FROM City_Averages
Order BY Average_Revenue DESC

--Next, we will see the cities with hotels that have the highest General review scores
SELECT* 
FROM City_Averages
Order BY General_Rating_Average DESC

--Finally, we will see the cities that have the highest average Walkability scores
SELECT* 
FROM City_Averages
Order BY Average_Walkability DESC