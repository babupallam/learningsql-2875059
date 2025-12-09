/**
 * SQL PRACTICE SCRIPT
 * Database Schema:
 * 1. people (id_number, first_name, last_name, city, state_code, 
 * shirt_or_hat, quiz_points, team, signup, age, company)
 * 2. states (state_name, state_abbrev, region, division)
 *
 * NOTE: The queries below are written in ANSI SQL syntax (compatible with SQLite, MySQL, PostgreSQL, etc.).
 * For date functions, standard SQL functions like LIKE, SUBSTR, and DATE() are used, common in SQLite.
 *
 * This script is divided into sections matching the complexity level.
 **/

---------------------------------------------------------------------------------------------------
-- I. Basic SELECT, WHERE, and ORDER BY (Questions 1-10)
---------------------------------------------------------------------------------------------------

-- 1. Select the first 10 unique team names in alphabetical order.
SELECT DISTINCT
    team
FROM
    people
ORDER BY
    team ASC
LIMIT 10;

-- 2. Find the first_name and last_name of all participants who have exactly 300 quiz_points.
SELECT
    first_name,
    last_name
FROM
    people
WHERE
    quiz_points = 300;

-- 3. List the team and quiz_points for all participants who scored over 600 points, ordered by points descending.
SELECT
    team,
    quiz_points
FROM
    people
WHERE
    quiz_points > 600
ORDER BY
    quiz_points DESC;

-- 4. Find the names (first_name, last_name) and city for people who want a 'hat' and are over 50 years old.
SELECT
    first_name,
    last_name,
    city
FROM
    people
WHERE
    shirt_or_hat = 'hat' AND age > 50;

-- 5. Retrieve the full details (*) for participants whose last_name starts with the letter 'S'.
SELECT
    *
FROM
    people
WHERE
    last_name LIKE 'S%';

-- 6. Get the first_name and last_name of all participants whose city is 'Boston' or 'Denver'.
SELECT
    first_name,
    last_name
FROM
    people
WHERE
    city IN ('Boston', 'Denver');

-- 7. Show the state_name and state_abbrev for all states in the 'Northeast' region.
SELECT
    state_name,
    state_abbrev
FROM
    states
WHERE
    region = 'Northeast';

-- 8. List participants whose quiz points are between 400 and 500 (inclusive), showing their first_name, last_name, and quiz_points.
SELECT
    first_name,
    last_name,
    quiz_points
FROM
    people
WHERE
    quiz_points BETWEEN 400 AND 500;

-- 9. Find the names of participants whose first_name contains the sequence 'an' and order them alphabetically by last_name.
SELECT
    first_name,
    last_name
FROM
    people
WHERE
    first_name LIKE '%an%'
ORDER BY
    last_name ASC;

-- 10. Retrieve the total list of participants who want a 'shirt', ordered by team ascending, then city descending.
SELECT
    team,
    city,
    first_name,
    last_name
FROM
    people
WHERE
    shirt_or_hat = 'shirt'
ORDER BY
    team ASC,
    city DESC;

---------------------------------------------------------------------------------------------------
-- II. Simple Aggregate Functions (Questions 11-20)
---------------------------------------------------------------------------------------------------

-- 11. What is the average age of all participants?
SELECT
    AVG(age) AS average_age
FROM
    people;

-- 12. What is the highest score (quiz_points) achieved in the quiz?
SELECT
    MAX(quiz_points) AS highest_score
FROM
    people;

-- 13. What is the total number of participants signed up?
SELECT
    COUNT(id_number) AS total_participants
FROM
    people;

-- 14. Calculate the sum of all quiz points awarded across all participants.
SELECT
    SUM(quiz_points) AS total_quiz_points
FROM
    people;

-- 15. Find the minimum age of any participant.
SELECT
    MIN(age) AS minimum_age
FROM
    people;

-- 16. How many participants live in the city of 'New York City'?
SELECT
    COUNT(id_number) AS nyc_participant_count
FROM
    people
WHERE
    city = 'New York City';

