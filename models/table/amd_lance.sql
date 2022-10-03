{{ config(
    materialized='table'
)}}
select * from {{ ref('union4')}} 