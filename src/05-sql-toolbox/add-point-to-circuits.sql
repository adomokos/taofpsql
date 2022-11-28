\c f1db;

begin;

alter table circuits add column position point;
update circuits set position = point(lng, lat);
create index on circuits using gist(position);

commit;

