\c f1db;

select
  lap,
  drivers.code,
  position,
  milliseconds * interval '1ms' as laptime
from lap_times
join drivers using(driver_id)
where race_id = 972
order by lap, position
fetch first 3 rows only;

-- next "page"
select
  lap,
  drivers.code,
  position,
  milliseconds * interval '1ms' as laptime
from lap_times
join drivers using(driver_id)
where race_id = 972
  and row(lap, position) > (1, 3)
order by lap, position
fetch first 3 rows only;
