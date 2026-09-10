CREATE OR REPLACE VIEW vw_monthly_performance AS
                SELECT
                    YEAR(order_date) AS sales_year,
                    MONTH(order_date) AS sales_month_number,
                    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
                    MONTHNAME(order_date) AS month_name,
                    COUNT(DISTINCT order_id) AS total_orders,
                    SUM(quantity_sold) AS total_units_sold,
                    ROUND(SUM(total_revenue), 2) AS total_revenue,
                    ROUND(SUM(profit), 2) AS total_profit,
                    ROUND(
                        SUM(total_revenue)
                        / NULLIF(COUNT(DISTINCT order_id), 0),
                        2
                    ) AS average_order_value,
                    ROUND(
                        SUM(profit)
                        / NULLIF(SUM(total_revenue), 0) * 100,
                        2
                    ) AS profit_margin_percent
                FROM fact_amazon_sales
                GROUP BY
                    YEAR(order_date),
                    MONTH(order_date),
                    DATE_FORMAT(order_date, '%Y-%m'),
                    MONTHNAME(order_date); 


CREATE OR REPLACE VIEW vw_category_performance AS
                SELECT
                    product_category,
                    COUNT(DISTINCT order_id) AS total_orders,
                    COUNT(DISTINCT product_id) AS distinct_products,
                    SUM(quantity_sold) AS total_units_sold,
                    ROUND(SUM(total_revenue), 2) AS total_revenue,
                    ROUND(SUM(profit), 2) AS total_profit,
                    ROUND(AVG(rating), 2) AS average_rating,
                    SUM(review_count) AS total_reviews,
                    ROUND(
                        SUM(profit)
                        / NULLIF(SUM(total_revenue), 0) * 100,
                        2
                    ) AS profit_margin_percent
                FROM fact_amazon_sales
                GROUP BY product_category;

CREATE OR REPLACE VIEW vw_region_performance AS
                SELECT
                    customer_region,
                    COUNT(DISTINCT order_id) AS total_orders,
                    SUM(quantity_sold) AS total_units_sold,
                    ROUND(SUM(total_revenue), 2) AS total_revenue,
                    ROUND(SUM(profit), 2) AS total_profit,
                    ROUND(AVG(rating), 2) AS average_rating,
                    ROUND(
                        SUM(total_revenue)
                        / NULLIF(COUNT(DISTINCT order_id), 0),
                        2
                    ) AS average_order_value,
                    ROUND(
                        SUM(profit)
                        / NULLIF(SUM(total_revenue), 0) * 100,
                        2
                    ) AS profit_margin_percent
                FROM fact_amazon_sales
                GROUP BY customer_region;

CREATE OR REPLACE VIEW vw_discount_impact AS
                SELECT
                    discount_group,
                    COUNT(DISTINCT order_id) AS total_orders,
                    SUM(quantity_sold) AS total_units_sold,
                    ROUND(AVG(discount_percent), 2)
                        AS average_discount_percent,
                    ROUND(SUM(total_revenue), 2) AS total_revenue,
                    ROUND(SUM(profit), 2) AS total_profit,
                    ROUND(
                        SUM(total_revenue)
                        / NULLIF(COUNT(DISTINCT order_id), 0),
                        2
                    ) AS average_revenue_per_order,
                    ROUND(
                        SUM(profit)
                        / NULLIF(COUNT(DISTINCT order_id), 0),
                        2
                    ) AS average_profit_per_order,   
                    ROUND(
                        SUM(profit)
                        / NULLIF(SUM(total_revenue), 0) * 100,
                        2
                    ) AS profit_margin_percent
                FROM fact_amazon_sales
                GROUP BY discount_group;
