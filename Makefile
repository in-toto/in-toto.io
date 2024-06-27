HUGO?=npx hugo

serve:
	$(HUGO) server \
		--buildDrafts \
		--buildFuture \
		--disableFastRender

production-build:
	$(HUGO)

preview-build:
	$(HUGO) \
		--baseURL $(DEPLOY_PRIME_URL) \
		--buildDrafts \
		--buildFuture
