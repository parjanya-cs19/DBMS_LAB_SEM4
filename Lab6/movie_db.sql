create schema `movie_db`;
use `movie_db`;
create table actor(act_id integer PRIMARY KEY, act_name varchar(255), act_gender varchar(255)); 
create table director(dir_id integer PRIMARY KEY, dir_name varchar(255), dir_phone varchar(255));
create table movies(mov_id integer PRIMARY KEY, mov_title varchar(255), mov_year varchar(255), mov_lang varchar(255), dir_id integer, FOREIGN KEY (dir_id) REFERENCES director(dir_id));
create table movie_cast(act_id integer, mov_id integer, act_role varchar(255), FOREIGN KEY (act_id) REFERENCES actor(act_id),FOREIGN KEY (mov_id) REFERENCES movies(mov_id));
create table rating(mov_id integer, rev_stars integer, FOREIGN KEY (mov_id) REFERENCES movies(mov_id));

INSERT INTO director(dir_id, dir_name, dir_phone) VALUES (1, 'Sajid Nadiadwala', '9876543210'),  
														(2, 'SRK', '8967452310'),   
                                                        (3, 'Alfred Hitchcock', '6789123450'),   
                                                        (4, 'Selemendor Bhai', '7890123456'),   
                                                        (5, 'James Cameron', '9988776655'),
                                                        (6, 'Alfred Hitchcock', 6789123450);
                                                        
INSERT INTO actor(act_id ,act_name ,act_gender) VALUES (1, 'Tom Cruise','MALE' ),
													 (2, 'Jamie Foxx','MALE'),
													 (3, 'Robert De Niro', 'MALE'),
													 (4, 'Zoe Saldana','FEMALE'),
													 (5, 'Kim Novak','FEMALE');
                                                     
INSERT INTO movies(mov_id, mov_title, mov_year, mov_lang, dir_id) VALUES(1,'War of the Worlds', 2005, 'ENG', 1),
																			(2,'Minority Report', 2002, 'ENG', 3),
                                                                            (3,'Django Unchained', 2012, 'ENG', 2),
                                                                            (4,'Vertigo', 1958, 'ENG', 3),
                                                                            (5,'Goodfellas',1990, 'ENG', 4),
                                                                            (6, 'Avatar', 2009, 'ENG', 5),
                                                                            (7, 'NTG', 2020, 'ENG', 3);
																		
                                                                            
INSERT INTO movie_cast(act_id, mov_id, act_role) VALUES (1, 1, 'LEAD'),		
														(1, 2, 'LEAD'),	
														(2, 3, 'LEAD'),	
														(3, 5, 'LEAD'),	
														(4, 6, 'CO-STAR'),	
														(5, 4, 'LEAD'),                                                                            
                                                        (5, 7, 'LEAD');   
 
INSERT INTO rating(mov_id, rev_stars) VALUES (1, 3),
												(2, 4),
                                                 (3, 5),
                                                 (4, 4),
                                                 (5, 5),
                                                 (6, 4),  
                                                 (7, 3);   
  
SELECT mov_title
FROM movies
WHERE mov_id IN (SELECT mov_id FROM movies WHERE dir_id IN (SELECT dir_id FROM director WHERE dir_name = 'Alfred Hitchcock'));

SELECT mov_title 
FROM movies 
WHERE mov_id IN (SELECT mov_id FROM movie_cast WHERE act_id IN (SELECT act_id FROM actor WHERE act_id IN (SELECT act_id FROM movie_cast GROUP BY act_id HAVING COUNT(act_id)>1)));

SELECT act_name, mov_title, mov_year
FROM actor
JOIN movie_cast 
ON actor.act_id=movie_cast.act_id
JOIN movies 
ON movie_cast.mov_id=movies.mov_id
WHERE mov_year NOT BETWEEN 2000 and 2015;

SELECT mov_title, MAX(rev_stars)
FROM movies
INNER JOIN rating USING(mov_id)
GROUP BY mov_title 
HAVING MAX(rev_stars)>0
ORDER BY mov_title;

UPDATE rating SET rev_stars = 5 WHERE mov_id IN
(SELECT m.mov_id FROM movies m, director d WHERE m.dir_id = d.dir_id AND d.dir_name='Selemendor Bhai');

select * from rating;