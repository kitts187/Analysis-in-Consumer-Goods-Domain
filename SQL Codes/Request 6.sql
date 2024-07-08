/*6. Generate a report which contains the top 5 customers who received an 
average high  pre_invoice_discount_pct  for the  fiscal  year 2021  and in the 
Indian  market. The final output contains these fields, 
customer_code 
customer 
average_discount_percentage*/

WITH CTE1 AS
(SELECT customer_code AS A, AVG(pre_invoice_discount_pct) AS B FROM fact_pre_invoice_deductions
WHERE fiscal_year = '2021'
GROUP BY customer_code),
     CTE2 AS
(SELECT customer_code AS C, customer AS D FROM dim_customer
WHERE market = 'India')

SELECT CTE2.C AS customer_code, CTE2.D AS customer, ROUND (CTE1.B, 4) AS average_discount_percentage
FROM CTE1 JOIN CTE2
ON CTE1.A = CTE2.C
ORDER BY average_discount_percentage DESC
LIMIT 5 
