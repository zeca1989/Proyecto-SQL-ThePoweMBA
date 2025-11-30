-- 02.Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ--

select "title","rating" 
FROM "film"
WHERE "rating" = 'R';

--03.Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40--

select "actor_id","first_name","last_name"
from "actor"
where "actor_id" between 30 and 40;

--4. Obtén las películas cuyo idioma coincide con el idioma original--
-- No trae registro--

select "title","language_id","original_language_id" 
from "film" 
where "language_id"="original_language_id";

--5. Ordena las películas por duración de forma ascendente--

select "title", "length" as "tiempo"
from "film"
order by length asc;

--6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.--

select "first_name","last_name"
from "actor"
where "last_name" = 'Allen';

-- Uso LIKE--

select "first_name","last_name"
from "actor"
where "last_name" LIKE '%Allen%';

--7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.--

SELECT rating,
       COUNT(film_id) AS total_peliculas
FROM film
GROUP BY rating;

--8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.--

select "title","rating"
from "film"
where rating = 'PG-13';

select "title","rating",length as duracion
from "film"
where rating = 'PG-13'
or length > 180;

--9. Encuentra la variabilidad de lo que costaría reemplazar las películas.--

SELECT 
    ROUND(AVG(replacement_cost), 2)     AS promedio,
    ROUND(STDDEV(replacement_cost), 2)  AS desviacion_estandar,
    ROUND(VARIANCE(replacement_cost), 2) AS varianza
FROM film;

--10. Encuentra la mayor y menor duración de una película de nuestra BBDD--

SELECT 
    MIN(length) AS duracion_minima,
    MAX(length) AS duracion_maxima
FROM film;

--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día--

SELECT "InvoiceId","Total","InvoiceDate"
from "Invoice"
order by "InvoiceDate" desc
offset 2 limit 1;


--12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación--

12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-
17’ ni ‘G’ en cuanto a su clasificación.

select "title", "rating"
from film
where "rating" not in ('NC-17', 'G');

--13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración--

select "rating",
	AVG (length)
from film
group by rating;
	
--14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos--

select Title,length
from film
where length > 180;

--15. ¿Cuánto dinero ha generado en total la empresa?-- NO SE CUAL DE LOS DOS ES EL CORRECTO--

SELECT SUM(amount) AS total_generado
FROM payment;


--17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.--

select a.first_name  ,a.last_name 
from actor a 
inner join film_actor fa ON a.actor_id = fa.actor_id 
inner join film f ON fa.film_id = f.film_id 
where F.title = 'Egg Igby';

select a.first_name ,a.last_name 
FROM actor a ;

SELECT title
FROM film;

select  A.first_name , a.last_name 
from actor a
inner join film_actor fa on A.actor_id = FA.actor_id 
inner join film f on fa.film_id = f.film_id 
where F.title ilike 'Egg Igby';

--18. Selecciona todos los nombres de las películas únicos--

select distinct f.title as NOMBRE_UNICOS
from film f; 

--19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.--

select F.title,f.length 
from film f 
inner join film_category fc on F.film_id = FC.film_id 
inner join category c on FC.category_id =C.category_id 
where C."name" = 'Comedy'
and F.length > 180;

--20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.--

select c.name as CATEGORIA,
		AVG(F.length) as promedio_duracion
from Film F
inner join film_category fc on F.film_id =FC.film_id 
inner join category c on fc.category_id =c.category_id 
group by C."name"  
having AVG(F.length) > 110;

--21. ¿Cuál es la media de duración del alquiler de las películas?--

select AVG(rental_duration) as media_alquiler
from Film;

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.--

select first_name  || ' ' || last_name as nombre_completo
from actor a; 

--23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.--

select DATE(rental_date) as fecha_alquiler,
		COUNT(*) as cantidad_alquileres
FROM rental r 
group by DATE(rental_date)
order by cantidad_alquileres desc;


--24. Encuentra las películas con una duración superior al promedio.--

select title,length
from film
where length > (select AVG(length)from film);

--25. Averigua el número de alquileres registrados por mes.--

SELECT DATE_PART('month', rental_date) AS mes,
       COUNT(*) AS total_alquileres
