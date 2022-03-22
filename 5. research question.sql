-- 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

WITH growth_GDP_CZ AS (
	SELECT 
		a.country, a.year, a.GDP,
		ROUND((a.GDP - b.GDP) / b.GDP * 100, 2) as growth_GDP
	FROM (
		SELECT
			*
		FROM 
			t_adam_valenta_project_SQL_secondary_final
		WHERE country = 'Czech Republic'
		 ) a
	JOIN (
		SELECT
			*
		FROM 
			t_adam_valenta_project_SQL_secondary_final
		WHERE country = 'Czech Republic'
		 ) b
		ON a.year = b.year + 1
),
growth_payroll AS (
	SELECT
		a.year,
		ROUND((a.year_avg_net_value - b.year_avg_net_value) / b.year_avg_net_value * 100, 2) as growth_payroll
	FROM (
		SELECT
			*,
			AVG(avg_net_value) AS year_avg_net_value
		FROM
			t_adam_valenta_project_sql_primary_final
		GROUP BY year
		 ) a
	JOIN (
		SELECT
			*,
			AVG(avg_net_value) AS year_avg_net_value
		FROM
			t_adam_valenta_project_sql_primary_final
		GROUP BY year
		 ) b
		 ON a.year = b.year + 1
),
growth_food_price AS (
	SELECT
		a.year,
		ROUND((a.year_avg_price - b.year_avg_price) / b.year_avg_price * 100, 2) as growth_food_price
	FROM (
		SELECT
			*,
			AVG(avg_price) AS year_avg_price
		FROM
			t_adam_valenta_project_sql_primary_final
		GROUP BY year
		 ) a
	JOIN (
		SELECT
			*,
			AVG(avg_price) AS year_avg_price
		FROM
			t_adam_valenta_project_sql_primary_final
		WHERE avg_price IS NOT NULL
		GROUP BY year
		 ) b
		 ON a.year = b.year + 1
		 AND b.year < 2018
)
SELECT
	gg.year, gg.growth_GDP, gp.growth_payroll, gf.growth_food_price
FROM 
	growth_GDP_CZ as gg
JOIN 
	growth_payroll AS gp
	ON gg.year = gp.year
JOIN
	growth_food_price AS gf 
	ON gg.year = gf.year
ORDER BY year;

-- Z dat vyplývá, že HDP nemá přímý vliv na průměrnou mzdu ani na cenu potravin.
-- K zjištění vlivu HDP na průměrnou mzdu a cenu potravin bylo použito grafické znázornění a výpočet lineární regrese. 
-- Grafy jsou dostupné zde: https://docs.google.com/spreadsheets/d/1WE0knllTnqCoRrvX6zIaSEI2JNn3Jpr-B3QLWGMZ3J4/edit?usp=sharing
-- Koeficient determinace (R^2), který se používá k zjištění závislosti mezi dvěma proměnnými vyšel v obou případech nízký a tudíž se jedná o nízkou závislost.
