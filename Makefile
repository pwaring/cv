SRC = $(wildcard *.md)

PDFS=$(SRC:.md=.pdf)
HTML=$(SRC:.md=.html)
TEX=$(SRC:.md=.tex)

all:    clean $(PDFS) $(HTML) $(DOC) $(DOCX) $(TEX)

pdf:   clean $(PDFS)
html:  clean $(HTML)
tex:   clean $(TEX)

%.html: %.md
	python resume.py html < $< | pandoc -t html -c resume.css -V pagetitle:'Paul Waring - CV' -o $@

%.pdf:  %.md
	python resume.py tex < $< | pandoc --template=./pandoc-templates/default.latex -H header.tex -V papersize:'a4paper' -o $@

%.tex:  %.md
	python resume.py tex < $< | pandoc --template=./pandoc-templates/default.latex -H header.tex -V papersize:'a4paper' -o $@

clean:
	rm -f *.html *.pdf *.doc
