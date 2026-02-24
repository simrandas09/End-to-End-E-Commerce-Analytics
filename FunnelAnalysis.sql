SELECT 
    COUNT(DISTINCT order_id) AS Total_Orders,

    COUNT(DISTINCT CASE 
        WHEN order_status = 'approved' 
        THEN order_id 
    END) AS Approved_Orders,

    COUNT(DISTINCT CASE 
        WHEN order_status = 'shipped' 
        THEN order_id 
    END) AS Shipped_Orders,

    COUNT(DISTINCT CASE 
        WHEN order_status = 'delivered' 
        THEN order_id 
    END) AS Delivered_Orders

FROM ecommerce_master_table;

SELECT
    COUNT(DISTINCT CASE 
        WHEN order_status = 'approved' 
        THEN order_id 
    END) * 100.0 
    / COUNT(DISTINCT order_id) 
    AS Approval_Rate,

    COUNT(DISTINCT CASE 
        WHEN order_status = 'shipped' 
        THEN order_id 
    END) * 100.0 
    / COUNT(DISTINCT CASE 
        WHEN order_status = 'approved' 
        THEN order_id 
    END)
    AS Shipping_Rate,

    COUNT(DISTINCT CASE 
        WHEN order_status = 'delivered' 
        THEN order_id 
    END) * 100.0 
    / COUNT(DISTINCT CASE 
        WHEN order_status = 'shipped' 
        THEN order_id 
    END)
    AS Delivery_Rate

FROM ecommerce_master_table;