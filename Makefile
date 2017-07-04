all: cv.html cv.pdf

cv.html: cv.md
	python cv.py html < $< | pandoc -t html -c cv.css -V pagetitle:'Paul Waring - CV' -o $@

cv.pdf:  cv.md
	python cv.py tex < $< | pandoc --template=./pandoc-templates/default.latex -H header.tex -V papersize:'a4paper' -o $@

clean:
	rm -f *.html *.pdf *.doc
