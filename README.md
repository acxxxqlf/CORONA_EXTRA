**CORONA-EXTRA**

This project showcases a complete end-to-end data analytics workflow built using real-world Covid-19 data from India. Starting with raw datasets containing inconsistent formats and messy columns, the data was fully cleaned, transformed and loaded into a relational database for further analysis. The goal was to extract meaningful healthcare insights directly from real data using pure SQL.

**Project Overview**

Multiple raw datasets were extracted from public sources. These files had different structures, naming conventions and data formats. The first step was to clean the data using Python. Columns were renamed, unnecessary fields were dropped and the data was standardized to match a clean database schema.

After cleaning, the data was imported into SQL Server where proper tables were created. Using SQL queries, several key performance indicators were calculated directly on the database, without relying on any external visualization or BI tools. This demonstrates the ability to build insights directly from data using SQL alone.

**Tools Used**

-SQL Server Management Studio
-Python (pandas)
-Kaggle datasets

**Data Sources**

-Covid-19 India daily case data
-ICMR Testing Data
-Both datasets were collected from Kaggle and cover state-wise Covid statistics and testing details for India.

**Key Metrics Developed**

**_Spike Detection_**: States were classified daily into Spike, Moderate or Stable based on new confirmed cases calculated using SQL window functions.
**_Positivity Rate_**: The percentage of positive cases relative to the number of tests performed was computed to analyze testing efficiency.
**_Recovery-to-Death Ratio_**: The ratio between recovered and deceased patients was calculated to track healthcare system performance.

**SQL Concepts Applied**

-Full ETL workflow from raw data to database
-Data cleaning and schema transformation
-Common Table Expressions (CTE)
-Window functions (LAG) to calculate daily new cases
-CASE statements for classification logic
-Derived KPIs directly within SQL queries
-NULL handling using NULLIF
-Bulk data import handling

**What This Project Demonstrates**

The ability to take completely raw and messy real-world data and transform it into an analysis-ready database. The project highlights skills in data cleaning, schema design, troubleshooting import issues, writing advanced SQL queries and developing business-oriented KPIs directly from the database.

**Possible Expansion**

The project can be further expanded by adding visualization layers using Tableau or Power BI. Forecasting models can also be integrated using Python to predict future trends based on the existing data.