-- 17. Count the number of unique state_code values in the people table.
SELECT
    COUNT(DISTINCT state_code) AS unique_states_count
FROM
    people;

-- 18. Find the average quiz_points for participants who want a 'hat'.
SELECT
    AVG(quiz_points) AS avg_hat_score
FROM
    people
WHERE
    shirt_or_hat = 'hat';

-- 19. How many distinct companies are listed in the people table?
SELECT
    COUNT(DISTINCT company) AS distinct_companies
FROM
    people;

-- 20. Calculate the median quiz_points (Approximate using (MAX + MIN) / 2).
SELECT
    (MAX(quiz_points) + MIN(quiz_points)) / 2 AS approximate_median_score
FROM
    people;

---------------------------------------------------------------------------------------------------
-- III. GROUP BY and HAVING (Questions 21-30)
---------------------------------------------------------------------------------------------------

-- 21. Count the number of participants per team.
SELECT
    team,
    COUNT(id_number) AS participant_count
FROM
    people
GROUP BY
    team;

-- 22. Find the maximum quiz_points for each team.
SELECT
    team,
    MAX(quiz_points) AS max_score
FROM
    people
GROUP BY
    team;

-- 23. Calculate the average quiz_points per state_code.
SELECT
    state_code,
    AVG(quiz_points) AS average_score
FROM
    people
GROUP BY
    state_code;

-- 24. Find the city where the minimum age is greater than 20.
SELECT
    city,
    MIN(age) AS min_age
FROM
    people
GROUP BY
    city
HAVING
    MIN(age) > 20;

-- 25. List all teams that have more than 50 participants.
SELECT
    team,
    COUNT(id_number) AS team_size
FROM
    people
GROUP BY
    team
HAVING
    COUNT(id_number) > 50;

-- 26. For each type of shirt_or_hat preference, find the total sum of quiz_points.
SELECT
    shirt_or_hat,
    SUM(quiz_points) AS total_points
FROM
    people
GROUP BY
    shirt_or_hat;

-- 27. List all state_codes where the average quiz_points is less than 500.
SELECT
    state_code,
    AVG(quiz_points) AS avg_score
FROM
    people
GROUP BY
    state_code
HAVING
    AVG(quiz_points) < 500;

-- 28. Count the number of participants in each age group (decade), rounding down (e.g., 20s, 30s).
SELECT
    (age / 10) * 10 AS age_decade,
    COUNT(id_number) AS participant_count
FROM
    people
GROUP BY
    age_decade
ORDER BY
    age_decade;

-- 29. Find the state_codes that have at least two participants who want a 'shirt'.
SELECT
    state_code,
    COUNT(id_number) AS shirt_count
FROM
    people
WHERE
    shirt_or_hat = 'shirt'
GROUP BY
    state_code
HAVING
    COUNT(id_number) >= 2;

-- 30. Calculate the count and average age for each unique combination of team and shirt_or_hat preference.
SELECT
    team,
    shirt_or_hat,
    COUNT(id_number) AS count,
    AVG(age) AS average_age
FROM
    people
GROUP BY
    team,
    shirt_or_hat;

---------------------------------------------------------------------------------------------------
-- IV. JOIN Operations (Questions 31-40)
---------------------------------------------------------------------------------------------------

-- 31. (INNER JOIN) List the first_name, last_name, and full state_name for all participants.
SELECT
    p.first_name,
    p.last_name,
    s.state_name
FROM
    people p
INNER JOIN
    states s ON p.state_code = s.state_abbrev;

-- 32. Find all participants (name and city) who live in the 'West' region.
SELECT
    p.first_name,
    p.city
FROM
    people p
INNER JOIN
    states s ON p.state_code = s.state_abbrev
WHERE
    s.region = 'West';

-- 33. Show the state_name and the total number of participants from that state.
SELECT
    s.state_name,
    COUNT(p.id_number) AS participant_count
FROM
    people p
INNER JOIN
    states s ON p.state_code = s.state_abbrev
GROUP BY
    s.state_name;

