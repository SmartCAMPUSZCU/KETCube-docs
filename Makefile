LATEX = pdflatex -shell-escape -interaction=nonstopmode -file-line-error -output-directory build
BIBTEX = bibtex

.PHONY: all clean

all: datasheet appnotes presentations

clean: clean_build clean_appnotes clean_presentations clean_datasheet

appNotes/%.pdf: appNotes/%.tex
	${LATEX} $<
	${BIBTEX} build/$(patsubst %.tex,%.aux,$(notdir $<))
	${LATEX} $<
	${LATEX} $<
	mv build/$(notdir $@) $(patsubst %.tex,%.pdf,$<)

presentations/%.pdf: presentations/%.tex
	${LATEX} $<
	${LATEX} $<
	mv build/$(notdir $@) $(patsubst %.tex,%.pdf,$<)

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

presentations: $(patsubst %.tex, %.pdf, $(wildcard presentations/*.tex))

clean_appnotes: 
	rm -rf appNotes/*.pdf

clean_presentations: 
	rm -rf presentations/*.pdf

clean_build:
	rm -rf build/*
