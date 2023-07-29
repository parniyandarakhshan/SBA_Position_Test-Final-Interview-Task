

-- 1)	Determine the SDM Market share (using the SDM Prod Data and IMS data) by province based on total dosages for 2021.


-- First change the 64,113 PEI(PE) Records to NL. This will write to the table and change it forever.
UPDATE SDM_Prod_Data
SET PROV = CASE WHEN PROV = 'PE' THEN 'NL' ELSE PROV END
 
-- Query to Calculate Shoppers Dosage Sales By Province
SELECT PROV, SUM(SDM_Prod_Data.SALES_QTY * sdm_products.SKU_Size) AS [Shoppers Dosages by Province]
FROM SDM_Prod_Data
-- We need SKU sizes from tbl sdm_products
LEFT JOIN sdm_products ON SDM_Prod_Data.UPC = sdm_products.UPC
GROUP BY PROV
ORDER BY PROV

-- Now calculate how many doses were sold in all of Canada

SELECT PROVINCE AS IMS_Dosages, SUM(DOSAGES) AS AllDosesInCanada
  FROM [shoppers].[dbo].[IMS_CDH_Data]
  WHERE YEAR(MONTH) = 2021
  GROUP BY PROVINCE
  ORDER BY PROVINCE
 
