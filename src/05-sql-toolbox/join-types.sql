\c f1db;

select
  results.position_order as position,
  drivers.code,
  count(behind.*) as behind

from results
join drivers using(driver_id)

left join results behind
  on results.race_id = behind.race_id
  and results.position_order < behind.position_order

where results.race_id = 972
  and results.position_order <= 3

group by results.position_order, drivers.code
order by results.position_order;
