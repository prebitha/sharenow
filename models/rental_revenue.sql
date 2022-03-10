{{ config(materialized='table') }}

with date_rental as
(
SELECT 
count(customer_ID) as customers,
parse_date('%d.%m.%y', rental_start_date ) as rental_date_start,
extract(week from parse_date('%d.%m.%y', rental_start_date )) as week
  from {{source('rentals', 'rental')}}
  GROUP BY rental_start_date
  order by rental_date_start asc
)

select 
rental_date_start,
sum(customers) over (order by rental_date_start ROWS CURRENT ROW) as daily_driving_customer,
sum(customers) over (order by rental_date_start ROWS BETWEEN 6 preceding AND CURRENT ROW) as weekly_driving_customer,
sum(customers) over (order by rental_date_start ROWS BETWEEN 29 preceding AND CURRENT ROW) as monthly_driving_customer


from date_rental
order by rental_date_start DESC