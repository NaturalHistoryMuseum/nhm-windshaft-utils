# Dependencies and verisons

## CKAN / SQLAlchemy

We're using the SQLAlchemy array accessors, which were introduced in SQLAlchemy 0.8

http://docs.sqlalchemy.org/en/rel_0_8/dialects/postgresql.html#sqlalchemy.dialects.postgresql.ARRAY

CKAN uses SQLAlchemy 0.7, and depends on VDM 0.11 which in turn requires SQLAlchemy 0.7 . However, SQLAlchemy 0.8.4 appears to work fine, and VDM 0.12 supports SQLAlchemy 0.8.

Note that neither VDM, nor Geoalchemy (which we also use) supports SQLAlchemy 0.9. If CKAN/VDM starts requiring SQLAlchemy 0.9 then either we need a compatible GeoAlchemy release, or (perhaps just as easily) we should remove the GeoAlchemy requirement.

## Windshaft

Need to update nhm-windshaft-app/package.json now that there have been more windshaft releases

## Heatmaps

We need to use a patched version of mapnik-reference in order to make the colorize-alpha styling work in the heatmaps. The patch has been merged and will be in the next release:

https://github.com/mapnik/mapnik-reference/pull/57

The dependencies are nhm-windshaft-app -> windshaft -> grainstore -> mapnik-reference: "~5.0.4". Assuming the pull request ends up in a 5.0.x release, nothing else will need changing.
