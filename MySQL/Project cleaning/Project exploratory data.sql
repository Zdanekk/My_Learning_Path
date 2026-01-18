-- Project Exploratory Data Analysis


SELECT *
FROM layoffs_staging2;


SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;



SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- sum_total_laid_of by company
SELECT company, SUM(total_laid_off) AS sum_total_laid_of
FROM layoffs_staging2
GROUP BY company
ORDER BY sum_total_laid_of DESC;


SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- sum_total_laid_of by industry
SELECT industry, SUM(total_laid_off) AS sum_total_laid_of
FROM layoffs_staging2
GROUP BY industry
ORDER BY sum_total_laid_of DESC;

-- sum_total_laid_of by country
SELECT country, SUM(total_laid_off) AS sum_total_laid_of
FROM layoffs_staging2
GROUP BY country 
ORDER BY sum_total_laid_of DESC;

-- sum_total_laid_of by year
SELECT YEAR(`date`), SUM(total_laid_off) AS sum_total_laid_of
FROM layoffs_staging2
WHERE YEAR(`date`) IS NOT NULL
GROUP BY YEAR(`date`)	
ORDER BY 1;

-- sum_total_laid_of by stage
SELECT stage, SUM(total_laid_off) AS sum_total_laid_of
FROM layoffs_staging2
GROUP BY stage
ORDER BY 1 DESC;




-- total_percentage_laid_of by country
SELECT country, SUM(percentage_laid_off) AS percentage_laid_of
FROM layoffs_staging2
GROUP BY country 
ORDER BY percentage_laid_of DESC;


-- sum_total_laid_of by month ASC
SELECT SUBSTRING(`date`,1,7) AS year_month_, SUM(total_laid_off) AS sum_total_laid_of
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY  year_month_
ORDER BY 1 ASC;


-- sum_total_laid_of by month ASC with rolling total
WITH rolling_total AS 
(
SELECT SUBSTRING(`date`,1,7) AS year_month_, SUM(total_laid_off) AS sum_total_laid_of
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY  year_month_
ORDER BY 1 ASC
)
SELECT year_month_, sum_total_laid_of, SUM(sum_total_laid_of) OVER(ORDER BY year_month_) AS rolling_total
FROM rolling_total;


-- sum_total_laid_of by company and YEAR
SELECT company, YEAR(`date`), SUM(total_laid_off) AS sum_total_laid_of
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY sum_total_laid_of DESC;


-- sum_total_laid_of by company and YEAR ranking top 5 of the year
WITH Company_Year(company,years,total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off) AS sum_total_laid_of
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY sum_total_laid_of DESC
),	Company_Year_Rank AS
( SELECT *,
DENSE_RANK () OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5;


