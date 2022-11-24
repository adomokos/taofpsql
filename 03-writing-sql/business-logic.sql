select
  album.title as album,
  sum(milliseconds) * interval '1 ms' as duration
from albums as album
  join artists
    on artists.id = album.artist_id
  left join tracks
    on tracks.album_id = album.id
where artists.name = 'Red Hot Chili Peppers'
group by album
order by album;
