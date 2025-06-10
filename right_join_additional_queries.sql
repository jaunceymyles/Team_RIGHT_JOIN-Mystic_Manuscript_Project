-- query 8
SELECT
    COUNT(*) FILTER (WHERE id IS NULL) AS null_id,
    COUNT(*) FILTER (WHERE purchase_date IS NULL) AS null_purchase_date,
    COUNT(*) FILTER (WHERE 'date' IS NULL) AS null_date,
    COUNT(*) FILTER (WHERE 'time' IS NULL) AS null_time,
    COUNT(*) FILTER (WHERE 'quarter' IS NULL) AS null_quarter,
    COUNT(*) FILTER (WHERE qtr IS NULL) AS null_qtr,
    COUNT(*) FILTER (WHERE 'year' IS NULL) AS null_year,
    COUNT(*) FILTER (WHERE 'month' IS NULL) AS null_month,
    COUNT(*) FILTER (WHERE date_day IS NULL) AS null_day,
    COUNT(*) FILTER (WHERE special_day IS NULL) AS null_special_day,
    COUNT(*) FILTER (WHERE online_sale_offers IS NULL) AS null_onl_sl_offers,
    COUNT(*) FILTER (WHERE 'day' IS NULL) AS null_day_repeat,
    COUNT(*) FILTER (WHERE weekend IS NULL) AS null_weekend,
    COUNT(*) FILTER (WHERE morning IS NULL) AS null_morning,
    COUNT(*) FILTER (WHERE afternoon IS NULL) AS null_afternoon,
    COUNT(*) FILTER (WHERE evening IS NULL) AS null_evening,
    COUNT(*) FILTER (WHERE night IS NULL) AS null_night,
    COUNT(*) FILTER (WHERE gender_num IS NULL) AS null_gender_num,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS null_customer_id,
    COUNT(*) FILTER (WHERE gender IS NULL) AS null_gender,
    COUNT(*) FILTER (WHERE product_name IS NULL) AS null_product_name,
    COUNT(*) FILTER (WHERE item_status IS NULL) AS null_item_status,
    COUNT(*) FILTER (WHERE quantity IS NULL) AS null_quantity,
    COUNT(*) FILTER (WHERE currency IS NULL) AS null_currency,
    COUNT(*) FILTER (WHERE item_price IS NULL) AS null_item_price,
    COUNT(*) FILTER (WHERE shipping_price IS NULL) AS null_shipping_price,
    COUNT(*) FILTER (WHERE ship_state IS NULL) AS null_ship_state,
    COUNT(*) FILTER (WHERE ship_postal_code IS NULL) AS null_ship_postal_code,
    COUNT(*) FILTER (WHERE category IS NULL) AS null_category,
    COUNT(*) FILTER (WHERE total_amount IS NULL) AS null_total_amount,
    COUNT(*) FILTER (WHERE author IS NULL) AS null_author,
    COUNT(*) FILTER (WHERE 'publication' IS NULL) AS null_publication,
    COUNT(*) FILTER (WHERE profit_percentage IS NULL) AS null_profit_percentage,
    COUNT(*) FILTER (WHERE profit_inr IS NULL) AS null_profit_inr,
    COUNT(*) FILTER (WHERE cost_price IS NULL) AS null_cost_price
FROM mystic_manuscript.right_join;

--query 9
SELECT
    MIN(item_price) AS min_item_price,
    MAX(item_price) AS max_item_price,
    MIN(quantity) AS min_quantity,
    MAX(quantity) AS max_quantity,
    MIN(profit_inr) AS min_profit,
    MAX(profit_inr) AS max_profit
FROM mystic_manuscript.right_join;


-- query 10
SELECT
    id,
    item_price,
    quantity,
    total_amount,
    profit_inr,
    cost_price,
    (item_price * quantity) - cost_price AS calculated_profit,
    CASE
        WHEN profit_inr = (item_price * quantity) - cost_price THEN 'Consistent'
        ELSE 'Inconsistent'
    END AS profit_consistency
FROM mystic_manuscript.right_join
WHERE profit_inr <> (item_price * quantity) - cost_price;


-- query 11
SELECT
    COUNT(CASE WHEN gender = 'F' THEN 1 END) AS female_count,
    COUNT(CASE WHEN gender = 'M' THEN 1 END) AS male_count
FROM
    mystic_manuscript.right_join;


-- query 12
SELECT
    r.id,
    CAST(r.purchase_date AS TIME) AS purchase_time,
    r.time,
    CASE
        WHEN CAST(r.purchase_date AS TIME) = r.time THEN TRUE
        ELSE FALSE
    END AS same
FROM
    mystic_manuscript.right_join r
WHERE
    CASE
        WHEN CAST(r.purchase_date AS TIME) = r.time THEN TRUE
        ELSE FALSE
    END = FALSE;


-- query 13
SELECT
    *
FROM (
    SELECT
        r.id,
        CAST(r.purchase_date AS TIME) AS purchase_time,
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
        mystic_manuscript.right_join r
) sub
WHERE
    sub.time_accuracy <> 'Correct';


-- query 14
SELECT
    'morning' AS time_of_day,
    MIN(time) AS min,
    MAX(time) AS max
FROM
    mystic_manuscript.right_join
WHERE morning = 1

UNION ALL

SELECT
    'afternoon' AS time_of_day,
    MIN(time) AS min,
    MAX(time) AS max
FROM
    mystic_manuscript.right_join
WHERE
    afternoon = 1

UNION ALL

SELECT
    'evening' AS time_of_day,
    MIN(time) AS min,
    MAX(time) AS max
FROM
    mystic_manuscript.right_join
WHERE evening = 1

UNION ALL

SELECT
    'night' AS time_of_day,
    MIN(time) AS min,
    MAX(time) AS max
FROM
    mystic_manuscript.right_join
WHERE
    night = 1;


-- query 15
SELECT
    *
FROM
    mystic_manuscript.right_join
WHERE
    quantity < 0 OR
    item_price < 0 OR
    total_amount < 0 OR
    profit_inr < 0;
