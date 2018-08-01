SITE_DIRECTORY=/home/paul/sites/www.pwaring.com
DOWNLOAD_DIRECTORY=$(SITE_DIRECTORY)/input/downloads

all: cv.html cv.pdf

cv.html: cv.md
	python cv.py html < $< | pandoc -t html -c cv.css -V pagetitle:'Paul Waring - CV' -o $@

cv.pdf: cv.md
	python cv.py tex < $< | pandoc --template=./pandoc-templates/default.latex -H header.tex -V papersize:'a4paper' -o $@

copy: cv.pdf cv.html
	cp cv.pdf $(DOWNLOAD_DIRECTORY)/cv-web.pdf
	cp cv.html $(DOWNLOAD_DIRECTORY)/cv-web.html
	cd $(SITE_DIRECTORY) &&	templer

clean:
	rm -f *.html *.pdf *.doc
