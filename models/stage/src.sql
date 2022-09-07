with cte as (select action as status,start_time,end_time,
          DATE(start_time) as date,
          duration as total_minute                    
FROM {{ source('public','lance_demo') }} order by start_time asc),

cte1 as (select status,total_minute,start_time,end_time, date, ROW_NUMBER() OVER(ORDER BY start_time ASC) AS Row
 from cte),
cte2 as (select status,total_minute,start_time,end_time,Row,date,
  case
  when lag(status,1)over(order by Row)='Use' and status='Change' then 'true' else 'false'
  end as condition from cte1 order by start_time asc),

  cte3 as (select *,(condition+Row)as id from cte2)
          
select count(*) as cn ,date from cte3 where condition ='true' group by date  order by date asc
