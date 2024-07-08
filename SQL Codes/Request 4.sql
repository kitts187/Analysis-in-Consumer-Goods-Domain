/*4. Follow-up: Which segment had the most increase in unique products in 
2021 vs 2020? The final output contains these fields, 
segment 
product_count_2020 
product_count_2021 
difference*/

WITH CTE1 AS 
	(SELECT P.segment AS X , COUNT(DISTINCT(F.product_code)) AS Y 
    FROM dim_product P, fact_sales_monthly F
    WHERE P.product_code = F.product_code
    GROUP BY F.fiscal_year, P.segment
    HAVING F.fiscal_year = "2020"),
CTE2 AS
    (
	SELECT P.segment AS A , COUNT(DISTINCT(F.product_code)) AS B 
    FROM dim_product P, fact_sales_monthly F
    WHERE P.product_code = F.product_code
    GROUP BY F.fiscal_year, P.segment
    HAVING F.fiscal_year = "2021"
    )     
    
SELECT CTE1.X AS segment, CTE1.Y AS product_count_2020, CTE2.B AS product_count_2021, (CTE2.B-CTE1.Y) AS difference  
FROM CTE1, CTE2
WHERE CTE1.X = CTE2.A ;
