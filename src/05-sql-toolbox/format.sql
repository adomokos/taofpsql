\c f1db;

select
  code,
  format('%s %s', forename, surname) as fullname,
  forename,
  surname
from drivers
limit 10;
