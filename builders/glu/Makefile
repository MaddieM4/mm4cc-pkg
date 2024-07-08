VERSION=$(shell ./get-version)
AMD64=out/glu_$(VERSION)_amd64.deb

all: $(AMD64)

tmp/amd64:
	# Build and incorporate binary
	mkdir -p tmp/amd64/usr/bin/
	(cd upstream; cargo build --release)
	cp upstream/target/release/glu tmp/amd64/usr/bin
	# Debian metadata
	mkdir -p tmp/amd64/DEBIAN
	./generate-control amd64 > tmp/amd64/DEBIAN/control
	./get-version > tmp/amd64/debian-binary
	(cd tmp/amd64 && md5sum usr/bin/glu > DEBIAN/md5sums)

$(AMD64): tmp/amd64
	mkdir -p out
	dpkg-deb -b tmp/amd64 $(AMD64)

clean:
	rm -rf out tmp
