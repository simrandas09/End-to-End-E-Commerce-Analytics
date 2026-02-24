SELECT 
    o.order_id,
    o.customer_id,
    c.customer_city,
    c.customer_state,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    oi.product_id,
    p.product_category_name,
    oi.price,
    oi.freight_value,
    op.payment_type,
    op.payment_value,
    r.review_score
INTO ecommerce_master_table
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
LEFT JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN order_payments op
    ON o.order_id = op.order_id
LEFT JOIN order_reviews r
    ON o.order_id = r.order_id;

SELECT TOP 10 * FROM ecommerce_master_table;