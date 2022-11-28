\c f1db;

select x
from generate_series(1, 100) as t(x)
where x not in (1, 2, 3, null);
