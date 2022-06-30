SELECT * FROM covid_deaths;

SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM covid_deaths
order by 1, 2;

-- Standardize date
UPDATE covid_deaths
SET date = CONVERT(date, date)
SELECT date FROM covid_deaths;

-- lets add date column
ALTER TABLE covid_deaths
ADD date2 date;

UPDATE covid_deaths
SET date2 = CONVERT(date, date)

SELECT date, date2 FROM covid_deaths;




-- Total Cases vs Total deaths
-- How many % of total infected people died?
SELECT Location, date2, total_cases,total_deaths, (total_deaths/total_cases)*100 AS death_percentage
FROM covid_deaths
order by 1, 2;

SELECT Location, date2, total_cases,total_deaths, (total_deaths/total_cases)*100 AS death_percentage
FROM covid_deaths
WHERE location= 'India'
order by 1, 2;

-- Total cases vs Populations
-- How many % of total polpulation got infected 
SELECT Location, date2, total_cases,population, (total_cases/population)*100 AS infect_percentage
FROM covid_deaths
WHERE location= 'India'
order by 1, 2;

-- Highest infection rate by population
-- What max % of total population got infected
SELECT Location, population, MAX(total_cases) as total_cases, max((total_cases/population)*100) AS infect_percentage
FROM covid_deaths
where continent is not null
group by location, population
order by 4 desc;


--Highest Death Count per population
SELECT Location, MAX(CAST(total_deaths as int)) as total_deaths
FROM covid_deaths
where continent is not null
group by location
order by total_deaths desc; 



-- Check by continenet
SELECT Location, MAX(CAST(total_deaths as int)) as total_deaths
FROM covid_deaths
where continent is null and location not like '%income%'
group by location
order by total_deaths desc; 


--SELECT *
--FROM covid_deaths
--WHERE location like '%income%'

 



 -- Global Numbers
SELECT date, sum(new_cases) as daily_new_cases, sum(cast(new_deaths As int)) as new_deaths
-- sum(cast(new_deaths As int))/sum(new_cases)*100 AS death_percentage
FROM covid_deaths
where continent is null and location not like '%income%'
group by date
order by 1



-------------------------------

SELECT * FROM covid_vaccinations;

SELECT * FROM covid_vaccinations v
join covid_deaths d
on d.location = v.location
and d.date = v.date		


-- Total Population vs Total Vaccination
SELECT d.location,d.population,d.date2, v.new_vaccinations,v.total_vaccinations
FROM covid_vaccinations v
join covid_deaths d
on d.location = v.location
and d.date = v.date		
order by 1, 2, 3




--- View 
CREATE VIEW continent_wise_deaths AS
SELECT Location, MAX(CAST(total_deaths as int)) as total_deaths
FROM covid_deaths
where continent is null and location not like '%income%'
group by location

SELECT * from continent_wise_deaths;