1.How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
SELECT DATE_TRUNC('WEEK', r.registration_date) + INTERVAL '4days' week,
COUNT(r.runner_id ) no_of_signed_up_runner
FROM pizza_runner.runners r
GROUP BY 1
ORDER BY 1 DESC;
SELECT DATE_TRUNC(&#39;QUARTER&#39;, CURRENT_DATE) + INTERVAL &#39;3MONTHS&#39;;
-- 2.What was the average time in minutes it took for each runner to arrive at the Pizza
Runner HQ to pickup the order?
SELECT r.runner_id,
AVG((DATE_PART(&#39;day&#39;, r.pickup_time - c.order_time) * 24 +
DATE_PART(&#39;hour&#39;, r.pickup_time - c.order_time)) * 60 +
DATE_PART(&#39;minute&#39;, r.pickup_time - c.order_time)) Average_Arrival_Time
FROM pizza_runner.customer_orders c
JOIN pizza_runner.runner_orders r
ON c.order_id = r.order_id
WHERE r.pickup_time IS null
GROUP BY 1,2
ORDER BY 2 ASC;

-- 3.Is there any relationship between the number of pizzas and how long the order takes to
prepare?
WITH CTE AS
(
SELECT c.order_id,
AGE(r.pickup_time, c.order_time) preparation_time,
COUNT(c.pizza_id) no_of_pizzas
FROM pizza_runner.customer_orders c
JOIN pizza_runner.runner_orders r
ON c.order_id = r.order_id
WHERE r.pickup_time IS NOT null
GROUP BY 1,2
ORDER BY 1

)
SELECT no_of_pizzas,
AVG(preparation_time)
FROM CTE
GROUP BY 1;
