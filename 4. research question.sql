-- 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

WITH growth_payroll AS (
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
	gp.year, gp.growth_payroll, gf.growth_food_price,
	gf.growth_food_price - gp.growth_payroll AS growth_diff
FROM 
	growth_payroll AS gp
JOIN growth_food_price AS gf
	ON gp.year = gf.year
ORDER BY growth_diff DESC;

-- Největší rozdíl mezi meziročním nárustem cen potravin a průměrnou mzdou byl v roce 2013 a činil 6,66%.
-- Tudíž neexistuje rok ve sledovaném období kde by byl rozdíl větší než 10%
