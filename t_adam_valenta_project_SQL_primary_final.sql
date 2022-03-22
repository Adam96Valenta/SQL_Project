CREATE OR REPLACE TABLE t_adam_valenta_project_SQL_primary_final AS
WITH czechia_avg_price AS (
	SELECT
		category_code, 
		YEAR(date_from) AS year, 
		ROUND(AVG(value),2) AS avg_price
	FROM
		czechia_price AS cp
	GROUP BY category_code, YEAR(date_from)
),
czechia_price_category_avg AS (
	SELECT
		cap.year AS price_year,
		cpc.name AS category_name,
		cap.avg_price,
		CONCAT(cpc.price_value, ' ', cpc.price_unit) AS unit
	FROM
		czechia_avg_price AS cap
	LEFT JOIN czechia_price_category AS cpc
		ON cap.category_code = cpc.code
),
czechia_payroll_year AS (
	SELECT 
		*,
		value * (1 - 0.15) AS net_value
	FROM
		czechia_payroll AS cp
	WHERE 1=1
		AND unit_code = 200
		AND calculation_code = 100
		AND industry_branch_code IS NOT NULL
),
czechia_payroll_year_avg AS (
	SELECT
		cpy.payroll_year,
		cpib.name AS industry_name,
		ROUND(AVG(net_value), 2) AS avg_net_value
	FROM
		czechia_payroll_year AS cpy
	JOIN czechia_payroll_industry_branch AS cpib
		ON cpy.industry_branch_code = cpib.code
	GROUP BY industry_branch_code, payroll_year
)
SELECT
	cpya.payroll_year AS year,
	cpya.industry_name, cpya.avg_net_value,
	cpca.category_name, cpca.avg_price, cpca.unit
FROM
	czechia_payroll_year_avg AS cpya
LEFT JOIN czechia_price_category_avg AS cpca
	ON cpya.payroll_year = cpca.price_year
;
