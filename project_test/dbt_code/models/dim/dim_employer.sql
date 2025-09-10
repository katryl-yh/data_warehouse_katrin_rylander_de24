-- Dimension: Employer
-- Grain: one row per employer_id (hash of org number, name, workplace)

with src as (
	select * from {{ ref('src_employer') }}
)

select
	employer_id,
	employer_organization_number,
	employer_name,
	employer_workplace,
	workplace_street_address,
	workplace_region,
	workplace_postcode,
	workplace_city,
	workplace_country,
	current_timestamp() as record_loaded_at
from src
-- src_employer is already distinct; qualify retained as safety
qualify row_number() over (partition by employer_id order by employer_id) = 1
