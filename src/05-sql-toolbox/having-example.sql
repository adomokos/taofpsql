\c f1db;
\set season 'date ''1978-01-01'''

select
  status,
  count(*)
from results
  join races using(race_id)
  join status using(status_id)
where date >= :season
  and date < :season + interval '1 year'
  and position is null
group by status
having count(*) >= 10
order by count(*) desc;
