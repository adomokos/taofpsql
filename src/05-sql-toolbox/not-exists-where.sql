\c f1db;

\set season 'date ''1978-01-01'''

select
  forename,
  surname,
  constructors.name as contructor,
  count(*) as races,
  count(distinct status) as reasons
from drivers
join results using(driver_id)
join races using(race_id)
join status using(status_id)
join constructors using(constructor_id)
where date >= :season
  and date < :season + interval '1 year'
  and not exists (
    select 1
    from results r
    where position is not null
      and r.driver_id = drivers.driver_id
      and r.result_id = results.result_id
  )
group by constructors.name, driver_id
order by count(*) desc;
