SELECT *
FROM census_project..data1;

SELECT *
FROM census_project..data2;


-- number of rows in dataset

SELECT COUNT(*)
FROM census_project..data1;

SELECT COUNT(*)
FROM census_project..data2;


-- dataset for jharkhand and bihar

SELECT data1.State, data1.District,  data1.Growth, data1.Sex_Ratio, data1.Literacy, data2.Area_km2, data2.Population
FROM census_project..data1
JOIN census_project..data2
ON data1.District = data2.District
WHERE data1.State = 'Jharkhand' OR data1.State = 'Bihar'
ORDER BY data1.State;

-- population of India

SELECT SUM(Population) AS India_population_2011
FROM census_project..data2;


-- avg growth 

SELECT State, AVG(Growth)*100 AS state_population_Growth
FROM census_project..data1
GROUP BY State;

-- avg sex ratio

SELECT State, ROUND(AVG(Sex_Ratio),0) AS Sex_Ratio
FROM census_project..data1
GROUP BY State
ORDER BY Sex_Ratio DESC;

-- avg literacy rate

SELECT State, ROUND(AVG(Literacy),2) AS Literacy_rate
FROM census_project..data1
GROUP BY State
HAVING AVG(Literacy)>=90
ORDER BY Literacy_rate DESC;

-- top 3 state showing highest growth ratio

SELECT TOP 3 State, AVG(growth)*100 AS growth
FROM census_project..data1
GROUP BY State
ORDER BY growth DESC;

--bottom 3 state showing lowest sex ratio

SELECT TOP 3 state, ROUND(AVG(sex_ratio),0) AS sex_ratio
FROM census_project..data1
GROUP BY State
ORDER BY sex_ratio ASC;

-- top and bottom 3 states in literacy rate

--union opertor

SELECT *
FROM 
(
SELECT TOP 3 State, ROUND(AVG(Literacy),0) AS literacy_rate
FROM census_project..data1
GROUP BY state
ORDER BY literacy_rate DESC ) AS a

UNION

SELECT *
FROM 
(
SELECT TOP 3 State, ROUND(AVG(Literacy),0) AS literacy_rate
FROM census_project..data1
GROUP BY state
ORDER BY literacy_rate ASC ) AS b

ORDER BY literacy_rate DESC;




-- states starting with letter a

SELECT DISTINCT state 
FROM census_project..data1
WHERE state LIKE 'a%';

-- joining both table

--total males and females

SELECT state, SUM(Population) AS Tot_population, SUM(Male_count) AS tot_male_count, SUM(female_count) AS tot_female_count
FROM 
(

SELECT data1.state, data1.District, data1.Sex_Ratio, data2.Population, ROUND(((Population*Sex_Ratio)/(1000+Sex_Ratio)),0) AS female_count, ROUND((Population- ((Population*Sex_Ratio)/(1000+Sex_Ratio))),0) AS Male_count
FROM census_project..Data1
JOIN census_project..Data2
ON data1.District = data2.District) AS a
GROUP BY state;



-- total literacy rate


SELECT State, SUM(population) AS population, ROUND(AVG(literacy),0) AS literacy_rate, SUM(literates) AS literates, SUM(Illiterates) AS illiterates
FROM
(
select data1.district, data1.state, literacy, population, ROUND((literacy/100)*Population,0) AS literates, ROUND((Population-((literacy/100)*Population)),0) AS Illiterates
from census_project..data1
JOIN census_project..data2
ON  data1.district = data2.district) AS a
GROUP BY state;


-- population in previous census


SELECT data1.State, ROUND(avg(Growth),2) Growth, SUM(population) AS present_population, sum(ROUND((Population/(1+growth)),0)) AS prev_population
FROM census_project..data1
JOIN census_project..data2
ON data1.district = data2.district
GROUP BY data1.state;


---- population vs area


----SELECT district, area_km2, Population, ROUND((Population/Area_km2),0) AS population_per_sq_km
----FROM census_project..Data2
----ORDER BY population_per_sq_km DESC;




----window 

----output top 3 districts from each state with highest literacy rate






