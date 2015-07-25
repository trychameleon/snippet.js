all: indexify devify minify

build:
	@node tasks/build

indexify:
	PROTOCOL=https FAST_URL=fast.trychameleon.com HOST=trychameleon.com TARGET_FILE=index.js $(MAKE) build

devify:
	PROTOCOL=http FAST_URL=localhost:3278 HOST=dev TARGET_FILE=index.dev.js $(MAKE) build

minify:
	@uglifyjs index.js --compress --mangle --stats --output index.min.js

spec:
	if [ -e ./node_modules/.bin/minijasminenode2 ]; then ./node_modules/.bin/minijasminenode2 --verbose --forceexit **/*_spec.js; else printf "\nMini Jasmine not installed @ ./node_modules/.bin/minijasminenode2...\n\nTrying npm install\n\n" && npm install; fi;

test: indexify spec

.PHONY: spec
.PHONY: test
.PHONY: indexify
