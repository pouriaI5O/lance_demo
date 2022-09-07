{{ config(materialized='ephemeral') }}
SELECT cycle_id,use_count,start_time,end_time,total_minute,date,status                 
            FROM {{ ref('int3progress')}}
UNION 
             SELECT cycle_id,use_count,start_time,end_time,total_minute,date,status
              FROM {{ ref('int2used')}} 