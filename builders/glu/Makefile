VERSION=$(shell ./get-version)
AMD64=out/glu_$(VERSION)_amd64.deb
ARM64=out/glu_$(VERSION)_arm64.deb
RUST_ARCH_amd64=x86_64
RUST_ARCH_arm64=aarch64

all: $(AMD64) $(ARM64)

.SECONDARY: $(out/glu-%)

out/glu-%:
	mkdir -p out
	(cd upstream; cargo build \
          --target=$(RUST_ARCH_$*)-unknown-linux-gnu \
	  --release --features vendored)
	cp upstream/target/$(RUST_ARCH_$*)-unknown-linux-gnu/release/glu $@

out/glu_$(VERSION)_%.deb: out/glu-% generate-control get-version build-deb
	./build-deb $* $<

clean:
	rm -rf out tmp
