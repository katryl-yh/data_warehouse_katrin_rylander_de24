with stg_job_ads as (select * from {{ source('job_ads', 'stg_ads') }})

select
    ID as job_details_id,
    HEADLINE as headline,
    DESCRIPTION__TEXT as description,
    DESCRIPTION__TEXT_FORMATTED as description_html_formatted,
    EMPLOYMENT_TYPE__LABEL as employment_type,
    DURATION__LABEL as duration,
    SALARY_TYPE__LABEL as salary_type,
    SCOPE_OF_WORK__MIN as scope_of_work_min,
    SCOPE_OF_WORK__MAX as scope_of_work_max

   
from stg_job_ads 