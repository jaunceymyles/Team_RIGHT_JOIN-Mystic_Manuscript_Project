-- queries 8
SELECT
    COUNT(*) FILTER (WHERE id IS NULL),
    COUNT(*) FILTER (WHERE purchase_date IS NULL),
    COUNT(*) FILTER (WHERE 'date' IS NULL),
    COUNT(*) FILTER (WHERE 'time' IS NULL),
    COUNT(*) FILTER (WHERE quarter IS NULL),
    COUNT(*) FILTER (WHERE qtr IS NULL),
    COUNT(*) FILTER (WHERE year IS NULL),
    COUNT(*) FILTER (WHERE month IS NULL),
    COUNT(*) FILTER (WHERE date_day IS NULL),
    COUNT(*) FILTER (WHERE special_day IS NULL),
    COUNT(*) FILTER (WHERE online_sale_offers IS NULL),
    COUNT(*) FILTER (WHERE day IS NULL),
    COUNT(*) FILTER (WHERE weekend IS NULL),
    COUNT(*) FILTER (WHERE morning IS NULL),
    COUNT(*) FILTER (WHERE afternoon IS NULL),
    COUNT(*) FILTER (WHERE evening IS NULL),
    COUNT(*) FILTER (WHERE night IS NULL),
    COUNT(*) FILTER (WHERE gender_num IS NULL),
    COUNT(*) FILTER (WHERE customer_id IS NULL),
    COUNT(*) FILTER (WHERE gender IS NULL),
    COUNT(*) FILTER (WHERE product_name IS NULL),
    COUNT(*) FILTER (WHERE item_status IS NULL),
    COUNT(*) FILTER (WHERE quantity IS NULL),
    COUNT(*) FILTER (WHERE currency IS NULL),
    COUNT(*) FILTER (WHERE item_price IS NULL),
    COUNT(*) FILTER (WHERE shipping_price IS NULL),
    COUNT(*) FILTER (WHERE ship_state IS NULL),
    COUNT(*) FILTER (WHERE ship_postal_code IS NULL),
    COUNT(*) FILTER (WHERE category IS NULL),
    COUNT(*) FILTER (WHERE total_amount IS NULL),
    COUNT(*) FILTER (WHERE author IS NULL),
    COUNT(*) FILTER (WHERE publication IS NULL),
    COUNT(*) FILTER (WHERE profit_percentage IS NULL),
    COUNT(*) FILTER (WHERE profit_inr IS NULL),
    COUNT(*) FILTER (WHERE cost_price IS NULL)
FROM mystic_manuscript.right_join;

--Check for Duplicates
SELECT id,
       purchase_date,
       date,
       time,
       quarter,
       qtr,
       YEAR,
       MONTH,
       date_day,
       special_day,
       online_sale_offers,
       DAY,
       weekend,
       morning,
       afternoon,
       evening,
       night,
       gender_num,
       customer_id,
       gender,
       product_name,
       item_status,
       quantity,
       currency,
       item_price,
       shipping_price,
       ship_city,
       ship_state,
       ship_postal_code,
       category,
       total_amount,
       author,
       PUBLICATION,
       profit_percentage,
       profit_inr,
       cost_price,
       COUNT(*) AS duplicate_count
FROM mystic_manuscript.right_join
GROUP BY id,
         purchase_date,
         date,
         time,
         quarter,
         qtr,
         YEAR,
         MONTH,
         date_day,
         special_day,
         online_sale_offers,
         DAY,
         weekend,
         morning,
         afternoon,
         evening,
         night,
         gender_num,
         customer_id,
         gender,
         product_name,
         item_status,
         quantity,
         currency,
         item_price,
         shipping_price,
         ship_city,
         ship_state,
         ship_postal_code,
         category,
         total_amount,
         author,
         PUBLICATION,
         profit_percentage,
         profit_inr,
         cost_price
HAVING COUNT(*) > 1;

-- SQL-13
SELECT
  COUNT(CASE WHEN gender = 'F' THEN 1 END) AS female_count,
  COUNT(CASE WHEN gender = 'M' THEN 1 END) AS male_count
FROM mystic_manuscript.right_join;


-- SQL-14
SELECT *
FROM mystic_manuscript.right_join
WHERE
  CASE 
    WHEN Morning = 1 THEN 
      COALESCE(Afternoon, 0) + COALESCE(Evening, 0) + COALESCE(Night, 0)
    WHEN Afternoon = 1 THEN 
      COALESCE(Morning, 0) + COALESCE(Evening, 0) + COALESCE(Night, 0)
    WHEN Evening = 1 THEN 
      COALESCE(Morning, 0) + COALESCE(Afternoon, 0) + COALESCE(Night, 0)
    WHEN Night = 1 THEN 
      COALESCE(Morning, 0) + COALESCE(Afternoon, 0) + COALESCE(Evening, 0)
    ELSE 1
  END <> 0;




