{{
  config(
    materialized = 'table',
    )
}}

with fct_reviews as (
    select * from {{ ref('fct_reviews') }}
),
full_moon_dates as (
    select * from {{ ref('seed_full_moon_dates') }}
)

select 
    r.*,
    Case when fm.full_moon_date IS NULL THEN 'not full moon'
    else 'full moon'
    end as is_full_moon
FROM
fct_reviews r
left join seed_full_moon_dates fm
on (TO_DATE(r.review_date) = DATEADD(DAY,1, fm.full_moon_date))