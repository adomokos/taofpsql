\c f1db;

with counts as
(
  select date_trunc('year', date) as year,
    count(*) filter (where position is null) as outs,
    bool_and(position is null) never_finished
  from drivers
    join results using(driver_id)
    join races using(race_id)
  group by date_trunc('year', date), driver_id
)
select
  extract(year from year) as season,
  sum(outs) as "#times any driver didn't finish a race"
from counts
where never_finished
group by season
order by sum(outs) desc
limit 5;
