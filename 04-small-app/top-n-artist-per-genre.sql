select
  g.name as genre,
  case when length(ss.name) > 15
    then substring(ss.name from 1 for 15) || '...'
  else ss.name
  end as track,
  artists.name as artist
from genres g
left join lateral
  /*
   * The lateral left join implements a nested loop over
   * the genres and allows to fetch our Top-N tracks per
   * genre, applying the order by desc limit n clause.
   *
   * Here we choose to weight the tracks by how many times
   * the appear in a paylist, so we join against
   * the playlisttrack table and count appearances.
   */
  (
    select t.name, t.album_id, count(playlist_id)
    from tracks t
    left join playlist_track pt
      on pt.track_id = t.id
    where t.genre_id = g.id
    group by t.id
    order by count desc
      limit 5
  )
  /* The join happens in the subquery's where caluse,
   * so we don't need to add another one at the outer join level
   * hence the "on true" spelling
  */
  ss(name, album_id, count) on true
join albums a
  on a.id = ss.album_id
join artists
  on a.artist_id = artists.id
order by g.name, ss.count desc;

