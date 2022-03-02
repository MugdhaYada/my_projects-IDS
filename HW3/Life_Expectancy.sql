use ids13db;

select * from Life_Expectancy;

select count(*) from Life_Expectancy;

Select count(*)
from Life_Expectancy
where Population = 0;

set SQL_SAFE_UPDATES = 0;

delete from Life_Expectancy
where Population = 0;

Select count(Country) 
from Life_Expectancy;

select * from Life_Expectancy;

set SQL_SAFE_UPDATES = 0;

update Life_Expectancy
set Alcohol = null
where Alcohol = 0;

update Life_Expectancy
set Percentage_Expenditure = null
where Percentage_Expenditure = 0;

set SQL_SAFE_UPDATES = 0;

update Life_Expectancy
set Total_Expenditure = null
where Total_Expenditure = 0;

set SQL_SAFE_UPDATES = 0;

update Life_Expectancy
set GDP= null
where GDP = 0;

set SQL_SAFE_UPDATES = 0;

update Life_Expectancy
set Schooling = null
where Schooling = 0;

select * from Life_Expectancy;

Set SQL_SAFE_UPDATES = 0;

update Life_Expectancy
set Life_Expectancy = null
where Life_Expectancy = 0;

update Life_Expectancy
set Adult_Mortality = null
where Adult_Mortality = 0;

Select *
from Life_Expectancy;

update Life_Expectancy
set BMI = null
where BMI = 0;

Select @avg_Alcohol := format(avg(Alcohol),2)
from Life_Expectancy;

Set SQL_SAFE_UPDATES = 0;

Update Life_Expectancy 
set Alcohol = @avg_Alcohol
where Alcohol is null;


Select @avg_Percentage_Expenditure := ROUND(avg(Percentage_Expenditure),8)
from Life_Expectancy;

set SQL_SAFE_UPDATES = 0;

Update Life_Expectancy 
set Percentage_Expenditure = @avg_Percentage_Expenditure
where Percentage_Expenditure is null;


Select @avg_BMI := format(avg(BMI),1)
from Life_Expectancy;

Set SQL_SAFE_UPDATES = 0;

update Life_Expectancy 
set BMI = @avg_BMI
where BMI is null;

select Country, BMI
from Life_Expectancy
where BMI = 39.9;

Select @avg_GDP := round(avg(GDP),6)
from Life_Expectancy;

Set SQL_SAFE_UPDATES = 0;

Update Life_Expectancy
set GDP = @avg_GDP
where GDP is null;

Select @avg_Schooling := round(avg(Schooling),1)
from Life_Expectancy;

Set SQL_SAFE_UPDATES = 0;

Update Life_Expectancy
set Schooling = @avg_Schooling
where Schooling is null;

Select @avg_Adult_Mortality := round(avg(Adult_Mortality),2)
from Life_Expectancy;

Set SQL_SAFE_UPDATES = 0;

Update Life_Expectancy
set Adult_Mortality = @avg_Adult_Mortality
where Adult_Mortality is null;

Select @avg_Life_Expectancy := round(avg(Life_Expectancy),1)
from Life_Expectancy;

Set SQL_SAFE_UPDATES = 0;

Update Life_Expectancy
set Life_Expectancy = @avg_Life_Expectancy
where Life_Expectancy is null;

Select *
from Life_Expectancy;

-- List of countries with the highest and lowest average average mortality rates (years 2010-2015)
(Select Country, avg_adultMortality,'Highest' AVERAGETYPE FROM
(Select DISTINCT Country, avg(Adult_Mortality) avg_adultMortality from Life_Expectancy group by Country)S 
ORDER BY avg_adultMortality desc limit 1)
Union
(Select Country, avg_adultMortality, 'Lowest' AverageType FROM
(Select DISTINCT Country, avg(Adult_Mortality) avg_adultMortality from Life_Expectancy group by Country)M
ORDER BY avg_adultMortality LIMIT 1);

-- List of countries with the highest and lowest average population (years 2010-2015)
(Select Country, avg_Population,'Lowest' AVERAGETYPE FROM
(Select DISTINCT Country, avg(Population) avg_Population from Life_Expectancy group by Country)S 
ORDER BY avg_Population desc limit 1)
Union
(Select Country, avg_Population, 'Lowest' AverageType FROM
(Select DISTINCT Country, avg(Population) avg_Population from Life_Expectancy group by Country)M
ORDER BY avg_Population limit 1);

-- List of countries with the highest and lowest average GDP (years 2010-2015)
(Select Country, avg_GDP,'Highest' AVERAGETYPE FROM
(Select DISTINCT Country, avg(GDP) avg_GDP from Life_Expectancy group by Country)S 
ORDER BY avg_GDP desc limit 1)
Union
(Select Country, avg_GDP, 'Lowest' AverageType FROM
(Select DISTINCT Country, avg(GDP) avg_GDP from Life_Expectancy group by Country)M
ORDER BY avg_GDP limit 1);

-- List of countries with the highest and lowest average Schooling (years 2010-2015)
(Select Country, avg_Schooling,'Highest' AVERAGETYPE FROM
(Select DISTINCT Country, round(avg(Schooling),2) avg_Schooling from Life_Expectancy group by Country)S 
ORDER BY avg_Schooling desc limit 1)
Union
(Select Country, avg_Schooling, 'Lowest' AverageType FROM
(Select DISTINCT Country, round(avg(Schooling),2) avg_Schooling from Life_Expectancy group by Country)M
ORDER BY avg_Schooling limit 1);

-- List of countries that have highest and lowest average alcohol consumption (years 2010-2015)
(Select Country, avg_Alcohol,'Highest' AVERAGETYPE FROM
(Select DISTINCT Country, avg(Alcohol) avg_Alcohol from Life_Expectancy group by Country)S 
ORDER BY avg_Alcohol desc limit 1)
Union
(Select Country, avg_Alcohol, 'Lowest' AverageType FROM
(Select DISTINCT Country, avg(Alcohol) avg_Alcohol from Life_Expectancy group by Country)M
ORDER BY avg_Alcohol limit 1);

-- Do densely populated countries tend to have lower life expectancy
(Select Country, avg_Population, avg_Life_Expectancy FROM
(Select  Country, avg(Population) avg_Population, avg(Life_Expectancy) avg_Life_Expectancy from Life_Expectancy group by Country)S 
ORDER BY avg_Life_Expectancy desc limit 1)
Union
(Select Country, avg_Population, avg_Life_Expectancy FROM
(Select  Country, avg(Population) avg_Population, avg(Life_Expectancy) avg_Life_Expectancy from Life_Expectancy group by Country)S 
ORDER BY avg_Life_Expectancy limit 1);




