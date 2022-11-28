\c f1db;

explain (costs off)
select year, url
from seasons
order by year desc
limit 3;
