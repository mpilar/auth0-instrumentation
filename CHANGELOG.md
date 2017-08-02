# Changelog

## v2.6.1

FEATURES:
* Changed StatsD library from `node-statsd` to `hot-shots`

NOTES:
* The new library has new DataDog specific features that can be used, also it changes multiline messages in events so that DataDog can escape them properly.


## v2.6.0

FEATURES:
* Added Profiler which allows to take heap dumps on demand and produces GC metrics.

NOTES:
* If you already have a `profiler` in your service, you should remove it to avoid having duplicates.
