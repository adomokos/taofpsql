select
  ar.name,
  al.title
from albums al
inner join artists ar
  on al.artist_id = ar.id
where ar.name = :'name'
limit :n;
