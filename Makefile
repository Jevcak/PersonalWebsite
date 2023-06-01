
PAGES = \
	index \
	rules \
	score \
	group-a \
	group-b
	
PAGES_HTML=$(addprefix out/, $(addsuffix .html, $(PAGES)))

all: $(PAGES_HTML) out/main.css spelling

.PHONY: all clean

clean:
	rm -f out/*.html out/*.css
	
spelling: src/*.md
	cat src/*.md | aspell list --master en 
	
out/%.html: src/%.md src/template.html
	pandoc --template src/template.html -o $@ $<

out/%.html: src/%.csv src/template.html
	./src/table.py <$< | pandoc --template src/template.html --metadata title="Score" - >$@

out/main.css: src/main.css
	cp src/main.css out/