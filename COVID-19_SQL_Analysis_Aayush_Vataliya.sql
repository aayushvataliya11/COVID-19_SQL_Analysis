-- DATA GATHERING:

-- First Create a table which will store the data coming from the .csv file:

CREATE TABLE coronaData(
	Province VARCHAR(50),
	Country_or_Region VARCHAR(50),
	Latitude NUMERIC,
	Longitude NUMERIC,
	Date DATE,
	Confirmed INT,
	Deaths INT,
	Recovered INT
);

SELECT * FROM coronaData;

-- Now Import the data of "Corona Virus Dataset.csv" file into our "coronaData" table:

COPY coronaData(Province, Country_or_Region, Latitude, Longitude, Date, Confirmed, Deaths, Recovered)
FROM 'D:\college\Mentorness Internship Feb-Mar 2024\Project 1 - Corona Virus Analysis-20240218T120232Z-001\Corona Virus Dataset.csv'
DELIMITER ','
CSV HEADER;


SELECT * FROM coronaData;

-- DATA CLEANING:

-- To avoid any errors, check missing value / null value

-- Q1. Write a code to check NULL values

SELECT * FROM coronaData
WHERE Province IS NULL
	or Country_or_Region IS NULL
	or Latitude IS NULL
	or Longitude IS NULL
	or Date IS NULL
	or Confirmed IS NULL
	or Deaths IS NULL
	or Recovered IS NULL;


--Q2. If NULL values are present, update them with zeros for all columns. 

-- No Null/missing Values are present in the given dataset.
-- If missing values are present, then below query can be used to replace missing values with default values:

UPDATE coronaData
SET 
    Province = COALESCE(Province, 'Not Available'),
    Country_or_Region = COALESCE(Country_or_Region, 'Not Available'),
    Latitude = COALESCE(Latitude, 0),
    Longitude = COALESCE(Longitude, 0),
    Date = COALESCE(Date, '1970-01-01'::DATE),
    Confirmed = COALESCE(Confirmed, 0),
    Deaths = COALESCE(Deaths, 0),
    Recovered = COALESCE(Recovered, 0);


-- Q3. check total number of rows

SELECT COUNT(*) as total_rows FROM coronaData;


-- INSIGHTFUL QUERIES:

-- Q4. Check what is start_date and end_date

SELECT
	MIN(Date) as start_date,
	MAX(Date) as end_date
FROM coronaData;


-- Q5. Number of month present in dataset

-- total number of unique months in dataset
SELECT Count(Distinct Extract(MONTH FROM Date)) as num_of_month 
FROM coronadata;

-- Total no. of months and occurence of each month in table
SELECT 
	EXTRACT(MONTH FROM date) AS month_number,
	COUNT(*) as month_count
FROM coronaData
GROUP BY month_number
ORDER BY month_number;


-- Q6. Find monthly average for confirmed, deaths, recovered

SELECT 
	EXTRACT(YEAR FROM Date) AS year,
	EXTRACT(MONTH FROM Date) AS month_number,
	ROUND(AVG(Confirmed),2) as avg_confirmed_cases,
	ROUND(AVG(Deaths),2) as avg_deaths,
	ROUND(AVG(Recovered),2) as avg_recovered
FROM coronaData
GROUP BY year, month_number
ORDER BY year, month_number;
	
	
-- Q7. Find most frequent value for confirmed, deaths, recovered each month

WITH FrequentData AS (
    SELECT
        EXTRACT(MONTH FROM Date) as month_no,
        EXTRACT(YEAR FROM Date) as year,
        Confirmed,
        Deaths,
        Recovered,
        RANK() OVER (PARTITION BY EXTRACT(MONTH FROM Date),
					 EXTRACT(YEAR FROM Date)
					 ORDER BY COUNT(*) DESC) as rank
    FROM
        coronaData
    GROUP BY
        EXTRACT(MONTH FROM Date), EXTRACT(YEAR FROM Date), Confirmed, Deaths, Recovered
)
SELECT
    month_no,
    year,
    Confirmed,
    Deaths,
    Recovered
