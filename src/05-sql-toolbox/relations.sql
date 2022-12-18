begin;

create table relation(id integer, f1 text, f2 date, f3 point);

insert into relation
values (
  1,
  'one',
  current_date,
  point(2.349014, 48.864716)
);

select relation from relation;

rollback;
