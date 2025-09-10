-- Dimension: Auxilliary Attributes
-- Grain: one row per auxilliary_attributes_id

with src as (
	select * from {{ ref('src_auxilliary_attributes') }}
	where auxilliary_attributes_id is not null
)

select
	auxilliary_attributes_id,
	experience_required,
	driving_license_required as driver_license,
	access_to_own_car
from src
qualify row_number() over (
	partition by auxilliary_attributes_id
	order by auxilliary_attributes_id
) = 1
