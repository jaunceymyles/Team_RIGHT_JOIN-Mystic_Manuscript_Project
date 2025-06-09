-- query1
SELECT
	COUNT(*)
FROM
	mystic_manuscript.right_join;

-- query2
SELECT
	COUNT(DISTINCT *)
FROM
	mystic_manuscript.right_join;

-- query3
SELECT
	COUNT(*)
FROM
	mystic_manuscript.columns
WHERE
	table_name = 'right_join';

-- query4
SELECT
	SUM(qtr) +
	SUM('year') +
	SUM('month') +
	SUM(date_day) +
	SUM(special_day) +
	SUM(online_sales_offers) +
	SUM('day') +
	SUM(weekend) +
	SUM(morning) +
	SUM(afternoon) +
	SUM(evening) +
	SUM(night) +
	SUM(gender_num) +
	SUM(gender) +
	SUM(quantity) +
	SUM(item_price) +
	SUM(shipping_price) +
	SUM(total_amount) +
	SUM(profit_percentage) +
	SUM(profit_inr) +
	SUM(cost_price) AS total
FROM
	mystic_manuscript.right_join;
--SUM of all numeric columns
--Need to ask what columns to be summed

-- query5

--SUM OF ROW SUMS?

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
