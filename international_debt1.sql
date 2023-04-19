-- Table: international_debt

CREATE TABLE international_debt
(
  country_name character varying(50),
  country_code character varying(50),
  indicator_name text,
  indicator_code text,
  debt numeric
);

-- Copy over data from CSV
\copy international_debt FROM 'international_debt.csv' DELIMITER ',' CSV HEADER;


-- The World Bank's international debt data
SELECT *
FROM international_debt
LIMIT 10


-- Finding the number of distinct countries
SELECT 
    COUNT (DISTINCT country_name) as total_distinct_counties
FROM international_debt;


-- Finding out distinct debt indicators
SELECT DISTINCT indicator_code as distinct_debt_indicators
FROM international_debt
ORDER BY  distinct_debt_indicators


-- Totalling amount of debt owed by countries 
SELECT 
    ROUND (SUM(debt)/1000000, 2) as total_debt
FROM international_debt; 


-- Country with highest debt
SELECT 
    country_name, 
    SUM(debt) as total_debt
FROM international_debt
GROUP BY country_name
ORDER BY total_debt DESC
LIMIT 1;


-- Average amount of debt accross indicators
SELECT 
    indicator_code as debt_indicator,
    indicator_name,
    AVG(debt) as average_debt
FROM international_debt
GROUP BY debt_indicator, indicator_name
ORDER BY average_debt DESC
LIMIT 10;


-- The highest amount of principal repayments
SELECT 
    country_name, 
    indicator_name
FROM international_debt
WHERE debt = (SELECT MAX(debt)
             FROM internationaL_debt
             WHERE indicator_code = 'DT.AMT.DLXF.CD');


-- The most common debt indicators
SELECT indicator_code,
    COUNT(*) as indicator_count
FROM international_debt
GROUP BY indicator_code
ORDER BY indicator_count desc, indicator_code desc
LIMIT 20


-- Other viable debt issues
SELECT country_name,
    MAX(debt) as maximum_debt
FROM international_debt
GROUP BY country_name
ORDER BY maximum_debt desc
LIMIT 10