{{ config(
    materialized='table'
)}}
SELECT cycle_id,use_count,start_time,end_time,total_minute,date,'done' as "status",'America/New_York' as "time_zone" 
              FROM {{ ref('int2used')}} 
UNION 
            
SELECT cycle_id,use_count,start_time,end_time,total_minute,date,'in-progress' as "status" ,'America/New_York' as "time_zone"                 
            FROM {{ ref('int3progress')}}
