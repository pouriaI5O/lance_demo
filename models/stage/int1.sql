with cte as (select *,row_number() over (order by start_time asc)as id  FROM {{ source('public','lance_demo') }}),

cte1 as 
( select TOP 1  id as change
FROM cte
WHERE action= 'Change'
ORDER BY id DESC
),
cte2 as (
select*,(select TOP 1  id
FROM cte
WHERE action= 'Change'
ORDER BY id DESC) as change ,case when id < change AND action = 'Use' then 'done' else action
END as status from cte order by start_time desc)
select * from cte2



