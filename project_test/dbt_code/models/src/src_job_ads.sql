-- Base job ad attributes + FK hashes.
-- Adds job_details_id, employer_id, auxilliary_attributes_id for joins.
-- so downstream fact model can join to dimension/source models.

with stg_job_ads as (
    select * from {{ source('job_ads', 'stg_ads') }}
)

select
    occupation__label,
    number_of_vacancies as vacancies,
    relevance,
    application_deadline,
    id as job_details_id,
    md5(
        coalesce(cast(employer__organization_number as varchar), '')
        || '|' || coalesce(employer__name, '')
        || '|' || coalesce(employer__workplace, '')
    ) as employer_id,
    md5(
        coalesce(cast(experience_required as varchar), '')
        || '|' || coalesce(cast(driving_license_required as varchar), '')
        || '|' || coalesce(cast(access_to_own_car as varchar), '')
    ) as auxilliary_attributes_id

from stg_job_ads

-- no order by
