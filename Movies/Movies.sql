use etlc;
select * from movies_sql;
/* 1. Retrieve the names of all the Bollywood
movies which are of drama genre in the
dataset.*/
select movie_name, genre from movies_sql where genre='drama';

/*2. Retrieve the names of all the Bollywood
movies of Amir Khan in the dataset.*/
select movie_name, lead_star from movies_sql where lead_star='Aamir Khan';

/*3. Retrieve the names Of all the Bollywood
movies which are directed by RamGopal
Verma in the dataset.*/
select movie_name, director from movies_sql where director='Ram Gopal Verma';

/* 4. Retrieve the names of all the Bollywood
movies Which have been released over
more than 1000 number of screens in the
dataset.*/
select movie_name, Number_of_Screens from movies_sql where Number_of_Screens>1000;

/* 5. Retrieve the names of all the Bollywood
movies which have generated Revenue(lNR)
more than 70,00,00,000 in the dataset.*/
select movie_name, revenue from movies_sql where revenue>700000000;

/*6. Retrieve the names of all the Bollywood
movies which have budget less than lcr in
the dataset.*/
select movie_name, budget from movies_sql where budget<10000000;

/* 7. Retrieve the names Of all the Bollywood
movies which are flop in the
dataset.(flop=revenue — budget) */
select movie_name, budget,revenue from movies_sql where revenue-budget<0;

/* 8. Retrieve the names and profit of all the
Bollywood movies in the
detaset. profit= revenue — budget) */
select movie_name, revenue, budget from movies_sql where revenue-budget>0;

/* 9. Retrieve the names and loss of all the
Bollywood movies in the
dataset.(loss=revenue — budget) */
select movie_name, revenue, budget, budget-revenue AS loss from movies_sql where revenue-budget<0;

/* 10. Retrieve the names of all the Bollywood
movies which have been released on
holidays in dataset. */
select movie_name, Release_Period from movies_sql where Release_Period='holiday';

/* 11. Retrieve the names of all the Bollywood
movie which have lead Star as Akshay
umar and directed by Priyadarshan in the
dataset. */
select movie_name, lead_star, director from movies_sql where lead_star='Akshay Kumar'and director='Priyadarshan';

/* 12. Retrieve the names of all the Bollywood
movies starting with 'a' in the dataset. */
select movie_name from movies_sql where movie_name like 'a%';

/* 13. Retrieve the names Of all the Bollywood
movies ending with 'a' in the dataset. */
select movie_name from movies_sql where movie_name like '%a';

/* 14. Retrieve the names Of all the Bollywood
movies having 'a' at second place of the
name in the dataset.*/
select movie_name from movies_sql where movie_name like '_a%';

/* 15. Retrieve the names of all the Bollywood
movies having music rof amit trivedi the
dataset. */
select movie_name, Music_Director from movies_sql where Music_Director='Amit trivedi';

/* 16. Retrieve the names of all the comedy
movies of Akshay Kumar in the dataset. */
select movie_name, lead_star, genre from movies_sql where lead_star='Akshay Kumar'and genre='comedy';

/* 17. Retrieve the names of movies and star
name starring khan in the dataset. */
select movie_name, lead_star from movies_sql where lead_star like '%khan';

/* 18. Retrieve all the information Of movies
race and race2 in the dataset. */
select * from movies_sql where movie_name in ('race','race 2');

/* 19. Retrieve the names of all the thriller
Bollywood movies in the dataset. */
select movie_name, genre from movies_sql where genre in('thriller');

/* 20. Retrieve the names and budget of all the
Bollywood movies according to the highest
to lowest budget in the dataset. */
select movie_name, budget from movies_sql order by budget desc;

/* 21. Retrieve the names and budget of top 5
Bollywood movies with highest budget in
he datasets. */
select movie_name, budget from movies_sql order by budget desc limit 5;

/* 22. Retrieve the names of top 10 Bollywood
movies with highest revenue generation in
the dataset. */
select movie_name, revenue from movies_sql order by revenue desc limit 10;

/* 23. Retrieve the names of top 5 movies of
salman khan in the dataset. */
select movie_name, lead_star, revenue from movies_sql where lead_star='Salman Khan' order by revenue desc limit 5;

/* 24. Retrieve the names of top 5 floped movies
in the dataset. */
select movie_name, revenue, budget from movies_sql where revenue-budget<0 limit 5;

/* 25. Retrieve the names of top 5 hit movies in
the dataset. */
select movie_name, revenue, budget from movies_sql where revenue-budget>0 order by revenue desc limit 5;

/* 26. Which is the second movie released on
maximum screens. */
select movie_name, Number_of_Screens from movies_sql order by Number_of_Screens desc limit 1,1; 

/* 27. Which is the 10th movies with highest
budget. */
select movie_name, budget from movies_sql order by budget desc limit 9,1;

/* 28. Which is the 2nd movie of Amitabh
Bachchan with highest budget. */
select movie_name, lead_star, budget from movies_sql where lead_star='Amitabh Bachchan' order by budget desc limit 1,1;

/* 29. Which are the flopped movies of Akshay
Kumar. */
select movie_name, lead_star, revenue, budget from movies_sql where revenue-budget<0 and lead_star='Akshay Kumar';

/* 30. With which director Sharuk Khan have
given the biggest hit movie. */
select movie_name, lead_star, director, revenue, budget from movies_sql where revenue-budget>0 and lead_star='Aamir Khan' order by revenue desc;
