\c f1db;

\set beginning '2017-04-01'
\set months 3

select
  date,
  name,
  drivers.surname as winner
from races
left join results
  on results.race_id = races.race_id
  and results.position = 1
left join drivers using(driver_id)
where date >= date :'beginning'
  and date < date :'beginning'
  + :months * interval '1 month';
