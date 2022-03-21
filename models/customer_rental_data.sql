select

customer_ID as customerid,
Gender,
Registration_Datetime_Local,
Rental_First_Datetime_Local,
Age_Years,

rental.* 
from 
 {{source('rentals', 'customer')}}
 LEFT JOIN  {{source('rentals', 'rental')}}
 on customer.customer_ID = rental.customer_ID