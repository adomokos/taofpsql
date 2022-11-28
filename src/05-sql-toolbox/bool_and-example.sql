\c f1db;

with counts as
(
  select
    driver_id,
    forename,
    surname,
    count(*) as races,
    bool_and(position is null) as never_finished
  from drivers
  join results using(driver_id)
  join races using(race_id)
  group by driver_id
)
select
  driver_id,
  forename,
  surname,
  races
from counts
where never_finished
order by races desc;
