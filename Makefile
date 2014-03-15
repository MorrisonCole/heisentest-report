# Makefile for a latex paper
LATEX = TEXINPUTS=$(TEXINPUTS):packages pdflatex
PAPER = paper

#all: $(PAPER).dvi $(PAPER).ps $(PAPER).pdf
all: $(PAPER).pdf

# Run once, then re-run until it's happy
# Input redirected from /dev/null is like hitting ^C at first error
$(PAPER).pdf: $(wildcard *.tex) ./Bib/paper.bib
	$(LATEX) $(PAPER).tex </dev/null
	bibtex $(PAPER)
	$(LATEX) $(PAPER).tex </dev/null
	$(LATEX) $(PAPER).tex </dev/null

Figures: Figures/TypeBarGraph.pdf Figures/InDegreeTypeViolinPlots.pdf \
	Figures/RegionPropertyBarGraph.pdf \
	Figures/InDegreeRegionViolinPlots.pdf \
	Figures/ShapeCountBarGraph.pdf \
	Figures/PropertyPerFieldBarGraph.pdf \
	Figures/PropertyPerEdgeBarGraph.pdf \
	Figures/InjectivityFieldBarGraph.pdf \
	Figures/InjectivityEdgeBarGraph.pdf \

Figures/%.pdf: ../data/%.pdf
	pdfcrop $< $@
	
# generate eps from xfig's "Combined PS/LaTeX (both parts)" export output
%.eps: %.pstex_t
	./pstex-to-eps $*.pstex_t

.PHONY: ps print
print: $(PAPER).ps
	gv $(PAPER).ps

#$(PAPER).ps: $(PAPER).dvi
#	dvips -tletter -o $(PAPER).ps $(PAPER).dvi

#$(PAPER).pdf: $(PAPER).ps
#	ps2pdf $(PAPER).ps

clean:
	rm -f *.aux *.log $(PAPER).ps $(PAPER).pdf *.dvi *.blg *.bbl *.lof *.lot *.toc *~