-- 34. Find all division names and the corresponding average quiz_points.
SELECT
    s.division,
    AVG(p.quiz_points) AS avg_division_score
FROM
    people p
INNER JOIN
    states s ON p.state_code = s.state_abbrev
GROUP BY
    s.division;

-- 35. (LEFT JOIN) List all state_names, and the count of participants from that state. Include states with 0 participants.
SELECT
    s.state_name,
    COUNT(p.id_number) AS participant_count
FROM
    states s
LEFT JOIN
    people p ON s.state_abbrev = p.state_code
GROUP BY
    s.state_name
ORDER BY
    participant_count DESC;

-- 36. Find the first_name of participants from the 'Mountain' region who are in the 'Angry Ants' team.
SELECT
    p.first_name
FROM
    people p
INNER JOIN
    states s ON p.state_code = s.state_abbrev
WHERE
    s.region = 'Mountain' AND p.team = 'Angry Ants';

-- 37. List the teams and the distinct regions their members come from.
SELECT
    p.team,
    s.region
FROM
    people p
INNER JOIN
    states s ON p.state_code = s.state_abbrev
GROUP BY
    p.team,
    s.region;

-- 38. Find the state with the highest total quiz_points.
SELECT
    s.state_name,
    SUM(p.quiz_points) AS total_score
FROM
    people p
INNER JOIN
    states s ON p.state_code = s.state_abbrev
GROUP BY
    s.state_name
ORDER BY
    total_score DESC
LIMIT 1;

-- 39. List the city and team for people who are from the 'New England' division and want a 'hat'.
SELECT
    p.city,
    p.team
FROM
    people p
INNER JOIN
    states s ON p.state_code = s.state_abbrev
WHERE
    s.division = 'New England' AND p.shirt_or_hat = 'hat';

-- 40. List all state_abbrev that do not have any participants.
SELECT
    s.state_abbrev
FROM
    states s
LEFT JOIN
    people p ON s.state_abbrev = p.state_code
WHERE
    p.id_number IS NULL;

---------------------------------------------------------------------------------------------------
-- V. Subqueries and Nested Queries (Questions 41-50)
---------------------------------------------------------------------------------------------------

-- 41. Find the first_name and last_name of participants whose quiz_points is higher than the overall average score.
SELECT
    first_name,
    last_name
FROM
    people
WHERE
    quiz_points > (
        SELECT AVG(quiz_points)
        FROM people
    );

-- 42. Find all details (*) of participants from the 'East North Central' division.
SELECT
    *
FROM
    people
WHERE
    state_code IN (
        SELECT state_abbrev
        FROM states
        WHERE division = 'East North Central'
    );

-- 43. List the team that has the highest maximum quiz_points.
SELECT
    team
FROM
    people
GROUP BY
    team
HAVING
    MAX(quiz_points) = (
        SELECT MAX(quiz_points)
        FROM people
    );

-- 44. Find the first_name of the participant with the lowest score who is under 25 years old.
SELECT
    first_name
FROM
    people
WHERE
    age < 25
ORDER BY
    quiz_points ASC
LIMIT 1;

-- 45. Find the states (state_abbrev) where the average quiz_points is higher than the average quiz_points in California ('CA').
SELECT
    state_code
FROM
    people
GROUP BY
    state_code
HAVING
    AVG(quiz_points) > (
        SELECT AVG(quiz_points)
        FROM people
        WHERE state_code = 'CA'
    );

-- 46. List the last_name of all participants who have the same quiz_points as 'Paul Schmidt'.
SELECT
    last_name
FROM
    people
WHERE
    quiz_points = (
        SELECT quiz_points
        FROM people
        WHERE first_name = 'Paul' AND last_name = 'Schmidt'
    )
    -- Exclude Paul Schmidt himself
    AND NOT (first_name = 'Paul' AND last_name = 'Schmidt');

-- 47. Find all company names that have members in more than 3 states.
SELECT
    company
FROM
    people
GROUP BY
    company
