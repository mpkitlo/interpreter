
dir = build
exe = interpreter

$(exe):
	mkdir -p $(dir)
	ghc -outputdir $(dir) -o $@ Main.hs

clean:
	rm -rf $(dir) $(exe)

.PHONY: clean