# DIRAC Pilot running on Microsoft Azure

## Quick Start

### Azure Account

A Microsoft account is needed to try Azure. Go to the [Azure Portal](https://azure.microsoft.com/en-us/free/) and create a free trial account.

### Azure Client

Install the [client for Azure](https://azure.microsoft.com/en-us/documentation/articles/xplat-cli-install/), login 

 ```
 $ azure login
 ```

And change mode to Azure Resource Manager:  

 ```
 $ azure config mode arm
 ```

### Create the resources required

WIP
(Look at the [first steps](https://github.com/michmx/AzureBelleDIRAC/wiki/First-steps))

### Deploy a VM

Deploy the VM:

```
 $ azure group deployment create -f azuredeploy.json -e azuredeploy.parameters.json -g <Resource Group> -n <VM Name>
```

### Run the DIRAC pilot on the VM

Find the IP of the deployed VM

```
$ azure vm list-ip-address
```

Copy the wrapper to the VM

```
$ scp pilot_wrapper.py dirac@<IP>:~/
```

Run the wrapper:

```
$ bash ~/pilot_wrapper.py
```


## Wiki and Azure documentation

More detailed information can be found in the [Wiki](https://github.com/michmx/AzureBelleDIRAC/wiki).

You can look at the [Azure Documentation](https://azure.microsoft.com/en-us/get-started/?b=16.40) for a complete description of all the capacities of Azure.