SELECT 
    customer_id,
    MIN(DATEFROMPARTS(
        YEAR(order_purchase_timestamp),
        MONTH(order_purchase_timestamp),
        1
    )) AS First_Purchase_Month
INTO customer_cohort
FROM ecommerce_master_table
GROUP BY customer_id;

SELECT 
    e.customer_id,
    c.First_Purchase_Month,
    DATEFROMPARTS(
        YEAR(e.order_purchase_timestamp),
        MONTH(e.order_purchase_timestamp),
        1
    ) AS Purchase_Month
INTO retention_data
FROM ecommerce_master_table e
JOIN customer_cohort c
    ON e.customer_id = c.customer_id;

SELECT 
    First_Purchase_Month,
    Purchase_Month,
    COUNT(DISTINCT customer_id) AS Customers_Retained
INTO retention_summary
FROM retention_data
GROUP BY First_Purchase_Month, Purchase_Month;