with stg_job_ads as (

    select * 
    from {{ source('job_ads', 'stg_ads') }}

)

select distinct
    {{ dbt_utils.generate_surrogate_key([
        'EXPERIENCE_REQUIRED',
        'DRIVING_LICENSE_REQUIRED',
        'ACCESS_TO_OWN_CAR'
    ]) }} as auxilliary_attributes_id,

    EXPERIENCE_REQUIRED as experience_required,
    DRIVING_LICENSE_REQUIRED as driving_license_required,
    ACCESS_TO_OWN_CAR as access_to_own_car

from stg_job_ads
