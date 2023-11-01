with source as (
      select * from {{ source('jaffle_shop_2', 'orders') }}
),
renamed as (
    select
        {{ adapter.quote("ID") }},
        {{ adapter.quote("USER_ID") }},
        {{ adapter.quote("ORDER_DATE") }},
        {{ adapter.quote("STATUS") }}

    from source
)
select * from renamed
  