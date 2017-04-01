# make sermon
SUNDAY ?= $(shell date -v +Sun "+%Y-%m-%d")

# The default targets
all: sermon-a5.pdf

done: upload-all

sermon-a5.pdf:
	$(MAKE) -C book lshort-a5.pdf
	mv book/lshort-a5.pdf sermon-a5.pdf

upload-all:
	@while [ -z "$$PASSAGE" ]; do \
		read -r -p "Passage: " PASSAGE;\
		if ! [ -z "$$PASSAGE" ]; then \
			PASSAGE="$${PASSAGE// /_}"; \
		fi \
	done && \
	while [ -z "$$DATE" ]; do \
		read -r -p "Date [Sunday $(SUNDAY)]: " DATE; \
		if [ -z "$$DATE" ]; then \
			DATE="$(SUNDAY)"; \
		fi \
	done && \
	FILE="$(UPLOAD_DIR)/$${DATE}__$${PASSAGE}.pdf"; \
	cp sermon-a5.pdf "$$FILE"; \
	printf 'Uploading %s\n' "$$FILE"

clean:
	rm -f *.pdf
	$(MAKE) -C book clean
