POOL=site-root/debian/pool

OBSIDIAN_VERSION=1.6.5
OBSIDIAN=$(POOL)/obsidian-$(OBSIDIAN_VERSION)
OBSIDIAN_UPSTREAM=https://github.com/obsidianmd/obsidian-releases/releases/download/v${OBSIDIAN_VERSION}/obsidian-${OBSIDIAN_VERSION}-
OBSIDIAN_AMD64=$(OBSIDIAN)-amd64.deb
OBSIDIAN_ARM64=$(OBSIDIAN)-arm64.deb

obsidian: $(OBSIDIAN_AMD64) $(OBSIDIAN_ARM64)
$(OBSIDIAN_AMD64):
	curl "$(OBSIDIAN_UPSTREAM)-amd64.deb" > $(OBSIDIAN_AMD64)
$(OBSIDIAN_ARM64):
	curl "$(OBSIDIAN_UPSTREAM)-arm64.deb" > $(OBSIDIAN_ARM64)

clean:
	rm $(POOL)/*
