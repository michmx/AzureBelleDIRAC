#!/bin/bash
#
# Script to automatic deploy resources required to run virtual machines on Azure -- Michel

azure group create TestingDIRAC japaneast
azure storage account create bellestorage --resource-group TestingDIRAC --location japaneast --kind Storage --sku-name PLRS
azure storage account keys list bellestorage --resource-group TestingDIRAC
echo "key1? :"
read KEY
azure storage container create --account-name bellestorage --account-key $KEY --container cernvmimage
wget http://cernvm.cern.ch/releases/production/cernvm-3.6.5.vhd
azure storage blob upload --blobtype page --account-name bellestorage --account-key $KEY --container cernvmimage cernvm-3.6.5.vhd
azure storage container create --account-name bellestorage --account-key $KEY --container vhdfiles 
azure keyvault create --vault-name BelleKeys --resource-group TestingDIRAC --location japaneast
azure keyvault secret set --vault-name BelleKeys --secret-name VMPassword --value testDirac
