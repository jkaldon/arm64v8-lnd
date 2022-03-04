#!/bin/sh

helm upgrade lnd -n bitcoin --create-namespace --install ./ -f values.yaml
