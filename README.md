![schema](https://github.com/MayuriSingh0227/Pizza_sales/assets/143704053/3436f23d-9dc4-493b-8c81-9116dfd2371a)

<b>1) Pizza_Types</b>
<br> pizza_type_id (Primary Key)
<br> name
<br> category
<br> ingredients


<br><b>2) Pizzas </b>
<br> pizza_id (Primary Key)
<br> pizza_type_id (Foreign Key referencing Pizza_Types)
<br> size
<br> price

<br><b>3) Orders</b>
<br> order_id (Primary Key)
<br> order_date
<br> order_time

<br><b>4) Order_Details</b>
<br> order_detail_id (Primary Key)
<br> order_id (Foreign Key referencing Orders)
<br> pizza_id (Foreign Key referencing Pizzas)
<br> quantity

<br><b>Relationships:</b>
<br> Pizzas table references Pizza_Types.
<br> Order_Details table references both Orders and Pizzas.


