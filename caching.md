# Caching

The map tiles and grids take a non-zero amount of time to render. While mapnik and windshaft are blazingly fast,
for the number of records we're dealing with then rendering times can be of the order 1-5 seconds.

Speeding up the rendering of tiles when they are first rendered is discussed in [the performance notes](performance.md) but
mechanisms will be needed beyond that in order to serve a map tile for a second (or third, or tenth) time after
it is first created - think the first tiles that are shown before any filters are applied.

# RESTful

The systems we are using are all RESTful, which for the purposes here mean that every request for a given map or grid url
will receive the same response. The only time that will change is when we change a configuration, such as changing the map
style, or changing the records in the database. Beyond that the results don't change, and so the same map tile can be
confidently served to two clients asking for the same URL.

Or in short, we can use caching!

# Caching

There are main three places we can do caching

1. In front of the Windshaft server
2. Within CKAN
3. In the browser cache

## In front of the Windshaft server

Windshaft, by design, doesn't cache any rendered tiles or grids (it does use redis to do some internal caching, but that's
a separate matter). We could add a caching proxy like [Varnish](https://www.varnish-cache.org/) or [Squid](http://www.squid-cache.org/)
in front of Windshaft to cache the outputs. For our usecase there would be little configuration, other than either flushing
the cache on configuration changes or setting a timeout (of an hour or two) between re-renderings.

## In CKAN itself

CKAN uses pylon, and pylon has a built-in mechanism for caching, described [in the docs](http://docs.pylonsproject.org/projects/pylons-webframework/en/latest/caching.html). The pylon caching is based on the URL already, so there would be little configuration required to
get this working

## In the browser

The final place to cache is in the browser. This can work through ETags and Cache Control headers sent along with the images. This will
save clients from re-downloading the same tile data multiple times, speeding up their experience, but it would work best as a final layer
on top of other caching. The methods are explained well in the pylon documentation.

To avoid bringing in even more pieces of software, I'd suggest using the CKAN/pylons caching with the appropriate headers set. This will
speed up the most-viewed tiles considerably, especially under high traffic to the site.

    +----------------+
    |                |
    |   Browser      |
    |              3 |
    +-------+--------+
            |
            |
    +-------+--------+
    |                |
    |   Javscript    |
    |                |
    +-------+--------+
            |
            |
    +-------+--------+
    |                |       +---+
    |     CKAN       +-------| 1 |--+
    |              2 |       +---+  |
    +-------+--------+       +--------------+
            |                |              |
            |                |  Windshaft   |
            |                |              |
            |                +--------------+
    +-------+--------+              |
    |                |              |
    |   Datastore    +--------------+
    |                |
    +----------------+