-- SQL-15
SELECT *
FROM mystic_manuscript.right_join
WHERE quantity < 0
   OR item_price < 0
   OR total_amount < 0
   OR profit_inr < 0;

<<<<<<< HEAD

-- SQL-17 (Needs re-thinking about purchase_date formatting)

SELECT * FROM mystic_manuscript.right_join
WHERE
    EXTRACT (YEAR FROM purchase_date) != "year" OR
    EXTRACT (MONTH FROM purchase_date) != "month"  OR
    EXTRACT (DAY FROM purchase_date) != date_day ;
=======
>>>>>>> 2a074d56644f766e2e5fe235272681a6e7108b7c




SELECT * FROM mystic_manuscript.right_join_test;



-- Checking datetimes with time of days
SELECT
	r.id,
	CAST(r.purchase_date AS TIME),
	r.time,
	CASE 
        WHEN CAST(r.purchase_date AS TIME) = r.time THEN TRUE
        ELSE FALSE
    END AS "match"
FROM
	mystic_manuscript.right_join_test r
WHERE
	CASE 
        WHEN CAST(r.purchase_date AS TIME) = r.time THEN TRUE
        ELSE FALSE
    END = FALSE;

-- Checking dates with date_day month and year
SELECT
	r.id,
	r.purchase_date,
	CAST(r.purchase_date AS TIME),
	r.time
FROM
	mystic_manuscript.right_join_test r;


-- Checking the time of day is correct
SELECT *
FROM(
	SELECT
		r.id,
		CAST(r.purchase_date AS TIME),
		r.time,
		r.morning,
		r.afternoon,
		r.evening,
		r.night,
		CASE
			WHEN r.morning = 1 AND (r.time <= '6:00:00' OR r.time > '12:00:00') THEN 'Incorrect Morning'
			WHEN r.afternoon = 1 AND (r.time <= '12:00:00' OR r.time > '16:00:00') THEN 'Incorrect Afternoon'
			WHEN r.evening = 1 AND (r.time <= '16:00:00' OR r.time > '20:00:00') THEN 'Incorrect Evening'
			WHEN r.night = 1 AND NOT (r.time >= '20:00:00' OR r.time < '06:00:00') THEN 'Incorrect Night'
			ELSE 'Correct'
		END AS time_accuracy
	FROM
		mystic_manuscript.right_join_test r) sub
WHERE
	sub.time_accuracy <> 'Correct';

SELECT
	'morning' AS time_of_day,
	MIN(r.time) AS "min",
	MAX(r.time) AS "max"
FROM
	mystic_manuscript.right_join_test r
WHERE r.morning = 1

UNION ALL

SELECT
	'afternoon' AS time_of_day,
	MIN(r.time) AS "min",
	MAX(r.time) AS "max"
FROM
	mystic_manuscript.right_join_test r
WHERE r.afternoon = 1

UNION ALL

SELECT
	'evening' AS time_of_day,
	MIN(r.time) AS "min",
	MAX(r.time) AS "max"
FROM
	mystic_manuscript.right_join_test r
WHERE r.evening = 1

UNION ALL

SELECT
	'night' AS time_of_day,
	MIN(r.time) AS "min",
	MAX(r.time) AS "max"
FROM
	mystic_manuscript.right_join_test r
WHERE r.night = 1;

--FIXING PURCHASE_DATE IN TEST
CREATE TABLE mystic_manuscript.tmp_datetime (
  id INT,
  raw_datetime VARCHAR(50)
);

ALTER TABLE mystic_manuscript.right_join_test
ADD COLUMN raw_datetime VARCHAR(20);

UPDATE mystic_manuscript.right_join_test r
SET raw_datetime = t.raw_datetime
FROM mystic_manuscript.tmp_datetime t
WHERE r.id = t.id;

ALTER TABLE mystic_manuscript.right_join_test
ADD COLUMN fixed_purchase_date TIMESTAMP;

UPDATE mystic_manuscript.right_join_test
SET fixed_purchase_date = TO_TIMESTAMP(raw_datetime, 'DD/MM/YYYY HH24:MI');

ALTER TABLE mystic_manuscript.right_join_test
DROP COLUMN raw_datetime;

SELECT
	*
FROM
	mystic_manuscript.right_join_test
ORDER BY
	id;