FROM rental
GROUP BY DATE_PART('month', rental_date)
ORDER BY mes;

--26. Encuentra el promedio, la desviación estándar y varianza del total Pagado.--

select  AVG(AMOUNT) as promedio,
		STDDEV(AMOUNT) as desviacion_estandar,
		VARIANCE(AMOUNT) as varianza
from payment p ;

--27. ¿Qué películas se alquilan por encima del precio medio?--

SELECT title,rental_rate
FROM film
WHERE rental_rate > (select AVG(rental_rate ) from film);

--28. Muestra el id de los actores que hayan participado en más de 40 películas.--

select actor_id, COUNT(film_id) as total_peliculas
from film_actor
group by actor_id 
having COUNT(film_id) > 40;

--29. Obtener todas las películas y, si están disponibles en el inventario,mostrar la cantidad disponible.--

SELECT f.title, COUNT(i.inventory_id) AS disponibles
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY f.title;

--30. Obtener los actores y el número de películas en las que ha actuado.--

SELECT a.actor_id, a.first_name, a.last_name,
       COUNT(fa.film_id) AS total_peliculas
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY total_peliculas DESC;

--31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.--

SELECT f.title, a.first_name, a.last_name
FROM film f
LEFT JOIN film_actor fa ON f.film_id = fa.film_id
LEFT JOIN actor a ON fa.actor_id = a.actor_id
ORDER BY f.title;

--32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.--

select film.title,
	   actor.first_name,
	   actor.last_name
from film
left join film_actor
	on film.film_id = film_actor.film_id 
left join actor
	on film_actor.film_id = film_actor.actor_id 
order by film.title;
	
--33. Obtener todas las películas que tenemos y todos los registros de alquiler.--

select film.title,
		rental.rental_id,
		rental.rental_date
from film
left join inventory
	on film.film_id = inventory.film_id
left join rental
	on inventory.inventory_id = rental.inventory_id
order by film.title;

--34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.--

SELECT customer.first_name,
       customer.last_name,
       SUM(payment.amount) AS total_dinero_gastado
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.first_name, customer.last_name
ORDER BY total_dinero_gastado DESC
LIMIT 5;


--35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.--

SELECT first_name, last_name
FROM actor
WHERE first_name = 'Johnny';

--36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.--

SELECT first_name AS "Nombre",
       last_name AS "Apellido"
FROM actor;

--37. Encuentra el ID del actor más bajo y más alto en la tabla actor.--

SELECT MIN(actor_id) AS id_minimo,
       MAX(actor_id) AS id_maximo
FROM actor;

--38. Cuenta cuántos actores hay en la tabla “actor”.--

SELECT COUNT(*) AS total_actores
FROM actor;

--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.--

SELECT first_name, last_name
FROM actor
ORDER BY last_name ASC;

--40. Selecciona las primeras 5 películas de la tabla “film”.--

SELECT title
FROM film
LIMIT 5;


--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?--

SELECT first_name,
       COUNT(*) AS cantidad
FROM actor
GROUP BY first_name
ORDER BY cantidad DESC;


--42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.--

SELECT r.rental_id,
       r.rental_date,
       c.first_name,
       c.last_name
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
ORDER BY r.rental_date;

--43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.--

SELECT c.first_name,
       c.last_name,
       r.rental_id,
       r.rental_date
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
ORDER BY c.last_name;

--44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.--

SELECT film.title, category.name
FROM film
CROSS JOIN category;

--Creo que no aporta nada-- la misma peli tiene diferentes categorias--

--45. Encuentra los actores que han participado en películas de la categoría 'Action'.--

SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action'
ORDER BY a.last_name;


--46. Encuentra todos los actores que no han participado en películas.--

select a.actor_id actor_id,a.actor_id first_name,a.last_name 
from  actor a 
left join film_actor fa on a.actor_id = fa.actor_id 
where fa.film_id is null;


--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.--

select a.first_name,
	   a.last_name,
	   COUNT(fa.film_id) as cantidad_peliculas
from actor a	   
join film_actor fa on a.actor_id = fa.actor_id 
group by a.first_name, a.last_name 
order by cantidad_peliculas desc;

