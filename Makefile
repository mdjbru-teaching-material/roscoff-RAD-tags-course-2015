# Help from
# http://stackoverflow.com/questions/22072773/batch-export-of-org-mode-files-from-the-command-line
# https://www.gnu.org/software/make/manual/html_node/Wildcard-Function.html#Wildcard-Function
# http://unix.stackexchange.com/questions/87605/is-there-a-way-to-make-mv-fail-silently

### * Variables

ORG2HTML_CMD=python python-scripts/org2html.py
ORG2MD_CMD=python python-scripts/org2md.py

PELICAN_PAGES_DIR=pelican_website/content/pages
PELICAN_ARTICLES_DIR=pelican_website/content/articles
PELICAN_RESOURCES_DIR=pelican_website/content/resources

ORG_PAGES_FILES=$(wildcard page-*.org)
HTML_PAGES_FILES=$(patsubst %.org,%.html,$(ORG_PAGES_FILES))
ORG_ARTICLES_FILES=$(wildcard article-*.org)
HTML_ARTICLES_FILES=$(patsubst %.org,%.html,$(ORG_ARTICLES_FILES))

### * Help

help:
	@echo 'Makefile for the Roscoff RAD tags course 2015 website                        '
	@echo '                                                                             '
	@echo 'Usage:                                                                       '
	@echo '   make updateContent               update pages from org files              '
	@echo '   make publish                     generate pages using production settings '
	@echo '   make serve                       serve site at http://localhost:8000      '
	@echo '   make stopserver                  stop local server                        '
	@echo '   make clean                       remove the pages in pelican folder       '
	@echo '   make github                      upload github and the web site           '
	@echo '   make presentation                make the pdf presentation                '

### * Rules for main targets

updateContent: $(addprefix $(PELICAN_PAGES_DIR)/, $(HTML_PAGES_FILES)) \
  $(addprefix $(PELICAN_ARTICLES_DIR)/, $(HTML_ARTICLES_FILES)) \
  $(PELICAN_RESOURCES_DIR)/pre-assessment.txt \
  presentation

publish: updateContent
	cd pelican_website; make publish

serve:
	cd pelican_website; make serve

stopserver:
	cd pelican_website; make stopserver

clean:
	rm -f $(PELICAN_PAGES_DIR)/*.html
	rm -f $(PELICAN_ARTICLES_DIR)/*.html
	rm -f $(PELICAN_RESOURCES_DIR)/presentation.pdf
	rm -f $(PELICAN_RESOURCES_DIR)/pre-assessment.txt

github:
	git push origin
	make updateContent
	cd pelican_website; make github

presentation: $(PELICAN_RESOURCES_DIR)/presentation.pdf

### * Rules for secondary targets

$(PELICAN_PAGES_DIR)/page-%.html: page-%.org
	$(ORG2HTML_CMD) $<
	mv $(notdir $@) $(PELICAN_PAGES_DIR)

$(PELICAN_ARTICLES_DIR)/article-%.html: article-%.org
	$(ORG2HTML_CMD) $<
	mv $(notdir $@) $(PELICAN_ARTICLES_DIR)

$(PELICAN_RESOURCES_DIR)/pre-assessment.txt: pre-assessment.org
	emacs $< --batch -f org-ascii-export-to-ascii --kill
	mv pre-assessment.txt $(PELICAN_RESOURCES_DIR)

$(PELICAN_RESOURCES_DIR)/presentation.pdf: presentation.org
	# http://stackoverflow.com/questions/22072773/batch-export-of-org-mode-files-from-the-command-line
	emacs presentation.org --batch -f org-beamer-export-to-pdf --kill
	cp presentation.pdf $(PELICAN_RESOURCES_DIR)
	rm -f presentation.tex presentation.tex~

