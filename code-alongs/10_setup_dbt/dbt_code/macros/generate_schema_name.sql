{% macro generate_schema_name(custom_schema_name, node) -%} -- this macro is like creating a function

    {%- set default_schema = target.schema -%} -- is the default schema the same as defined in the profiles.yml file, staging is our case
    {%- if custom_schema_name is none -%} -- if no custom schema name is provided, use the default schema, but in our case custom is staging/warehous or marts, depending on the mdel used

        {{ default_schema }} -- if you do not specify, use the default schema: staging

    {%- else -%}

        {{ custom_schema_name | trim }} -- the original file from dbt would create staging_staging OR staging_warehouse, or staging_marts, depending on the model used. But we want to use just staging, warehouse or marts, so we trim the default schema away
    {%- endif -%}

{%- endmacro %}