FROM
    FrequentData
WHERE
    rank = 1
ORDER BY
    year, month_no;
	
	
-- Q8. Find minimum values for confirmed, deaths, recovered per year

SELECT 
	EXTRACT(YEAR FROM Date) AS year,
	MIN(Confirmed) as min_confirmed,
	MIN(Deaths) as min_deaths,
	MIN(Recovered) as min_recovered
FROM coronaData
GROUP BY year
ORDER BY year;


-- Q9. Find maximum values of confirmed, deaths, recovered per year

SELECT 
	EXTRACT(YEAR FROM Date) AS year,
	MAX(Confirmed) as max_confirmed,
	MAX(Deaths) as max_deaths,
	MAX(Recovered) as max_recovered
FROM coronaData
GROUP BY year
ORDER BY year;


-- Q10. The total number of case of confirmed, deaths, recovered each month

SELECT 
	EXTRACT(YEAR FROM Date) AS year,
	EXTRACT(MONTH FROM Date) AS month_number,
	SUM(Confirmed) as total_confirmed,
	SUM(Deaths) as total_deaths,
	SUM(Recovered) as total_recovered
FROM coronaData
GROUP BY year, month_number
ORDER BY year, month_number;


-- Q11. Check how corona virus spread out with respect to confirmed case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT
	EXTRACT(YEAR FROM Date) AS year,
	EXTRACT(MONTH FROM Date) AS month_number,
	SUM(Confirmed) as total_confirmed,
	ROUND(AVG(Confirmed), 2) as avg_confirmed,
	ROUND(VARIANCE(Confirmed), 2) as variance_confirmed,
	ROUND(STDDEV(Confirmed), 2) as standard_deviation_confirmed
FROM coronaData
GROUP BY year, month_number
ORDER BY year, month_number;


-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total death cases, their average, variance & STDEV )

SELECT
	EXTRACT(YEAR FROM Date) AS year,
	EXTRACT(MONTH FROM Date) AS month_number,
	SUM(Deaths) as total_deaths,
	ROUND(AVG(Deaths), 2) as avg_deaths,
	ROUND(VARIANCE(Deaths), 2) as variance_deaths,
	ROUND(STDDEV(Deaths), 2) as standard_deviation_deaths
FROM coronaData
GROUP BY year, month_number
ORDER BY year, month_number;


-- Q13. Check how corona virus spread out with respect to recovered case per month
--      (Eg.: total recovered cases, their average, variance & STDEV )

SELECT
	EXTRACT(YEAR FROM Date) AS year,
	EXTRACT(MONTH FROM Date) AS month_number,
	SUM(Recovered) as total_recovered,
	ROUND(AVG(Recovered), 2) as avg_recovered,
	ROUND(VARIANCE(Recovered), 2) as variance_recovered,
	ROUND(STDDEV(Recovered), 2) as standard_deviation_recovered
FROM coronaData
GROUP BY year, month_number
ORDER BY year, month_number;


-- Q14. Find Country having highest number of the Confirmed case

SELECT 
	Country_or_Region,
	SUM(Confirmed) as total_confirmed
FROM coronaData
GROUP BY Country_or_Region
ORDER BY total_confirmed DESC
LIMIT 1;


-- Q15. Find Country having lowest number of the death case

WITH countryRank AS (
    SELECT
        Country_or_Region AS Country,
        SUM(Deaths) AS total_deaths,
        RANK() OVER(ORDER by SUM(Deaths) ASC) AS rank_no
    FROM
        coronaData
    GROUP BY
        Country
)
SELECT 
	Country,
	total_deaths
FROM 
	countryRank
WHERE 
    rank_no = 1;


-- Q16. Find top 5 countries having highest recovered case

SELECT 
	Country_or_Region,
	SUM(Recovered) as total_recovered
FROM coronaData
GROUP BY Country_or_Region
ORDER BY total_recovered DESC
LIMIT 5;

