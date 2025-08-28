-- switch to an appropriate role 
USE ROLE sysadmin;


-- set up database for dlt csv data ingestion
CREATE DATABASE IF NOT EXISTS MOVIES;

-- staging layer is a landing zone where data is loaded 
CREATE SCHEMA IF NOT EXISTS MOVIES.STAGING; -- this is fully qualified object name
-- but CREATE SCHEMA staging; will create the schema in the current database
