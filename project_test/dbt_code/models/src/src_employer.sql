with stg_job_ads as (

    select * 
    from {{ source('job_ads', 'stg_ads') }}

)

select distinct
    {{ dbt_utils.generate_surrogate_key([
        'EMPLOYER__ORGANIZATION_NUMBER',
        'EMPLOYER__NAME',
        'EMPLOYER__WORKPLACE'
    ]) }} as employer_id,

    EMPLOYER__NAME as employer_name,
    EMPLOYER__WORKPLACE as employer_workplace,
    EMPLOYER__ORGANIZATION_NUMBER as employer_organization_number,

    WORKPLACE_ADDRESS__STREET_ADDRESS as workplace_street_address,
    WORKPLACE_ADDRESS__REGION as workplace_region,
    WORKPLACE_ADDRESS__POSTCODE as workplace_postcode,
    WORKPLACE_ADDRESS__CITY as workplace_city,
    WORKPLACE_ADDRESS__COUNTRY as workplace_country

from stg_job_ads
where EMPLOYER__NAME is not null
  or EMPLOYER__ORGANIZATION_NUMBER is not null
  or EMPLOYER__WORKPLACE is not null
 
