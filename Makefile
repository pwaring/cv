all: resume.html resume.pdf

resume.html: resume.md
	python resume.py html < $< | pandoc -t html -c resume.css -V pagetitle:'Paul Waring - CV' -o $@

resume.pdf:  resume.md
	python resume.py tex < $< | pandoc --template=./pandoc-templates/default.latex -H header.tex -V papersize:'a4paper' -o $@

#resume.tex:  resume.md
#	python resume.py tex < $< | pandoc --template=./pandoc-templates/default.latex -H header.tex -V papersize:'a4paper' -o $@

clean:
	rm -f *.html *.pdf *.doc
