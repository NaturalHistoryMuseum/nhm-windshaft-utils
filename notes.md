# Useful SQL queries

select AddGeometryColumn('public', 'botany_all', 'geom', 4326, 'POINT', 2);
update botany_all set geom = st_setsrid(st_makepoint(longitude::float8, latitude::float8), 4326) where latitude is not null and latitude not like '%{%' and latitude != '';
select addgeometrycolumn('public', 'botany_all', 'the_geom_webmercator', 3857, 'POINT', 2);
update botany_all set the_geom_webmercator = st_transform(geom, 3857);

http://gis.stackexchange.com/questions/11567/spatial-clustering-with-postgis
