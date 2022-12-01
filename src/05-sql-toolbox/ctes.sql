\c f1db;

with points as (
  select
    year as season, driver_id, constructor_id,
    sum(points) as points
  from results join races using(race_id)
  group by grouping sets((year, driver_id),
                         (year, constructor_id))
  having sum(points) > 0
  order by season, points desc
),
tops as (
  select season,
    max(points) filter(where driver_id is null) as ctops,
    max(points) filter(where constructor_id is null) as dtops
  from points
  group by season
  order by season, dtops, ctops
),
champs as (
  select
    tops.season,
    champ_driver.driver_id,
    champ_driver.points,
    champ_constructor.constructor_id,
    champ_constructor.points
  from tops
    join points as champ_driver
      on champ_driver.season = tops.season
     and champ_driver.constructor_id is null
     and champ_driver.points = tops.dtops

    join points as champ_constructor
      on champ_constructor.season = tops.season
     and champ_constructor.driver_id is null
     and champ_constructor.points = tops.ctops
)
select
  season,
  format('%s %s', drivers.forename, drivers.surname) as "Driver's Champion",
  constructors.name as "Constructor's champion"
from champs
  join drivers using(driver_id)
  join constructors using(constructor_id)
order by season;

