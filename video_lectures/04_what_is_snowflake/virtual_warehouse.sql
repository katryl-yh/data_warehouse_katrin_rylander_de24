SHOW WAREHOUSES;

CREATE WAREHOUSE IF NOT EXISTS demo_warehouse
    WITH 
    WAREHOUSE_SIZE = 'XSMALL' 
    AUTO_SUSPEND = 300  -- it will auto suspend after 5 minutes
    AUTO_RESUME = TRUE 
    INITIALLY_SUSPENDED = TRUE
    COMMENT = 'Demo warehouse created through a worksheet';

SHOW WAREHOUSES;

-- DDL operation: ALTER to modify compute resources (warehouses) and database objects
ALTER WAREHOUSE demo_warehouse
    SET AUTO_SUSPEND = 60;  -- change to 1 minute to decrease costs

ALTER WAREHOUSE demo_warehouse
    SET MAX_CLUSTER_COUNT = 3;

DROP WAREHOUSE demo_warehouse;

SHOW WAREHOUSES;