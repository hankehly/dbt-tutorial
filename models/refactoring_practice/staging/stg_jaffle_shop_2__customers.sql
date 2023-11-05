with source as (
      select * from {{ source('jaffle_shop_2', 'customers') }}
),
renamed as (
    select
        {{ adapter.quote("ID") }} AS id,
        {{ adapter.quote("FIRST_NAME") }} AS first_name,
        {{ adapter.quote("LAST_NAME") }} AS last_name,

    from source
)
select * from renamed
  