with source as (
      select * from {{ source('stripe_2', 'payments') }}
),
renamed as (
    select
        {{ adapter.quote("ID") }},
        {{ adapter.quote("ORDERID") }},
        {{ adapter.quote("PAYMENTMETHOD") }},
        {{ adapter.quote("STATUS") }},
        {{ adapter.quote("AMOUNT") }},
        {{ adapter.quote("CREATED") }}

    from source
)
select * from renamed
  