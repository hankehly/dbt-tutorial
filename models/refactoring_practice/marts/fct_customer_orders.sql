WITH
  --
  --
  --
  finalized_payments AS (
  SELECT
    order_id,
    MAX(created_at) AS payment_finalized_date,
    {{ cents_to_dollars('SUM(amount)') }} AS total_amount_paid
  FROM
    {{ ref("stg_stripe_2__payments") }}
  WHERE
    status = "success"
  GROUP BY
    order_id
  ),
  --
  --
  --
  paid_orders AS (
  SELECT
    orders.id AS order_id,
    orders.customer_id,
    orders.date AS order_placed_at,
    orders.status AS order_status,
    payments.total_amount_paid,
    payments.payment_finalized_date,
    customers.first_name AS customer_first_name,
    customers.last_name AS customer_last_name
  FROM
    {{ ref("stg_jaffle_shop_2__orders") }} AS orders
  LEFT JOIN
    finalized_payments payments
  ON
    orders.id = payments.order_id
  LEFT JOIN
    {{ ref('stg_jaffle_shop_2__customers') }} customers
  ON
    customers.id = orders.customer_id
  ),
  --
  --
  --
  customer_orders AS (
  SELECT
    customers.id AS customer_id,
    MIN(date) AS first_order_date,
    MAX(date) AS most_recent_order_date,
    COUNT(orders.ID) AS number_of_orders
  FROM
    {{ ref('stg_jaffle_shop_2__customers') }} customers
  LEFT JOIN
    {{ ref("stg_jaffle_shop_2__orders") }} AS orders
  ON
    orders.customer_id = customers.id
  GROUP BY
    customer_id
  ),
  --
  --
  --
  x AS (
  SELECT
    t1.order_id,
    SUM(t2.total_amount_paid) AS customer_lifetime_value
  FROM
    paid_orders t1
  LEFT JOIN
    paid_orders t2
  ON
    t1.customer_id = t2.customer_id
    AND t1.order_id >= t2.order_id
  GROUP BY
    t1.order_id
  ORDER BY
    t1.order_id
  ),
  --
  --
  --
  final AS (
  SELECT
    p.order_id,
    p.customer_id,
    p.order_placed_at,
    p.order_status,
    p.total_amount_paid,
    p.payment_finalized_date,
    p.customer_first_name,
    p.customer_last_name,
    ROW_NUMBER() OVER (ORDER BY p.order_id) AS transaction_seq,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY p.order_id) AS customer_sales_seq,
    CASE WHEN c.first_order_date = p.order_placed_at THEN 'new' ELSE 'return' END AS nvsr,
    x.customer_lifetime_value,
    c.first_order_date AS fdos
  FROM
    paid_orders p
  LEFT JOIN
    customer_orders AS c
  USING
    (customer_id)
  LEFT JOIN
    x
  USING
    (order_id)
  ORDER BY
    order_id
  )

SELECT * FROM final
