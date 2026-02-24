CREATE TABLE customers (
    customer_id NVARCHAR(100),
    customer_unique_id NVARCHAR(100),
    customer_zip_code_prefix NVARCHAR(20),
    customer_city NVARCHAR(100),
    customer_state NVARCHAR(10)
);
BULK INSERT customers
FROM 'C:\EcommerceData\olist_customers_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    CODEPAGE = '65001',
    TABLOCK
);
SELECT TOP 10 * FROM customers;

CREATE TABLE orders (
    order_id NVARCHAR(100),
    customer_id NVARCHAR(100),
    order_status NVARCHAR(50),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME
);
BULK INSERT orders
FROM 'C:\EcommerceData\olist_orders_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    CODEPAGE = '65001',
    TABLOCK
);
SELECT TOP 10 * FROM orders;

CREATE TABLE order_items (
    order_id NVARCHAR(100),
    order_item_id INT,
    product_id NVARCHAR(100),
    seller_id NVARCHAR(100),
    shipping_limit_date DATETIME,
    price FLOAT,
    freight_value FLOAT
);

BULK INSERT order_items
FROM 'C:\EcommerceData\olist_order_items_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    CODEPAGE = '65001',
    TABLOCK
);

SELECT TOP 10 * FROM order_items;

CREATE TABLE order_payments (
    order_id NVARCHAR(100),
    payment_sequential INT,
    payment_type NVARCHAR(50),
    payment_installments INT,
    payment_value FLOAT
);
BULK INSERT order_payments
FROM 'C:\EcommerceData\olist_order_payments_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    CODEPAGE = '65001',
    TABLOCK
);

SELECT TOP 10 * FROM order_payments;

CREATE TABLE products (
    product_id NVARCHAR(100),
    product_category_name NVARCHAR(100),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);
BULK INSERT products
FROM 'C:\EcommerceData\olist_products_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    CODEPAGE = '65001',
    TABLOCK
);
SELECT TOP 10 * FROM products;

CREATE TABLE sellers (
    seller_id NVARCHAR(100),
    seller_zip_code_prefix NVARCHAR(20),
    seller_city NVARCHAR(200),
    seller_state NVARCHAR(50)
);

BULK INSERT sellers
FROM 'C:\EcommerceData\olist_sellers_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    CODEPAGE = '65001',
    TABLOCK
);

SELECT TOP 10 * FROM sellers;

DROP TABLE order_reviews;
CREATE TABLE order_reviews_staging (
    review_id NVARCHAR(MAX),
    order_id NVARCHAR(MAX),
    review_score NVARCHAR(MAX),
    review_comment_title NVARCHAR(MAX),
    review_comment_message NVARCHAR(MAX),
    review_creation_date NVARCHAR(MAX),
    review_answer_timestamp NVARCHAR(MAX)
);

BULK INSERT order_reviews_staging
FROM 'C:\EcommerceData\olist_order_reviews_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    CODEPAGE = '65001',
    TABLOCK
);

CREATE TABLE order_reviews (
    review_id NVARCHAR(100),
    order_id NVARCHAR(100),
    review_score INT,
    review_comment_title NVARCHAR(MAX),
    review_comment_message NVARCHAR(MAX),
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME
);
INSERT INTO order_reviews
SELECT
    review_id,
    order_id,
    TRY_CAST(review_score AS INT),
    review_comment_title,
    review_comment_message,
    TRY_CAST(review_creation_date AS DATETIME),
    TRY_CAST(review_answer_timestamp AS DATETIME)
FROM order_reviews_staging
WHERE
    LEN(order_id) <= 100
    AND TRY_CAST(review_score AS INT) IS NOT NULL;

SELECT TOP 10 * FROM order_reviews;

