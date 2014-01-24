# Heatmaps

Heatmaps are inherintly raster-orientated, since they extrapolate points into a full-map coverage of values. Typically using mapnik the rasters are calculated first and saved to file, and then added as raster layers through the gdal or raster drivers.

## Generate rasters in PostGIS from query results

Assuming from now that it's possible, the question is how would the rasters make it to mapnik.

### Mapnik PostGIS raster plugin

Mapnik can't yet read from PostGIS rasters, see https://github.com/mapnik/mapnik/issues/1660

### via GDAL plugin

Mapnik can read rasters using the gdal plugin, but expects them to be simple files on disk. Is there a way to create a VRT that points to a postgis raster?

* https://trac.osgeo.org/gdal/wiki/frmts_wtkraster.html
* http://postgis.refractions.net/documentation/manual-svn/RT_FAQ.html#id3076646

It might be possible, but then the sql query is baked into the vrt file. So we would need a service where you pass a query string, it creates a tempfile vrt and returns a reference, and then you can request map tiles using that vrt as a reference. Or similar.

### via heatmap plugin

There's a heatmap plugin that someone has developed - cool!

https://github.com/stellaeof/mapnik-rasterizers

You get to specify the datasource to be a "source" of the heatmap plugin. The example uses a shapefile but might work against postgis. Unfortunately it doesn't look like it's being maintained, but might stiff be useful.

Ah, springmeyer (mapnik dev) has a slightly-more-maintained version at https://github.com/springmeyer/mapnik-rasterizers 

## Other mapnik heatmap approaches

### Colorize-alpha

* http://www.stevehorn.cc/blog/creating-heatmaps-with-open-source-software
* https://www.mapbox.com/blog/colorize-alpha-image-filter/

## Leaflet heatmap approaches

### Heatcanvas

http://sunng.info/heatcanvas/leaflet.html

Has the advantage that you can pass points with values through, rather than needing millions of points returned. This could hook into the stacked-points SQL that we have already.

### Heatmap.js

http://www.patrick-wied.at/static/heatmapjs/index.html

### More plugins

... are available at http://leafletjs.com/plugins.html
