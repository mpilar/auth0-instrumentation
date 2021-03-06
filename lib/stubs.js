const noop = function() {};
const returnValue = function() { return 1; };
const emptyMiddleware = function (a, b, next) { next(); };

const emptyLogger = {
  trace: noop,
  debug: noop,
  info: noop,
  warn: noop,
  error: noop,
  fatal: noop
};

const emptyErrorReporter = {
  isActive: false,
  captureException: noop,
  captureMessage: noop,
  patchGlobal: noop,
  hapi: {
    plugin: {
      register: emptyMiddleware
    }
  },
  express: {
    requestHandler: emptyMiddleware,
    errorHandler: emptyMiddleware
  },
};
emptyErrorReporter.hapi.plugin.register.attributes = { pkg: require('../package.json') };

const emptyMetrics = {
  isActive: false,
  gauge: noop,
  increment: noop,
  histogram: noop,
  flush: noop,
  setDefaultTags: noop,
  startResourceCollection: noop,
  time: returnValue,
  endTime: noop
};

const emptyProfiler = {
  setupProcessListener: noop,
  createDebouncedSnapshot: noop,
  report: noop,
  setupGCReporter: noop
};

module.exports = {
  logger: emptyLogger,
  errorReporter: emptyErrorReporter,
  metrics: emptyMetrics,
  profiler: emptyProfiler
};
