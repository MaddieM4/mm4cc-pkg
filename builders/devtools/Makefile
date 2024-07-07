DEB=mm4cc-devtools_1.0_all.deb

out/$(DEB): tmp/$(DEB)
	mkdir -p out && cp tmp/$(DEB) out/$(DEB)

tmp/$(DEB): mm4cc-devtools.cfg
	mkdir -p tmp; cp *.cfg tmp
	cd tmp && equivs-build *.cfg

clean:
	rm -rf tmp out
