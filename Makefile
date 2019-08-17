# Copyright © 2019 Sharice Mayer
# mayers.research@gmail.com
# [This program is licensed under the "MIT License"]
# Please see the file LICENSE in the source
# distribution of this software for license terms.

# Thanks to Bruno Rocha for ffi resources used in this project


.PHONY: clean clean-test clean-pyc clean-build docs help

clean: clean-build clean-pyc clean-test ## remove all build, test, coverage and Python artifacts

clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test: ## remove test and coverage artifacts
	rm -fr .tox/
	rm -f .coverage
	rm -fr htmlcov/

lint: ## check style with flake8
	flake8 manage tests

test-rust: ## run tests quickly with the default Python
	py.test -v -s testffi.py

compile-rust: ## compile new rust lib
	@cd promachosffi;RUSTFLAGS="-C target-cpu=native" cargo build --release
	@cp promachosffi/target/release/libpromachosffilib.so promachosffilib.so

#compile-c: ## compile new c lib
#	@cd pyext-myclib;python3 setup.py build_ext -i

