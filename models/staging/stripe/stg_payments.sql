select
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    -- amount is stored as cents, convert to dollars
    amount / 100 as amount,
    status,
    created
from `dbt-tutorial.stripe.payment`
