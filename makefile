# Makefile vs cakefile as learning more toolchains = bad
COFFEEC?=coffee
COFFEE_FLAGS?=--bare
REQ?=browserify
REQ_FLAGS?=--debug
SRCMAPR?=exorcist
BINDIR?=bin
LIBDIR?=lib
SRCDIR?=src

all: build

build: convert prepare copyhtml zip

convert:
	$(COFFEEC) $(COFFEE_FLAGS) -o $(LIBDIR) --compile $(SRCDIR)

prepare:
	rm $(BINDIR)/*
	wget http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js -O $(BINDIR)/jquery.min.js
	$(REQ) $(REQ_FLAGS) $(LIBDIR)/turing-main.js -o $(BINDIR)/turing-machine.js

copyhtml:
	cp $(SRCDIR)/index.html $(BINDIR)/index.html
	cp $(SRCDIR)/style.css  $(BINDIR)/style.css

zip:
	zip $(BINDIR)/turing-machine.zip $(BINDIR)/index.html $(BINDIR)/jquery.min.js $(BINDIR)/turing-machine.js $(BINDIR)/style.css README.md LICENSE.md
