VERSION=$(shell cat VERSION)
VERSION_CODENAME=noble # TODO: better approach
.SECONDARY: $(tmp/1password/deb-%)

AMD64=out/mm4cc-base_$(VERSION)_amd64.deb
ARM64=out/mm4cc-base_$(VERSION)_arm64.deb

all: $(AMD64) $(ARM64)

out/mm4cc-base_$(VERSION)_%.deb: tmp/base/deb-%
	mkdir -p out
	dpkg-deb -b $< $@

tmp/base/deb-%: tmp/1password/deb-% tmp/docker/deb-% VERSION generate-control
	mkdir -p $@
	cp -r tmp/1password/deb-$*/* $@/
	cp -r tmp/docker/deb-$*/* $@/
	(cd $@ && find . -type f | xargs md5sum) > tmp/md5sums-$*
	du -bs $@ | cut -f1 > tmp/size-$*
	mkdir -p $@/DEBIAN
	./generate-control $* > $@/DEBIAN/control
	mv tmp/md5sums-$* $@/DEBIAN/md5sums

# -----------------------------------------------------------------------------
#  1Password
# -----------------------------------------------------------------------------
tmp/1password/keyring.gpg:
	mkdir -p tmp/1password
	curl -sS https://downloads.1password.com/linux/keys/1password.asc \
	  | gpg --dearmor --output tmp/1password/keyring.gpg
tmp/1password/1password.pol:
	mkdir -p tmp/1password
	curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol > $@

tmp/1password/deb-%: tmp/1password/keyring.gpg tmp/1password/1password.pol
	# Copy keyring
	mkdir -p $@/usr/share/keyrings/
	cp tmp/1password/keyring.gpg $@/usr/share/keyrings/1password-archive-keyring.gpg
	# Set up Apt list
	mkdir -p $@/etc/apt/sources.list.d/
	echo "deb [arch=$* signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$* stable main" \
	  > $@/etc/apt/sources.list.d/1password.list
	# Debsig policy
	mkdir -p $@/etc/debsig/policies/AC2D62742012EA22/
	cp tmp/1password/1password.pol $@/etc/debsig/policies/AC2D62742012EA22/
	# Debsig keyring
	mkdir -p $@/usr/share/debsig/keyrings/AC2D62742012EA22
	cp tmp/1password/keyring.gpg $@/usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

# -----------------------------------------------------------------------------
#  Docker
# -----------------------------------------------------------------------------
tmp/docker/keyring.gpg:
	mkdir -p tmp/docker
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg > $@
tmp/docker/deb-%: tmp/docker/keyring.gpg
	# Copy keyring
	install -m 0755 -d $@/etc/apt/keyrings
	cp tmp/docker/keyring.gpg $@/etc/apt/keyrings/docker.asc
	chmod a+r $@/etc/apt/keyrings/docker.asc
	# Set up Apt list
	mkdir -p $@/etc/apt/sources.list.d/
	echo "deb [arch=$* signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(VERSION_CODENAME) stable" \
	  > $@/etc/apt/sources.list.d/docker.list

clean:
	rm -rf ./tmp ./out
