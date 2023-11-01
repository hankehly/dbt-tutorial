with source as (
      select * from {{ source('stripe_2', 'payments') }}
),
renamed as (
    select
        {{ adapter.quote("ID") }} AS id,
        {{ adapter.quote("ORDERID") }} AS order_id,
        {{ adapter.quote("PAYMENTMETHOD") }} AS payment_method,
        {{ adapter.quote("STATUS") }} AS status,
        {{ adapter.quote("AMOUNT") }} AS amount,
        {{ adapter.quote("CREATED") }} AS created_at

    from source
)
select * from renamed
  