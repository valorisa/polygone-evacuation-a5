.PHONY: pdf test-all clean setup test changelog

pdf:
	pandoc plan-evacuation.md -o plan-evacuation.pdf --css=style-pdf.css -V geometry:margin=1.5cm -V papersize=a5

test-all:
	pytest tests/

test:
	pytest

clean:
	rm -f plan-evacuation.pdf

setup:
	./setup-complete.sh

changelog:
	python3 update_changelog.py
	git add CHANGELOG.md
	git commit -m "docs: update changelog"
