PREFIX = /usr/local/bin

FILE_PATH = $(CURDIR)/cvsignore2svn.sh
INSTALL_FILE_PATH = $(PREFIX)/cvsignore2svn

$(INSTALL_FILE_PATH):
	ln -s $(FILE_PATH) $(INSTALL_FILE_PATH)

.PHONY: install
install: $(INSTALL_FILE_PATH)

include tools.mk
