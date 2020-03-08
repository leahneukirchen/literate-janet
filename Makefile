all: lit.html README.md

%.md: %.janet lit.janet
	janet lit.janet < $< > $@

README.md: lit.md
	sed '1s/^% /# /; s/^% /### /' $< | pandoc -t gfm -o $@

%.html: %.md janet.xml
	pandoc --standalone --syntax-definition=janet.xml -o $@ $<
