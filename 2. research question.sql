-- 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

WITH czechia_price_and_payroll AS (
	SELECT
		year, category_name, avg_price, unit,
		ROUND(AVG(avg_net_value), 2) AS avg_net_value
	FROM
		t_adam_valenta_project_sql_primary_final 
	WHERE  category_name = 'Chléb konzumní kmínový' 
		OR category_name = 'Mléko polotučné pasterované'
	GROUP BY year, category_name
)
SELECT DISTINCT
	a.category_name,
	ROUND(a.avg_net_value / a.avg_price, 2) AS amount_2006, a.unit,
	ROUND(b.avg_net_value / b.avg_price, 2) AS amount_2018, b.unit
FROM (
	SELECT
		*
	FROM (
		SELECT
			*,
			rank() OVER (PARTITION BY category_name ORDER BY year) AS rank
		FROM
			czechia_price_and_payroll
		 ) AS a
	WHERE a.rank = 1
	 ) AS a
JOIN (
	SELECT
		*
	FROM (
		SELECT
			*,
			rank() OVER (PARTITION BY category_name ORDER BY year DESC) AS rank
		FROM
			czechia_price_and_payroll
		 ) AS a
	WHERE a.rank = 1
	) AS b
	ON a.rank = b.rank
	AND a.category_name = b.category_name 
;
-- Za průměrnou mzdu bylo možné si v roce 2006 koupit 1072.64 kg chleba a 1197.44 l mléka.
-- V roce 2018 si za průměrnou mzdu bylo možné koupit 1197.44 kg chleba a 1371.51 l mléka.
