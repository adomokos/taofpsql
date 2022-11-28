\c f1db;

select
  drivers.code,
  drivers.surname,
  position,
  laps,
  status
from results
  join drivers using(driver_id)
  join status using(status_id)
where race_id = 972
order by position nulls last,
  laps desc,
  case when status = 'Power Unit'
    then 1
    else 2
  end;
