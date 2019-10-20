use sakila;

#Display the first and last names of all actors from the table actor.

select first_name,last_name from actor;

#Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
select concat (first_name, " ", last_name) as 'Actor' from actor;

#You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
select actor_id,first_name,last_name from actor having first_name = 'Joe';

#Find all actors whose last name contain the letters GEN:
select * from actor where last_name like '%GEN%';

#Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
select * from actor where last_name like '%LI%' order by last_name, first_name;

# Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
select country_id, country from country where country in ('Afghanistan', 'China', 'Bangladesh');

#Add a middle_name column to the table actor. Position it between first_name and last_name. Hint: you will need to specify the data type.
alter table actor
	add column middle_name varchar (20) after first_name;

#You realize that some of these actors have tremendously long last names. Change the data type of the middle_name column to blobs.
alter table actor
	modify column middle_name blob (20) after first_name;
    
#Now delete the middle_name column.
alter table actor
	drop column middle_name;

#List the last names of actors, as well as how many actors have that last name.

SELECT last_name, COUNT(DISTINCT last_name) as 'last_name_count' from actor group by last_name;

#List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors

SELECT last_name, COUNT(DISTINCT last_name) as 'last_name_count' from actor group by last_name 
	having last_name_count > 2;
   
#Oh, no! The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS, the name of Harpo's second cousin's husband's yoga teacher. Write a query to fix the record. 
update actor
	set FIRST_NAME = 'WALDO' where first_name = 'GROUCHO' AND last_name = 'WILLIAMS';
    
#Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO. Otherwise, change the first name to MUCHO GROUCHO
update actor
	set FIRST_NAME = 'GROUCHO' where first_name = 'WALDO' AND last_name = 'WILLIAMS';

# You cannot locate the schema of the address table. Which query would you use to re-create it?
SHOW CREATE TABLE address;


#Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address
select staff.first_name, staff.last_name,address.address
from address
join staff on staff.address_id = address.address_id;

#Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment

select staff.first_name, staff.last_name,payment.amount
from staff
join payment on staff.staff_id = payment.staff_id
where payment_date between '2005-08-01' and '2005-08-31';

#List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
select title, count(actor_id) as 'actor count'
from film
inner join film_actor on film.film_id = film_actor.film_id
group by title;

#How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT COUNT(*)
 inventory_id
    FROM inventory
    WHERE film_id IN
    (
     SELECT film_id
     FROM film
     WHERE title = 'Hunchback Impossible'
     );

#Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
select first_name, last_name, sum(amount) as 'total spent' from customer
inner join payment on customer.customer_id = payment.customer_id
group by customer.last_name
order by customer.last_name;

#The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English

describe film;
show tables;
select* from language;

SELECT title
  FROM film
 WHERE( title LIKE 'K%' or title like'Q%')
 AND language_id IN
  (
     SELECT language_id
     FROM language
     WHERE name = 'English'
     );
     
     

 

