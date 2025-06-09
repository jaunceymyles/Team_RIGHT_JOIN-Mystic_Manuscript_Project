-- TEAM RIGHT JOIN

--CREATE TABLE

CREATE TABLE mystic_manuscript.right_join(
	ID INT PRIMARY KEY,
	purchase_date TIMESTAMP,
	"date" DATE,
	"time" TIME,
	"quarter" VARCHAR(50),
	qtr INT,
	"year" INT,
	"month" INT,
	date_day INT,
	special_day INT,
	online_sale_offers INT,
	"day" INT,
	weekend INT,
	morning INT,
	afternoon INT,
	evening INT,
	night INT,
	gender_num INT,
	customer_id VARCHAR(50),
	gender INT,
	product_name VARCHAR(200),
	item_status VARCHAR(50),
	quantity INT,
	currency VARCHAR(50),
	item_price INT,
	shipping_price INT,
	ship_city VARCHAR(60),
	ship_state VARCHAR(50),
	ship_postal_code VARCHAR(50),
	category VARCHAR(50),
	total_amount INT,
	author VARCHAR(100),
	"publication" VARCHAR(100),
	profit_percentage INT,
	profit_inr DECIMAL(10,2),
	cost_price DECIMAL(10,2)
);


--grant permission
GRANT 
    ALL 
ON mystic_manuscript.right_join 
    TO da13_myja, da13_jasi, de13_nima;

--grant permission
GRANT 
    SELECT 
ON mystic_manuscript.right_join 
    TO github_classroom;


