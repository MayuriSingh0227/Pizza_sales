-- Join relevant tables to find the category-wise distribution of pizzas


Select category, count(name) from pizza_types
group by category;