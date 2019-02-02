USE sakila;


# display first and last names of all actors in actor
SELECT first_name, last_name
FROM actor;

#display the first and last name of each actor in a single column in upper case letters. Name column 'Actor Name'
SELECT 
		CONCAT_WS('', first_name, last_name) AS Actor_Name 
  FROM actor;
  
#Find ID #, first name, last name of actor with first name "Joe" 

 SELECT actor_id, first_name, last_name
	FROM actor
	WHERE first_name="JOE";

# Find all actors whose last name contain the letters "GEN"
SELECT first_name, last_name
		FROM actor
        WHERE last_name LIKE "%GEN%";
  
# Find all actors whose last name contain the letters "LI" order rows by last_name, first_name  
SELECT last_name, first_name
		FROM actor
        WHERE last_name LIKE "%LI%";
        
# using IN display country_id, country columns for "Afghanistan', Bangladesh, China
SELECT country_id, country
	FROM country
	WHERE country IN ("Afghanistan", "Bangladesh", "China");
    
#Create column in actor table called "description" use data type blob

ALTER TABLE actor
	ADD COLUMN description BLOB AFTER last_name;    

# delete description column
ALTER TABLE actor
	DROP description;
    
 #list last names of actors, and how many actors have last name
 
 SELECT 
    last_name, 
    COUNT(last_name)
FROM
    actor
GROUP BY last_name
HAVING COUNT(last_name) > 0;

# list last names only for those shared by at least 2 actors

SELECT 
    last_name, 
    COUNT(last_name)
FROM
    actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

#change Harpo Williams to "Groucho Williams
SET SQL_SAFE_UPDATES = 0;
UPDATE actor 
	SET first_name = REPLACE (first_name, 'HARPO', 'GROUCHO')
    WHERE last_name =('WILLIAMS');
SET SQL_SAFE_UPDATES = 1;  

# change back
SET SQL_SAFE_UPDATES = 0;
UPDATE actor 
	SET first_name = REPLACE (first_name, 'GROUCHO', 'HARPO')
    WHERE last_name =('WILLIAMS');
SET SQL_SAFE_UPDATES = 1;  

#locate schema of address table
DESCRIBE address;

# use join to display first name, last name and address of employees

SELECT staff.first_name, staff.last_name, address.address, address.address2
FROM address
INNER JOIN staff ON
staff.address_id=address.address_id;

# use join to display the total amount rung up by each staf member use "staff" and payment


SELECT  staff.staff_id, SUM(payment.amount) AS Total
FROM staff
INNER JOIN payment ON
staff.staff_id=payment.staff_id
WHERE payment.payment_date LIKE '%08%'
GROUP BY staff_id;

# List each film and the number of actor in each film use inner join for film_actor and film

SELECT film.title, COUNT(film_actor.actor_id) AS 'Total Cast'
FROM film_actor
INNER JOIN film ON
film.film_id=film_actor.film_id
GROUP BY film.title;

#how many copies of 'Hunchback Impossible" exist in the inventory system
 
 SELECT COUNT(*)
 FROM inventory
 WHERE inventory_id IN
   (
    SELECT inventory_id
    FROM inventory
    WHERE film_id IN
    (
     SELECT film_id
     FROM film
     WHERE title = 'Hunchback Impossible'
    )
 );

# using "payment' and 'customer' join and list total paid b each customer


SELECT customer.last_name, customer.first_name, SUM(payment.amount) AS 'Total Paid'
FROM customer
INNER JOIN payment ON
payment.customer_id=customer.customer_id
GROUP BY customer.last_name;

# group films with titles starting with K and Q whose language is English

SELECT title
FROM film
WHERE title LIKE 'Q%' OR title Like 'K%' AND language_id='1';


# use subqueries to display all actors in Alone Trip

SELECT first_name, last_name
FROM actor
WHERE actor_id IN
(
  SELECT actor_id
  FROM film_actor
  WHERE film_id IN
  (
   SELECT film_id
   FROM film
   WHERE title = 'ALONE TRIP'
  )
);

# names and emails for all canadian customers use joins to get there

SELECT customer.last_name, customer.first_name, customer.email, customer_list.country
FROM customer
INNER JOIN customer_list ON
customer.customer_id=customer_list.ID
WHERE customer_list.country='Canada'
GROUP BY customer.last_name;

# identify all movies identified as family films

SELECT title FROM film_list WHERE category LIKE '%FAMILY%' OR 'Child%';


# dsiplay most frequently rented movies in descending order - STRUCK OUT ON THIS ONE


 

 SELECT COUNT(*)
 FROM customer
 WHERE customer_id IN
 (
  SELECT customer_id
  FROM payment
  WHERE rental_id IN
  (
   SELECT rental_id
   FROM rental
   WHERE inventory_id IN
   (
    SELECT inventory_id
    FROM inventory
    WHERE film_id IN
    (
     SELECT film_id
     FROM film
     GROUP BY title
    )
   )
  )
 );

# write a query to display how much business in $ each store brought in
SELECT * FROM sales_by_store;

# Write a query to display for each store ID, city and county - STRUCK OUT HERE AS WELL


SELECT store.store_id, sales_by_store.store
FROM store
JOIN address
ON store.store_id=address.address_id
JOIN sales_by_store 
ON address.address_id=sales_by_store.store
GROUP BY sales_by_store.store;

#7h=-8c - past my depth/skills right now.... need help on these....

