VERSION=$(shell grep '^Version' *.cfg | cut -d' ' -f2)
PACKAGE=$(shell grep '^Package' *.cfg | cut -d' ' -f2)
DEB=$(PACKAGE)_$(VERSION)_all.deb

out/$(DEB): tmp/$(DEB)
	mkdir -p out && cp tmp/$(DEB) out/$(DEB)

tmp/$(DEB): $(PACKAGE).cfg
	mkdir -p tmp; cp *.cfg tmp
	cd tmp && equivs-build *.cfg

clean:
	rm -rf tmp out
