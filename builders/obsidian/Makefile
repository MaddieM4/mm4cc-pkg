VERSION=1.6.5
UPSTREAM=https://github.com/obsidianmd/obsidian-releases/releases/download/v${VERSION}/obsidian-${VERSION}

AMD64=out/obsidian_${VERSION}_amd64.deb
ARM64=out/obsidian_${VERSION}_arm64.deb

all: $(AMD64) $(ARM64)

$(AMD64):
	mkdir -p out
	curl -L "$(UPSTREAM)-amd64.deb" -o $(AMD64)

tmp/arm64.tar.gz:
	mkdir -p tmp
	curl -L "$(UPSTREAM)-arm64.tar.gz" -o tmp/arm64.tar.gz

tmp/arm64: tmp/arm64.tar.gz
	cd tmp && tar xvf arm64.tar.gz && mv obsidian-1.6.5-arm64 arm64

tmp/amd64deb: $(AMD64)
	mkdir -p tmp
	dpkg-deb -R $(AMD64) tmp/amd64deb

tmp/arm64deb: tmp/arm64 tmp/amd64deb
	rm -rf tmp/arm64deb && mkdir -p tmp/arm64deb/opt
	cp -r tmp/amd64deb/usr tmp/arm64deb
	cp -r tmp/amd64deb/DEBIAN tmp/arm64deb
	cp -r tmp/arm64 tmp/arm64deb/opt/Obsidian
	sed -ie 's/Architecture: amd64/Architecture: arm64/' tmp/arm64deb/DEBIAN/control
	cd tmp/arm64deb && find opt usr -type f \
		| xargs md5sum \
		> DEBIAN/md5sums

$(ARM64): tmp/arm64deb
	dpkg-deb -b tmp/arm64deb $(ARM64)

clean:
	rm -rf out tmp
