#!/bin/bash
azure group deployment create -f azuredeploy.json -e azuredeploy.parameters.json -g TestingDIRAC -n testingDeploy
