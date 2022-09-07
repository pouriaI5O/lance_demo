
with cte as (select status,start_time,end_time          
from {{ ref('int1')}} 
where status='Use'),

cte1 as (select min(start_time) as start_time,max(end_time) as end_time,0 as cycle_id ,(select count(*) from cte ) as use_count
                from cte),
cte2 as (select cycle_id,use_count,start_time,end_time,
       DATEDIFF(second,start_time,end_time)/60 as total_minute,DATE(start_time) as date,'in-progress' as status  from cte1 )

select * from cte2

                

