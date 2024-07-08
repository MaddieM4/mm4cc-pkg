VERSION=$(shell ./get-version)
AMD64=out/glu_$(VERSION)_amd64.deb
ARM64=out/glu_$(VERSION)_arm64.deb

all: $(AMD64) $(ARM64)

tmp/amd64bin:
	mkdir -p tmp
	(cd upstream; cargo build --release)
	cp upstream/target/release/glu tmp/amd64bin

tmp/amd64: tmp/amd64bin generate-control get-version
	mkdir -p tmp/amd64/usr/bin/
	mkdir -p tmp/amd64/DEBIAN
	cp tmp/amd64bin tmp/amd64/usr/bin/glu
	./generate-control amd64 > tmp/amd64/DEBIAN/control
	./get-version > tmp/amd64/debian-binary
	(cd tmp/amd64 && md5sum usr/bin/glu > DEBIAN/md5sums)

tmp/arm64bin:
	mkdir -p tmp
	(cd upstream; cross build --release --target=aarch64-unknown-linux-gnu)
	cp upstream/target/aarch64-unknown-linux-gnu/release/glu tmp/arm64bin

tmp/arm64: tmp/arm64bin generate-control get-version
	mkdir -p tmp/arm64/usr/bin
	mkdir -p tmp/arm64/DEBIAN
	cp tmp/arm64bin tmp/arm64/usr/bin/glu
	./generate-control arm64 > tmp/arm64/DEBIAN/control
	./get-version > tmp/arm64/debian-binary
	(cd tmp/arm64 && md5sum usr/bin/glu > DEBIAN/md5sums)

$(AMD64): tmp/amd64
	mkdir -p out
	dpkg-deb -b tmp/amd64 $(AMD64)

$(ARM64): tmp/arm64
	mkdir -p out
	dpkg-deb -b tmp/arm64 $(ARM64)

clean:
	rm -rf out tmp
