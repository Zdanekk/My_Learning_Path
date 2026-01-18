-- DATA cleaning project
SELECT *
FROM layoffs;

-- 1.Remove duplicates
-- 2.Standardize the data
-- 3.Null values or blank values
-- 4.Remove any Columns/rows

-- Tworzenie kopii tabeli aby nie pracować na Raw data
CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;


SELECT *
FROM layoffs_staging;

-- TWorzenie kolumny z liczbą duplikatów
SELECT *,
ROW_NUMBER() OVER( PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions)
AS row_num
FROM layoffs_staging;


-- filtrowanie duplikatów
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER( PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions)
AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1
;

-- Tworzenie nowej tabeli na podstawie poprzedniej w której usuniemy duplikaty
CREATE TABLE layoffs_staging2 (
  company TEXT,
  location TEXT,
  industry TEXT,
  total_laid_off INT DEFAULT NULL,
  percentage_laid_off TEXT,
  `date` TEXT,
  stage TEXT,
  country TEXT,
  funds_raised_millions INT DEFAULT NULL,
  row_num INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;

-- dodawanie danych
INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER( PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions)
AS row_num
FROM layoffs_staging;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;


SELECT *
FROM layoffs_staging2;

-- jezeli nie dziala trzeba wejsc w edit -> preferences -> sqk editor -> i odznaczyc na samym dole opcje

DELETE FROM layoffs_staging2
WHERE row_num > 1;


SELECT *
FROM layoffs_staging2;


-- Standardizing data

-- TRIM pokazuje goly tekst bez spacji z przodu czy z tylu tak mozemy porownac czy nie wystepuja spacje na poczatku lub koncu rekordu
SELECT company, TRIM(company) 
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

-- sprawdzamy kazda kolumne po kolei np tutaj wykrylismy to ze niektore wiersze są nazwane Crypto a niektore Crypto cash 
-- czyli jest to jedno i to samo 
-- jesli jestesmy tego pewni to mozemy przypisac wszystkim po prostu Crypto
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;


SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

-- tutaj updatetujemy reszte blednie przypisanych wierszy
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

-- w lokacji jedyne bledy jakie znalezlismy to bledy skladni jezykowej ale to moze byc inny jezyk wiec pomijamy
SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;

-- tutaj wykrylismy kropke to USA w niektorych wersach wiec musimy je zsynchronizowac
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%';

-- inny sposob z filmiku: - trim trailing dziala tak, ze sprawdza czy przed czy po są jakies kropki i usuwa je
UPDATE layoffs_staging2
SET country =  TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;


-- chcemy zmienic format kolumny date na txt 
-- uwaga '%m/%d/%Y' literki musza byc takiej wielkosci! bo inaczej robi blad
SELECT `date`,
STR_TO_DATE(`date`,'%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');

SELECT `date`
FROM layoffs_staging2;

-- to zamienia format kolumny na daty 
-- ALTER TABLE to polecenie SQL do zmiany struktury istniejącej tabeli (schematu) – np. dodawanie/usuwanie kolumn, zmiana typu kolumny, zmiana nazw, indeksów itd.
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;



-- Usuwanie pustych miejsc
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


-- sprawdzamy czy nie brakuje industry i jesli brakuje to uzupelniamy (jesli jest podana w innych wierszach)
SELECT DISTINCT industry
FROM layoffs_staging2; 

-- to dodalismy bo nie zadzialo na poczatku nasze zapytanie i po prostu zamienilismy wszystko na nulle zeby ulatwic zadanie
UPDATE layoffs_staging2
SET industry = NULL
WHERE (industry = '');

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

-- Tworzymy polaczenie tabeli samej z soba tak zeby zobaczyc czy dla konkretnej firmy nie ma w innych rekordach przypisanego industry
SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    AND t1.location	= t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL; 


-- to nie zadzialalo do konca jak chcielismy wiec zamienilismy wszystkie puste wartosci na nulle w osobnym zapytaniu
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL)
AND t2.industry IS NOT NULL; 


SELECT *
FROM layoffs_staging2;

-- mozemy usunac te dane jesli w obu kolunmnach jest pusto
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;



-- jak usunac kolumne
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT *
FROM layoffs_staging2;
