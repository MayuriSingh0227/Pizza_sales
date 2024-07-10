<b> 1) Retrieve the total number of orders placed </b>
<br>   select count(order_id) as total_orders
<br>   from orders;


<b> 2) Calculate the total revenue generated from pizza sales </b>
<br>   SELECT ROUND(SUM(order_details.quantity * pizzas.price),2) AS total_sales  
<br>   FROM order_details       
<br>   JOIN                                                
<br>   pizzas ON pizzas.pizza_id = order_details.pizza_id;


<br><b>3) Identify the highest-priced pizza </b>
<br>  SELECT 
<br>  pizza_types.name, pizzas.price
<br>  FROM pizza_types
<br>  JOIN pizzas
<br>  ON pizza_types.pizza_type_id = pizzas.pizza_type_id
<br>  ORDER BY pizzas.price DESC LIMIT 1;


<br><b>4) Identify the most common pizza size ordered </b>
<br> SELECT 
<br> pizzas.size,COUNT(order_details.order_details_id) AS order_count
<br> FROM pizzas JOIN order_details
<br> ON pizzas.pizza_id = order_details.pizza_id
<br> GROUP BY pizzas.size
<br> ORDER BY order_count DESC
<br> LIMIT 1;


<br><b>5) List the top 5 most ordered pizza types along with their quantities</b>
<br> SELECT 
<br> pizza_types.name, SUM(order_details.quantity) AS quantity
<br> FROM pizza_types JOIN pizzas
<br> ON pizza_types.pizza_type_id = pizzas.pizza_type_id
<br> JOIN
<br> order_details ON order_details.pizza_id = pizzas.pizza_id
<br> GROUP BY pizza_types.name
<br> ORDER BY quantity DESC
<br> LIMIT 5;


<br><b>6) Join the necessary tables to find the total quantity of each pizza category ordered</b>
<br> SELECT 
<br> pizza_types.category, SUM(order_details.quantity) AS total_quantity
<br> FROM pizza_types JOIN pizzas
<br> ON pizza_type.pizza_type_id = pizzas.pizza_type_id
<br> JOIN
<br> order_details ON order_details.pizza_id = pizzas.pizza_id
<br> GROUP BY pizza_types.category
<br> ORDER BY total_quantity DESC;


<br><b>7) Join the necessary tables to find the total quantity of each pizza category ordered</b>
<br> SELECT 
<br> pizza_types.category,
<br> SUM(order_details.quantity) AS total_quantity
<br> FROM pizza_types JOIN pizzas 
<br> ON pizza_type.pizza_type_id = pizzas.pizza_type_id
<br> JOIN
<br> order_details ON order_details.pizza_id = pizzas.pizza_id
<br> GROUP BY pizza_types.category
<br> ORDER BY total_quantity DESC;


<br><b>8) Join relevant tables to find the category-wise distribution of pizzas</b>
<br> Select category, count(name) from pizza_types 
<br> group by category;


<br><b>9) Group the orders by date and calculate the average number of pizzas ordered per day</b>
<br> SELECT ROUND(AVG(quantity), 0)
<br> FROM
<br> (SELECT orders.order_date, SUM(order_details.quantity) AS quantity
<br> FROM orders JOIN order_details
<br> ON orders.order_id = order_details.order_id
<br> GROUP BY orders.order_date) AS order_quantity;


<br><b>10) Determine the top 3 most ordered pizza types based on revenue</b>
<br> SELECT 
<br> pizza_types.name, SUM(order_details.quantity * pizzas.price) AS revenue
<br> FROM pizza_types
<br> JOIN
<br> pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
<br> JOIN
<br> order_details ON order_details.pizza_id = pizzas.pizza_id
<br> GROUP BY pizza_types.name
<br> ORDER BY revenue DESC
<br> LIMIT 3;  


<br><b>11) Calculate the percentage contribution of each pizza type to total revenue</b>
<br> SELECT 
<br> pizza_types.category,
<br> round(SUM(order_details.quantity * pizzas.price) / (SELECT ROUND(SUM(order_details.quantity * pizzas.price),2) AS total_sales
<br> FROM order_details
<br> JOIN
<br> pizzas ON pizzas.pizza_id = order_details.pizza_id) * 100,2) AS revenue
<br> FROM pizza_types JOIN pizzas
<br> ON pizza_types.pizza_type_id = pizzas.pizza_type_id
<br> JOIN
<br> order_details ON order_details.pizza_id = pizzas.pizza_id
<br> GROUP BY category
<br> ORDER BY revenue DESC;


<br><b>12) Analyze the cumulative revenue generated over time</b>
<br> select  order_date,sum(revenue) over(order by order_date) as cum_revenue
<br> from
<br> (select orders.order_date , sum(order_details.quantity*pizzas.price) as revenue
<br> from
<br> order_details join pizzas 
<br> on order_details.pizza_id=pizzas.pizza_id
<br> join orders 
<br> on orders.order_id=order_details.order_id 
<br> group by orders.order_date) as sales;


<br><b>13) Determine the top 3 most ordered pizza types based on revenue for each pizza category</b>
<br> select name, revenue 
<br> from (select category,name,revenue,rank() over(partition by category order by revenue desc) as rn
<br> from
<br> (select pizza_types.category , pizza_types.name,sum((order_details.quantity)*pizzas.price) as revenue
<br> from pizza_types join pizzas on
<br> pizza_types.pizza_type_id=pizzas.pizza_type_id
<br> join order_details
<br> on order_details.pizza_id=pizzas.pizza_id
<br> group by pizza_types.category,pizza_types.name) as a) as b
<br> where rn <=3;

