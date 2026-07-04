AUX_DIR   := aux_outputs
TEX       := pdflatex -interaction=nonstopmode -output-directory=$(AUX_DIR)
BIBTEX    := bibtex

.PHONY: default clean cleanall

default:
	$(MAKE) compile FILE=main.tex

FORCE:

%.tex: FORCE
	$(MAKE) compile FILE=$@

compile:
	@if [ ! -f "$(FILE)" ]; then \
		echo "Error: archivo $(FILE) no encontrado"; \
		exit 1; \
	fi
	@echo "Compilando $(FILE)..."
	@mkdir -p $(AUX_DIR)
	$(TEX) $(FILE)
	-$(BIBTEX) $(AUX_DIR)/$(basename $(FILE))
	$(TEX) $(FILE)
	$(TEX) $(FILE)
	@cp $(AUX_DIR)/$(basename $(FILE)).pdf $(basename $(FILE)).pdf
	@echo "PDF generado: $(basename $(FILE)).pdf"

clean:
	rm -rf $(AUX_DIR)

cleanall: clean
	rm -f *.pdf
