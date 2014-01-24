# Performance

The main tiles take a while to render, since they have hundreds of thousands of points on them. This will
only get worse as more data is added to the databases.

4/7/5.png is a good place to start.

### Select all

* Total rendering time: 5168 ms
* Explain analyze: 179858 points in 343 ms

### DISTINCT ON (the_geom_webmercator)

This speeds things up considerably:

* Total rendering time: 1114 ms
* Explain analyze: 3789 points in 1035 ms

The problem is the output looks a bit rubbish, since the data is sorted by geometry and so overlaps in a particular pattern.

Using these results, it appears that the time is roughly 0.02695 ms to render a marker. Checked with 3/3/2.png (211459 records) and that still holds.

Can markers be made faster to render? Not really - removing the outline makes a negligable difference.
Can we shuffle the results of the distinct?

### Shuffle DISTINCT ON

Yes, actually. `select * from (select distinct on (the_geom_webmercator) * from botany_all) as dt order by random()`

* Total rendering time: 1170 ms
* Explain analyze: 3789 points in 1004 ms

So that's no slower than just doing distinct on, and it looks much nicer too.

## Full database

3,547,292 records, of which only 592,693 have geometries. 60% increase in raw numbers of points for our tile, but 730% increase in their distribution!

### Shuffle DISTINCT ON

* Total rendering time: 2805 ms
* Explain analyze: 27701 points in 1911 ms

### Select all

* Total rendering time: 7000 ms
* Explain analyze: 288671 in 790 ms

### Gridding the results

In order to cut the rendering time below the 'shuffle distinct on' numbers, we need to reduce the number of positions returned. We can pre-calculate a SnapToGrid and see if that makes much of a difference:

```
select addgeometrycolumn('public', 'botany_all', 'the_geom_webmercator_grid', 3857, 'POINT', 2);
update botany_all set the_geom_webmercator_grid = st_snaptogrid(the_geom_webmercator, 10000, 10000);
```

Make sure to filter by !bbox! otherwise it'll order the entire dataset (by _grid, to do the distinct) before filtering by _the_geom_webmercator later on.
`sql=select * from (select distinct on (the_geom_webmercator_grid) * from botany_all where st_intersects(the_geom_webmercator_grid, !bbox!)) as dt order by random()`

* Total rendering time: 2535 ms
* Explain analyze: 16539 in 2176 ms

So that cuts the number of points by 40% but the sql query is starting to dominate! This can only be used for low zooms, otherwise the grid will start to become obvious.
