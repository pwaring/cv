SITE_DIRECTORY=$(HOME)/Nextcloud/sites/www.pwaring.com
DOWNLOAD_DIRECTORY=$(SITE_DIRECTORY)/output/downloads
CSS_FILE=cv.css

all: cv.html cv.pdf

cv.html: cv.md $(CSS_FILE)
	python3 cv.py html --no-gravatar < $< | pandoc -t html -s --include-in-header $(CSS_FILE) -V pagetitle:'Paul Waring - CV' -o $@

cv.pdf: cv.md header.tex ./pandoc-templates/default.latex
	python3 cv.py tex --no-gravatar < $< | pandoc --template=./pandoc-templates/default.latex -H header.tex -V papersize:'a4paper' -o $@

copy: cv.pdf cv.html
	cp cv.pdf $(DOWNLOAD_DIRECTORY)/cv-web.pdf
	cp cv.html $(DOWNLOAD_DIRECTORY)/cv-web.html

clean:
	rm -f *.html *.pdf *.doc
