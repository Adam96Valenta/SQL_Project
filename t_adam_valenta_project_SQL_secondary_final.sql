CREATE OR REPLACE TABLE t_adam_valenta_project_SQL_secondary_final AS
WITH europe_countries AS (
	SELECT 
		*
	FROM
		countries AS c 
	WHERE continent = 'Europe'
)
SELECT
	e.country, e.year, e.GDP, e.population, e.gini
FROM
	economies AS e 
JOIN europe_countries AS ec
	ON e.country = ec.country
WHERE GDP IS NOT NULL;
