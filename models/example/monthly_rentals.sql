
{{ config(materialized='table') }}

with rentals as
(
SELECT 
count(distinct(customer_ID)) as customers,
extract(month from parse_date('%d.%m.%y', rental_start_date )) as month,
extract(year from parse_date('%d.%m.%y', rental_start_date )) as year


  from {{source('rentals', 'rental')}}
  GROUP BY rental_start_date
  order by rental_start_date asc
)
,final as 
(
select customers, 
concat(month,'/', year) as yr_month
from rentals
)
select sum(customers), yr_month from final
group by yr_month