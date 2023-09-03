-- analyses are for one-off queries that you *don't need to materialize* in your data
-- you can use jinja code, compile and preview..
with
    orders as (select * from {{ ref("stg_orders") }}),
    daily_orders as (
        select order_date, count(*) as num_orders from orders group by order_date
    ),
    compared as (
        select *, lag(num_orders) over (order by order_date) as previous_num_orders
        from daily_orders
    )
select *
from compared
