SITE_DIRECTORY=$(HOME)/Nextcloud/sites/www.pwaring.com
DOWNLOAD_DIRECTORY=$(SITE_DIRECTORY)/output/downloads
CSS_FILE=cv.css

all: cv.html cv.pdf

cv.html: cv.md $(CSS_FILE)
	python cv.py html < $< | pandoc -t html -s --include-in-header $(CSS_FILE) -V pagetitle:'Paul Waring - CV' -o $@

cv.pdf: cv.md
	python cv.py tex < $< | pandoc --template=./pandoc-templates/default.latex -H header.tex -V papersize:'a4paper' -o $@

copy: cv.pdf cv.html
	cp cv.pdf $(DOWNLOAD_DIRECTORY)/cv-web.pdf
	cp cv.html $(DOWNLOAD_DIRECTORY)/cv-web.html

clean:
	rm -f *.html *.pdf *.doc
