USE sakila;
#1. Find active customers whose first name starts with J
SELECT *
FROM customer
WHERE first_name LIKE 'J%'
  AND active = 1;
  #2. Find films with ACTION in the title or WAR in the description
  SELECT *
FROM film
WHERE title LIKE '%ACTION%'
   OR description LIKE '%WAR%';
   #3. Customers whose last name is not SMITH and first name ends with A
   SELECT *
FROM customer
WHERE last_name <> 'SMITH'
  AND first_name LIKE '%A';
  #4. Films with rental rate greater than 3 and replacement cost not NULL
  SELECT *
FROM film
WHERE rental_rate > 3.0
  AND replacement_cost IS NOT NULL;
  #5. Count active customers in each store
  SELECT store_id,
       COUNT(*) AS active_customers
FROM customer
WHERE active = 1
GROUP BY store_id;
#6. Show distinct film ratings
SELECT DISTINCT rating
FROM film;
#7. Number of films per rental duration, with average length greater than 100 minutes
SELECT rental_duration,
       COUNT(*) AS film_count,
       AVG(length) AS avg_length
FROM film
GROUP BY rental_duration
HAVING AVG(length) > 100;
#8. Payment dates and daily totals for days with more than 100 payments
SELECT DATE(payment_date) AS payment_day,
       COUNT(*) AS payment_count,
       SUM(amount) AS total_amount
FROM payment
GROUP BY DATE(payment_date)
HAVING COUNT(*) > 100
ORDER BY payment_day;
#9. Customers whose email is NULL or ends in .org
SELECT *
FROM customer
WHERE email IS NULL
   OR email LIKE '%.org';
   #10. Films rated PG or G, sorted by rental rate descending
   SELECT title, rating, rental_rate
FROM film
WHERE rating IN ('PG', 'G')
ORDER BY rental_rate DESC;
#11. Film counts by length for titles starting with T, keeping counts above 5
SELECT length,
       COUNT(*) AS film_count
FROM film
WHERE title LIKE 'T%'
GROUP BY length
HAVING COUNT(*) > 5;
#12. Actors who appeared in more than 10 films
SELECT a.actor_id,
       a.first_name,
       a.last_name,
       COUNT(fa.film_id) AS film_count
FROM actor AS a
JOIN film_actor AS fa
  ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(fa.film_id) > 10
ORDER BY film_count DESC;
#13. Top 5 films by rental rate, then length
SELECT title, rental_rate, length
FROM film
ORDER BY rental_rate DESC,
         length DESC,
         film_id ASC
LIMIT 5;
#14. All customers and their total rentals
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(r.rental_id) AS total_rentals
FROM customer AS c
LEFT JOIN rental AS r
  ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_rentals DESC;
#15. Films that have never been rented
SELECT f.film_id, f.title
FROM film AS f
WHERE NOT EXISTS (
    SELECT 1
    FROM inventory AS i
    JOIN rental AS r
      ON i.inventory_id = r.inventory_id
    WHERE i.film_id = f.film_id
);




   
  
  
  
   