/*7. Get the complete report of the Gross sales amount for the customer  “Atliq 
Exclusive”  for each month  .  This analysis helps to  get an idea of low and 
high-performing months and take strategic decisions. 
The final report contains these columns: 
Month 
Year 
Gross sales Amount*/

SELECT CONCAT(MONTHNAME(F.date), ' (', YEAR(F.date), ')') AS 'Month', F.fiscal_year,
       ROUND(SUM(G.gross_price*F.sold_quantity), 2) AS Gross_sales_Amount
FROM fact_sales_monthly F JOIN dim_customer C ON F.customer_code = C.customer_code
						   JOIN fact_gross_price G ON F.product_code = G.product_code
WHERE C.customer = 'Atliq Exclusive'
GROUP BY  Month, F.fiscal_year 
ORDER BY F.fiscal_year ;
