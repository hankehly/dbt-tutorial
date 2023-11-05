with source as (
      select * from {{ source('jaffle_shop_2', 'orders') }}
),
renamed as (
    select
        {{ adapter.quote("ID") }} AS id,
        {{ adapter.quote("USER_ID") }} AS customer_id,
        {{ adapter.quote("ORDER_DATE") }} AS date,
        {{ adapter.quote("STATUS") }} AS status

    from source
)
select * from renamed
  