--48. Crea una vista llamada actor num peliculas que muestre los nombres de los actores y el número de películas en las que han participado.--

--Me ha dado error porque indica que ya hay una tabla creada asi, no la encuentro--

create view vista_Actor_pelicula as 

SELECT a.first_name,
       a.last_name,
       COUNT(fa.film_id) AS cantidad_peliculas
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.first_name, a.last_name
ORDER BY cantidad_peliculas DESC;


--49. Calcula el número total de alquileres realizados por cada cliente.--

select c.customer_id,
	   c.first_name,
	   c.last_name,
	   COUNT(r.rental_id) as total_alquileres
from customer c 
join rental r on r.customer_id = r.customer_id 
group by c.customer_id , C.first_name, C.last_name 
order by total_alquileres desc;

-- 50. Calcula la duración total de las películas en la categoría 'Action'.--

SELECT c.name AS categoria,
       SUM(f.length) AS duracion_total
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action'
GROUP BY c.name;


--51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.-- 

CREATE TEMP TABLE cliente_rentas_temporal AS
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(r.rental_id) AS total_alquileres
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_alquileres DESC;

-- Me da error

--52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces--

CREATE TEMP TABLE peliculas_alquiladas AS
SELECT f.film_id,
       f.title,
       COUNT(r.rental_id) AS total_alquileres
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
HAVING COUNT(r.rental_id) >= 10
ORDER BY total_alquileres DESC;

--53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.--

SELECT f.title
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE c.first_name = 'Tammy'
  AND c.last_name = 'Sanders'
  AND r.return_date IS NULL
ORDER BY f.title;

--54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
alfabéticamente por apellido.--


SELECT DISTINCT a.first_name,
       a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Sci-Fi'
ORDER BY a.last_name ASC;

--55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus
Cheaper’ se alquilara por primera--


SELECT DISTINCT a.first_name,
       a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_date > (
    SELECT MIN(r2.rental_date)
    FROM film f2
    JOIN inventory i2 ON f2.film_id = i2.film_id
    JOIN rental r2 ON i2.inventory_id = r2.inventory_id
    WHERE f2.title = 'Spartacus Cheaper')
ORDER BY a.last_name;

--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.--

SELECT a.actor_id,
       a.first_name,
       a.last_name
FROM actor a
WHERE NOT EXISTS (
      SELECT 1
      FROM film_actor fa
      JOIN film f ON fa.film_id = f.film_id
      JOIN film_category fc ON f.film_id = fc.film_id
      JOIN category c ON fc.category_id = c.category_id
      WHERE fa.actor_id = a.actor_id
        AND c.name = 'Music');


--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.--


SELECT DISTINCT f.title,
       EXTRACT(DAY FROM (r.return_date - r.rental_date)) AS dias_alquilada
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE EXTRACT(DAY FROM (r.return_date - r.rental_date)) > 8
ORDER BY f.title;



--58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.--

SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
WHERE fc.category_id = (
    SELECT category_id
    FROM category
    WHERE name = 'Animation')
ORDER BY f.title;


--59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.--

SELECT title, length
FROM film
WHERE length = 
(SELECT length
    FROM film
    WHERE title = 'Dancing Fever')
ORDER BY title;


--60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.--

SELECT c.first_name,
       c.last_name,
       COUNT(DISTINCT f.film_id) AS peliculas_diferentes
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY c.first_name, c.last_name
HAVING COUNT(DISTINCT f.film_id) >= 7
ORDER BY c.last_name;


--61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.---

SELECT c.name AS categoria,
       COUNT(r.rental_id) AS total_alquileres
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name
ORDER BY total_alquileres DESC;

--62. Encuentra el número de películas por categoría estrenadas en 2006.--

SELECT c.name AS categoria,
       COUNT(f.film_id) AS total_peliculas
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
WHERE f.release_year = 2006
GROUP BY c.name
ORDER BY total_peliculas DESC;

--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.--

SELECT s.staff_id,
       s.first_name,
       s.last_name,
       st.store_id
FROM staff s
CROSS JOIN store st
ORDER BY s.last_name, st.store_id;


64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.--

SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(r.rental_id) AS total_peliculas_alquiladas
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_peliculas_alquiladas DESC;















