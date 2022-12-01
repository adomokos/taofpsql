\c f1db;

(
  select
    race_id,
    'driver' as type,
    format('%s %s', drivers.forename, drivers.surname) as name,
    driver_standings.points
  from driver_standings
  join drivers using(driver_id)
  where race_id = 972
    and points > 0
)
union all
/*
  We use `union all`, as we know the way the queries are built,
  and we know there are no duplicates in the resultsets
*/
(
  select
    race_id,
    'constructor' as type,
    constructors.name as name,
    constructor_standings.points
  from constructor_standings
    join constructors using(constructor_id)
  where race_id = 972
    and points > 0
)
order by points desc;
