-- query 8
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

--query 9
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

--query 10
SELECT
    MIN(item_price) AS min_item_price,
    MAX(item_price) AS max_item_price,
    MIN(quantity) AS min_quantity,
    MAX(quantity) AS max_quantity,
    MIN(profit_inr) AS min_profit,
    MAX(profit_inr) AS max_profit
FROM mystic_manuscript.right_join;

--query 11
SELECT 'quarter' AS column_checked,
       LOWER(quarter) AS lower_val,
       ARRAY_AGG(DISTINCT quarter) AS case_variants,
       COUNT(*) AS total
FROM mystic_manuscript.right_join
GROUP BY LOWER(quarter)
HAVING COUNT(DISTINCT quarter) > 1

UNION ALL

SELECT 'customer_id'AS column_checked,
       LOWER(customer_id),
       ARRAY_AGG(DISTINCT customer_id),
       COUNT(*)
FROM mystic_manuscript.right_join
GROUP BY LOWER(customer_id)
HAVING COUNT(DISTINCT customer_id) > 1

UNION ALL

SELECT 'gender'AS column_checked,
       LOWER(gender),
       ARRAY_AGG(DISTINCT gender),
       COUNT(*)
FROM mystic_manuscript.right_join
GROUP BY LOWER(gender)
HAVING COUNT(DISTINCT gender) > 1

UNION ALL

SELECT 'item_status'AS column_checked,
       LOWER(item_status),
       ARRAY_AGG(DISTINCT item_status),
       COUNT(*)
FROM mystic_manuscript.right_join
GROUP BY LOWER(item_status)
HAVING COUNT(DISTINCT item_status) > 1

UNION ALL

SELECT 'currency'AS column_checked,
       LOWER(currency),
       ARRAY_AGG(DISTINCT currency),
       COUNT(*)
FROM mystic_manuscript.right_join
GROUP BY LOWER(currency)
HAVING COUNT(DISTINCT currency) > 1

UNION ALL

SELECT 'ship_city'AS column_checked,
       LOWER(ship_city),
       ARRAY_AGG(DISTINCT ship_city),
       COUNT(*)
FROM mystic_manuscript.right_join
GROUP BY LOWER(ship_city)
HAVING COUNT(DISTINCT ship_city) > 1

UNION ALL

SELECT 'ship_state'AS column_checked,
       LOWER(ship_state),
       ARRAY_AGG(DISTINCT ship_state),
       COUNT(*)
FROM mystic_manuscript.right_join
GROUP BY LOWER(ship_state)
HAVING COUNT(DISTINCT ship_state) > 1

UNION ALL

SELECT 'category'AS column_checked,
       LOWER(category),
       ARRAY_AGG(DISTINCT category),
       COUNT(*)
FROM mystic_manuscript.right_join
GROUP BY LOWER(category)
HAVING COUNT(DISTINCT category) > 1;

-- query 12
SELECT 
    id,
    item_price,
    quantity,
    total_amount,
    profit_inr,
    COST_price,
    (item_price * quantity) - cost_price AS calculated_profit,
    CASE
        WHEN profit_inr = (item_price * quantity) - cost_price THEN 'Consistent'
        ELSE 'Inconsistent'
    END AS profit_consistency
FROM mystic_manuscript.right_join
WHERE profit_inr <> (item_price * quantity) - cost_price;


-- query 13
SELECT
  COUNT(CASE WHEN gender = 'F' THEN 1 END) AS female_count,
  COUNT(CASE WHEN gender = 'M' THEN 1 END) AS male_count
FROM mystic_manuscript.right_join;


-- query 14
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


-- query 15
SELECT *
FROM mystic_manuscript.right_join
WHERE quantity < 0
   OR item_price < 0
   OR total_amount < 0
   OR profit_inr < 0;

