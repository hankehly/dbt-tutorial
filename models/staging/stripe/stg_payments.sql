select id as payment_id, orderid as order_id, paymentmethod as payment_method, amount, status, created
from `dbt-tutorial.stripe.payment`
