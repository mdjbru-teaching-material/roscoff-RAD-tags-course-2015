# Help from
# http://stackoverflow.com/questions/22072773/batch-export-of-org-mode-files-from-the-command-line
# https://www.gnu.org/software/make/manual/html_node/Wildcard-Function.html#Wildcard-Function
# http://unix.stackexchange.com/questions/87605/is-there-a-way-to-make-mv-fail-silently

ORG2HTML_CMD=python python-scripts/org2html.py
ORG2MD_CMD=python python-scripts/org2md.py

PELICAN_PAGES_DIR=pelican_website/content/pages
PELICAN_ARTICLES_DIR=pelican_website/content/articles
PELICAN_RESOURCES_DIR=pelican_website/content/resources

ORG_PAGES_FILES=$(wildcard page-*.org)
ORG_ARTICLES_FILES=$(wildcard article-*.org)

help:
	@echo 'Makefile for the Roscoff RAD tags course 2015 website                        '
	@echo '                                                                             '
	@echo 'Usage:                                                                       '
	@echo '   make updatePages                 update pages from org files              '
	@echo '   make publish                     generate pages using production settings '
	@echo '   make serve                       serve site at http://localhost:8000      '
	@echo '   make stopserver                  stop local server                        '
	@echo '   make clean                       remove the pages in pelican folder       '
	@echo '   make github                      upload github and the web site           '
	@echo '   make presentation                make the pdf presentation                '

presentation: $(PELICAN_RESOURCES_DIR)/presentation.pdf

$(PELICAN_RESOURCES_DIR)/presentation.pdf: presentation.org
	# http://stackoverflow.com/questions/22072773/batch-export-of-org-mode-files-from-the-command-line
	emacs presentation.org --batch -f org-beamer-export-to-pdf --kill
	cp presentation.pdf $(PELICAN_RESOURCES_DIR)
	rm -f presentation.tex presentation.tex~

updatePages: $(PELICAN_PAGES_DIR)/page-bibliography-notes.html \
  $(PELICAN_PAGES_DIR)/page-index.html \
  $(PELICAN_PAGES_DIR)/page-notes.html \
  $(PELICAN_PAGES_DIR)/page-practicals.html \
  $(PELICAN_RESOURCES_DIR)/pre-assessment.txt \
  presentation

publish: updatePages
	cd pelican_website; make publish

clean:
	rm -f $(PELICAN_PAGES_DIR)/*.html
	rm -f $(PELICAN_RESOURCES_DIR)/presentation.pdf
	rm -f $(PELICAN_RESOURCES_DIR)/pre-assessment.txt

serve:
	cd pelican_website; make serve

stopserver:
	cd pelican_website; make stopserver

github:
	git push origin
	make updatePages
	cd pelican_website; make github

$(PELICAN_PAGES_DIR)/page-%.html: page-%.org
	$(ORG2HTML_CMD) $<
	mv $(notdir $@) $(PELICAN_PAGES_DIR)

$(PELICAN_ARTICLES_PAGES)/article-%.html: article-%.org
	$(ORG2HTML_CMD) $<
	mv $(notdir $@) $(PELICAN_ARTICLES_DIR)

$(PELICAN_RESOURCES_DIR)/pre-assessment.txt: pre-assessment.org
	emacs $< --batch -f org-ascii-export-to-ascii --kill
	mv pre-assessment.txt $(PELICAN_RESOURCES_DIR)

$(PELICAN_RESOURCES_DIR)/presentation.pdf: presentation.pdf
