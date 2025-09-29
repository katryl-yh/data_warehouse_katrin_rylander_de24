# Snowflake Environment Summary (jobmarket-hr-analytics)

This document summarizes the Snowflake setup defined in the `snowflake_worksheets` folder: databases, schemas, warehouses, roles, users, and privileges.

Source files:
- `00_reset.snowsql`
- `01_roles.snowsql`
- `02_warehouse.snowsql`
- `03_create_user_admin.snowsql.example`
- `04_grants_admin.snowsql`
- `05_database_schema.snowsql`
- `06_grants.snowsql`
- `07_create_users_services.snowsql.example`
- `08_grants_services.snowsql`

## Database and Schema Structure

- Database: `job_ads` (comment: "jobmarket-hr-analytics data platform")
  - Schemas:
    - `staging` — unprocessed job ad data from external jobsearch API
    - `warehouse` — cleaned and transformed data for analytics
    - `marts` — business-ready datasets for reporting and analysis

Notes:
- The role that creates these objects (`admin_job_ads`) implicitly owns them upon creation.

## Warehouse Setup

- Warehouse: `compute_wh`
  - Size: `x-small`
  - `auto_suspend`: 300 seconds
  - `auto_resume`: true
  - `initially_suspended`: true
  - `statement_timeout_in_seconds`: 1800
  - Comment: "jobmarket-hr-analytics wh"

## Roles Setup

Created roles:
- `admin_job_ads` — administrative role for this environment
- `pipeline_operator` — orchestration parent role
- `ingestion_writer` — writes ingestion outputs (primarily into `staging`)
- `transformation_runner` — runs transformations (writes into `warehouse` and `marts`)
- `analytics_reader` — read-only analytics access (to `warehouse` and `marts`)

Grants between roles (hierarchy):
- `admin_job_ads` granted to role `ACCOUNTADMIN` (so `ACCOUNTADMIN` inherits `admin_job_ads`)
- `pipeline_operator` granted to role `admin_job_ads`
- `ingestion_writer`, `transformation_runner`, `analytics_reader` granted to role `pipeline_operator`

## Users Setup

From user creation and grants scripts:

| User                 | Default Role           | Default Warehouse | Directly Granted Roles     | Notes |
|----------------------|------------------------|-------------------|----------------------------|-------|
| `anon_engineer`      | `admin_job_ads`        | `compute_wh`      | `admin_job_ads`, `PUBLIC`  | Admin persona |
| `svc_dlt_ingestion`  | `ingestion_writer`     | `compute_wh`      | `ingestion_writer`         | Service: ingestion |
| `svc_dbt_transform`  | `transformation_runner`| `compute_wh`      | `transformation_runner`    | Service: dbt transforms |
| `svc_analytics_read` | `analytics_reader`     | `compute_wh`      | `analytics_reader`         | Service: analytics reads |

## User-Role Dependency Table

Direct assignments only (excludes inherited roles):

| User                 | Role                   |
|----------------------|------------------------|
| `anon_engineer`      | `admin_job_ads`        |
| `anon_engineer`      | `PUBLIC`               |
| `svc_dlt_ingestion`  | `ingestion_writer`     |
| `svc_dbt_transform`  | `transformation_runner`|
| `svc_analytics_read` | `analytics_reader`     |

## Role Hierarchy

Diagram (parent inherits from child role when "GRANT ROLE child TO ROLE parent"):

```
ACCOUNTADMIN
└─ admin_job_ads
   └─ pipeline_operator
      ├─ ingestion_writer
      ├─ transformation_runner
      └─ analytics_reader
```

Parent-child mapping table:

| Parent Role          | Child Role             |
|----------------------|------------------------|
| `ACCOUNTADMIN`       | `admin_job_ads`        |
| `admin_job_ads`      | `pipeline_operator`    |
| `pipeline_operator`  | `ingestion_writer`     |
| `pipeline_operator`  | `transformation_runner`|
| `pipeline_operator`  | `analytics_reader`     |

## Database Privilege Table

Explicit database-level grants plus implied ownership for creator role:

| Role                   | Database  | Privileges                                 | Source |
|------------------------|-----------|--------------------------------------------|--------|
| `admin_job_ads`        | `job_ads` | OWNERSHIP (implicit, creator)              | 05, implicit |
| `pipeline_operator`    | `job_ads` | USAGE                                      | 06 |
| `ingestion_writer`     | `job_ads` | USAGE, CREATE SCHEMA                       | 06 |
| `transformation_runner`| `job_ads` | USAGE                                      | 06 |
| `analytics_reader`     | `job_ads` | USAGE                                      | 06 |

Legend: Source references point to script numbers, e.g., 05 = `05_database_schema.snowsql`, 06 = `06_grants.snowsql`.

## Role-Schema Privilege Table

Schema-level and table-level grants (including future grants):

| Role                   | Schema     | Schema Privileges | Table Privileges                | Future Table Privileges | Source |
|------------------------|------------|-------------------|----------------------------------|-------------------------|--------|
| `admin_job_ads`        | all created| OWNERSHIP         | ALL (as owner)                   | n/a                     | 05, implicit |
| `ingestion_writer`     | `staging`  | ALL               | ALL on ALL tables                | ALL on FUTURE tables    | 06 |
| `transformation_runner`| `staging`  | USAGE             | SELECT on ALL tables             | SELECT on FUTURE tables | 06 |
| `transformation_runner`| `warehouse`| ALL               | ALL on ALL tables                | ALL on FUTURE tables    | 06 |
| `transformation_runner`| `marts`    | ALL               | ALL on ALL tables                | ALL on FUTURE tables    | 06 |
| `analytics_reader`     | `warehouse`| USAGE             | SELECT on ALL tables             | SELECT on FUTURE tables | 06 |
| `analytics_reader`     | `marts`    | USAGE             | SELECT on ALL tables             | SELECT on FUTURE tables | 06 |

Note: `pipeline_operator` inherits the privileges of `ingestion_writer`, `transformation_runner`, and `analytics_reader` via role hierarchy.

## Warehouse Privilege Table

Warehouse-level grants on `compute_wh`:

| Role                | Warehouse   | Privileges                      | Source |
|---------------------|-------------|----------------------------------|--------|
| `admin_job_ads`     | `compute_wh`| USAGE, OPERATE, MONITOR         | 04 |
| `pipeline_operator` | `compute_wh`| USAGE                           | 06 |
| `ingestion_writer`  | `compute_wh`| USAGE                           | 06 |
| `transformation_runner` | `compute_wh`| USAGE                        | 06 |
| `analytics_reader`  | `compute_wh`| USAGE                           | 06 |

## Additional Notes

- Account-level: `admin_job_ads` has `CREATE DATABASE` on the account (04), enabling creation of `job_ads` and future databases if desired.
- Ownership: The role executing object creation owns those objects and can perform all operations; this is captured as implicit ownership above.
- Role inheritance: Effective permissions for `pipeline_operator` include the union of `ingestion_writer`, `transformation_runner`, and `analytics_reader`.
- Defaults: All service users default to `compute_wh` and their respective roles for least-privilege adherence.

---

Change history: generated from the SQL worksheets as of the current repository state.
