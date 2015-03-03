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
	rm -f presentation.tex~

updatePages: pelican_website/content/pages/bibliography-notes.html pelican_website/content/pages/index.html \
  pelican_website/content/pages/notes.html pelican_website/content/pages/schedule.html

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
	python org2html.py bibliography-notes.org
	mv bibliography-notes.html pelican_website/content/pages/

pelican_website/content/pages/index.html: index.org
	python org2html.py index.org
	mv index.html pelican_website/content/pages/

pelican_website/content/pages/notes.html: notes.org
	python org2html.py notes.org
	mv notes.html pelican_website/content/pages/

pelican_website/content/pages/schedule.html: schedule.org
	python org2html.py schedule.org
	mv schedule.html pelican_website/content/pages/