HAVING
    COUNT(DISTINCT state_code) > 3;

-- 48. Find the participants who are the oldest in their respective team.
SELECT
    p.first_name,
    p.team,
    p.age
FROM
    people p
WHERE
    p.age = (
        SELECT MAX(p2.age)
        FROM people p2
        WHERE p2.team = p.team
    );

-- 49. List the state_abbrev where the average age of participants is lower than the average age of all participants who want a 'hat'.
SELECT
    state_code
FROM
    people
GROUP BY
    state_code
HAVING
    AVG(age) < (
        SELECT AVG(age)
        FROM people
        WHERE shirt_or_hat = 'hat'
    );

-- 50. Find the first_name and last_name of participants whose signup date is the earliest overall.
SELECT
    first_name,
    last_name
FROM
    people
ORDER BY
    signup ASC
LIMIT 1;

---------------------------------------------------------------------------------------------------
-- VI. Conditional Logic and String Functions (Questions 51-60)
---------------------------------------------------------------------------------------------------

-- 51. Display a status: 'High Scorer' if quiz_points > 700, otherwise 'Regular'. Show name and status.
SELECT
    first_name,
    last_name,
    CASE
        WHEN quiz_points > 700 THEN 'High Scorer'
        ELSE 'Regular'
    END AS score_status
FROM
    people;

-- 52. Count the number of states whose state_name ends with 'a'.
SELECT
    COUNT(state_abbrev)
FROM
    states
WHERE
    state_name LIKE '%a';

-- 53. List the first_name, last_name, and the length of their last name.
SELECT
    first_name,
    last_name,
    LENGTH(last_name) AS last_name_length
FROM
    people
ORDER BY
    last_name_length DESC;

-- 54. Count the total number of participants, classifying them as 'Young' (Age <= 30) or 'Adult' (Age > 30).
SELECT
    CASE
        WHEN age <= 30 THEN 'Young'
        ELSE 'Adult'
    END AS age_group,
    COUNT(id_number) AS participant_count
FROM
    people
GROUP BY
    age_group;

-- 55. Find the first_name of people whose city name is at least 15 characters long.
SELECT
    first_name
FROM
    people
WHERE
    LENGTH(city) >= 15;

-- 56. Concatenate first_name and last_name with a space for all participants.
SELECT
    (first_name || ' ' || last_name) AS full_name
FROM
    people;

-- 57. List the state_name and classify its region as 'East Half' ('Northeast', 'South', 'Midwest') or 'West Half'.
SELECT
    state_name,
    CASE
        WHEN region IN ('Northeast', 'South', 'Midwest') THEN 'East Half'
        ELSE 'West Half'
    END AS national_half
FROM
    states;

-- 58. Find the names of participants whose last_name does not contain the letter 'o'.
SELECT
    first_name,
    last_name
FROM
    people
WHERE
    last_name NOT LIKE '%o%';

-- 59. For each team, get a simple rank based on their average quiz_points (highest average is rank 1).
-- NOTE: This is a simplified ranking and may not reflect true dense rank or window function output.
SELECT
    team,
    AVG(quiz_points) AS avg_score,
    (SELECT COUNT(DISTINCT team) FROM people WHERE team = p.team) AS team_rank_estimate
FROM
    people p
GROUP BY
    team
ORDER BY
    avg_score DESC;

-- 60. List the team and shirt_or_hat preference, displaying 'Apparel' if the value is 'shirt' or 'hat', otherwise 'Other'.
SELECT
    team,
    CASE
        WHEN shirt_or_hat IN ('shirt', 'hat') THEN 'Apparel'
        ELSE 'Other'
    END AS preference_category
FROM
    people;

---------------------------------------------------------------------------------------------------
-- VII. Date and Time Functions (Questions 61-70)
---------------------------------------------------------------------------------------------------

-- 61. Count how many participants signed up on '2021-01-25'.
SELECT
    COUNT(id_number) AS signups_on_jan_25
FROM
    people
WHERE
    signup = '2021-01-25';

