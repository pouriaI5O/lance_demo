
with cte as (select status,start_time,end_time,
             duration as total_minute                    
from {{ ref('int1')}}),

cte1 as ( select row_number() over (order by start_time asc)as cycle,start_time
,lead(start_time,1) over (order by start_time asc) as end_before from cte where status='Change'),

cte2 as (
select cycle,count(*) as count_b,max(end_before) as end_time,min(cte.start_time) as start_time
from cte1 inner join cte on cte1.start_time<=cte.start_time and cte1.end_before>=cte.end_time
where cte.status='done'
group by cycle),

cte3 as (select cycle as cycle_id,count_b as use_count,start_time,end_time,
       DATEDIFF(second,start_time,end_time)/60 as total_minute,DATE(start_time) as date from cte2 order by cycle asc)
select *,'done' as status from cte3
