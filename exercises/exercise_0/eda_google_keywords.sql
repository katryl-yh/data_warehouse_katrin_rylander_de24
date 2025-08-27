--  c) Find out number of rows in the dataset.
SELECT COUNT(*) AS total_rows
FROM google_keywords_search_dataset__discover_all_searches_on_google.datafeeds.GOOGLE_KEYWORDS;

-- 35046855

-- d) When is the first search and when is the latest search in the dataset?
SELECT * FROM google_keywords_search_dataset__discover_all_searches_on_google.datafeeds.GOOGLE_KEYWORDS
LIMIT 5;
    
SELECT 
    MIN(date) AS first_search_date,
    MAX(date) AS latest_search_date
FROM google_keywords_search_dataset__discover_all_searches_on_google.datafeeds.GOOGLE_KEYWORDS;

-- FIRST_SEARCH_DATE: 22-06-01
-- LATEST_SEARCH_DATE: 22-06-30

-- e) Which are the 10 most popular keywords?
SELECT keyword, COUNT(*) AS search_count
FROM google_keywords_search_dataset__discover_all_searches_on_google.datafeeds.GOOGLE_KEYWORDS
GROUP BY keyword
ORDER BY search_count DESC
LIMIT 10;

-- 1. gmail, 2. youtube, 3. facebook, 4. google, 5. amazon, 6. google drive, 7. canva, 8. instagram, 9. netflix, 10. roblox

-- f) How many unique keywords are there?
SELECT COUNT(DISTINCT keyword) AS unique_keywords
FROM google_keywords_search_dataset__discover_all_searches_on_google.datafeeds.GOOGLE_KEYWORDS;

-- UNIQUE_KEYWORDS: 7263686

--  g) Check what type of platforms are used and how many users per platform

SELECT DISTINCT platform
FROM google_keywords_search_dataset__discover_all_searches_on_google.datafeeds.GOOGLE_KEYWORDS;

SELECT platform, SUM(calibrated_users) AS user_count
FROM google_keywords_search_dataset__discover_all_searches_on_google.datafeeds.GOOGLE_KEYWORDS
GROUP BY platform
ORDER BY user_count DESC;

-- same for SITE

SELECT site, SUM(calibrated_users) AS user_count
FROM google_keywords_search_dataset__discover_all_searches_on_google.datafeeds.GOOGLE_KEYWORDS
GROUP BY site
ORDER BY user_count DESC
LIMIT 10;

-- h) Let's dive into what swedish people are searching. 
-- Country code for Sweden:752
--  Find the 20 most popular keywords and the number of searches of that keyword.
SELECT keyword, COUNT(*) AS search_count
FROM google_keywords_search_dataset__discover_all_searches_on_google.datafeeds.GOOGLE_KEYWORDS
WHERE country= '752'
GROUP BY keyword
ORDER BY search_count DESC
LIMIT 20;

-- users
SELECT keyword, SUM(calibrated_users) AS user_count
FROM google_keywords_search_dataset__discover_all_searches_on_google.datafeeds.GOOGLE_KEYWORDS
WHERE country= '752'
GROUP BY keyword
ORDER BY user_count DESC
LIMIT 20;

--   i) Lets see how popular spotify is around the world. 
--List the top 10 number countries and the number of searches for spotify.
SELECT country, SUM(calibrated_users) AS user_count
FROM google_keywords_search_dataset__discover_all_searches_on_google.datafeeds.GOOGLE_KEYWORDS
WHERE keyword = 'spotify'
GROUP BY country
ORDER BY user_count DESC
LIMIT 10;
