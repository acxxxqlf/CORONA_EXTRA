--Creating the database
CREATE DATABASE covid_project;
USE covid_project;

--Table definition
CREATE TABLE covid_india (
    Date DATE,
    State VARCHAR(100),
    Latitude FLOAT,
    Longitude FLOAT,
    Confirmed INT,
    Active INT,
    Deaths INT,
    Mortality_rate FLOAT,
    Cured INT,
    Recovery_rate FLOAT
);

CREATE TABLE icmr_testing (
    Day DATE,
    Total_Samples_Tested INT,
    Total_Positive_Cases INT,
    Positive_Ratio FLOAT,
    Perday_Positive INT,
    Perday_Tests INT
);

--How much spikes are confirmed in each state
WITH state_daily AS (
    SELECT State, Date, Confirmed,
           LAG(Confirmed) OVER (PARTITION BY State ORDER BY Date) AS Prev_Confirmed
    FROM covid_india
),
daily_new AS (
    SELECT State, Date,
           Confirmed - Prev_Confirmed AS Daily_New,
           CASE
               WHEN Confirmed - Prev_Confirmed > 500 THEN 'Spike'
               WHEN Confirmed - Prev_Confirmed BETWEEN 100 AND 500 THEN 'Moderate'
               ELSE 'Stable'
           END AS Spike_Level
    FROM state_daily
    WHERE Prev_Confirmed IS NOT NULL
)
SELECT * FROM daily_new
ORDER BY Daily_New DESC;

--ICMR efficiency 
SELECT Day,
       Total_Samples_Tested,
       Total_Positive_Cases,
       ROUND((Total_Positive_Cases * 1.0 / Total_Samples_Tested) * 100, 2) AS Positivity_Percentage
FROM icmr_testing
ORDER BY Day;

--K/D ratio
SELECT Date,
       SUM(Cured) AS Total_Recovered,
       SUM(Deaths) AS Total_Deaths,
       ROUND(SUM(Cured) * 1.0 / NULLIF(SUM(Deaths), 0), 2) AS Recovery_to_Death_Ratio
FROM covid_india
GROUP BY Date
ORDER BY Date;

--Inserting the data into my tables
INSERT INTO covid_india (Date, State, Latitude, Longitude, Confirmed, Active, Deaths, Mortality_rate, Cured, Recovery_rate)
SELECT Date, State, Latitude, Longitude, Confirmed, Active, Deaths, Mortality_rate, Cured, Recovery_rate
FROM covid_india_clean_final;

INSERT INTO icmr_testing (Day, Total_Samples_Tested, Total_Positive_Cases, Positive_Ratio, Perday_Positive, Perday_Tests)
SELECT Day, totalSamplesTested, totalPositiveCases, positive_ratio, perday_positive, perday_tests
FROM icmr_testing_clean_final;


--Visualizing no. of columns in the datasets
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'covid_india_clean_final';
