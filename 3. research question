-- 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
WITH czechia_price_first_year AS (
	SELECT
		*
	FROM (
		SELECT
			year, category_name, avg_price, unit,
			rank() OVER (PARTITION BY category_name ORDER BY year) AS rank
		FROM
			t_adam_valenta_project_sql_primary_final
		WHERE category_name IS NOT NULL
		GROUP BY category_name, year
		) AS a
		WHERE a.rank = 1
),
czechia_price_last_year AS (
	SELECT
		*
	FROM (
		SELECT
			year, category_name, avg_price, unit,
			rank() OVER (PARTITION BY category_name ORDER BY year DESC) AS rank
		FROM
			t_adam_valenta_project_sql_primary_final
		WHERE category_name IS NOT NULL
		GROUP BY category_name, year
		) AS a
		WHERE a.rank = 1
)
SELECT
	f.category_name,
	CONCAT(ROUND((l.avg_price - f.avg_price) / f.avg_price * 100, 2), ' %') AS growth
FROM
	czechia_price_first_year AS f
JOIN czechia_price_last_year AS l 
	ON f.category_name = l.category_name
ORDER BY (l.avg_price - f.avg_price) / f.avg_price * 100
LIMIT 1;

-- Nejmenší percentuální nárust za sledované období má Cukr krystalový. Jeho nárust činí -27,52 %.
