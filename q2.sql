select sp.year,sp.period,
pl.molecule,
pl.brand_reference, 
sp.prov,
case when sd.IS_generic ='Y' then 'Generic'
	 else 'Brand'
	 end as Product_type,
	 sum(sp.sales_qty) as dosages

from 
sdm_prod_data sp
join CMF10_to_UPC_Mapping mp on sp.UPC=mp.UPC
join  sdm_products sd on sp.UPC=sd.UPC
join product_list pl on pl.molecule=sd.molecule

where sp.year=2022

group by
sp.year,sp.period,
pl.molecule,
pl.brand_reference,
sp.prov,
sd.IS_Generic


 