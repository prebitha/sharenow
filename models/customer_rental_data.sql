select customer.*, rental.* 
from 
 {{source('rentals', 'customer')}}
 LEFT JOIN  {{source('rentals', 'rental')}}
 on customer.customer_ID = rental.customer_ID