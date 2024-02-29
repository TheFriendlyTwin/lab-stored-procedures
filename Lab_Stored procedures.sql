/*Lab | Stored procedures*/

/*In this lab, we will continue working on the Sakila database of movie rentals.

Instructions
Write queries, stored procedures to answer the following questions:*/

/* 1. In the previous lab we wrote a query to find first name, last name, and emails of all the customers who rented Action movies. 
Convert the query into a simple stored procedure. Use the following query: */
select first_name, last_name, email
from customer
join rental on customer.customer_id = rental.customer_id
join inventory on rental.inventory_id = inventory.inventory_id
join film on film.film_id = inventory.film_id
join film_category on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
where category.name = "Action"
group by first_name, last_name, email;

DELIMITER //
create procedure return_query_rows_action_film_customers()
begin

  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
  
end //
DELIMITER ;

call return_query_rows_action_film_customers();

/* 2. Now keep working on the previous stored procedure to make it more dynamic. 
Update the stored procedure in a such manner that it can take a string argument for the category name and return the results for all customers that rented movie of that category/genre. 
For eg., it could be action, animation, children, classics, etc. */
select * from sakila.category;

drop procedure if exists return_query_rows_film_category_customers;

DELIMITER //
create procedure return_query_rows_film_category_customers(in param varchar(20))
begin

  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = param
  group by first_name, last_name, email;
  
end //
DELIMITER ;

call return_query_rows_film_category_customers('Action');
call return_query_rows_film_category_customers('Animation');
call return_query_rows_film_category_customers('Children');
call return_query_rows_film_category_customers('Classics');
call return_query_rows_film_category_customers('Comedy');
call return_query_rows_film_category_customers('Documentary');
call return_query_rows_film_category_customers('Drama');
call return_query_rows_film_category_customers('Family');
call return_query_rows_film_category_customers('Foreign');
call return_query_rows_film_category_customers('Games');
call return_query_rows_film_category_customers('Horror');
call return_query_rows_film_category_customers('Music');
call return_query_rows_film_category_customers('New');
call return_query_rows_film_category_customers('Sci-Fi');
call return_query_rows_film_category_customers('Sports');
call return_query_rows_film_category_customers('Travel');

/* 3. Write a query to check the number of movies released in each movie category. 
Convert the query in to a stored procedure to filter only those categories that have movies released greater than a certain number. 
Pass that number as an argument in the stored procedure. */

-- Query:
select c.name, count(fc.film_id) as film_count from sakila.film_category fc
join sakila.category c
on fc.category_id = c.category_id
group by c.name;

select c.name, count(fc.film_id) as film_count from sakila.film_category fc
join sakila.category c
on fc.category_id = c.category_id
group by c.name
having count(fc.film_id) > 32;

-- Procedure:
drop procedure if exists return_film_count_category;

DELIMITER //
create procedure return_film_count_category(in num int)
begin

  select c.name, count(fc.film_id) as film_count from sakila.film_category fc
  join sakila.category c
  on fc.category_id = c.category_id
  group by c.name
  having count(fc.film_id) > num;
  
end //
DELIMITER ;

call return_film_count_category(32);
call return_film_count_category(65);
call return_film_count_category(70);