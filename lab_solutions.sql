USE sakila;
-- 1.As a movie rental company, we need to use SQL built-in functions to help us gain insights into our business operations:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select max(length) as max_duration, min(length) as min_duration from sakila.film;
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: look for floor and round functions.
select concat(floor(avg(length) / 60), ' hours ', avg(length) % 60, ' minutes') as average_duration
from sakila.film;
-- 2.We need to use SQL to help us gain insights into our business operations related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating. Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
select datediff(max(rental_date), min(rental_date)) as operating_days
from sakila.rental;
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select rental_id, rental_date, month(rental_date) as month, weekday(rental_date) as weekday
from sakila.rental
limit 20;
-- 2.3 Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week. Hint: use a conditional expression.
select rental_id, rental_date, dayname(rental_date) as day_type
from sakila.rental;
/*3.Retrieve the film titles and their rental duration. 
If any rental duration value is NULL, replace it with the string 'Not Available'. 
Sort the results by the film title in ascending order.
*/
select title,
       case
           when rental_duration is null then 'Not Available'
           else cast(rental_duration as char)
       end as rental_duration
from film
order by title asc;

/* 4.Retrieve the concatenated first and last names of our customers, along with the first 3 characters of their email address.
The results should be ordered by last name in ascending order to make it easier for us to use the data.
*/
select concat(first_name, ' ', last_name) as Customer_Name,
       substring(email, 1, 3) as Email_Start
from customer
order by last_name asc;

-- Challenge 2

-- 1.We need to analyze the films in our collection to gain insights into our business operations. Using the film table, determine:
-- 1.1 The total number of films that have been released.
select count(film_id)
from sakila.film;
-- 1.2 The number of films for each rating.
select rating, count(*) as number_of_films
from sakila.film
group by rating;
-- 1.3 The number of films for each rating, and sort the results in descending order of the number of films.
select rating, count(*) as number_of_films
from sakila.film
group by rating
order by number_of_films desc;
-- 2 Determine the number of rentals processed by each employee.
select staff_id, count(*) as number_of_rentals
from sakila.rental
group by staff_id;
-- 3.Using the film table, determine:
/* 3.1 The mean film duration for each rating, and sort the results in descending order of the mean duration.
Round off the average lengths to two decimal places. 
*/
select rating, round(avg(length), 2) as mean_duration
from sakila.film
group by rating
order by mean_duration desc;
-- 3.2 Identify which ratings have a mean duration of over two hours.
select rating, round(avg(length), 2) as mean_duration
from sakila.film
group by rating
having avg(length) > 120;

-- 4.Determine which last names are not repeated in the table actor.
select last_name
from actor
group by last_name
having COUNT(*) = 1;