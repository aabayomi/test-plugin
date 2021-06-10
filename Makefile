RELEASE?=0.2.0
PLATFORM?=linux/amd64,linux/arm64
IMAGE=image-sampler

all: image

image:
	docker buildx build -t "waggle/plugin-$(IMAGE):$(RELEASE)" --load .

push:
	docker buildx build -t "waggle/plugin-$(IMAGE):$(RELEASE)" --platform "$(PLATFORM)" --push .

setup:
	pip install poetry
	poetry install

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test:
	rm -f .coverage
	rm -f coverage.*

clean: clean-pyc clean-test

test: clean
	poetry run py.test tests --cov-config=.coveragerc --cov=src --cov-report xml

mypy:
	poetry run mypy src

lint:
	poetry run pylint src -j 4 --reports=y

check: test lint mypy