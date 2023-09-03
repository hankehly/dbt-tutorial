select sum(amount) total_revenue from {{ ref("stg_payments") }} where status = 'success'
