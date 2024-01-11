.PHONY: help
.DEFAULT_GOAL := help

define BROWSER_PYSCRIPT
import os, webbrowser, sys

try:
	from urllib import pathname2url
except:
	from urllib.request import pathname2url

webbrowser.open("file://" + pathname2url(os.path.abspath(sys.argv[1])))
endef
export BROWSER_PYSCRIPT

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

BROWSER := python3 -c "$$BROWSER_PYSCRIPT"

help:
	@python3 -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

clean: ## clean the project sources
	sed -i -r "s/BUILD_TYPE(.+)/BUILD_TYPE = Release/g" config.txt
	sed -i -r "s/ENABLE_CODE_COVERAGE(.+)/ENABLE_CODE_COVERAGE = OFF/g" config.txt
	sed -i -r "s/ENABLE_DOXYGEN(.+)/ENABLE_DOXYGEN = OFF/g" config.txt
	sed -i -r "s/ENABLE_FORMATTING(.+)/ENABLE_FORMATTING = ON/g" config.txt
	rm -rf packages/
	rm -rf doc/
	rm -rf _build/

test: clean ## run tests
	sed -i -r "s/BUILD_TYPE(.+)/BUILD_TYPE = Release/g" config.txt
	mkdir _build && cd _build && cmake .. && make -j && ctest

coverage: clean ## check code coverage
	sed -i -r "s/BUILD_TYPE(.+)/BUILD_TYPE = Debug/g" config.txt
	sed -i -r "s/ENABLE_CODE_COVERAGE(.+)/ENABLE_CODE_COVERAGE = ON/g" config.txt
	mkdir _build && cd _build && cmake .. && make -j && make coverage

doc: clean ## generate Doxygen HTML documentation
	sed -i -r "s/BUILD_TYPE(.+)/BUILD_TYPE = Release/g" config.txt
	sed -i -r "s/ENABLE_DOXYGEN(.+)/ENABLE_DOXYGEN = ON/g" config.txt
	mkdir _build && cd _build && cmake .. && make -j && make doxygen
	$(BROWSER) doc/index.html

format: clean ## format the project sources
	sed -i -r "s/BUILD_TYPE(.+)/BUILD_TYPE = Release/g" config.txt
	sed -i -r "s/ENABLE_FORMATTING(.+)/ENABLE_FORMATTING = ON/g" config.txt
	mkdir _build && cd _build && cmake .. && make -j && make clang-format

release: clean ## create release packages
	sed -i -r "s/BUILD_TYPE(.+)/BUILD_TYPE = Release/g" config.txt
	mkdir _build && cd _build && cmake .. && make -j && cpack

