REPORTER ?= spec
TEST_NODE_ENV=test
TEST_DEBUG_LEVEL=fatal
TEST_FILES=$(shell find test/ -name "*.test*.js" -not -path "*service/*" | sort -f)
SERVICE_TEST_FILES=$(shell find test/service -name "*.test*.js" | sort -f)
TEST_TIMEOUT=10s
NODE_VERSION="v4.4.3"

PLATFORM_CMD=node -e "console.log(process.platform)"
PLATFORM=$(shell $(PLATFORM_CMD))
NATIVE_PACKAGES=bunyan v8-profiler gc-stats
NATIVE_PLATFORM=$(shell find node_modules/v8-profiler/build/profiler/v5.7.0 -name 'node-*-x64' | grep $(PLATFORM))

fix-native-packages:
ifneq ("$(PLATFORM)","$(findstring $(PLATFORM),$(NATIVE_PLATFORM))")
	npm --quiet uninstall $(NATIVE_PACKAGES)
	npm --quiet install $(NATIVE_PACKAGES)
endif

# To remove: gc-stats, v8-profiler, bunyan
test: fix-native-packages
	@NODE_ENV=$(TEST_NODE_ENV) STATSD_HOST=statsd:8125 CONSOLE_LOG_LEVEL=$(TEST_DEBUG_LEVEL) \
	./node_modules/.bin/_mocha --timeout $(TEST_TIMEOUT) --reporter $(REPORTER) $(TEST_FILES)

docker-test: fix-native-packages
	@NODE_ENV=$(TEST_NODE_ENV) CONSOLE_LOG_LEVEL=$(TEST_DEBUG_LEVEL) \
	./node_modules/.bin/_mocha --timeout $(TEST_TIMEOUT) --reporter $(REPORTER) $(TEST_FILES) $(SERVICE_TEST_FILES)

clean:

.PHONY: all test clean fix-native-packages
