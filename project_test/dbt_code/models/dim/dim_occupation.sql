-- Dimension: Occupation
-- Grain: one row per occupation (occupation label)
-- Required columns:
--   occupation_id (pk)
--   occupation (not null)
--   occupation_group (not null)
--   occupation_field (not null)

with src as (
    select * from {{ ref('src_occupation') }}
    where occupation_label is not null
)

select
    occupation_label as occupation,
    md5(coalesce(lower(trim(occupation_label)), '')) as occupation_id,
    max(occupation_group) as occupation_group,
    max(occupation_field) as occupation_field
from src
group by occupation_label
