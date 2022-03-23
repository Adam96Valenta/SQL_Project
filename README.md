# SQL_Project
SQL project for Enegeto Academy 2022

Projekt byl vypracován na základě zadání, ve kterém bylo za úkol vytvoření dvou tabulek. 
Tabulky slouží k získání odpovědí na tyto výzkumné otázky: 
1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

Tabulka primary final obsahuje data o:
- průměrných hrubých mzdách v jednotlivých odvětvích ČR od roku 2000 do roku 2021
- průměrných cenách potravin v ČR od roku 2006 do roku 2018 (Jakostní víno obsahuje data pouze od roku 2015)

Tabulka secondary final obsahuje data o:
- GDP, populaci a gini koeficientu (zde jsou data neúplná) pro Evropské státy
- chybí zde data o státech Holy See, Northern Ireland a Svalbard and Jan Mayen

1. research question 
- z tabulky primary final vypočítaná procentuální změna průměrné hrubé mzdy za první a poslední a srovnatelné období v dostupných datech
- vytvořen nový sloupec s názvem "growth", který odpovídá na otázku zda mzdy v průběhu let rostou nebo klesají

2. research question
- z tabulky primary final vypočítáno kolik šlo koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech
- výsledkem je tabulka znázorňující množství daných potravin, které bylo možné koupit za první a poslední srovnatelné období v dostupných datech

3. research question
- z tabulky primary final vypočítaná procentuální změna průměrných cen potravin za první a poslední srovnatelné období v dostupných datech
- tabulka seřazena vzestupně podle vypočítané procentuální změny a limit nastaven na jeden řádek

4. research question
- z tabulky primary final vypočítaná procentuální změna průměrné hrubé mzdy a průměrné ceny potravin
- vytvořen nový sloupec s názvem "growth_diff", který znázorňuje rozdíl mezi růstem cen potravin a hrubou mzdou
- sloupec "growth_diff" seřazen vzestupně

5. research question
- z tabulky primary final vypočítaná procentuální změna průměrné hrubé mzdy a průměrné ceny potravin
- z tabulky secondary final vypočítaná procentuální změna HDP v ČR
- data exportovaná do google sheets k vytvoření XY grafů, ke zjištění možného vlivu HDP na růst mezd nebo cen potravin
