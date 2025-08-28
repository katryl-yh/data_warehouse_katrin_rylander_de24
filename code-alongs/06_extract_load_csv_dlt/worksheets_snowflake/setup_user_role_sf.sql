-- switch to an apropriate role to create dlt user and dlt role 
USE ROLE USERADMIN;

-- create dlt user
CREATE USER IF NOT EXISTS extract_loader
    PASSWORD='a123' -- create a password and fill in here
    DEFAULT_WAREHOUSE = COMPUTE_WH;

-- create dlt role
CREATE ROLE IF NOT EXISTS movies_dlt_role;

-- switch to an appropriate role
USE ROLE SECURITYADMIN;

-- grant role to user
GRANT ROLE movies_dlt_role TO USER extract_loader;

-- grant privileges to role
-- this role needs to use warehouse, db and schema
GRANT USAGE ON WAREHOUSE COMPUTE_WH TO ROLE movies_dlt_role;
GRANT USAGE ON DATABASE MOVIES TO ROLE movies_dlt_role;
GRANT USAGE ON SCHEMA MOVIES.STAGING TO ROLE movies_dlt_role;

-- this role needs some special privileges for the db and schema
GRANT CREATE TABLE ON SCHEMA MOVIES.STAGING TO ROLE movies_dlt_role;
GRANT INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA MOVIES.STAGING TO ROLE movies_dlt_role;
GRANT INSERT, UPDATE, DELETE ON FUTURE TABLES IN SCHEMA MOVIES.STAGING TO ROLE movies_dlt_role;

-- check grants
SHOW GRANTS ON SCHEMA movies.staging;
SHOW FUTURE GRANTS IN SCHEMA movies.staging;
SHOW GRANTS TO ROLE movies_dlt_role;
SHOW GRANTS TO USER extract_loader;