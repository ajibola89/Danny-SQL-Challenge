-- 1.How many pizzas were ordered?
SELECT COUNT(c.customer_id) No_of_ordered_pizza
  FROM pizza_runner.customer_orders c;
  
-- 2.How many unique customer orders were made?
SELECT COUNT(DISTINCT c.customer_id) No_of_ordered_customer
  FROM pizza_runner.customer_orders c;
  
-- 3.How many successful orders were delivered by each runner?
SELECT c.runner_id,
       COUNT(c.order_id) No_of_successful_Order_delivered
  FROM pizza_runner.runner_orders c
 WHERE distance IS NOT null
 GROUP BY 1
 ORDER BY 2 DESC;
 
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
  
-- 5.How many Vegetarian and Meatlovers were ordered by each customer?
SELECT c.customer_id,
       p.pizza_name,
       COUNT(c.order_id) no_of_pizza_ordered
  FROM pizza_runner.customer_orders c
  JOIN pizza_runner.pizza_names p
    ON c.pizza_id = p.pizza_id
 GROUP BY 1,2
 ORDER BY 1;

-- 6.What was the maximum number of pizzas delivered in a single order? 
SELECT c.order_id,
       COUNT(c.order_id) Maximum_Number_of_pizza_delivered
  FROM pizza_runner.customer_orders c
  JOIN pizza_runner.runner_orders r
    ON c.order_id = r.order_id
 WHERE r.distance IS NOT null
 GROUP BY 1
 ORDER BY 2 DESC
 LIMIT 1;
 
 
-- 7.For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
SELECT c.customer_id, 
       COUNT(CASE WHEN exclusions IS NULL AND extras IS NULL THEN 0     
            END) pizza_delivered_with_no_changes,
       COUNT(CASE WHEN exclusions IS NOT NULL OR extras IS NOT NULL THEN 1 
            END) pizza_delivered_with_changes            
  FROM pizza_runner.customer_orders c
  JOIN pizza_runner.runner_orders r
    ON c.order_id = r.order_id
 WHERE r.distance IS NOT NULL
 GROUP BY 1
 ORDER BY 1;
-- 8.How many pizzas were delivered that had both exclusions and extras?
SELECT COUNT(CASE WHEN (exclusions IS NOT NULL AND LENGTH(exclusions) > 0) 
             AND (extras IS NOT NULL AND LENGTH(extras) > 0) THEN c.pizza_id
             END) no_of_pizza_delivered_with_both_exclusions_annd_extras
 FROM pizza_runner.customer_orders c
 JOIN pizza_runner.runner_orders r
   ON c.order_id = r.order_id     
 WHERE r.distance IS NOT NULL;
          

-- 9.What was the total volume of pizzas ordered for each hour of the day?
SELECT CASE WHEN date_part ('hour', c.order_time) > 17 THEN 'late hours'
            ELSE 'early hours'
            END order_time,
       date_part ('hour', c.order_time), 
       COUNT(c.order_id) volume_of_ordered_pizza
  FROM pizza_runner.customer_orders c
 GROUP BY 1,2
 ORDER BY 2 DESC;


-- 10.What was the volume of orders for each day of the week?
SELECT CASE WHEN date_part ('day', c.order_time) > 17 THEN 'late hours'
            ELSE 'early hours'
            END order_time,
       to_char(c.order_time, 'day') day_of_the_week, 
       COUNT(c.order_id) volume_of_ordered_pizza
  FROM pizza_runner.customer_orders c
 GROUP BY 1,2
 ORDER BY 3 DESC;
