VERSION=$(shell cat VERSION)

out/mm4cc-dotfiles_$(VERSION)_all.deb: tmp/deb
	mkdir -p out
	dpkg-deb -b $< $@

tmp/deb: generate-control VERSION
	mkdir -p tmp tmp/DEBIAN
	rm -rf tmp/deb
	cp -r ~/projects/dotfiles/sys tmp/deb
	./generate-control > tmp/DEBIAN/control
	(cd tmp/deb && find . -type f | xargs md5sum) > tmp/DEBIAN/md5sums
	mv tmp/DEBIAN tmp/deb/DEBIAN

clean:
	rm -rf out tmp
