#!/bin/bash

# Pull the docker image
docker pull makerdao/testchain-pymaker:unit-testing

# Start the docker image and wait for parity to initialize
pushd ./lib/pymaker
docker-compose up -d
sleep 2
popd

PYTHONPATH=$PYTHONPATH:./lib/pymaker py.test -s --cov=dsrdemo --cov-report=term --cov-append test/test_dsrdemo.py $@
TEST_RESULT=$?

echo Stopping container
pushd ./lib/pymaker
docker-compose down
popd

exit $TEST_RESULT
