POOL=site-root/debian/pool
INRELEASE=site-root/debian/dists/stable/InRelease

all: $(INRELEASE)

$(INRELEASE): $(OBSIDIAN_AMD64) $(OBSIDIAN_ARM64)
	docker compose run indexer reindex

OBSIDIAN_VERSION=1.6.5
OBSIDIAN=$(POOL)/obsidian-$(OBSIDIAN_VERSION)
OBSIDIAN_UPSTREAM=https://github.com/obsidianmd/obsidian-releases/releases/download/v${OBSIDIAN_VERSION}/obsidian-${OBSIDIAN_VERSION}
OBSIDIAN_AMD64=$(OBSIDIAN)-amd64.deb
OBSIDIAN_ARM64=$(OBSIDIAN)-arm64.deb

obsidian: $(OBSIDIAN_AMD64) $(OBSIDIAN_ARM64)
$(OBSIDIAN_AMD64):
	curl -L "$(OBSIDIAN_UPSTREAM)-amd64.deb" -o $(OBSIDIAN_AMD64)

# This is a real treat :/
# Why upstream doesn't supply a deb for this, I'll never know.
# Hence, fusing the amd64 packaging with arm64 contents in horrific surgery.
resources/obsidian_arm64.tar.gz:
	mkdir -p resources
	curl -L "$(OBSIDIAN_UPSTREAM)-arm64.tar.gz" -o resources/obsidian_arm64.tar.gz

$(OBSIDIAN_ARM64): resources/obsidian_arm64.tar.gz
	# Unpack the AMD debian package
	test -e resources/obsidian && rm -r resources/obsidian || true
	dpkg-deb -R $(OBSIDIAN_AMD64) resources/obsidian
	# Replace with the guts of the ARM tarball
	rm -r resources/obsidian/opt/Obsidian
	tar xvf resources/obsidian_arm64.tar.gz \
		--transform 's,obsidian-$(OBSIDIAN_VERSION)-arm64,resources/obsidian/opt/Obsidian,'
	# Metadata fixes
	cd resources/obsidian \
		&& sed -ie 's/Architecture: amd64/Architecture: arm64/' DEBIAN/control \
		&& find opt usr -type f \
		| xargs md5sum \
		> DEBIAN/md5sums
	# Build package to final location
	dpkg-deb -b resources/obsidian $(OBSIDIAN_ARM64)

test:
	docker compose up -d
	./test-packages amd64 obsidian
	./test-packages arm64 obsidian

clean:
	rm $(POOL)/*
