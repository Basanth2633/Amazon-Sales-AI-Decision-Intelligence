USE amazon_sales_project;

SELECT
    COUNT(*) AS total_rows,

    SUM(
        CASE
            WHEN order_id IS NULL THEN 1
            ELSE 0
        END
    ) AS missing_order_ids,

    COUNT(*) - COUNT(DISTINCT order_id)
        AS duplicate_order_ids,

    SUM(
        CASE
            WHEN order_date IS NULL THEN 1
            ELSE 0
        END
    ) AS missing_order_dates,

    SUM(
        CASE
            WHEN product_id IS NULL THEN 1
            ELSE 0
        END
    ) AS missing_product_ids,

    SUM(
        CASE
            WHEN discount_percent < 0
            OR discount_percent > 100
            THEN 1
            ELSE 0
        END
    ) AS invalid_discounts,

    SUM(
        CASE
            WHEN rating < 0
            OR rating > 5
            THEN 1
            ELSE 0
        END
    ) AS invalid_ratings,

    SUM(
        CASE
            WHEN price < 0
            OR discounted_price < 0
            OR total_revenue < 0
            THEN 1
            ELSE 0
        END
    ) AS invalid_financial_values,

    SUM(
        CASE
            WHEN quantity_sold <= 0
            THEN 1
            ELSE 0
        END
    ) AS invalid_quantities

FROM stg_amazon_sales;


-- Row-count checks also used by the DAG
SELECT COUNT(*) AS staging_row_count
FROM stg_amazon_sales;

SELECT COUNT(*) AS fact_row_count
FROM fact_amazon_sales
