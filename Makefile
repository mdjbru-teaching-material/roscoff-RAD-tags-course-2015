ORG2HTML_CMD=python python-scripts/org2html.py
ORG2MD_CMD=python python-scripts/org2md.py

PELICAN_PAGES_DIR=pelican_website/content/pages
PELICAN_RESOURCES_DIR=pelican_website/content/resources

help:
	@echo 'Makefile for the Roscoff RAD tags course 2015 website                        '
	@echo '                                                                             '
	@echo 'Usage:                                                                       '
	@echo '   make updatePages                 update pages from org files              '
	@echo '   make publish                     generate pages using production settings '
	@echo '   make serve                       serve site at http://localhost:8000      '
	@echo '   make stopserver                  stop local server                        '
	@echo '   make github                      upload github and the web site           '
	@echo '   make presentation                make the pdf presentation                '

presentation: presentation.pdf

presentation.pdf: presentation.org
	# http://stackoverflow.com/questions/22072773/batch-export-of-org-mode-files-from-the-command-line
	emacs presentation.org --batch -f org-beamer-export-to-pdf --kill
	cp presentation.pdf pelican_website/content/resources
	rm -f presentation.tex presentation.tex~

updatePages: $(PELICAN_PAGES_DIR)/bibliography-notes.html \
  $(PELICAN_PAGES_DIR)/index.html \
  $(PELICAN_PAGES_DIR)/notes.html \
  $(PELICAN_PAGES_DIR)/materials.html \
  $(PELICAN_RESOURCES_DIR)/pre-assessment.txt \
  $(PELICAN_RESOURCES_DIR)/presentation.pdf

publish:
	make updatePages
	cd pelican_website; make publish

serve:
	cd pelican_website; make serve

stopserver:
	cd pelican_website; make stopserver

github:
	git push origin
	make updatePages
	cd pelican_website; make github

pelican_website/content/pages/bibliography-notes.html: bibliography-notes.org
	$(ORG2HTML_CMD) bibliography-notes.org
	mv bibliography-notes.html $(PELICAN_PAGES_DIR)

pelican_website/content/pages/index.html: index.org
	$(ORG2HTML_CMD) index.org
	mv index.html $(PELICAN_PAGES_DIR)

pelican_website/content/pages/notes.html: notes.org
	$(ORG2HTML_CMD) notes.org
	mv notes.html $(PELICAN_PAGES_DIR)

pelican_website/content/pages/materials.html: materials.org
	$(ORG2HTML_CMD) materials.org
	mv materials.html $(PELICAN_PAGES_DIR)

pelican_website/content/resources/pre-assessment.txt: preassessment-form.org

pelican_website/content/resources/presentation.pdf: presentation.pdf
