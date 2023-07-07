-- 2.How many unique customer orders were made?
SELECT COUNT(DISTINCT c.customer_id) No_of_ordered_customer
FROM pizza_runner.customer_orders c;
-- 3.How many successful orders were delivered by each runner?
SELECT c.runner_id,
COUNT(c.order_id) No_of_successful_Order_delivered
FROM pizza_runner.runner_orders c
WHERE distance IS NOT null
GROUP BY 2
ORDER BY 1,2 DESC;
-- 4.How many of each type of pizza was delivered?
SELECT p.pizza_name,
COUNT(c.order_id) No_of_Pizza_delivered
FROM pizza_runner.customer_orders c
JOIN pizza_runner.runner_orders r
ON c.order_id = r.order_id
JOIN pizza_runner.pizza_names p
ON c.pizza_id = p.pizza_id
WHERE r.distance IS NOT null
GROUP BY 1;