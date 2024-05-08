use music_database;
-- EASY
-- Q1: Who is the senior most employee based on job title?
select * from employee order by levels desc limit 1;

-- Q2: Which countries have the most Invoices?
select billing_country, count(*) as No_of_Invoices from invoice group by billing_country order by billing_country desc limit 1;

-- Q3: What are top 3 values of total invoice?
select total from invoice order by total desc limit 3; 

/* Q4: Which city has the best customers? We would like to throw a 
promotional Music Festival in the city we made the most money. Write a
query that returns one city that has the highest sum of invoice totals.
Return both the city name & sum of all invoice totals? */
select billing_city, sum(total) as total_invoices from invoice group by billing_city order by total_invoices desc limit 1;

/* Q5: Who is the best customer? The customer who has spent the most
money will be declared the best customer. Write a query that returns
the person who has spent the most money. */
select customer.customer_id, customer.first_name, customer.last_name, sum(invoice.total) as total
from customer join invoice on customer.customer_id=invoice.customer_id
group by customer.customer_id,  customer.first_name, customer.last_name order by total desc limit 1;

-- MODERATE 

/* Q1: Write query to return the email, first name, last name, & Genre
of all Rock Music listeners. Return your list ordered alphabetically by email starting with A? */
select distinct first_name, last_name, email from customer c
join invoice i on c.customer_id=i.customer_id
join invoice_line il on i.invoice_id=il.invoice_id
where track_id in (
select track_id from track 
join genre on track.genre_id=genre.genre_id
where genre.name like 'ROCK')
order by c.email;

/* Q2: Let's invite the artists who have written the most rock music in
our dataset. Write a query that returns the Artist name and total
track count of the top 10 rock bands? */
select ar.artist_id, ar.name, count(ar.artist_id) as no_of_songs
from track tr
join album al on tr.album_id=al.album_id
join artist ar on al.artist_id=ar.artist_id
join genre gr on tr.genre_id=gr.genre_id
where gr.name like 'ROCK'
group by ar.artist_id, ar.artist_id, ar.name
order by no_of_songs desc limit 10;


/* Q3: Return all the track names that have a song length longer than
the average song length. Return the Name and Milliseconds for each track.
Order by the song length with the longest songs listed first.*/
select name, milliseconds from track 
where milliseconds > (
select avg(milliseconds) as length_of_song from track)
order by milliseconds desc;


-- ADVANCED

/* Q1: Find how much amount spent by each customer on artists? Write a
query to return customer name, artist name and total spent? */
with best_selling_artist as (
select ar.artist_id, ar.name, sum(il.unit_price*il.quantity) as total
from invoice_line il
join track tr on il.track_id=tr.track_id
join album al on tr.album_id=al.album_id
join artist ar on al.artist_id=ar.artist_id
group by ar.artist_id, ar.name
order by total
limit 1)
select c.customer_id, c.first_name, c.last_name, bsa.name, 
sum(il.unit_price*il.quantity) as amount_spent
from invoice i
join customer c on c.customer_id=i.customer_id
join invoice_line il on il.invoice_id=i.invoice_id
join track tr on tr.track_id=il.track_id
join album al on al.album_id=tr.album_id
join best_selling_artist bsa on bsa.artist_id=al.artist_id
group by c.customer_id, c.first_name, c.last_name, bsa.name
order by amount_spent desc;


/* Q2: We want to find out the most popular music Genre for each country.
We determine the most popular genre as the genre with the highest
amount of purchases. Write a query that returns each country along with
the top Genre. For countries where the maximum number of purchasea
is shared return all Genres.? */
with popular_genre as (
select count(invoice_line.quantity) as purchase, customer.country, genre.name, genre.genre_id,
row_number() over(partition by customer.country order by count(invoice_line.quantity) desc) as RowNo
from invoice_line
join invoice on invoice.invoice_id=invoice_line.invoice_id
join customer on customer.customer_id=invoice.customer_id
join track on track.track_id=invoice_line.track_id
join genre on genre.genre_id=track.genre_id
group by customer.country, genre.name, genre.genre_id
order by customer.country asc, purchase desc)
select * from popular_genre where RowNo<=1;


/* Q3: Write a query that determines the customer that has spent the most
on music for each country. Write a query that returns the country along
with the top customer and how much they spent. For countries where
the top amount spent is shared, provide all customers who spent this
amount.? */
with recursive customer_with_country as (
select customer.customer_id, first_name, last_name, sum(total) as total_spend, billing_country 
from invoice
join customer on customer.customer_id=invoice.customer_id
group by customer.customer_id, first_name, last_name, billing_country 
order by total_spend desc),
country_max_spend as (
	select billing_country, max(total_spend) as max_spend
	from customer_with_country
	group by billing_country)
select cc.customer_id, cc.first_name, cc.last_name, cc.billing_country, cc.total_spend
from customer_with_country cc
join country_max_spend ms on cc.billing_country=ms.billing_country
where cc.total_spend=ms.max_spend
order by cc.total_spend desc;
