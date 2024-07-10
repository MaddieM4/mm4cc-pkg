VERSION=$(shell grep '^Version' *.cfg | cut -d' ' -f2)
DEB=mm4cc-desktop_$(VERSION)_all.deb

out/$(DEB): tmp/$(DEB)
	mkdir -p out && cp tmp/$(DEB) out/$(DEB)

tmp/$(DEB): mm4cc-desktop.cfg
	mkdir -p tmp; cp *.cfg tmp
	cd tmp && equivs-build *.cfg

clean:
	rm -rf tmp out
