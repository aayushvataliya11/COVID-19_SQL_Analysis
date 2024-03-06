# COVID-19_SQL_Analysis

### About Project:
* The effects of COVID-19 on public health highlight the necessity of data-driven insights to understand the virus's progress.
* As a data analyst, our job is to search for important insights by analyzing a COVID-19 dataset.
* We want to identify patterns and trends through in-depth study to improve our understanding of virus transmission.
* Insights derived from data will help fight the pandemic and safeguard public health.


### About Dataset:

Information on each attribute in the dataset:  [COVID-19 Dataset](https://github.com/aayushvataliya11/COVID-19_SQL_Analysis/blob/main/Corona%20Virus%20Dataset.csv)

* Province: Geographic subdivision within a country/region.
* Country/Region: Geographic entity where data is recorded.
* Latitude: North-south position on Earth's surface.
* Longitude: East-west position on Earth's surface.
* Date: Recorded date of CORONA VIRUS data.
* Confirmed: Number of diagnosed CORONA VIRUS cases.
* Deaths: Number of CORONA VIRUS related deaths.
* Recovered: Number of recovered CORONA VIRUS cases

Thus dataset contains information related to 'location', 'date' and various categories of cases such as 'Confirmed', 'Deaths', 'Recovered'.


### About Technology:

* Database system used: PostgreSQL Database
* Database Management Tool used: pgAdmin4


### About SQL Analysis Process:

* Data Gathering Phase:
  * Created Database 'coronaVirusDB'.
  * Created Table 'coronaData'.
  * Import Data from 'Corona Virus Dataset.csv' file.
* Data Cleaning Phase:
  * Checking for NULL/Missing values.
  * Replacing Null values with default values if any.
  * Checking for total number of Records in the dataset.
* Insightful Queries:
  * In depth analysis of the dataset with the help of SQL queries.


### Insights:

1. COVID-19 Pandemic Duration: 22nd January 2020   to  13 June 2021.
2. Country with the highest Confirmed COVID-19 Cases: USA
3. Country with the highest Recovered COVID-19 Cases: India
4. Peak Confirmed Cases in: April 2021
5. Peak Death Rate in: January 2021
6. Countries with Lowest Death Rates are:
    1. Samoa
    2. Kiribati
    3. Dominica
    4. Marshall Islands

 For furthur information, refer [COVID-19_SQL_Analysis_Presentation](https://github.com/aayushvataliya11/COVID-19_SQL_Analysis/blob/main/COVID-19_SQL_Analysis_Presentation.pdf) and [SQL Source Code file](https://github.com/aayushvataliya11/COVID-19_SQL_Analysis/blob/main/COVID-19_SQL_Analysis.sql)