-- 62. Find the first_name and last_name of those who signed up in the month of January (01).
SELECT
    first_name,
    last_name
FROM
    people
WHERE
    signup LIKE '2021-01%';

-- 63. Find the latest signup date in the people table.
SELECT
    MAX(signup) AS latest_signup_date
FROM
    people;

-- 64. List the number of participants who signed up on each distinct date.
SELECT
    signup,
    COUNT(id_number) AS signups_per_day
FROM
    people
GROUP BY
    signup
ORDER BY
    signup DESC;

-- 65. Find the participants who signed up exactly 7 days before the latest sign-up date. (Uses DATE math, typical for SQLite/MySQL)
SELECT
    first_name,
    last_name
FROM
    people
WHERE
    signup = (
        SELECT DATE(MAX(signup), '-7 day')
        FROM people
    );

-- 66. Count the number of teams that had at least 5 signups on the same day.
SELECT
    COUNT(DISTINCT team)
FROM
    people
GROUP BY
    team,
    signup
HAVING
    COUNT(id_number) >= 5;

-- 67. List the participants who signed up in the first week (days 01-07) of 2021.
SELECT
    first_name,
    last_name
FROM
    people
WHERE
    CAST(SUBSTR(signup, 9, 2) AS INTEGER) BETWEEN 1 AND 7 AND SUBSTR(signup, 1, 7) = '2021-01';

-- 68. Find the team that had the most total signups across all days.
SELECT
    team,
    COUNT(id_number) AS total_signups
FROM
    people
GROUP BY
    team
ORDER BY
    total_signups DESC
LIMIT 1;

-- 69. Calculate the average quiz_points for participants who signed up in the second half of the month (day 16 or later).
SELECT
    AVG(quiz_points)
FROM
    people
WHERE
    CAST(SUBSTR(signup, 9, 2) AS INTEGER) >= 16;

-- 70. Find the city that had the earliest signup date.
SELECT
    city
FROM
    people
ORDER BY
    signup ASC
LIMIT 1;

---------------------------------------------------------------------------------------------------
-- VIII. Advanced Filtering and Self-Joins (Questions 71-80)
---------------------------------------------------------------------------------------------------

-- 71. (Self-Join) Find all pairs of participants (showing their names) who share the same last_name but have different first_names.
SELECT
    p1.first_name AS name1_first,
    p1.last_name,
    p2.first_name AS name2_first
FROM
    people p1
JOIN
    people p2 ON p1.last_name = p2.last_name
    AND p1.id_number < p2.id_number; -- Prevents duplicates and comparing a person to themselves

-- 72. Find participants (first_name, last_name) who live in a state where the region is the 'South' AND their quiz_points is above 500.
SELECT
    p.first_name,
    p.last_name
FROM
    people p
INNER JOIN
    states s ON p.state_code = s.state_abbrev
WHERE
    s.region = 'South' AND p.quiz_points > 500;

-- 73. List the team that has the fewest number of participants.
SELECT
    team,
    COUNT(id_number) AS participant_count
FROM
    people
GROUP BY
    team
ORDER BY
    participant_count ASC
LIMIT 1;

-- 74. Find the names and quiz_points of participants who have a score greater than 800 and are NOT in the 'Cosmic Cobras' team.
SELECT
    first_name,
    last_name,
    quiz_points
FROM
    people
WHERE
    quiz_points > 800 AND team != 'Cosmic Cobras';

-- 75. List the first_name of participants who share a city with someone who wants a 'shirt'.
SELECT
    DISTINCT p1.first_name
FROM
    people p1
JOIN
    people p2 ON p1.city = p2.city
WHERE
    p2.shirt_or_hat = 'shirt';

-- 76. Find the top 5 largest cities (by participant count), showing the city name and the count.
SELECT
    city,
    COUNT(id_number) AS participant_count
FROM
    people
GROUP BY
    city
ORDER BY
    participant_count DESC
LIMIT 5;

-- 77. Find all teams that have an average score greater than the average score of all members of the 'Baffled Badgers' team.
SELECT
    team
