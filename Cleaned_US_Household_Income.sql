SELECT * 
FROM us_houseold_income.us_household_income;

SELECT * 
FROM us_houseold_income.us_household_income_statistics;

# We change the column name

ALTER TABLE us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`;

SELECT * 
FROM us_houseold_income.us_household_income;

SELECT id, COUNT(id) 
FROM us_household_income
GROUP BY id
HAVING COUNT(id) > 1
;

# These are the duplicates id we have to delete
# For that we have to find their associate row number or row_id to delete them


SELECT id, COUNT(id) 
FROM us_household_income
GROUP BY id
HAVING COUNT(id) > 1
;

SELECT row_id,
id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
FROM us_household_income
;


SELECT *
FROM(
	SELECT row_id,
	id,
	ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
	FROM us_household_income) AS duplicates
WHERE row_num > 1
;

# We got the row_id now we can delete the duplicates

DELETE FROM us_household_income
WHERE row_id IN (
	SELECT row_id
	FROM(
		SELECT row_id,
		id, 
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
		FROM us_household_income) AS duplicates
	WHERE row_num > 1)
;

# 6 rows affected. We deleted the duplicates

SELECT * 
FROM us_houseold_income.us_household_income;

SELECT State_Name, State_ab, County, Place
FROM us_household_income
WHERE Place = '' OR Place IS NULL ;

# There are no blanks or NULLs in the State column
# Now i must cheked for other columns too that there are blanks or nulls in it #
#and we found 1 blank in Place

SELECT *
FROM us_household_income
WHERE State_Name = 'Alabama' AND County = 'Autauga County' AND City = 'Vinemont';

UPDATE us_household_income 
SET Place = 'Autaugaville'
WHERE City = 'Vinemont' AND County = 'Autauga County'
;

SELECT DISTINCT State_name 
FROM us_household_income
;
# same name but two different entry

UPDATE us_household_income
SET State_name = 'Georgia'
WHERE State_name = 'georia'
;

UPDATE us_household_income
SET State_name = 'Alabama'
WHERE State_name = 'alabama'
;

SELECT Type, COUNT(Type) 
FROM us_household_income
GROUP BY Type
;



UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;



SELECT * 
FROM us_houseold_income.us_household_income_statistics;