\c f1db;

with decades as
(
  select extract('year' from date_trunc('decade', date)) as decade
  from races
  group by decade
)
select
  decade,
  rank() over(partition by decade order by wins desc) as rank,
  forename,
  surname,
  wins
from decades
  left join lateral
  (
    select code, forename, surname, count(*) as wins
    from drivers
    join results
      on results.driver_id = drivers.driver_id
     and results.position = 1
    join races using(race_id)
    where extract('year' from date_trunc('decade', races.date))
      = decades.decade
    group by decades.decade, drivers.driver_id
    order by wins desc
    limit 3
  ) as winners on true
order by decades asc, wins desc;
