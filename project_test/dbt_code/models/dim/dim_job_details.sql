-- Dimension: Job Details
-- Grain: 1 row per job_details_id
-- Required columns defined by target spec.

with src as (
	select * from {{ ref('src_job_details') }}
	where job_details_id is not null
)

select
	job_details_id,
	headline,
	description,
	description_html_formatted,
	employment_type,
	duration,
	salary_type,
	scope_of_work_min,
	scope_of_work_max
from src
qualify row_number() over (
	partition by job_details_id
	order by job_details_id
) = 1
