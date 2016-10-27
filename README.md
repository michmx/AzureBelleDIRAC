# DIRAC Pilot running on Microsoft Azure

## Introduction

Microsoft Azure works with two models: Resource Manager (ARM) and Service Manager (ASM).

The ARM is the new model used by Azure. The advantage is the deployment of resources using JSON templates, who simplifies a lot the tasks.

The ASM model is the ‘old' model. According to the Microsoft documentation, this model is going to be deprecated after a while, but still is available for compatibility.

More information can be found in the [documentation](https://azure.microsoft.com/en-us/documentation/articles/resource-manager-deployment-model/). For our convinience, we are going to use ARM model.



## First steps 

1. Install the [client for Azure](https://azure.microsoft.com/en-us/documentation/articles/xplat-cli-install/), login and change the mode.

 To login:  
 
 ```
 $ azure login
 ```

 Change mode to Azure Resource Manager:  

 ```
 $ azure config mode arm
 ```


2. Create a group from the portal.  

 ```
 $ azure group create TestingVMmich japaneast
 ```

 To confirm the group was created:  
 
 ```
 $ azure group list
 ```

3. Create Storage Account:
 
 ```
 $ azure resource create TestingVMmich cernstorageaccount \  
 "Microsoft.Storage/storageAccounts" "japaneast" -o "2015-06-15" \  
 -p '{"accountType": "Standard_LRS"}'
 ```

 or

 ```
 $ azure storage account create cernstorageaccount --resource-group TestingVMmich \  
 --location “japaneast" --kind Storage --sku-name PLRS
    
 ```

 Confirm is created:  
 
 ```
 $ azure resource list TestingVMmich  
 $ azure storage account show cernstorageaccount
 ```

4. List storage account keys:  
 
 ```bash
 $ azure storage account keys list cernstorageaccount --resource-group TestingVMmich
 ```

 Keep the `key1`, is the one used to interact with the storage account.

5. Create a container:  

 ```bash
 $ azure storage container create --account-name cernstorageaccount \
 --account-key <key1> --container vm-images
 ```

6. Upload the vhd file:  

 ```bash
 $ azure storage blob upload --blobtype page --account-name cernstorageaccount \  
 --account-key <key1> --container vm-images /path/to/disk/yourdisk.vhd
 ```

7. Create a container for the HDD of the virtual machines (vhd):

 ```
 $ azure storage container create --account-name cernstorageaccount  \
 --account-key <key1> --container vhd
 ```

8. Create a Key Vault (to store passwords):
 
 ```
 $ azure keyvault create --vault-name ‘KeyVault1' --resource-group ’TestingVMmich' --location ‘japaneast'
 $ azure keyvault secret set --vault-name 'VaultKey1' --secret-name 'VMPassword' --value 'diracTesting88#'
 $ azure keyvault secret list --vault-name 'VaultKey1'
 ```

## Control of the VM in Azure

Deploy the VM:

 ```
 $ azure group deployment create -f azuredeploy.json -e azuredeploy.parameters.json -g TestingVMmich -n testingDeploy
 ```

Show VM:

```
$ azure vm list TestingVMmich
$ azure vm list-ip-address
```

Stop VM:

```
$ azure vm stop TestingVMmich CernVMtest
```

Liberar los recursos (para evitar cargos mientras está apagada):

```
$ azure vm deallocate TestingVMmich CernVMtest
```

