with
    -- order_id, customer_id
    orders as (select * from {{ ref("stg_orders") }}),
    -- order_id, amount
    payments as (select * from {{ ref("stg_payments") }})
select orders.order_id, orders.customer_id, payments.amount
from orders
inner join
    payments using (order_id)

    -- order_id
    -- customer_id
    -- amount (hint: this has to come from payments)
    
