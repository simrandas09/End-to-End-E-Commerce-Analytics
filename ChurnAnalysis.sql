SELECT 
    customer_id,
    MAX(order_purchase_timestamp) AS Last_Purchase_Date
INTO customer_last_purchase
FROM ecommerce_master_table
GROUP BY customer_id;

SELECT *,
    CASE 
        WHEN DATEDIFF(DAY, Last_Purchase_Date, GETDATE()) > 90 
        THEN 'Churned'
        ELSE 'Active'
    END AS Customer_Status
INTO churn_analysis
FROM customer_last_purchase;

SELECT 
    Customer_Status,
    COUNT(*) AS Total_Customers
FROM churn_analysis
GROUP BY Customer_Status;

