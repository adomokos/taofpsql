\c f1db;

select
  extract(year from races.date) as season,
  count(*) filter(where status = 'Accident') as accidents
from results
join status using(status_id)
join races using(race_id)
group by season
order by accidents desc
limit 5;
