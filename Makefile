# Makefile
# Celine Habashy Dec 13th, 2024

# This driver script completes the textual analysis of
# 3 novels and creates figures on the 10 most frequently
# occuring words from each of the 3 novels. This script
# takes no arguments.

# example usage:
# make all

.PHONY: all clean
all: report/count_report.html

# count the words
results/isles.dat: data/isles.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=$< --output_file=$@

results/abyss.dat: data/abyss.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=$< --output_file=$@

results/last.dat: data/last.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=$< --output_file=$@

results/sierra.dat: data/sierra.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=$< --output_file=$@

# make the plots
results/figure/isles.png: results/isles.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=$< --output_file=$@

results/figure/abyss.png: results/abyss.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=$< --output_file=$@

results/figure/last.png: results/last.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=$< --output_file=$@

results/figure/sierra.png: results/sierra.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=$< --output_file=$@

# Write the report
report/count_report.html: report/count_report.qmd \
	results/figure/isles.png \
	results/figure/abyss.png \
	results/figure/last.png \
	results/figure/sierra.png
	quarto render $<

clean:
	rm -f results/*.dat results/figure/*.png report/count_report.html
