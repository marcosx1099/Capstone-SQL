use sakila;

#1 Displaying the full names of all the actors in the database
select first_name, last_name
from actor;

select *
from film_actor;

#2.1 Display the number of times each first name appears in the database
#displaying only the name with duplicates
select first_name,count(first_name)
from actor
group by first_name
having count(first_name) > 1;

#2.2 what is the count of actors that have unique first names in the database
select first_name,count( distinct first_name)
from actor
group by first_name;

# the count is 128 distinct names
 select count( distinct first_name)
from actor;

#3 Display the number of times each first name appears in the database
#displaying only the name with duplicates
select last_name,count(last_name)
from actor
group by last_name
having count(last_name) > 1;

#3.2 what is the count of actors that have unique last names in the database
select last_name,count( distinct last_name)
from actor
group by last_name;

# the count is 121 distinct names
 select count( distinct last_name)
from actor;

#4.1 Movies with rating 'R'
select title, rating
from film
where rating = 'R';

#4.2 Movies that are not rated 'R'
select title, rating
from film
where rating != 'R';

#4.3 Movies that are suitable for those less than 13
select title, rating
from film
where rating = 'G' or rating = 'PG';

#5.1 Display list of records where replacement cost is up to 11
select *
from film
where replacement_cost <= 11;

#5.2 Display list of records for all the movies where the replacement cost is between 11 and 20
select title, replacement_cost
from film
where replacement_cost >= 11 and replacement_cost <=20;

#5.3 Display the list of records for all the movies in decending order of their replacement cost
select title, replacement_cost
from film
order by 2 desc;

#6 Display names of top 3 movies with greatest number of actors
select count(film_actor.actor_id), film_actor.actor_id, film.title #creating a column to count the actor id's
from film_actor
join film on film_actor.film_id = film.film_id #joing both tables to get the title of the movie
group by 3 #grouping by the title
order by 1 desc #ordering it by the actor id count in descending order
limit 3; #show top 3

#7 Display the titles of movies starting with the letters 'K' and 'Q'
select title
from film
where title like 'K%' or title like 'Q%';

#8 Display the names of all the actors that appeared in 'Agent Truman'
select actor.first_name,actor.last_name, film_actor.actor_id, film.title 
from film_actor
join film on film_actor.film_id = film.film_id #joing both tables to get the title of the movie
join actor on film_actor.actor_id = actor.actor_id #joining third table to get names of actors
where film.title = 'Agent Truman';

#9 Identify the movies categorized as family films
select film.title as 'Title of movie', category.name as Genre
from film_category
join film on film_category.film_id = film.film_id
join category on film_category.category_id = category.category_id
where category.name = 'Family';

#10.1 Display the maximum rental rates of movies based on their ratings
select max(rental_rate), rating
from film
group by rating;
#10.1 Display the minimum rental rates of movies based on their ratings
select min(rental_rate), rating
from film
group by rating;
#10.1 Display the average rental rates of movies based on their ratings 
select avg(rental_rate) as 'Average rental rating', rating 'Movie rating'
from film
group by rating
order by 1 desc;

#10.2 Display the moviees in descending order of their rental frequencies so the management can maintain more copies of those movies
select film.title, count(rental.rental_id) as 'Number of times rented'
from inventory
join rental on inventory.inventory_id = rental.inventory_id
join film on inventory.film_id = film.film_id
group by film.title
order by 2 desc;

#11 Find the difference between the categories, avg replacement cost and  avg rental rate. Find the catgeories that have a difference higher than 15$
select  category.name, avg(film.replacement_cost) as 'Average replacement cost', avg(film.rental_rate) as 'Average rental rate', avg(film.replacement_cost) - avg(film.rental_rate) as Difference 
from film_category
join film on film_category.film_id = film.film_id
join category on film_category.category_id = category.category_id
group by category.name
having Difference > 15;

#12 Display the films categories in which the number of movies is greater than 70
select  count(film_category.category_id) as 'Count of Categories', category.name as 'Category'
from film_category
join film on film_category.film_id = film.film_id
join category on film_category.category_id = category.category_id
group by 2
having count(film_category.category_id) > 70;

#13 Highest genre count
select  count(*), category.name
from film_category
join film on film_category.film_id = film.film_id
join category on film_category.category_id = category.category_id
group by category.name;

