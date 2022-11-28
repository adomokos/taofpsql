\c f1db;

select
  drivers.surname as driver,
  constructors.name as constructor,
  sum(points) as points
from results
join races using (race_id)
join drivers using(driver_id)
join constructors using(constructor_id)
where drivers.surname in ('Prost', 'Senna')
group by rollup(drivers.surname, constructors.name);
