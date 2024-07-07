POOL=site-root/debian/pool
INRELEASE=site-root/debian/dists/stable/InRelease

all: $(INRELEASE)

$(INRELEASE): $(POOL) $(wildcard indexer/bin/*)
	docker compose run indexer reindex

$(POOL): $(wildcard builders/*/*)
	rm -rf $(POOL) && mkdir -p $(POOL)
	for builder in builders/*; do \
		(cd $$builder && make); \
		cp $$builder/out/* $(POOL); \
	done

test:
	docker compose up -d && \
	  ./test-packages amd64 obsidian devtools && \
	  ./test-packages arm64 obsidian devtools && \
	  echo "ALL TESTS PASSED"

clean:
	rm -r $(POOL)
