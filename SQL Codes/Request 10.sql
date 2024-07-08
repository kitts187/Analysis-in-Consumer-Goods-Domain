/*10. Get the Top 3 products in each division that have a high
total_sold_quantity in the fiscal_year 2021? The final output contains these
fields,
division
product_code
product
total_sold_quantity
rank_order*/ 

WITH Result1 AS 
(
SELECT P.division, F.product_code, P.product, SUM(F.sold_quantity) AS Total_sold_quantity
FROM dim_product P JOIN fact_sales_monthly F
ON P.product_code = F.product_code
WHERE F.fiscal_year = 2021 
GROUP BY  F.product_code, division, P.product
),
Result2 AS 
(
SELECT division, product_code, product, Total_sold_quantity,
        RANK() OVER(PARTITION BY division ORDER BY Total_sold_quantity DESC) AS 'Rank_Order' 
FROM Result1
)
 SELECT Result1.division, Result1.product_code, Result1.product, Result2.Total_sold_quantity, Result2.Rank_Order
 FROM Result1 JOIN Result2
 ON Result1.product_code = Result2.product_code
WHERE Result2.Rank_Order IN (1,2,3)
