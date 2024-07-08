/*9. Which channel helped to bring more gross sales in the fiscal year 2021 
and the percentage of contribution?  The final output  contains these fields, 
channel 
gross_sales_mln 
percentage*/

WITH Output AS
(
SELECT C.channel,
       ROUND(SUM(G.gross_price*F.sold_quantity/1000000), 2) AS Gross_sales_mln
FROM fact_sales_monthly F JOIN dim_customer C ON F.customer_code = C.customer_code
						   JOIN fact_gross_price G ON F.product_code = G.product_code
WHERE F.fiscal_year = 2021
GROUP BY channel
)
SELECT channel, CONCAT(Gross_sales_mln,' M') AS Gross_sales_mln , CONCAT(ROUND(Gross_sales_mln*100/total , 2), ' %') AS percentage
FROM
(
(SELECT SUM(Gross_sales_mln) AS total FROM Output) X,
(SELECT * FROM Output) Y
)
ORDER BY percentage DESC 
