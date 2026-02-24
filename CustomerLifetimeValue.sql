SELECT 
    customer_id,
    SUM(payment_value) AS Customer_Lifetime_Value
INTO clv_table
FROM ecommerce_master_table
GROUP BY customer_id;

SELECT TOP 10 * FROM clv_table;

SELECT 
    AVG(Customer_Lifetime_Value) AS Avg_CLV,
    MAX(Customer_Lifetime_Value) AS Max_CLV,
    MIN(Customer_Lifetime_Value) AS Min_CLV
FROM clv_table;