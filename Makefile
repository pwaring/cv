CSS_FILE=cv.css

all: cv.html cv.pdf

cv.html: cv.md $(CSS_FILE)
	python3 cv.py html --no-gravatar < $< | pandoc -t html -s --include-in-header $(CSS_FILE) -V pagetitle:'Paul Waring - CV' -o $@

cv.pdf: cv.md header.tex ./pandoc-templates/default.latex
	python3 cv.py tex --no-gravatar < $< | pandoc --template=./pandoc-templates/default.latex -H header.tex -V papersize:'a4paper' -o $@

deploy: cv.pdf cv.html
	scp cv.pdf "borusa:/srv/pwaring.com/public/htdocs/downloads/cv-web.pdf"
	scp cv.html "borusa:/srv/pwaring.com/public/htdocs/downloads/cv-web.html"

clean:
	rm -f *.html *.pdf *.doc
