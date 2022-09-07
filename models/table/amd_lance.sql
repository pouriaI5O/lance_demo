{{ config(
    materialized='table'
)}}
select * ,'America/New_York' as time_zone FROM {{ ref('union4')}}