FROM
    people
GROUP BY
    team
HAVING
    AVG(quiz_points) > (
        SELECT AVG(quiz_points)
        FROM people
        WHERE team = 'Baffled Badgers'
    );

-- 78. List the first_name and last_name of the participant whose score is closest to the overall median score of 500.
SELECT
    first_name,
    last_name
FROM
    people
ORDER BY
    ABS(quiz_points - 500) ASC
LIMIT 1;

-- 79. Find all company names that have participants in the 'Northeast' region.
SELECT
    DISTINCT p.company
FROM
    people p
INNER JOIN
    states s ON p.state_code = s.state_abbrev
WHERE
    s.region = 'Northeast';

-- 80. (Self-Join) Find all pairs of participants (name and team) where the two people are from the same team AND one wants a 'shirt' and the other wants a 'hat'.
SELECT
    p1.team,
    p1.first_name AS shirt_person,
    p2.first_name AS hat_person
FROM
    people p1
JOIN
    people p2 ON p1.team = p2.team
    AND p1.shirt_or_hat = 'shirt'
    AND p2.shirt_or_hat = 'hat'
    AND p1.id_number < p2.id_number;

---------------------------------------------------------------------------------------------------
-- IX. Complex Grouping and Filtering (Questions 81-90)
---------------------------------------------------------------------------------------------------

-- 81. Find the state_name and division that has the highest number of female participants (assuming first_name ending in 'a' is female - simplified heuristic).
SELECT
    s.state_name,
    s.division,
    COUNT(p.id_number) AS female_count
FROM
    people p
INNER JOIN
    states s ON p.state_code = s.state_abbrev
WHERE
    p.first_name LIKE '%a'
GROUP BY
    1, 2
ORDER BY
    female_count DESC
LIMIT 1;

-- 82. For each team, find the minimum quiz_points but only include teams where that minimum score is over 200.
SELECT
    team,
    MIN(quiz_points) AS min_score
FROM
    people
GROUP BY
    team
HAVING
    MIN(quiz_points) > 200;

-- 83. Find the team that has the most distinct city locations for its members.
SELECT
    team,
    COUNT(DISTINCT city) AS distinct_cities
FROM
    people
GROUP BY
    team
ORDER BY
    distinct_cities DESC
LIMIT 1;

-- 84. List the regions where the average age of participants is under 40.
SELECT
    s.region,
    AVG(p.age) AS avg_age
FROM
    people p
INNER JOIN
    states s ON p.state_code = s.state_abbrev
GROUP BY
    s.region
HAVING
    AVG(p.age) < 40;

-- 85. Find the total number of participants in each division that has at least one person with over 900 quiz_points.
SELECT
    s.division,
    COUNT(p.id_number) AS participant_count
FROM
    people p
INNER JOIN
    states s ON p.state_code = s.state_abbrev
GROUP BY
    s.division
HAVING
    MAX(p.quiz_points) > 900;

-- 86. Count the number of unique last_names where the quiz_points is an even number.
SELECT
    COUNT(DISTINCT last_name)
FROM
    people
WHERE
    quiz_points % 2 = 0;

-- 87. Find all citys that appear in more than one state (state_code).
SELECT
    city
FROM
    people
GROUP BY
    city
HAVING
    COUNT(DISTINCT state_code) > 1;

-- 88. List the state_name and the number of people who want a 'hat' in that state, ordered by the count descending.
SELECT
    s.state_name,
    COUNT(p.id_number) AS hat_count
FROM
    people p
INNER JOIN
    states s ON p.state_code = s.state_abbrev
WHERE
    p.shirt_or_hat = 'hat'
GROUP BY
    s.state_name
ORDER BY
    hat_count DESC;

-- 89. Find the state_abbrev where the range of quiz_points (Max - Min) is greater than 500.
SELECT
    state_code,
    (MAX(quiz_points) - MIN(quiz_points)) AS score_range
FROM
    people
GROUP BY
    state_code
HAVING
    score_range > 500;

