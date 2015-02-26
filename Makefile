help:
	@echo 'Makefile for the Roscoff RAD tags course 2015 website                        '
	@echo '                                                                             '
	@echo 'Usage:                                                                       '
	@echo '   make updatePages                 update pages from org files              '
	@echo '   make publish                     generate pages using production settings '
	@echo '   make serve                       serve site at http://localhost:8000      '
	@echo '   make stopserver                  stop local server                        '
	@echo '   make github                      upload github and the web site           '

updatePages:
#	python org2md.py bibliography-notes.org notes.org schedule.org
#	mv bibliography-notes.md notes.md schedule.md pelican_website/content/pages/
	python org2html.py index.org bibliography-notes.org notes.org schedule.org
	mv *.html pelican_website/content/pages/

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

