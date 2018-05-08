LATEX = pdflatex -shell-escape -interaction=nonstopmode -file-line-error -output-directory build
BIBTEX = bibtex

.PHONY: all clean

all: datasheet appnotes

%.pdf: %.tex
	${LATEX} $<
	${BIBTEX} build/$(patsubst %.tex,%.aux,$(notdir $<))
	${LATEX} $<
	${LATEX} $<
	mv build/$(notdir $@) $(patsubst %.tex,%.pdf,$<)

datasheet: KETCubeDatasheet.pdf

clean_datasheet: 
	rm -f KETCubeDatasheet.pdf

appnotes: $(patsubst %.tex, %.pdf, $(wildcard appNotes/*.tex))

clean_appnotes: 
	rm -rf appNotes/*.pdf

clean_build:
	rm -rf build/*

clean: clean_build clean_appnotes clean_datasheet
	
