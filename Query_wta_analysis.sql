-- select all data from players and matches;
SELECT * FROM players;
SELECT * FROM matches;

-- Select unique country from players
SELECT distinct country_code FROM players;

-- Determination of the number of players playing with the left and right hand
SELECT COUNT(*) AS number_of_players_play_using_left_hand FROM players WHERE hand = 'L';
SELECT COUNT(*) AS number_of_players_play_using_right_hand FROM players WHERE hand = 'R';
SELECT COUNT(*) AS number_of_players_play_using_u_hand FROM players WHERE hand = 'U';

-- Select information about winner under 20
SELECT winner_id, winner_name, winner_rank, winner_age
	FROM matches
    WHERE winner_age < 20
    ORDER BY winner_id ASC;

-- Select avarage age of players
SELECT AVG(loser_age), AVG(winner_age) FROM matches;

-- select the youngest loser
SELECT loser_id, loser_name, loser_age
	FROM matches
    WHERE loser_age = (SELECT MIN(loser_age) FROM matches);

-- select the oldes winner
SELECT winner_id, winner_name, winner_age
	FROM matches
    WHERE loser_age = (SELECT MAX(loser_age) FROM matches);
    
-- select player with max ranking points
SELECT MAX(winner_rank_points), MAX(loser_rank_points) FROM matches;

-- Select all first name players starter from 'S' and ended for 'a' from players
SELECT first_name, last_name
	FROM players
    WHERE first_name LIKE 'S%a';
    
-- Selection of french open final match result grouped after one year
SELECT score, year FROM matches
	WHERE tourney_name LIKE 'French%'
    GROUP BY year;
    
-- selection of a winner between 25 and 35 years of age
SELECT winner_id, winner_name, winner_age FROM matches
	WHERE winner_age BETWEEN 25 AND 35;
    
-- select any left right loser
SELECT loser_id, loser_name, loser_hand FROM matches
	WHERE NOT loser_hand = 'U' AND NOT loser_hand = 'R';
    
-- Count tourney
SELECT COUNT(tourney_id) FROM matches;

SELECT COUNT(tourney_id) FROM matches
	WHERE year = 2017;

-- Select all winner of Australian Open
SELECT winner_id, winner_name, winner_rank_points, year FROM matches
	WHERE tourney_name LIKE 'Aus%'
    GROUP BY year
    ORDER BY winner_rank_points DESC;
    
-- Select all tourney where winner was Agnieszka Radwańska
SELECT tourney_id, tourney_level, tourney_name FROM matches
	WHERE winner_id IN (SELECT player_id FROM players WHERE last_name = 'Radwańska' AND first_name = 'Agnieszka');

-- Not Null
SELECT tourney_id FROM matches
	WHERE minutes IS NOT NULL;
    
-- JOINY
SELECT matches.winner_name, players.country_code 
	FROM matches
    INNER JOIN players ON matches.winner_id = players.player_id;
    
SELECT matches.loser_name, players.birth_date
	FROM matches
    LEFT JOIN players ON matches.loser_id = players.player_id;
    
-- Player ID greater than 202400 (CASE)
SELECT tourney_id, tourney_date, 
	CASE
		WHEN winner_id > 202400 THEN 'Player ID is greater than 202400'
        WHEN winner_id = 202400 THEN 'Player ID is 202400'
        ELSE 'Player ID is under 202400'
	END AS Player_ID
FROM matches;