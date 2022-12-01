\c f1db;

select
  surname,
  constructors.name,
  position,
  format('%s / %s',
    row_number()
      over(partition by constructor_id
           order by position nulls last),
      count(*) over(partition by constructor_id)
  )
  as "pos same constr"
from results
join drivers using(driver_id)
join constructors using(constructor_id)
where race_id = 890
order by position;
