SELECT first_name, last_name from actor;
SELECT CONCAT(first_name, ' ' , last_name) AS 'Actor Name' FROM actor;
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'Joe';
SELECT first_name, last_name FROM actor WHERE last_name LIKE '%GEN%';
SELECT first_name, last_name FROM actor WHERE last_name LIKE '%LI%' ORDER BY 2, 1;
SELECT country_id, country FROM country WHERE country in ('Afghanistan', 'Bangladesh', 'China');
ALTER TABLE actor ADD description LONGBLOB; 
ALTER TABLE actor DROP COLUMN description;
SELECT last_name, COUNT(last_name) AS Count_Last_Name from actor GROUP BY 1;
SELECT last_name, COUNT(last_name) AS Count_Last_Name from actor GROUP BY 1 HAVING Count_Last_Name>1;
UPDATE actor set first_name = "Harpo" 
	WHERE first_name = "Groucho"
    AND last_name = "Williams";
UPDATE actor set first_name = "Groucho" 
	WHERE first_name = "Harpo";
SHOW CREATE TABLE address;
SELECT first_name, last_name, address FROM staff s JOIN address a ON s.address_id = a.address_id;
SELECT first_name, last_name, SUM(Amount) AS Total FROM staff s 
	JOIN payment p ON s.staff_id = p.staff_id
    WHERE MONTH(payment_date) = 8
    GROUP BY 1,2
    ORDER BY payment_date;
SELECT title, count(actor_id) AS Number_of_Actors FROM film_actor fa
	JOIN film f ON fa.film_id = f.film_id
    GROUP BY 1;
SELECT count(i.film_id) AS Copies FROM inventory i 
	JOIN film f on f.film_id = i.film_id
    WHERE title = "Hunchback Impossible";
SELECT first_name, last_name, SUM(amount) AS "Total Amount Paid" FROM payment p 
	JOIN customer c ON c.customer_id = p.customer_id
    GROUP BY 1,2
    ORDER BY 2;
SELECT title FROM film
	WHERE language_id IN (SELECT language_id FROM language
		WHERE name = 'English')
        AND  title LIKE"K%"
        OR  title LIKE "Q%";
SELECT first_name, last_name FROM actor WHERE actor_id in (
	SELECT actor_id FROM film_actor
		WHERE film_id IN(SELECT film_id FROM film WHERE title = 'Alone Trip'));
SELECT first_name, last_name, email FROM customer c
	JOIN address a ON a.address_id = c.address_id
    JOIN city ci ON ci.city_id = a.city_id
    JOIN country co ON co.country_id = ci.country_id
    WHERE country = 'Canada';
SELECT title FROM film f
	JOIN film_category fc ON f.film_id = fc.film_id
	JOIN category ca ON ca.category_id = fc.category_id
	WHERE ca.name = 'Family';
SELECT f.title, count(rental_date) AS Times_Rented FROM film f
	JOIN inventory i ON i.film_id = f.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
	GROUP BY 1
    ORDER BY 2 DESC;
SELECT s.store_id, SUM(amount) AS Revenue FROM store s 
	JOIN staff st ON st.store_id = s.store_id
	JOIN payment p ON p.staff_id = st.staff_id
    GROUP BY 1;
SELECT s.store_id, c.city, co.country FROM store s
	JOIN address a ON s.address_id = a.address_id
	JOIN city c ON c.city_id = a.city_id
	JOIN country co ON co.country_id = c.country_id;
SELECT c.name, SUM(p.amount) AS Revenue FROM category c
	JOIN film_category fc ON fc.category_id = c.category_id
    JOIN film f ON f.film_id = fc.film_id 
    JOIN inventory i ON i.film_id = fc.film_id
    JOIN rental r ON r.inventory_id = i.inventory_id
    JOIN payment p ON p.rental_id = r.rental_id
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 5;

CREATE VIEW TOP_5_Genres AS
 SELECT c.name, SUM(p.amount) AS Revenue FROM category c
	JOIN film_category fc ON fc.category_id = c.category_id
    JOIN film f ON f.film_id = fc.film_id 
    JOIN inventory i ON i.film_id = fc.film_id
    JOIN rental r ON r.inventory_id = i.inventory_id
    JOIN payment p ON p.rental_id = r.rental_id
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 5;
SELECT * FROM TOP_5_Genres;
DROP VIEW TOP_5_Genres;












