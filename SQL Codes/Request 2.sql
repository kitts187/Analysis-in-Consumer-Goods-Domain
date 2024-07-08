/*2. What is the percentage of unique product increase in 2021 vs. 2020? The 
final output contains these fields, 
unique_products_2020 
unique_products_2021 
percentage_chg*/

SELECT A.D AS unique_product_2020, B.C AS unique_products_2021, ROUND((C-D)*100/D, 2) AS percentage_chg
FROM
     (
      (SELECT COUNT(DISTINCT(product_code)) AS D FROM fact_sales_monthly
      WHERE fiscal_year = 2020) A,
      (SELECT COUNT(DISTINCT(product_code)) AS C FROM fact_sales_monthly
      WHERE fiscal_year = 2021) B 
	 )
