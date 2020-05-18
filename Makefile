# +---------------------------------------------------------------------------+
# | Makefile                                                                  |
# |                                                                           |
# | Example Test Package example_pkg mechanics                                |
# |                                                                           |
# | Version: 0.1.0 (change inline)                                            |
# |                                                                           |
# | Changes:                                                                  |
# |                                                                           |
# | 0.1.0 2020-05-18 Christian Külker <c@c8i.org>                             |
# |     - initial release                                                     |
# |                                                                           |
# +---------------------------------------------------------------------------+
#
VERSION=0.1.0
PACKAGE=example_pkg
UPLOAD=example-pkg
USERNAME:=ckuelker
# -----------------------------------------------------------------------------
# NO CHANGES BEYOND THIS POINT
ifndef VERSION
$(error VERSION is NOT defined)
endif
DEBUG_PRINT='1[$@]2[$%]3[$<]4[$?]5[$^]6[$+]7[$|]8[$*]9[$(@D)]10[$(@F)]11[$(*D)]\n12[$(*F)]13[$(%D)]14[$(%F)]15[$(<D)]16[$(<F)]17[$(^D)]18[$(^F)]\n19[$(+D)]20[$(+F)]21[$(?D)]22[$(?F)]\n'
L:=============================================================================
.PHONY: usage info clean realclean test
usage:
	@echo "$(L)"
	@echo "USAGE:"
	@echo "$(L)"
	@echo "make usage     : this information"
	@echo "make info      : print more info"
	@echo "make clean     : remove prcess files"
	@echo "make realclean : remove target"
	@echo "make test      : debug test"
	@echo "make build2    : build project with python2"
	@echo "make build3    : build project with python3"
	@echo "make uplodad2  : uplodad to test.pypi.org with python2"
	@echo "make uplodad3  : uplodad to test.pypi.org with python3"
	@echo "make install2  : install from test.pypi.org with python2"
	@echo "make install3  : install from test.pypi.org with python3"

info:
	@echo "VERSION: [$(VERSION)]"
clean:
	rm -rf build
	rm -rf $(PACKAGE)_$(USERNAME).egg-info
	find -name "*\.pyc"|xargs rm -f
	find -name "__pycache__"|xargs rmdir
realclean: clean
	rm -rf dist
test:
	@echo "$(DEBUG_PRINT)"
.venv2:
	virtualenv -p /usr/bin/python3 .venv2
.venv3:
	virtualenv -p /usr/bin/python3 .venv3
build2: .venv2
	source .venv2/bin/activate && python2 setup.py sdist bdist_wheel
build3: .venv3
	source .venv3/bin/activate && python3 setup.py sdist bdist_wheel
upload2:
	source .venv2/bin/activate && python2 -m twine upload --repository testpypi dist/*
upload3:
	source .venv3/bin/activate && python3 -m twine upload --repository testpypi dist/*
install2:
	source .venv2/bin/activate && python2 -m pip install --index-url https://test.pypi.org/simple/ --no-deps $(UPLOAD)-$(USERNAME)
install3:
	source .venv3/bin/activate && python3 -m pip install --index-url https://test.pypi.org/simple/ --no-deps $(UPLOAD)-$(USERNAME)

