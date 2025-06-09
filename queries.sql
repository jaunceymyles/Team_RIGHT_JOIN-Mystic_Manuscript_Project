-- query1
SELECT
	COUNT(*)
FROM
	mystic_manuscript.right_join;

-- query2
SELECT
	COUNT(*)
FROM(
	SELECT DISTINCT *
	FROM mystic_manuscript.right_join)
AS 
	distinct_rows;

-- query3
SELECT
	COUNT(*)
FROM
	information_schema.COLUMNS
WHERE 
	table_schema = 'mystic_manuscript'
	AND table_name = 'right_join';

-- query4
SELECT
	SUM(r.id) +
	SUM(r.qtr) +
	SUM(r.year) +
	SUM(r.month) +
	SUM(r.date_day) +
	SUM(r.special_day) +
	SUM(r.online_sale_offers) +
	SUM(r.day) +
	SUM(r.weekend) +
	SUM(r.morning) +
	SUM(r.afternoon) +
	SUM(CAST(r.ship_postal_pode AS INT)) +
	SUM(r.evening) +
	SUM(r.night) +
	SUM(r.gender_num) +
	SUM(r.quantity) +
	SUM(r.item_price) +
	SUM(r.shipping_price) +
	SUM(r.total_amount) +
	SUM(r.profit_percentage) +
	SUM(r.profit_inr) +
	SUM(r.cost_price) AS total
FROM
	mystic_manuscript.right_join r;

--17737903.46

-- query5

SELECT 
    id,
    COALESCE(item_price, 0) +
    COALESCE(shipping_price, 0) +
    COALESCE(quantity, 0) +
    COALESCE(total_amount, 0) AS row_total
FROM mystic_manuscript.right_join r
WHERE id=1;

(r.id, r.qtr, r.YEAR, r.MONTH, r.date_day, r.special_day, r.online_sale_offers, r.DAY, r.weekend, r.morning, r.afternoon, r.ship_postal_code, r.evening, r.night, r.gender_num, r.quantity, r.item_price, r.shipping_price, r.total_amount, r.profit_precentage, r.profit_inr, r.cost_price)

-- query6

SELECT
	*
FROM
	mystic_manuscript.right_join r
WHERE
	r.id IS IN ( /* 5 Random Rows*/ )

-- query7
	
SELECT
	*
FROM
	mystic_manuscript.right_join;
