select names[1] as name,
ids[1] as id,
count,
center
 from
(SELECT
    array_agg(scientific_name) as names,
    array_agg(_id) AS ids,
    COUNT( geom ) AS count,
    ST_SnapToGrid( geom, 0.1, 0.1)  AS center
FROM botany_all
WHERE st_intersects(geom, st_envelope('SRID=4326;LINESTRING(0 49,1 52)'::geometry))
GROUP BY
    ST_SnapToGrid( geom, 0.1, 0.1)
ORDER BY
    count DESC
) as sub

;

