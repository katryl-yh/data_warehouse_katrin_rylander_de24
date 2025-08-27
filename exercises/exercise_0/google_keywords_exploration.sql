-- a) Use this database and find out:
-- the underlying schemas, 
-- tables 
-- and views to get an overview of its logical structure.

SHOW SCHEMAS IN DATABASE google_keywords_search_dataset__discover_all_searches_on_google;
SHOW TABLES IN SCHEMA google_keywords_search_dataset__discover_all_searches_on_google.datafeeds;
SHOW VIEWS IN SCHEMA google_keywords_search_dataset__discover_all_searches_on_google.information_schema;

-- b) Find out the columns and its data types in the table `GOOGLE_KEYWORDS`.
SHOW COLUMNS IN TABLE google_keywords_search_dataset__discover_all_searches_on_google.datafeeds.GOOGLE_KEYWORDS;