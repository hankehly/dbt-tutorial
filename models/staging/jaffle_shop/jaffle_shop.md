{% docs stg_orders_order_id %}
The primary key for the orders table.
This block comes from `jaffle_shop.md`.
{% enddocs %}

{% docs stg_orders_status %}
	
One of the following values: 

| status         | definition                                       |
|----------------|--------------------------------------------------|
| placed         | Order placed, not yet shipped                    |
| shipped        | Order has been shipped, not yet been delivered   |
| completed      | Order has been received by customers             |
| return pending | Customer indicated they want to return this item |
| returned       | Item has been returned                           |

{% enddocs %}
