SELECT 
    payment_type,
    COUNT(DISTINCT order_id) AS Total_Orders,
    SUM(payment_value) AS Total_Revenue,
    AVG(payment_value) AS Avg_Order_Value
INTO payment_performance
FROM ecommerce_master_table
GROUP BY payment_type;

SELECT * FROM payment_performance;

