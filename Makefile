SUITE=unstable
POOL=site-root/debian/pool
INRELEASE=site-root/debian/dists/$(SUITE)/InRelease
TESTS=$(patsubst ./trial/test-%,%,$(wildcard ./trial/test-*))

all: $(INRELEASE) site-root/index.html

prod:
	SUITE=stable make -e

$(INRELEASE): $(POOL) $(wildcard indexer/bin/*)
	op read op://Personal/PPA-key/password | xclip -selection c
	docker compose run indexer reindex $(SUITE)

$(POOL): $(wildcard builders/*/*)
	rm -rf $(POOL) && mkdir -p $(POOL)
	for builder in builders/*; do \
		(cd $$builder && make); \
		cp $$builder/out/* $(POOL); \
	done

site-root/index.html: README.md
	pandoc --from gfm --to html --metadata title='ppa.maddiem4.cc' --standalone \
	  $< --output $@

test:
	docker compose up -d && \
	  ./test-packages amd64 $(TESTS) && \
	  ./test-packages arm64 $(TESTS) && \
	  echo "ALL TESTS PASSED"

clean:
	rm -r $(POOL)
