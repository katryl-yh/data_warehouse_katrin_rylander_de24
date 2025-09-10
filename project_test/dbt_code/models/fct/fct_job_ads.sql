-- this is an extract of the model

with 
job_ads as (
    select * from {{ ref('src_job_ads') }}
),

job_details as (
    select * from {{ ref('src_job_details') }}
),

employer as (
    select * from {{ ref('src_employer') }}
),

auxilliary as (
    select * from {{ ref('src_auxilliary_attributes') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['occupation__label']) }} as occupation_id,
    job_details.job_details_id,
    employer.employer_id,
    auxilliary.auxilliary_attributes_id,
    job_ads.vacancies,
    job_ads.relevance,
    job_ads.application_deadline
from job_ads
left join job_details  
    on job_details.job_details_id = job_ads.job_details_id
left join employer 
    on employer.employer_id = job_ads.employer_id
left join auxilliary 
    on auxilliary.auxilliary_attributes_id = job_ads.auxilliary_attributes_id
