-- 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

SELECT
	a.industry_name,
	a.avg_net_value - b.avg_net_value AS payroll_diff_2021_2000,
	CASE WHEN a.avg_net_value - b.avg_net_value > 0 
		THEN 'yes'
		ELSE 'no'
	END AS growth
FROM (
	SELECT
		*
	FROM (
		SELECT DISTINCT
			year, industry_name, avg_net_value,
			rank() OVER (PARTITION BY industry_name ORDER BY year DESC) AS rank
		FROM
			t_adam_valenta_project_sql_primary_final
		) AS a
	WHERE a.rank = 1
	) as a
JOIN (
	SELECT
		*
	FROM (
		SELECT DISTINCT
			year, industry_name, avg_net_value,
			rank() OVER (PARTITION BY industry_name ORDER BY year) AS rank
		FROM
			t_adam_valenta_project_sql_primary_final
		) AS a
	WHERE a.rank = 1
	) as b
	ON a.industry_name = b.industry_name
ORDER BY payroll_diff_2021_2000 DESC;

-- Sloupec growth odpovídá na otázku, zda v průběhu let roste mzda v daném odvětví
-- Z dat vyplývá, že se v průběhu let zvyšuje mzda ve všech odvětvích.
