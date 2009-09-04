LATEX=pdflatex
PDFJOIN=/usr/bin/pdfjoin
PDFNUP=/usr/bin/pdfnup

CPU-SERVERS= \
	stalhein \
	fritz 

WORKSTATIONS= \
	piggelin \
	surtsey \
	pavo \
	orion \
	balam \
	eligos \
	furfur \
	volac 	

CPU-SERVERS_COLLECTIONS=a5collection-cpu-servers.pdf \
			a4collection-cpu-servers.pdf
WORKSTATIONS_COLLECTIONS=a5collection-workstations.pdf \
			 a4collection-workstations.pdf

CPU-SERVERS_PDF=$(CPU-SERVERS:=.pdf)
WORKSTATIONS_PDF=$(WORKSTATIONS:=.pdf)

### User targets ####################################

default: cpu-servers workstations collections
	make clean

cpu-servers: $(CPU-SERVERS_PDF)

workstations: $(WORKSTATIONS_PDF)

collections: $(CPU-SERVERS_COLLECTIONS) $(WORKSTATIONS_COLLECTIONS)

example: exempel.pdf

#####################################################

a5collection-cpu-servers.pdf: $(CPU-SERVERS_PDF)
	$(PDFJOIN) $(CPU-SERVERS_PDF) \
		   --paper a5paper \
		   --outfile a5collection-cpu-servers.pdf 

a4collection-cpu-servers.pdf: a5collection-cpu-servers.pdf
	$(PDFNUP) a5collection-cpu-servers.pdf \
		  --paper a4paper \
		  --outfile a4collection-cpu-servers.pdf 


a5collection-workstations.pdf: $(WORKSTATIONS_PDF)
	$(PDFJOIN) $(WORKSTATIONS_PDF) \
		   --paper a5paper \
		   --outfile a5collection-workstations.pdf 

a4collection-workstations.pdf: a5collection-workstations.pdf
	$(PDFNUP) a5collection-workstations.pdf \
		  --paper a4paper \
		  --outfile a4collection-workstations.pdf 

lyslogo2.pdf: 
	ps2eps -f lyslogo2.ps
	epstopdf lyslogo2.eps

%.pdf : %.tex lyslogo2.pdf mall.sty
	$(LATEX) $<

clean:
	rm -f *.aux
	rm -f *.log

real-clean:
	make clean
	rm -f *.pdf
