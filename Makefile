NAME=doc

build:
	pdflatex ${NAME}.tex

run:
	evince ${NAME}.pdf

clean:
	rm -rf ${NAME}.aux ${NAME}.log ${NAME}.out ${NAME}.pdf

requirements:
	apt-get install texlive-latex-extra texlive-fonts-recommended dvipng
	pip install pandas scipy numpy matplotlib
