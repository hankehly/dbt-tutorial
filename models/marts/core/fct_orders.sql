with
    -- order_id, customer_id
    orders as (select * from {{ ref("stg_orders") }}),
    -- order_id, amount
    payments as (select * from {{ ref("stg_payments") }}),
    order_payments as (
        select
            order_id,
            coalesce(sum(case status when "success" then amount end), 0) as amount
        from payments
        group by order_id
    )
select orders.order_id, orders.customer_id, orders.order_date, order_payments.amount
from orders
left join
    order_payments using (order_id)

    -- order_id
    -- customer_id
    -- amount (hint: this has to come from payments)
    