-- 90. List the first_name and last_name of the youngest participant for each team who achieved a score over 500.
SELECT
    p.first_name,
    p.last_name,
    p.team,
    p.age
FROM
    people p
WHERE
    p.quiz_points > 500
    AND p.age = (
        SELECT MIN(p2.age)
        FROM people p2
        WHERE p2.team = p.team
        AND p2.quiz_points > 500
    );

---------------------------------------------------------------------------------------------------
-- X. Complex Multi-Level Queries (Questions 91-100)
---------------------------------------------------------------------------------------------------

-- 91. Find the first_name of participants who have a higher score than every other person in their state.
SELECT
    p1.first_name
FROM
    people p1
WHERE
    p1.quiz_points = (
        SELECT MAX(p2.quiz_points)
        FROM people p2
        WHERE p2.state_code = p1.state_code
    );

-- 92. List the state_name and the number of unique teams represented in that state.
SELECT
    s.state_name,
    COUNT(DISTINCT p.team) AS unique_teams
FROM
    people p
INNER JOIN
    states s ON p.state_code = s.state_abbrev
GROUP BY
    s.state_name
ORDER BY
    unique_teams DESC;

-- 93. Find the company name with the highest overall average age of its employees/participants.
SELECT
    company,
    AVG(age) AS avg_age
FROM
    people
GROUP BY
    company
ORDER BY
    avg_age DESC
LIMIT 1;

-- 94. Find the first_name and last_name of participants who have a quiz_points score within 10% of their team's maximum score.
SELECT
    p.first_name,
    p.last_name
FROM
    people p
INNER JOIN
    (
        SELECT team, MAX(quiz_points) AS max_score
        FROM people
        GROUP BY team
    ) AS team_max ON p.team = team_max.team
WHERE
    p.quiz_points >= team_max.max_score * 0.9;

-- 95. List the team and the minimum age of a person on that team that scored over 650 points.
SELECT
    team,
    MIN(age) AS min_age_high_scorer
FROM
    people
WHERE
    quiz_points > 650
GROUP BY
    team
HAVING
    MIN(age) IS NOT NULL;

-- 96. Identify the state_abbrev in the 'South Atlantic' division that has the lowest total quiz_points.
SELECT
    p.state_code,
    SUM(p.quiz_points) AS total_points
FROM
    people p
INNER JOIN
    states s ON p.state_code = s.state_abbrev
WHERE
    s.division = 'South Atlantic'
GROUP BY
    p.state_code
ORDER BY
    total_points ASC
LIMIT 1;

-- 97. Find all details of participants who have an 'Angry Ants' teammate that is older than them, and they both want a 'hat'.
SELECT
    p1.*
FROM
    people p1
JOIN
    people p2 ON p1.team = p2.team
    AND p1.team = 'Angry Ants'
    AND p1.age < p2.age
    AND p1.shirt_or_hat = 'hat'
    AND p2.shirt_or_hat = 'hat';

-- 98. List the name of the division with the most unique last names among its participants.
SELECT
    s.division,
    COUNT(DISTINCT p.last_name) AS unique_last_names
FROM
    people p
INNER JOIN
    states s ON p.state_code = s.state_abbrev
GROUP BY
    s.division
ORDER BY
    unique_last_names DESC
LIMIT 1;

-- 99. Find all pairs of states (e.g., 'CA' and 'NY') that share the same region but have different divisions.
SELECT
    s1.state_abbrev AS state1,
    s2.state_abbrev AS state2,
    s1.region
FROM
    states s1
JOIN
    states s2 ON s1.region = s2.region
    AND s1.division != s2.division
    AND s1.state_abbrev < s2.state_abbrev; -- Ensures unique pairs

-- 100. List the city and state_code where the total score is over 1000 AND the average age is under 30.
SELECT
    city,
    state_code,
    SUM(quiz_points) AS total_score,
    AVG(age) AS average_age
FROM
    people
GROUP BY
    city,
    state_code
HAVING
    SUM(quiz_points) > 1000 AND AVG(age) < 30;