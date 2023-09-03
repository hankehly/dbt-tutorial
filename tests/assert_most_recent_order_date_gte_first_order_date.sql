select *
from {{ ref("dim_customers") }}
where not (most_recent_order_date >= first_order_date)
