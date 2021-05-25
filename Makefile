.PHONY: help

help:
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: upload-bootstrap upload-plural upload-console upload-airflow upload-gitlab upload-sentry

upload-airflow: # uploads airflow artifacts 
	plural apply -f airflow/Pluralfile

upload-bootstrap: # uploads k8s bootstrapping artifacts
	plural apply -f bootstrap/Pluralfile

upload-plural: # uploads plural platform artifacts
	plural apply -f plural/Pluralfile

upload-console: # uploads console artifacts
	plural apply -f console/Pluralfile

upload-gitlab: # uploads gitlab artifacts
	plural apply -f gitlab/Pluralfile

upload-sentry: # uploads sentry artifacts
	plural apply -f sentry/Pluralfile

import-operator:
	cp ../plural-operator/config/crd/bases/* bootstrap/plural/crds/bootstrap