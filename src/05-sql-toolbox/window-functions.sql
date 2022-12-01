\c f1db;

select
  x, array_agg(x) over (order by x)
from generate_series(1, 5) as t(x);

select
  x,
  array_agg(x) over (order by x
                     rows between unbounded preceding
                       and current row)
from generate_series(1, 3) as t(x);

select
  x,
  array_agg(x) over (rows between current row
                       and unbounded following)
from generate_series(1,3) as t(x);

-- calculate sums in rows
select
  x,
  array_agg(x) over () as frame,
  sum(x) over () as sum,
  x::float/sum(x) over () as part
from generate_series(1, 3) as t(x);
