SELECT
    customer_id,
    MAX(order_purchase_timestamp) AS Last_Purchase_Date,
    COUNT(DISTINCT order_id) AS Frequency,
    SUM(payment_value) AS Monetary,
    DATEDIFF(DAY, MAX(order_purchase_timestamp), GETDATE()) AS Recency
INTO rfm_table
FROM ecommerce_master_table
GROUP BY customer_id;

SELECT TOP 10 * FROM rfm_table;

SELECT *,
    NTILE(5) OVER (ORDER BY Recency DESC) AS R_Score,
    NTILE(5) OVER (ORDER BY Frequency ASC) AS F_Score,
    NTILE(5) OVER (ORDER BY Monetary ASC) AS M_Score
INTO rfm_scores
FROM rfm_table;

SELECT *,
    CASE 
        WHEN R_Score >= 4 AND F_Score >= 4 AND M_Score >= 4 
            THEN 'Champions'
        WHEN R_Score >= 3 AND F_Score >= 3 
            THEN 'Loyal Customers'
        WHEN R_Score >= 3 AND F_Score <= 2 
            THEN 'Potential Loyalists'
        WHEN R_Score <= 2 AND F_Score >= 3 
            THEN 'At Risk'
        ELSE 'Lost Customers'
    END AS Customer_Segment
INTO customer_segments
FROM rfm_scores;

SELECT Customer_Segment, COUNT(*) AS Total_Customers
FROM customer_segments
GROUP BY Customer_Segment;

